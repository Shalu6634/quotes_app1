import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app/helper/quote_helper.dart';
import 'package:quotes_app/modal/quote_modal.dart';

class QuoteController extends GetxController {
  late QuotesModal quotesModal;
  RxList dataList = [].obs;
  Rx<Color> chooseColor = Colors.white.obs;
  RxInt bgIndex=0.obs;
  RxString font='popines'.obs;
  Rx<TextAlign> txtAlign=TextAlign.center.obs;
  RxInt size=18.obs;
  RxInt changeValue=0.obs;
  RxInt selectedIndex=0.obs;
  Rx<CrossAxisAlignment> alignSet = CrossAxisAlignment.center.obs;
  RxList<Color> color=<Color>[
    Colors.white,
    Colors.blue,
    Colors.red,
    Colors.indigo,
    Colors.pink,
    Colors.green,
    Colors.yellow,
    Colors.teal,
    Colors.blueAccent,
    Colors.brown,
    Colors.lime,
    Colors.lightBlue,
  ].obs;
  RxList chooseFonts= [
    'bold',
    'popines',
    'noto',
    'italic',
    'crackWord',
    'dance',
    'shadow'
  ] .obs;
  Future<void> initDb() async {
    await QuotesHelper.quotesHelper.database;
  }
  void favourite(int like,int id)
  {
    QuotesHelper.quotesHelper.updateData(like, id);
    getData();
  }
  Future<RxList> getData() async {
    fromAllData();
    dataList.value = await QuotesHelper.quotesHelper.readData();
    return dataList;
  }


  void fromAllData() async {
    final  data =
        await QuotesHelper.quotesHelper.fetchData();
    quotesModal = QuotesModal.fromMap(data!);

    for (int i = 0; i < quotesModal.quotes.length; i++) {
      QuotesHelper.quotesHelper.insertData(
          quotesModal.quotes[i].category,
          quotesModal.quotes[i].quote,
          quotesModal.quotes[i].author,
          quotesModal.quotes[i].description,0);
    }
  }

  Future<RxList> showFolderData(String category)
  async {
     dataList.value=await QuotesHelper.quotesHelper.showFolderData(category);
    return dataList;
  }

  void deleteData(int id)
  {
    QuotesHelper.quotesHelper.removeData(id);
  }

}
