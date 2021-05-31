import 'package:flutter/material.dart';
import 'package:shobek/src/MainWidgets/networkImage.dart';

class DriverOrderItem extends StatelessWidget {
  final Function onTap;
  final bool order;
  final bool dismissible;

  final String image, productName, shopName, description, productId, price;
  DriverOrderItem({
    Key key,
    this.onTap,
    @required this.image,
    @required this.productName,
    @required this.shopName,
    this.order,
    this.description,
    this.dismissible = false,
    this.productId,
    @required this.price,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Card(
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
              // Item Image
              Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                  child: Container(
                    height: 90.0,
                    child: image != null ? networkImage(image) : SizedBox(),
                    color: Colors.redAccent,
                  ),
                ),
              ),

              // Item Details
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 10,
                    top: 5,
                    bottom: 5,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Product Name
                            Text(
                              productName,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            // Shop Name
                            Text(
                              shopName,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5), // Date
                            // Description
                            description != null
                                ? Text(
                                    description,
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                      //  ID And Price
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              productId != null ? productId : "",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "SR $price",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
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
