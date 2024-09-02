import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app/utils/global.dart';

import '../controller/quote_Controller.dart';
import '../utils/imageList/list.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuoteController quoteController = Get.put(QuoteController());
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xfff56440),
          centerTitle: true,
          title: Text(
            "Edit your quote",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                quoteController.dataList[selectedIndex]['quote'],
                style: TextStyle(fontSize: 20),
              ),
            ),
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return quoteController.dataList[selectedIndex]['quote'];
                    },
                  );
                },
                icon: Icon(
                  Icons.text_fields,
                  color: Colors.black,
                )),
          ],
        ));
  }
}
