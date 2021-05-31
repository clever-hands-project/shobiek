import 'package:flutter/material.dart';
import 'package:shobek/src/MainScreens/HomeScreen/widgets/iconButton.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';
import 'package:shobek/src/MainWidgets/register_text_field.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GlobalKey<PopupMenuButtonState<String>> _key = GlobalKey();
  String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: "المحادثة",
        icon: PopupMenuButton<String>(
          key: _key,
          icon: CustomIconButton(
            icon: Icons.more_vert,
            iconColor: Colors.white,
            size: 40,
            color: Theme.of(context).accentColor,
            onTap: () => _key.currentState.showButtonMenu(),
          ),
          offset: Offset(15, 45),
          enabled: true,
          onSelected: (value) {
            setState(() {
              message = value;
              print(message);
            });
          },
          itemBuilder: (context) {
            return <PopupMenuEntry<String>>[
              PopupMenuItem(
                child: Text('first comment'),
                value: 'first comment',
              ),
              PopupMenuItem(
                child: Text('second comment'),
                value: 'second comment',
              ),
            ];
          },
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              // Messages List
              Expanded(
                child: Container(),
              ),
              // Message Field And Send Button
              Container(
                height: 70,
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 5.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    Flexible(
                      child: RegisterTextField(
                        hint: 'اكتب تعليقك...',
                        onChange: (v) {
                          setState(() {
                            message = v;
                          });
                        },
                      ),
                    ),
                    CustomIconButton(
                      icon: Icons.send,
                      iconColor: Theme.of(context).primaryColor,
                      color: Theme.of(context).accentColor,
                      size: 50,
                      onTap: () {},
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
