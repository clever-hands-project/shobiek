import 'package:flutter/material.dart';

class ListSelectorWidget extends StatefulWidget {
  final Function(String) onSelect;
  final String label, hint;
  final List<String> items;
  const ListSelectorWidget({
    Key key,
    this.onSelect,
    @required this.label,
    @required this.hint,
    this.items,
  }) : super(key: key);

  @override
  _DayWidgetState createState() => _DayWidgetState();
}

class _DayWidgetState extends State<ListSelectorWidget> {
  String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: widget.label,
              hintText: widget.hint,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: TextStyle(color: Colors.black54),
              suffixIcon: Container(
                height: 30,
                width: 30,
                margin: EdgeInsets.only(left: 5),
                alignment: Alignment.center,
                child: FittedBox(
                  child: Icon(
                    Icons.arrow_drop_down_sharp,
                    size: 40,
                    color: Color(0xff414141),
                  ),
                ),
              ),
              contentPadding: EdgeInsets.only(
                top: 10,
                right: 10,
                left: 10,
                bottom: 10,
              ),
              border: InputBorder.none,
            ),
            icon: SizedBox(),
            isExpanded: true,
            onChanged: (value) {
              setState(() {
                title = value;
                widget.onSelect(value);
              });
            },
            items: [
              for (int i = 0; i < widget.items.length ?? 7; i++)
                DropdownMenuItem<String>(
                  value: widget.label,
                  child: Text(
                    widget.items[i],
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
