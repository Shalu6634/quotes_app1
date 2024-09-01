// import 'dart:async';
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:quotes_app/view/homepage.dart';
// import 'package:quotes_app/view/splashScreen.dart';
//
// import '../controller/quote_Controller.dart';
//
// class Splash extends StatelessWidget {
//   const Splash({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Timer.periodic(
//       Duration(seconds: 3),
//       (timer) => Get.toNamed('/splash'),
//     );
//     double h = MediaQuery.of(context).size.height;
//     double w = MediaQuery.of(context).size.width;
//     QuoteController quoteController = Get.put(QuoteController());
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: Container(
//               height: h * 0.5,
//               width: w * 0.8,
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: AssetImage('assets/img/splash/splash1.png'),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
