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
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(40),
        decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 0.4,
                fit: BoxFit.cover,
                image: AssetImage('assets/img/background/bg10.jpeg')),
            color: Color(0xFF3B3B3D)),
        child: Obx(
          () => PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: quoteController.dataList.length,
            itemBuilder: (context, index) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      width: 100,

                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: Colors.white12,

                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text(quoteController.dataList[index]['category'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                    ),

                  ],
                ),
                Spacer(),
                SelectableText(
                  quoteController.dataList[index]['quote'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: height * 0.025,
                    fontWeight: FontWeight.w500,fontFamily: 'noto'
                  ),
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SelectableText(
                      '~ ${quoteController.dataList[index]['author']}',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'chocolate',
                        fontSize: height * 0.024,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
