import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/MainScreens/HomeScreen/widgets/iconButton.dart';
import 'package:shobek/src/MainWidgets/customBtn.dart';
import 'package:shobek/src/MainWidgets/custom_new_dialog.dart';
import 'package:shobek/src/Provider/post/add_to_cart_provider.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';
import 'package:shobek/src/MainScreens/Registeration/sign_in_screen.dart';

class QuantityWidget extends StatefulWidget {
  final double price;
  final int id;
  const QuantityWidget({Key key, @required this.price, this.id})
      : super(key: key);
  @override
  _QuantityWidgetState createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  CustomDialog _dialog = CustomDialog();
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return ListView(primary: false, shrinkWrap: true, children: [
      SizedBox(
        height: 40,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIconButton(
                      icon: Icons.add,
                      color: Colors.black12,
                      size: 30,
                      onTap: () {
                        setState(() {
                          quantity++;
                        });
                      },
                    ),
                    Text(
                      "$quantity",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CustomIconButton(
                      icon: Icons.remove,
                      color: Colors.black12,
                      size: 30,
                      onTap: () {
                        setState(() {
                          if (quantity != 1) quantity--;
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  quantity == 0 ? "الاجمالي" : "${widget.price * quantity} SR",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      SizedBox(height: 10),
      // Add to Cart Button
      CustomBtn(
          color: Theme.of(context).accentColor,
          text: "اضف للسلة",
          heigh: 50,
          elevation: 10,
          fontSize: 16,
          txtColor: Colors.white,
          fontWeight: FontWeight.bold,
          onTap: () async {
            if (NetworkUtil.token == null) {
              return await _dialog.showOptionDialog(
                  context: context,
                  msg: 'للاضافه للسله يرجي التسجيل اولا',
                  okFun: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => SignInScreen()));
                  },
                  okMsg: 'نعم',
                  cancelMsg: 'لا',
                  cancelFun: () {
                    return;
                  });
            } else {
              _dialog.showOptionDialog(
                  context: context,
                  msg: 'هل انت متاكد من اضافه هذا المنتج للسلة',
                  okFun: () {
                    Provider.of<AddToCartProvider>(context, listen: false)
                        .addToCart(context, widget.id, quantity);
                  },
                  okMsg: 'نعم',
                  cancelMsg: 'لا',
                  cancelFun: () {
                    return;
                  });
            }
          }),
    ]);
  }
}
