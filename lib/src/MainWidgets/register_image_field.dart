import 'package:flutter/material.dart';

class RegisterImageField extends StatefulWidget {
  final String label;
  final String hint;
  final Function onTap;
  const RegisterImageField({
    Key key,
    this.label,
    this.hint,
    this.onTap,
  }) : super(key: key);

  @override
  _RegisterImageFieldState createState() => _RegisterImageFieldState();
}

class _RegisterImageFieldState extends State<RegisterImageField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: TextFormField(
            textAlign: TextAlign.right,
            readOnly: true,
            onTap: widget.onTap,
            // validator: (value) {
            //   if (value.isEmpty) {
            //     return "${widget.label} مطلوب";
            //   }
            //   return null;
            // },
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xff414141),
              labelText: widget.label,
              hintText: widget.hint,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: TextStyle(color: Colors.white),
              hintStyle: TextStyle(color: Colors.white),
              suffixIcon: Container(
                height: 30,
                width: 30,
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: FittedBox(
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: Color(0xff414141),
                  ),
                ),
              ),
              contentPadding: EdgeInsets.only(top: 10, right: 10, bottom: 10),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
