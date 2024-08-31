import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app/view/favouritePage.dart';
import 'package:quotes_app/view/Quote.dart';
import 'package:quotes_app/view/homepage.dart';
import 'package:quotes_app/view/splashScreen.dart';


void main()
{
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
          //GetPage(name: '/', page: () => SplashScreen(),),
          GetPage(name: '/', page: () => const SplashScreen(),),
          GetPage(name: '/quote', page: () => const QuoteScreen(),),
          GetPage(name: '/fav', page: () => const FavouritePage(),),

      ],
    );
  }
}





























