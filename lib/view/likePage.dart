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
    return Scaffold(backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: IconButton(onPressed: (){
          favouriteController.updateData();
         Get.back();
        }, icon: Icon(Icons.arrow_back_ios)),
        title: Text('Liked Page'),
      ),
      body: ListView.builder(itemBuilder: (context, index) => Card(color: Colors.black,
        child: ListTile(
          title: Center(child: Text(quoteController.dataList[index]['quote'],style: TextStyle(color: Colors.white,fontFamily: 'popines',fontSize: 23),)),
          subtitle: Text(quoteController.dataList[index]['category'],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'noto'),),
          trailing: IconButton(onPressed: (){
           quoteController.deleteData(quoteController.dataList[index]['quote'], quoteController.dataList[index]['author']);
          }, icon: Icon(Icons.delete,color: Colors.red,size: 30,)),
        ),
      ),itemCount: quoteController.dataList.length,),

    );
  }
}
