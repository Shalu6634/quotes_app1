import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app/utils/global.dart';
import 'package:quotes_app/view/likePage.dart';

import '../controller/favourite_controller.dart';
import '../controller/quote_Controller.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    FavouriteController favouriteController = Get.put(FavouriteController());
    QuoteController quoteController = Get.put(QuoteController());

    void backPage()
    {
      Timer(const Duration(milliseconds:500), () {
        Get.back();
      });
    }
    return Scaffold(backgroundColor: Colors.black,
      appBar: AppBar(
centerTitle: true,
        leading: IconButton(onPressed: (){
          quoteController.getData();
          backPage();
        }, icon: Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.blue,
        title: const Text(
          'Favourite Quotes',
          style: TextStyle(
              fontFamily: 'popines', fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white),
        ),
      ),
      body: GridView.builder(
        itemCount: favouriteController.categoriesList.length,

        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) => GestureDetector(
          onTap: ()
          {
            quoteController.showFolderData(favouriteController.categoriesList[index]);
            Get.to(LikedPage(),);
          },
          child: Container(
            height: 100,
            width: 100,
            margin: EdgeInsets.all(15),
            decoration:  BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.blue,
                Colors.blueAccent,
              ]),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Center(child: Text('${favouriteController.categoriesList[index]}',style: TextStyle(fontFamily: 'noto',color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),)),
          ),
        ),
      ),
    );
  }
}
// GridView.builder(
// gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 4/4),
// itemCount: likeController.categoryList.length,
// itemBuilder: (context, index) =>
// GestureDetector(onTap:(){
// likeController.showCategoryData(likeController.categoryList[index]);
// Get.to(QuotesPage());
// },child:Container(
// margin: EdgeInsets.all(10),
// decoration: BoxDecoration(
// boxShadow: [
// BoxShadow(
// color: Colors.black26,
// blurRadius: 10.0,
// offset: Offset(5, 5),
// spreadRadius: 3.5,
// ),
// ],
// gradient: LinearGradient(
// colors: [Colors.blue, Colors.purple],
// begin: Alignment.topLeft,
// end: Alignment.bottomRight,
// ),
// borderRadius: BorderRadius.circular(15),
// // borderRadius: BorderRadius.only(topRight: Radius.circular(25),bottomLeft: Radius.circular(25),)
// ),
// alignment: Alignment.center,
// child: Text(likeController.categoryList[index],style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
// ),
// ),
// ),
// ),
// ),
// );
// }
// }