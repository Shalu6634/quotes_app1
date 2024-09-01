import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app/controller/favourite_controller.dart';
import 'package:quotes_app/utils/imageList/list.dart';
import 'package:quotes_app/view/backGround_Image.dart';

import '../controller/quote_Controller.dart';
import '../utils/global.dart';

class QuoteScreen extends StatelessWidget {
  const QuoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuoteController quoteController = Get.put(QuoteController());
    FavouriteController favouriteController = Get.put(FavouriteController());
    void openIconButton()
    {
      showModalBottomSheet(isScrollControlled: true,context: context, builder: (ctx) =>  GridView.builder(
        itemCount: bgList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 3 / 4),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: ()
            {
              image=bgList[index]['img'];
              Get.toNamed('/home');
            },

            child: Container(
              height: 300,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('${bgList[index]['bg']}'),
                ),
              ),
            ),
          ),
        ),
      ),);

    }
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body:
        Obx(()=>Container(
          padding: const EdgeInsets.all(20),
          decoration:  BoxDecoration(
            image: DecorationImage(
                opacity: 0.4,
                fit: BoxFit.cover,
                image: AssetImage(bgList[quoteController.bgIndex.value]['bg'].toString())),
          ),
          child: PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: quoteController.dataList.length,
            itemBuilder: (context, index) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        quoteController.dataList[index]['category'],
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'noto'),
                      ),
                    ),

                    Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(10)),
                      child: GestureDetector(
                          onTap: () {
                            favouriteController.folderData();
                            Get.to(InfoScreen());
                          },
                          child: const Text(
                            'background',
                            style: TextStyle(fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ),

                    Obx(
                          () => IconButton(
                          onPressed: () {
                            if (quoteController.dataList[index]['like'] == 0) {
                              quoteController.favourite(
                                  1, quoteController.dataList[index]['id']);
                              favouriteController.insertData(
                                quoteController.dataList[index]['category'],
                                quoteController.dataList[index]['quote'],
                                quoteController.dataList[index]['author'],
                                quoteController.dataList[index]['description'],
                                quoteController.dataList[index]['like'],
                              );
                            } else {
                              quoteController.favourite(
                                  0, quoteController.dataList[index]['id']);
                              favouriteController.removeFavouriteData(
                                  favouriteController.idList[index]['id']);
                            }
                          },
                          icon: quoteController.dataList[index]['like'] == 0
                              ? const Icon(
                            size: 30,
                            Icons.favorite_border,
                            color: Colors.white,
                          )
                              : const Icon(
                            size: 30,
                            Icons.favorite,
                            color: Colors.red,
                          )),
                    ),

                  ],
                ),
                Spacer(),
                SelectableText(
                  quoteController.dataList[index]['quote'].toString(),
                  style: TextStyle(
                      fontSize: height * 0.025,
                      fontFamily: 'noto',
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SelectableText(
                      '~ ${quoteController.dataList[index]['author'].toString()}',
                      style: TextStyle(
                          fontFamily: 'popines',
                          fontSize: height * 0.024,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black54),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.save_alt,
                            color: Colors.white,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.share,
                            color: Colors.white,
                            size: 30,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.wallpaper,
                            color: Colors.white,
                            size: 30,
                          )),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            favouriteController.folderData();
                            Get.toNamed('/fav');
                          },
                          child: const Icon(Icons.image_sharp,color: Colors.white,size: 30,)),

                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                IconButton(onPressed: openIconButton,icon: Icon(Icons.info,color: Colors.white,),)
              ],
            ),
          ),
        ),)
      ),
    );
  }
}
