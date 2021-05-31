import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/MainWidgets/networkImage.dart';

class ShopItemCard extends StatelessWidget {
  final Function onTap;
  final String image, driverName, carType, price;
  final bool isActive;
  const ShopItemCard({
    Key key,
    this.onTap,
    @required this.image,
    @required this.driverName,
    @required this.carType,
    this.price,
    this.isActive,
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
          padding: const EdgeInsets.only(
            right: 10,
            left: 15,
            top: 10,
            bottom: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Row(
            children: [
              // Driver Image
              Expanded(
                flex: 1,
                child: Stack(
                  children: [
                   ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                        child: Container(
                          height: 90.0,
                          child:
                              image != null ? networkImage(image) : Image.asset("assets/images/image.jpg"),
                          color: Colors.redAccent,
                        ),
                      ),
                    
                    isActive != null
                        ? Positioned(
                            bottom: 0,
                            right: 8,
                            child: Badge(
                              toAnimate: false,
                              shape: BadgeShape.circle,
                              badgeColor: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              padding: EdgeInsets.all(2),
                              badgeContent: Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isActive ? Colors.green : Colors.grey,
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
              SizedBox(width: 10),
              // Item Details
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Driver Name
                    Text(
                      driverName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Car type
                        Text(
                          carType,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Price
                        Text(
                          "متجر",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
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
