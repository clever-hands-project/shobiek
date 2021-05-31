import 'package:flutter/material.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';

class ShopItem extends StatelessWidget {
  final Function onTap;
  final String image, productQuantity, shopName, distance, view;
  final int open;
  const ShopItem({
    Key key,
    this.onTap,
    @required this.image,
    @required this.shopName,
    @required this.productQuantity,
    @required this.distance,
    @required this.view,
    @required this.open,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (onTap != null && open == 1)
          ? onTap
          : () {
              CustomAlert().toast(
                context: context,
                title: "المتجر غير متاح حاليا",
              );
            },
      child: Card(
        color: open == 1 ? Colors.white : Colors.grey[400],
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Row(
            children: [
              // Shop Image
              Expanded(
                flex: 1,
                child: Container(
                  height: 90.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: image != null
                          ? NetworkImage(image)
                          : AssetImage("assets/images/image.jpg"),
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                    color: Colors.redAccent,
                  ),
                ),
              ),
              // Shop Details
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 10,
                    top: 5,
                    bottom: 5,
                  ),
                  child: Column(
                    children: [
                      // Shop name and distance
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // shop Name
                          Text(
                            shopName.length > 20 ? shopName.substring(0,20) + "..":shopName  ,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Location
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 13,
                                color: Colors.red,
                              ),
                              SizedBox(width: 5),
                              // distance
                              Text(
                                distance,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                  letterSpacing: 1.5,
                                  height: 2,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      //  Product Quantity and View
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Product Quantity
                          Row(
                            children: [
                              Text(
                                "عدد المنتجات: ",
                                style: open == 1
                                    ? Theme.of(context).textTheme.bodyText1
                                    : TextStyle(color: Colors.black87),
                              ),
                              Text(
                                "$productQuantity منتج",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          //  View CVount
                          Text(
                            "$view مشاهدة",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
