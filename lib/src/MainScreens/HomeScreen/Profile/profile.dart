import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shobek/src/MainScreens/HomeScreen/Profile/internal/shopHours.dart';
import 'package:shobek/src/MainScreens/Registeration/sign_in_screen.dart';
import 'package:shobek/src/MainScreens/shop/edtitShopDetails.dart';
import 'package:shobek/src/MainWidgets/custom_option_card.dart';
import 'package:shobek/src/MainWidgets/networkImage.dart';
import 'package:shobek/src/MainWidgets/profileAppBar.dart';
import 'package:shobek/src/Provider/DriverProvider/availabiltyProvider.dart';
import 'package:shobek/src/Provider/auth/AuthController.dart';
import 'package:shobek/src/Provider/get/setting.dart';
import 'package:shobek/src/Repository/appLocalization.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../mainPage.dart';
import 'editProfile.dart';
import 'internal/Wallet/wallet.dart';
import 'internal/about.dart';
import 'internal/carData.dart';
import 'internal/completeOrders.dart';
import 'internal/historyScreen.dart';
import 'internal/myPlaces/myPlaces.dart';
import 'internal/terms.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';
import 'package:shobek/src/MainWidgets/custom_new_dialog.dart';

class ProfileScreen extends StatefulWidget {
  final Function onBack;

  const ProfileScreen({Key key, this.onBack}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CustomOptionCard _optionCard = CustomOptionCard();
  SharedPreferences _prefs;

  CustomDialog _dialog = CustomDialog();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ProfileAppBar(
            title: "حسابي",
            name:
                Provider.of<AuthController>(context, listen: false).name ?? "",
            hasBack: widget.onBack ?? false,
            onBack: widget.onBack,
            image: Container(
              height: 80,
              width: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: NetworkUtil.token != null
                    ? networkImage(
                        "${Provider.of<AuthController>(context, listen: false).userModel.data.photo}",
                        errorImage: "assets/images/avatar.jpeg")
                    : Image.asset("assets/images/avatar.jpeg"),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              padding: EdgeInsets.only(top: 10),
              children: <Widget>[
                Visibility(
                  visible: NetworkUtil.token != null,
                  child: _optionCard.optionCard(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditProfile(),
                          ),
                        );
                      },
                      label: localization.text("edit_profile"),
                      context: context,
                      //  'تعديل حسابي ',
                      icon: "assets/images/001.png"),
                ),
                Visibility(
                  visible: Provider.of<AuthController>(context, listen: false)
                              .type ==
                          3 &&
                      NetworkUtil.token != null,
                  child: _optionCard.optionCard(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditShopPage(),
                          ),
                        );
                      },
                      label: "تعديل بيانات المتجر",
                      context: context,
                      icon: "assets/images/001.png"),
                ),
                // _optionCard.optionCard(
                //     // onTap: () => Navigator.push(context,
                //     //     MaterialPageRoute(builder: (context) => EditLang())),
                //     onTap: () {},
                //     label: localization.text("languageAnCountry"),
                //     //  'اللغة',
                //     context: context,
                //     icon: "assets/images/001.png"),
                Visibility(
                  visible: Provider.of<AuthController>(context, listen: false)
                              .type ==
                          1 &&
                      NetworkUtil.token != null,
                  child: _optionCard.optionCard(
                    icon: "assets/images/002.png",
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CompleteOrders())),
                    context: context,
                    label: "مدفوعاتي",
                  ),
                ),
                Visibility(
                  visible: Provider.of<AuthController>(context, listen: false)
                              .type ==
                          1 &&
                      NetworkUtil.token != null,
                  child: _optionCard.optionCard(
                    icon: "assets/images/002.png",
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyPlaces())),
                    // onTap: () {},
                    context: context,
                    label: "عناويني",
                    //  'مدفوعاتي',
                  ),
                ),
                Visibility(
                  visible: Provider.of<AuthController>(context, listen: false)
                              .type ==
                          3 &&
                      NetworkUtil.token != null,
                  child: _optionCard.optionCard(
                    icon: "assets/images/002.png",
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ShopHours())),
                    // onTap: () {},
                    context: context,
                    label: "مواعيد العمل",
                    //  'مدفوعاتي',
                  ),
                ),
                Visibility(
                  visible: Provider.of<AuthController>(context, listen: false)
                              .type ==
                          2 &&
                      NetworkUtil.token != null,
                  child: _optionCard.optionCard(
                    icon: "assets/images/002.png",
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EditCarData())),
                    context: context,
                    label: "تعديل بيانات السيارة",
                  ),
                ),
                Visibility(
                  visible: Provider.of<AuthController>(context, listen: false)
                              .type !=
                          1 &&
                      NetworkUtil.token != null,
                  child: _optionCard.optionCard(
                    icon: "assets/images/002.png",
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyWallet())),
                    context: context,
                    label: "محفظتي",
                    //  'مدفوعاتي',
                  ),
                ),
                Visibility(
                  visible: NetworkUtil.token != null,
                  child: _optionCard.optionCard(
                    icon: "assets/images/002.png",
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HistoryScreen())),
                    // onTap: () {},
                    context: context,
                    label: "سجل العمليات",
                    //  'مدفوعاتي',
                  ),
                ),
                _optionCard.optionCard(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AboutApp())),
                    context: context,
                    label: localization.text("about"),
                    //  'عن التطبيق   ',
                    icon: "assets/images/004.png"),
                _optionCard.optionCard(
                  icon: "assets/images/005.png",
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TermsApp())),
                  context: context,
                  label: localization.text("terms"),
                  //  'الشروط و الاحكام',
                ),
                _optionCard.optionCard(
                  icon: "assets/images/007.png",
                  onTap: _sendWhatsApp,
                  context: context,
                  label: 'تواصل معنا',
                ),
                Visibility(
                  visible: NetworkUtil.token != null,
                  child: _optionCard.optionCard(
                    icon: "assets/images/006.png",
                    context: context,
                    onTap: () async {
                      await _dialog.showOptionDialog(
                          context: context,
                          msg: 'هل انت متاكد سوف يتم الغاء الطلب ؟',
                          okFun: () async {
                            _prefs = await SharedPreferences.getInstance();
                            if (Provider.of<AuthController>(context,
                                        listen: false)
                                    .type ==
                                2)
                              Provider.of<AvailabilityProvider>(context,
                                      listen: false)
                                  .changeAvailable(
                                available: 0,
                                context: context,
                              );
                            _prefs.remove("userData");
                            NetworkUtil.token = null;
                            Navigator.of(context, rootNavigator: true)
                                .pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => MainPage(),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          },
                          okMsg: 'نعم',
                          cancelMsg: 'لا',
                          cancelFun: () {
                            return;
                          });
                    },
                    label: localization.text("logout"),
                  ),
                ),
                Visibility(
                  visible: NetworkUtil.token == null,
                  child: _optionCard.optionCard(
                    icon: "assets/images/006.png",
                    context: context,
                    onTap: () async {
                      Navigator.of(context, rootNavigator: true)
                          .pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => SignInScreen(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                    label: localization.text("login"),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _sendWhatsApp() async {
    var url =
        "https://wa.me/${Provider.of<SettingProvider>(context, listen: false).phoneNumber}";
    await canLaunch(url) ? launch(url) : print('No WhatsAPP');
  }
}
