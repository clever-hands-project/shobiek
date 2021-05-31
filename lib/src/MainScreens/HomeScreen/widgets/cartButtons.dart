import 'package:flutter/material.dart';
import 'package:shobek/src/MainWidgets/customBtn.dart';

class CartButtons extends StatelessWidget {
  final Function onConfirm, emptyCart, goHome;

  const CartButtons({
    Key key,
    @required this.onConfirm,
    @required this.emptyCart,
    @required this.goHome,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 80),
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: Row(
          children: [
            // confirm cart order
            Expanded(
              flex: 1,
              child: CustomBtn(
                heigh: 50,
                color: Theme.of(context).primaryColor, //Colors.white,
                fontWeight: FontWeight.bold,
                text: "اعتماد الطلب",
                onTap: onConfirm,
              ),
            ),
            //  Empty cart orders
            Expanded(
              flex: 1,
              child: CustomBtn(
                heigh: 50,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                text: "افراغ السلة",
                onTap: emptyCart,
              ),
            ),
            //  continue Shopping
            Expanded(
              flex: 1,
              child: CustomBtn(
                heigh: 50,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                text: "اكمال التسوق",
                onTap: goHome,
              ),
            )
          ],
        ),
      ),
    );
  }
}
