import 'dart:async';
import 'dart:io';
import 'package:adhara_socket_io/manager.dart';
import 'package:adhara_socket_io/options.dart';
import 'package:adhara_socket_io/socket.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shobek/src/Helpers/text_helper.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/Models/chat/msg_model.dart';
import 'package:shobek/src/Models/chat/photo_model.dart';
import 'package:shobek/src/Provider/auth/AuthController.dart';
import 'package:shobek/src/Repository/appLocalization.dart';

import 'apiProvider.dart';
import 'app_event.dart';
import 'app_state.dart';

class ChatBloc extends Bloc<AppEvent, AppState> {
  final _api = ApiProvider();
  final _context = BehaviorSubject<BuildContext>();
  final _msg = BehaviorSubject<String>();
  final _chatID = BehaviorSubject<int>();
  final _secondUserID = BehaviorSubject<int>();
  final _photo = BehaviorSubject<File>();
  final _photoLink = BehaviorSubject<String>();
  final _lat = BehaviorSubject<String>();
  final _long = BehaviorSubject<String>();
  final _messagesController = PublishSubject<MsgModel>();
  final _key = BehaviorSubject<GlobalKey<ScaffoldState>>();
  SocketIO _socket;
  SocketIOManager _manager = SocketIOManager();
  String _ring;
  AudioPlayer audioPlayer = AudioPlayer();
  ChatBloc() : super(null);
  Function(String) get updateMsg => _msg.sink.add;
  Function(BuildContext) get updateContext => _context.sink.add;

  Function(String) get updatePhotoLink => _photoLink.sink.add;

  Function(String) get updateLat => _lat.sink.add;

  Function(String) get updateLong => _long.sink.add;

  Function(int) get updateChatID => _chatID.sink.add;

  Function(int) get updateSecondUserID => _secondUserID.sink.add;

  Function(File) get updatePhoto => _photo.sink.add;

  Function(MsgModel) get addMessage => _messagesController.sink.add;

  Stream<MsgModel> get messages =>
      _messagesController.stream.asBroadcastStream();

  Function(GlobalKey<ScaffoldState>) get updateKey => _key.sink.add;
  // CustomProgressDialog customProgressDialog;
  // ProgressDialog pr;
  dispose() {
    _key.close();
    _msg.close();
    _photoLink.close();
    _lat.close();
    _long.close();
    _chatID.close();
    _secondUserID.close();
    _msg.close();
    _photo.close();
    _messagesController.close();
    _messagesController.close();
    _context.close();
  }

  clear() {
    _photo.value = null;
    _chatID.value = null;
    _photoLink.value = null;
    _lat.value = null;
    _long.value = null;
    _msg.value = null;
    _manager.clearInstance(_socket);
  }

  clearMsg() {
    _photo.value = null;
    _photoLink.value = null;
    _lat.value = null;
    _long.value = null;
    _msg.value = null;
  }

  AppState get initialState => Start();

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    // if (event is Restart) {
    //   yield Start();
    // }
    if (event is UploadPhoto) {
      if (_photo.value != null) {
        PhotoModel _res = await _api
            .uploadPhoto(
                _photo.value,
                Provider.of<AuthController>(_context.value, listen: false)
                    .userModel
                    .data
                    .apiToken)
            .catchError((e) {
          // _key.value.currentState.showSnackBar(
          //     SnackBar(content: Text(localization.text('internet'))));
          CustomAlert().toast(
              context: _context.value, title: localization.text('internet'));
        });
        if (_res.code == 200) {
          updatePhotoLink(_res.data);
        }
      }
    }
    if (event is Init) {
      // customProgressDialog =
      //     CustomProgressDialog(context: _context.value, pr: pr);
      // customProgressDialog.showProgressDialog();
      // customProgressDialog.showPr();
      // PhotoModel _voice = await _api.getVoiceRing().catchError((e) {
      //   _key.value.currentState.showSnackBar(
      //       SnackBar(content: Text(localization.text('internet'))));
      // });
      // if (_voice.code == 200) {
      //   _ring = _voice.data;
      // }
      // sharedBloc.add(Click());
      var _old = await _api.getMessages(
          _chatID.value,
          Provider.of<AuthController>(_context.value, listen: false)
              .userModel
              .data
              .apiToken);

      //  Future.delayed(Duration(milliseconds: 500), () {
      //   customProgressDialog.hidePr();
      // });
      if (_old.code == 200) {
        for (int i = 0; i < _old.data.length; i++) {
          if (_old.data[i].message != null ||
              _old.data[i].file != null ||
              _old.data[i].latitude != null ||
              _old.data[i].longitude != null) {
            addMessage(_old.data[i]);
          }
        }
      }
      print('>>> Start init');
      _socket = await _manager.createInstance(
        SocketOptions("https://shobaik-lobaik.com:1994",
            query: {
              "room_id": "${_chatID.value}",
            },
            enableLogging: true,
            transports: [
              Transports.WEB_SOCKET,
              Transports.POLLING,
            ] //Enable required transport
            ),
      );
      _socket.emit('user-connected', [
        {
          "room_id": _chatID.value.toString(),
          "api_token":
              Provider.of<AuthController>(_context.value, listen: false)
                  .userModel
                  .data
                  .apiToken
        }
      ]);
      _socket.onConnect((connection) {
        print('<<< Socket connected >>>');
        _socket.on('chat message', (data) async {
          if (_chatID.value.toString() == data["room_id"] &&
              Provider.of<AuthController>(_context.value, listen: false)
                      .userModel
                      .data
                      .id !=
                  data["user_id"]) {
            print('<<< Receive Msg >>> ${data.toString()}');
            MsgModel _msg = new MsgModel(
                message: data["msg"],
                userPhoto: data["img"],
                createdAt: TextHelper().formatDate(date: DateTime.now()),
                userId: data["user_id"],
                file: data["file"]);
            addMessage(_msg);
            if (_ring != null) {
              await audioPlayer.play(_ring);
            }

            // _msg = null;
          }
        });
      });
      _socket.connect();
    }
    if (event is SendMsg) {
      MsgModel _newMsg = new MsgModel(
          message: _msg.value,
          userId: Provider.of<AuthController>(_context.value, listen: false)
              .userModel
              .data
              .id,
          secondUserId: _chatID.value,
          token: Provider.of<AuthController>(_context.value, listen: false)
              .userModel
              .data
              .apiToken,
          createdAt: TextHelper().formatDate(date: DateTime.now()),
          file: _photoLink.value,
          userPhoto: Provider.of<AuthController>(_context.value, listen: false)
              .userModel
              .data
              .photo,
          roomID: _chatID.value.toString());
      print(
          "token ${Provider.of<AuthController>(_context.value, listen: false).userModel.data.apiToken}");
      print("room id ${_chatID.value.toString()}");
      _socket.emit("send-message", [
        {
          "api_token":
              Provider.of<AuthController>(_context.value, listen: false)
                  .userModel
                  .data
                  .apiToken,
          "room_id": _chatID.value.toString(),
          "file": _photoLink.value,
          "message": _msg.value,
          "lang": "ar",
          "file_type": "text",
          "countryId": "178",
          "duration": 1
        }
      ]);
      _socket.emit('chat message', [
        {
          "msg": _msg.value,
          "room_id": _chatID.value.toString(),
          "img": Provider.of<AuthController>(_context.value, listen: false)
              .userModel
              .data
              .photo,
          "file": _photoLink.value,
          "user_id": Provider.of<AuthController>(_context.value, listen: false)
              .userModel
              .data
              .id,
        }
      ]);
      clearMsg();
      addMessage(_newMsg);
      // _newMsg = null;
    }
  }
}

final chatBloc = ChatBloc();
