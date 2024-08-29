import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: h * 0.4,
              width: w * 0.8,
              decoration: BoxDecoration(
                  color: Colors.red,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/img/splash/splash.jpg'))),
            ),
          ),
          Container(
              height: h * 0.2,
              width: w * 0.6,
              child: Center(
                child: const Text(
                    textAlign: TextAlign.center,
                    'Below the quote, the authors name is displayed in a smaller, italicized font, adding a touch of sophistication'),
              )),
          SizedBox(
            height: 40,
          ),
          Container(
            height: h * 0.080,
            width: w * 0.4,
            decoration: BoxDecoration(
                color: Colors.redAccent.shade100,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: const Text(
                  "Next",
                  style: TextStyle(color: Colors.white, fontSize: 23),
                )),
          )
        ],
      ),
    );
  }
}