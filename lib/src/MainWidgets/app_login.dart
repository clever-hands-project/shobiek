import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shobek/src/Helpers/route.dart';
import 'package:shobek/src/MainScreens/Registeration/sign_in_screen.dart';

class AppShouldLogin extends StatefulWidget {
  final String text;

  const AppShouldLogin({Key key, this.text}) : super(key: key);

  @override
  _AppShouldLoginState createState() => _AppShouldLoginState();
}

class _AppShouldLoginState extends State<AppShouldLogin> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset('assets/lolitJson/login.json',height: 200,width: 200,),
        SizedBox(height: 20),
        InkWell(
          onTap: ()=>pushAndRemoveUntil(context, SignInScreen()),
          child: Text(widget.text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, color: Colors.blue)),
        )
      ],
    );
  }
}
