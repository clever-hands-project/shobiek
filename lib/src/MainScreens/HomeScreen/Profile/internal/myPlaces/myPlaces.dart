import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/MainScreens/HomeScreen/Profile/internal/myPlaces/pickPlace.dart';
import 'package:shobek/src/MainWidgets/app_empty.dart';
import 'package:shobek/src/MainWidgets/app_loader.dart';
import 'package:shobek/src/MainWidgets/defaultAppbar.dart';
import 'package:shobek/src/Provider/get/MyAddressProvider.dart';
import 'widget/myPlaceCard.dart';

class MyPlaces extends StatefulWidget {
  @override
  _MyPlacesState createState() => _MyPlacesState();
}

class _MyPlacesState extends State<MyPlaces> {
  @override
  void initState() {
    Provider.of<MyAddressProvider>(context, listen: false)
        .getPlaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "عناويني",
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   centerTitle: true,
      //   leading: InkWell(
      //     onTap: () {
      //       Navigator.pop(context);
      //     },
      //     child: Icon(
      //       Icons.arrow_back_ios,
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
      appBar: defaultAppBar(
        context: context,
        title: "عناويني",
        hasBack: true,
        onPress: () => Navigator.pop(context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => PickPlace()));
        },
        child: Icon(
          Icons.add_location,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body:
          Provider.of<MyAddressProvider>(context, listen: true).categoriesModel == null
              ? AppLoader()
              : Provider.of<MyAddressProvider>(context, listen: true).adress .length == 0
                  ? AppEmpty(text: 'ليس لديك عناوين سابقة')
                  :
          ListView(
        physics: ScrollPhysics(),
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: Provider.of<MyAddressProvider>(context, listen: true).adress.length,
            itemBuilder: (context, index) {
              return MyPlacesCard(
                index: index,
                myAddress:Provider.of<MyAddressProvider>(context, listen: false).adress[index] ,
              );
            },
          ),
          SizedBox(
            height: 70,
          ),
        ],
      ),
    );
  }
}

class Places {
  final String title;

  final String message;

  final DateTime createdAt;

  Places(this.title, this.message, this.createdAt);
}
