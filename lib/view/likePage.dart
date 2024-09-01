import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app/utils/global.dart';

import '../controller/favourite_controller.dart';
import '../controller/quote_Controller.dart';

class LikedPage extends StatelessWidget {
  const LikedPage({super.key});

  @override
  Widget build(BuildContext context) {
    QuoteController quoteController = Get.put(QuoteController());
    FavouriteController favouriteController = Get.put(FavouriteController());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0xfff56440),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text('Liked Page'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Obx(
            () => ListView.builder(
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  title: Center(
                      child: Text(
                    quoteController.dataList[index]['quote'],
                    style: const TextStyle(fontFamily: 'popines', fontSize: 16),
                  )),
                  subtitle: Text(
                    quoteController.dataList[index]['category'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: 'noto'),
                  ),
                  trailing:
                        IconButton(onPressed: () {
                         favouriteController.removeData(quoteController.dataList[index]['id']);
                        }, icon: Icon(Icons.delete)),

                ),
              ),
              itemCount: quoteController.dataList.length,
            ),
          )),
    );
  }
}
