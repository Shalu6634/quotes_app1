import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app/utils/imageList/list.dart';

import '../controller/quote_Controller.dart';
import '../utils/global.dart';

class QuoteScreen extends StatelessWidget {
  const QuoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuoteController quoteController = Get.put(QuoteController());

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return
      Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          '${quote} Status',
          style: TextStyle(
              letterSpacing: height * 0.0007,
              fontWeight: FontWeight.bold,
              fontFamily: 'OFL'),
        ),
      ),

    );
  }
}
