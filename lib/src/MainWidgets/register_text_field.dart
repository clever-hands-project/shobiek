import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterTextField extends StatefulWidget {
  final String label;
  final IconData icon;
  final TextInputType type;
  final String hint;
  final String errorText;
  final Function onChange;
  final Function inValid;
  final String init;
  final bool edit;
  final Function onChangeCountry;
  final Function onInit;
  final int maxLines;
  final int leghth;
  final TextEditingController controller;
  const RegisterTextField({
    Key key,
    this.icon,
    this.label,
    this.type,
    this.hint,
    this.errorText,
    this.onChange,
    this.init,
    this.edit,
    this.onChangeCountry,
    this.onInit,
    this.controller,
    this.maxLines,
    this.inValid,
    this.leghth,
  }) : super(key: key);

  @override
  _RegisterTextFieldState createState() => _RegisterTextFieldState();
}

class _RegisterTextFieldState extends State<RegisterTextField> {
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
            inputFormatters: [
              widget.label == 'رقم الجوال'
                  ? LengthLimitingTextInputFormatter(11)
                  : widget.leghth != null
                      ? LengthLimitingTextInputFormatter(widget.leghth)
                      : LengthLimitingTextInputFormatter(null),
            ],
            controller: widget.controller,
            initialValue: widget.init,
            maxLines: widget.maxLines,
            textAlign: TextAlign.right,
            keyboardType: widget.label == 'رقم الجوال'
                ? TextInputType.phone
                : widget.type,
            onFieldSubmitted: (v) {},
            onChanged: widget.onChange,
            validator: widget.inValid != null
                ? widget.inValid
                : (value) {
                    if (value.isEmpty) {
                      return "${widget.hint == null ? widget.label : widget.hint} مطلوب";
                    }
                    if (widget.label == 'رقم الجوال') {
                      if (!value.startsWith("0")) {
                        return "يجب انا يبدا الهاتف ب0";
                      } else if (value.length > 11 || value.length < 11) {
                        return "يجب ان يكون الهاتف عبارة عن 11 رقم";
                      }
                    }
                    return null;
                  },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: widget.icon != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 1,
                        child: Icon(
                          widget.icon,
                          size: 15,
                          color: Colors.white,
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    )
                  : null,
              labelText: widget.label,
              labelStyle: TextStyle(color: Colors.black54),
              errorText: widget.errorText ?? null,
              suffixIcon: widget.edit == null
                  ? null
                  : widget.edit
                      ? Padding(
                          padding: EdgeInsets.all(6),
                          child: Icon(Icons.edit_outlined))
                      : CountryCodePicker(
                          onChanged: print,
                          initialSelection: 'eg',
                          favorite: [
                            '+966',
                          ],
                          showCountryOnly: false,
                          showOnlyCountryWhenClosed: false,
                          alignLeft: false,
                          textStyle: TextStyle(fontWeight: FontWeight.bold),
                          closeIcon: Icon(
                            Icons.close,
                            size: 30,
                          ),
                          flagWidth: 20,
                        ),
              hintText: widget.hint == null ? '' : widget.hint,
              floatingLabelBehavior: widget.hint != null
                  ? FloatingLabelBehavior.always
                  : FloatingLabelBehavior.auto,
              contentPadding: EdgeInsets.only(top: 10, right: 10, bottom: 10),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
