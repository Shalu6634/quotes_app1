import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/favourite_controller.dart';
import '../controller/quote_Controller.dart';

class LikedPage extends StatelessWidget {
  const LikedPage({super.key});

  @override
  Widget build(BuildContext context) {
    QuoteController quoteController = Get.put(QuoteController());
    FavouriteController favouriteController = Get.put(FavouriteController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          favouriteController.updateData();
         Get.back();
        }, icon: Icon(Icons.arrow_back_ios)),
        title: Text('Liked Page'),
      ),
      body: ListView.builder(itemBuilder: (context, index) => Card(
        child: ListTile(
          title: Text(quoteController.dataList[index]['quote']),
          subtitle: Text(quoteController.dataList[index]['category']),
          trailing: IconButton(onPressed: (){
           quoteController.deleteData(quoteController.dataList[index]['quote'], quoteController.dataList[index]['author']);
          }, icon: Icon(Icons.delete)),
        ),
      ),itemCount: quoteController.dataList.length,),
    );
  }
}
