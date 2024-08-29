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
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: quoteController.dataList[selectedIndex].length,
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.all(40),
          decoration: BoxDecoration(
              image: DecorationImage(fit: BoxFit.cover,
                  image: AssetImage(bgList[selectedIndex]['bg'])),
              color: Color(0xFF3B3B3D)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

          SelectableText(
          quoteController.dataList[index]['quote'].toString(),
            style: TextStyle(
                fontSize: height * 0.025,
                fontWeight: FontWeight.w500,
                color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SelectableText(
            '~ ${quoteController.dataList[index]['author'].toString()}',
            style: TextStyle(
                fontFamily: 'chocolate',
                fontSize: height * 0.024,
                fontWeight: FontWeight.w600,
                color: Colors.white),
            textAlign: TextAlign.center,
          ),
            ],
          ),
        ),
      ),
    );
  }
}
