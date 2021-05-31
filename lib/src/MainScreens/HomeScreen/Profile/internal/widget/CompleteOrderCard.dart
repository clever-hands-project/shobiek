import 'package:flutter/material.dart';
import 'package:shobek/src/Helpers/text_helper.dart';
import 'package:shobek/src/Models/ClientOrderModel.dart';

class CompleteOrder extends StatefulWidget {
  final ClientOrder driverCommitions;

  const CompleteOrder({Key key, this.driverCommitions}) : super(key: key);

  @override
  _CompleteOrderState createState() => _CompleteOrderState();
}

class _CompleteOrderState extends State<CompleteOrder> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 2),
      child: Card(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(7),
          child: ListView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 5, bottom: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                        TextHelper().formatDate(
                            date: widget
                                .driverCommitions.createdAt),
                        style: TextStyle(color: Colors.grey, fontSize: 10)),
                    Row(
                      children: <Widget>[
                        Text(
                            widget.driverCommitions.id
                                .toString(),
                            style:
                                TextStyle(color: Colors.black, fontSize: 11)),
                        SizedBox(width: 5),
                        Text(':رقم الطلب',
                            style: TextStyle(color: Colors.grey, fontSize: 11))
                      ],
                    )
                  ],
                ),
              ),
              Divider(height: 1, color: Colors.grey),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('الطلب',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13)),
                          Text(
                              widget.driverCommitions
                                      .orderPrice ??
                                  "0.0",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 15)),
                          Text('ريال',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 11)),
                        ],
                      ),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('التوصيل',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13)),
                          Text(
                              widget.driverCommitions.price ??
                                  "0.0",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 15)),
                          Text('ريال',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 11)),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Container(width: 1, color: Colors.grey, height: 60),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 3),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(widget.driverCommitions.user,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10)),
                            SizedBox(width: 10),
                            Text(':العميل',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 10))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(widget.driverCommitions.shop,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10)),
                              SizedBox(width: 10),
                              Text(':اسم المكان',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Row(
                  //   children: [
                  //     Text('ريال'),
                  //     SizedBox(width: 5),
                  //     Text(
                  //        widget.driverCommitions.commission,
                  //       style: TextStyle(color: Theme.of(context).primaryColor),
                  //     ),
                  //     SizedBox(width: 10),
                  //     Text('العمولة')
                  //   ],
                  // ),
                  Row(
                    children: [
                      Text('ريال'),
                      SizedBox(width: 5),
                      widget.driverCommitions.orderPrice != null
                          ? Text(
                              ((double.parse(widget.driverCommitions
                                          .orderPrice?? "0.0")) +
                                      double.parse(widget.driverCommitions
                                          .price ?? "0.0"))
                                  .toString(),
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            )
                          : Text(
                              (double.parse(widget
                                      .driverCommitions.price ?? "0.0"))
                                  .toString(),
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                      SizedBox(width: 10),
                      Text('إجمالي الطلب')
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
