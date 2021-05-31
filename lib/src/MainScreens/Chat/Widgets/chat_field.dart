import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/Bloc/app_event.dart';
import 'package:shobek/src/Bloc/chat_bloc.dart';

import '../img_upload_review.dart';

class ChatField extends StatefulWidget {
  @override
  _ChatFieldState createState() => _ChatFieldState();
}

class _ChatFieldState extends State<ChatField> {
  TextEditingController _controller = TextEditingController();
  String message = "";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (message.length == 0) {
                return;
              }
              setState(() {
                message = "";
              });
              chatBloc.add(SendMsg());
              _controller.clear();
            },
            child: Material(
              shape: CircleBorder(),
              color: message.length == 0
                  ? Colors.grey
                  : Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(11),
                child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Icon(Icons.send, color: Colors.white)),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextField(
                textDirection: TextDirection.rtl,
                controller: _controller,
                onChanged: (v) {
                  setState(() {
                    chatBloc.updateMsg(v);
                    message = v;
                  });
                },
                minLines: 1,
                maxLines: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: InkWell(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ImageUploadReview())),
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.transparent),
                        child: Icon(Icons.camera_alt),
                      ),
                    ),
                  ),
                  hintText: 'اكتب رساله...',
                  contentPadding: EdgeInsets.only(
                      top: 5.0, right: 10.0, bottom: 5.0, left: 5.0),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
