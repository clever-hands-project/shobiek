import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/Provider/get/RegisterHelper.dart';
import 'Helpers/map_helper.dart';
import 'Helpers/sharedPref_helper.dart';
import 'MainScreens/Intro/splash_screen.dart';
import 'Models/shop/deletePhotoProvider.dart';
import 'Provider/ClientFinishOrderProvider.dart';
import 'Provider/ClientOrderProvider.dart';
import 'Provider/DriverProvider/ClientCancleOrderProvider.dart';
import 'Provider/DriverProvider/DriverOrderProvider.dart';
import 'Provider/DriverProvider/editCarDataProvider.dart';
import 'Provider/DriverProvider/sendOfferProvider.dart';
import 'Provider/DriverProvider/availabiltyProvider.dart';
import 'Provider/DriverProvider/driverCancelOfferProvider.dart';
import 'Provider/DriverProvider/driverCancelOrderProvider.dart';
import 'Provider/DriverProvider/driverCommitionProvider.dart';
import 'Provider/DriverProvider/driverFinishOrderProvider.dart';
import 'Provider/aboutUsProvider.dart';
import 'Provider/addAdToFavProvider.dart';
import 'Provider/auth/confirmResetCodeProvider.dart';
import 'Provider/auth/forgetPasswordProvider.dart';
import 'Provider/auth/loginProvider.dart';
import 'Provider/auth/registerMobileProvider.dart';
import 'Provider/auth/AuthController.dart';
import 'Provider/auth/resetPasswordProvider.dart';
import 'Provider/categorisFiltter.dart';
import 'Provider/changeData/changePhoneCodeProvider.dart';
import 'Provider/changeData/changePhoneProvider.dart';
import 'Provider/chargeBankProvider.dart';
import 'Provider/chargeOnlineProvider.dart';
import 'Provider/checkProvider.dart';
import 'Provider/deletePlaceProvider.dart';
import 'Provider/deleteShopPhoto.Provider.dart';
import 'Provider/depatmentsProvider.dart';
import 'Provider/get/MyAddressProvider.dart';
import 'Provider/get/cartsProvider.dart';
import 'Provider/get/citiesProvider.dart';
import 'Provider/get/getMyFavShopsProvider.dart';
import 'Provider/get/getCartProvider.dart';
import 'Provider/get/getUserDataProvider.dart';
import 'Provider/get/notificationProvider.dart';
import 'Provider/get/offersProvider.dart';
import 'Provider/get/productByIdProvider.dart';
import 'Provider/get/setting.dart';
import 'Provider/get/shopByIdProvider.dart';
import 'Provider/get/sliderProvider.dart';
import 'Provider/helpCenterProvider.dart';
import 'Provider/historyProvider.dart';
import 'Provider/myChargeProvider.dart';
import 'Provider/post/CancelOrderOffer.dart';
import 'Provider/post/acceptOfferProvider.dart';
import 'Provider/post/add_to_cart_provider.dart';
import 'Provider/post/createPlaceProvider.dart';
import 'Provider/post/deleteNotificationProvider.dart';
import 'Provider/post/editPlaceProvider.dart';
import 'Provider/post/post_current_order_provider.dart';
import 'Provider/post/productFiltterProvider.dart';
import 'Provider/post/reportShopProvider.dart';
import 'Provider/post/search_provider.dart';
import 'Provider/post/shopViewProvider.dart';
import 'Provider/post/shopsProvider.dart';
import 'Provider/shop/MyProductProvider.dart';
import 'Provider/shop/ProductsShopProvider.dart';
import 'Provider/shop/createProductProvider.dart';
import 'Provider/shop/editProductProvider.dart';
import 'Provider/shop/productCatogoryProvider.dart';
import 'Provider/shop/shopHoursProvider.dart';
import 'Provider/shop/shopOrdersProvider.dart';
import 'Provider/termsProvider.dart';
import 'Provider/userPayProvider.dart';
import 'Provider/walletRequstProvider.dart';
import 'Provider/DriverProvider/availableTimerProvider.dart';

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigator;

  const MyApp({Key key, this.navigator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DepartMentProvider()),
        ChangeNotifierProvider(create: (_) => MapHelper()),
        ChangeNotifierProvider(create: (_) => SharedPref()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => RegisterMobileProvider()),
        ChangeNotifierProvider(create: (_) => TermsProvider()),
        ChangeNotifierProvider(create: (_) => NotoficationProvider()),
        ChangeNotifierProvider(create: (_) => ShopsProvider()),
        ChangeNotifierProvider(create: (_) => ShopByIdProvider()),
        ChangeNotifierProvider(create: (_) => ProductFiltterProvider()),
        ChangeNotifierProvider(create: (_) => ProductByIdProvider()),
        ChangeNotifierProvider(create: (_) => CategoriesFiltterProvider()),
        ChangeNotifierProvider(create: (_) => SliderProvider()),
        ChangeNotifierProvider(create: (_) => MyChargeProvider()),
        ChangeNotifierProvider(create: (_) => ProductsShopProvider()),
        ChangeNotifierProvider(create: (_) => WalletRequestProvider()),
        ChangeNotifierProvider(create: (_) => AboutUsProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
        ChangeNotifierProvider(create: (_) => ChargeOnlineProvider()),
        ChangeNotifierProvider(create: (_) => ClientOrdersProvider()),
        ChangeNotifierProvider(create: (_) => CartsProvider()),
        ChangeNotifierProvider(create: (_) => AvailabilityProvider()),
        ChangeNotifierProvider(create: (_) => DriverCommitionsProvider()),
        ChangeNotifierProvider(create: (_) => SettingProvider()),
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => GetMyFavShopProvider()),
        ChangeNotifierProvider(create: (_) => AddAdToFavProvider()),
        ChangeNotifierProvider(create: (_) => CheckProvider()),
        ChangeNotifierProvider(create: (_) => ReportShopProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => GetCartProvider()),
        ChangeNotifierProvider(create: (_) => AddToCartProvider()),
        ChangeNotifierProvider(create: (_) => PostCurrentOrderProvider()),
        ChangeNotifierProvider(create: (_) => AcceptOfferProvider()),
        ChangeNotifierProvider(create: (_) => OffersProvider()),
        ChangeNotifierProvider(create: (_) => DriverOrdersProvider()),
        ChangeNotifierProvider(create: (_) => ShopProuctProvider()),
        ChangeNotifierProvider(create: (_) => ProductCategoryProvider()),
        ChangeNotifierProvider(create: (_) => CreateProductProvider()),
        ChangeNotifierProvider(create: (_) => DeletePhotoProvider()),
        ChangeNotifierProvider(create: (_) => EditProductProvider()),
        ChangeNotifierProvider(create: (_) => ShopOrderProvider()),
        ChangeNotifierProvider(create: (_) => ShopHoursProvider()),
        ChangeNotifierProvider(create: (_) => CancelOrderProvider()),
        ChangeNotifierProvider(create: (_) => RegisterHelper()),
        ChangeNotifierProvider(create: (_) => MyAddressProvider()),
        ChangeNotifierProvider(create: (_) => CreatePlaceProvider()),
        ChangeNotifierProvider(create: (_) => EditPlaceProvider()),
        ChangeNotifierProvider(create: (_) => ShopViewProvider()),
        ChangeNotifierProvider(create: (_) => ShopViewProvider()),
        ChangeNotifierProvider(create: (_) => DriverCancelOrderProvider()),
        ChangeNotifierProvider(create: (_) => DriverFinishOrderProvider()),
        ChangeNotifierProvider(create: (_) => SendtOfferProvider()),
        ChangeNotifierProvider(create: (_) => DriverCancelOfferProvider()),
        ChangeNotifierProvider(create: (_) => DeletNotificationProvider()),
        ChangeNotifierProvider(create: (_) => ClientCancleOrderProvider()),
        ChangeNotifierProvider(create: (_) => ClientFinishOrderProvider()),
        ChangeNotifierProvider(create: (_) => UserPayProvider()),
        ChangeNotifierProvider(create: (_) => ChargeBankProvider()),
        ChangeNotifierProvider(create: (_) => ComplaintProvider()),
        ChangeNotifierProvider(create: (_) => EditCarDataProvider()),
        ChangeNotifierProvider(create: (_) => DeletePlaceProvider()),
        ChangeNotifierProvider(create: (_) => CitiesProvider()),
        ChangeNotifierProvider(create: (_) => DeleteShopPhotoProvider()),
        ChangeNotifierProvider(create: (_) => ChangePhoneCodeProvider()),
        ChangeNotifierProvider(create: (_) => ChangeMobileProvider()),
        ChangeNotifierProvider(create: (_) => GetUserDataProvider()),
        ChangeNotifierProvider(create: (_) => ForgetPasswordProvider()),
        ChangeNotifierProvider(create: (_) => ConfirmResetCodeProvider()),
        ChangeNotifierProvider(create: (_) => ResetPasswordProvider()),
        ChangeNotifierProvider(create: (_) => AvilableTimerProvider()),

        
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'شبيك لبيك',
        theme: ThemeData(
          accentColor: Color.fromRGBO(38, 36, 39, 1),
          primaryColor: Color.fromRGBO(252, 240, 0, 1),
          textTheme: TextTheme(
            headline1: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            headline2: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            bodyText1: TextStyle(fontSize: 12, color: Colors.grey),
            bodyText2: TextStyle(fontSize: 12, color: Colors.black),
          ),
        ),
        home: Splash(
          navigator: navigator,
        ),
      ),
    );
  }
}
