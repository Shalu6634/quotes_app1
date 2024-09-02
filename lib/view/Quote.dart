import 'dart:io';
import 'dart:typed_data';

import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quotes_app/controller/favourite_controller.dart';
import 'package:quotes_app/utils/global.dart';
import 'package:quotes_app/utils/imageList/list.dart';
import 'package:quotes_app/view/editScreen.dart';
import 'dart:ui';
import 'dart:ui' as ui;
import '../controller/quote_Controller.dart';
import 'package:share_extend/share_extend.dart';

class QuoteScreen extends StatelessWidget {
  const QuoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuoteController quoteController = Get.put(QuoteController());
    FavouriteController favouriteController = Get.put(FavouriteController());
    List<GlobalKey> bgImage = List.generate(
      quoteController.dataList.length,
      (index) => GlobalKey(),
    );

    String? _selectedItem;
    final List<String> _dropdownItems = [
      'HOMESCREEN',
      'LOCKSCREEN',
      'HOMESCREEN AND LOCKSCREEN'
    ];

    final List<IconData> _iconList = [
      Icons.add_to_home_screen,
      Icons.lock_outline,
      Icons.control_point_duplicate
    ];

    Future<void> _selectMenuItem(String value) async {
      _selectedItem = value;
      if (_selectedItem == 'HOMESCREEN') {
        String result;
        bool goToHome = true;
        // Platform messages may fail, so we use a try/catch PlatformException.
        try {
          result = await AsyncWallpaper.setWallpaper(
            url: bgList[quoteController.bgIndex.value].toString(),
            wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
            goToHome: goToHome,
            toastDetails: ToastDetails.success(),
            errorToastDetails: ToastDetails.error(),
          )
              ? 'Wallpaper set'
              : 'Failed to get wallpaper.';
        } on PlatformException {
          result = 'Failed to get wallpaper.';
        }
      } else if (_selectedItem == 'LOCKSCREEN') {
        String result;
        bool goToHome = true;
// Platform messages may fail, so we use a try/catch PlatformException.
        try {
          result = await AsyncWallpaper.setWallpaper(
            url: bgList[quoteController.bgIndex.value].toString(),
            wallpaperLocation: AsyncWallpaper.LOCK_SCREEN,
            goToHome: goToHome,
            toastDetails: ToastDetails.success(),
            errorToastDetails: ToastDetails.error(),
          )
              ? 'Wallpaper set'
              : 'Failed to get wallpaper.';
        } on PlatformException {
          result = 'Failed to get wallpaper.';
        }
      } else if (_selectedItem == 'HOMESCREEN AND LOCKSCREEN') {
        String result;
        bool goToHome = true;
// Platform messages may fail, so we use a try/catch PlatformException.
        try {
          result = await AsyncWallpaper.setWallpaper(
            url: bgList[quoteController.bgIndex.value].toString(),
            wallpaperLocation: AsyncWallpaper.BOTH_SCREENS,
            goToHome: goToHome,
            toastDetails: ToastDetails.success(),
            errorToastDetails: ToastDetails.error(),
          )
              ? 'Wallpaper set'
              : 'Failed to get wallpaper.';
        } on PlatformException {
          result = 'Failed to get wallpaper.';
        }
      }
    }

    // show Bottom sheet
    void openIconButton() {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10),
              child: IconButton(
                color: Colors.blue,
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.done),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: GridView.builder(
                  itemCount: bgList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 3 / 4),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      quoteController.bgIndex.value = index;
                      print(image);
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 300,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(bgList[index]['bg']),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => RepaintBoundary(
            key: bgImage[selectedIndex],
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(bgList[quoteController.bgIndex.value]
                            ['bg']
                        .toString())),
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
                          Obx(
                            () => IconButton(
                                onPressed: () {
                                  if (quoteController.dataList[index]['like'] ==
                                      0) {
                                    quoteController.favourite(1,
                                        quoteController.dataList[index]['id']);
                                    favouriteController.insertData(
                                      quoteController.dataList[index]
                                          ['category'],
                                      quoteController.dataList[index]['quote'],
                                      quoteController.dataList[index]['author'],
                                      quoteController.dataList[index]
                                          ['description'],
                                      quoteController.dataList[index]['like'],
                                    );
                                  } else {
                                    quoteController.favourite(0,
                                        quoteController.dataList[index]['id']);
                                    favouriteController.removeFavouriteData(
                                        favouriteController.idList[index]
                                            ['id']);
                                  }
                                },
                                icon:
                                    quoteController.dataList[index]['like'] == 0
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
                      Obx(() => Center(
                          child: Text(
                            quoteController.dataList[index]['quote'],
                            style: TextStyle( fontFamily: quoteController.font.value,
                                color: quoteController.chooseColor.value,
                                fontSize: quoteController.size.value.toDouble()),
                            textAlign: quoteController.txtAlign.value,
                          ))),
                      Obx(() => Text('~ ${quoteController.dataList[index]['author']}',
                          style: TextStyle(
                              fontFamily: quoteController.font.value,
                              color: quoteController.chooseColor.value,
                              fontSize: quoteController.size.value.toDouble()),
                          textAlign: quoteController.txtAlign.value),),

                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //wallpaper
                          IconButton(
                            onPressed: () async {
                              RenderRepaintBoundary boundary = bgImage[selectedIndex]
                                  .currentContext
                                  !.findRenderObject() as RenderRepaintBoundary;

                              ui.Image image = await boundary.toImage();
                              ByteData? bytedata = await image.toByteData(
                                  format: ui.ImageByteFormat.png);
                              Uint8List img = bytedata!.buffer.asUint8List();

                              final path = await getApplicationDocumentsDirectory();
                              File file = File("${path.path}/img.png");
                              file.writeAsBytes(img);
                              ShareExtend.share(file.path, "image");
                              int location = WallpaperManager
                                  .BOTH_SCREEN; //can be Home/Lock Screen
                              bool result =
                              await WallpaperManager.setWallpaperFromFile(
                                  file.path, location);
                              Navigator.pop(context);
                              //
                            },
                            icon: Icon(
                              Icons.wallpaper,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: 300,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Center(
                                              child: Text(
                                            quoteController.dataList[index]
                                                ['quote'],
                                            style: TextStyle(
                                                fontSize: quoteController
                                                    .size.value
                                                    .toDouble(),
                                                color: quoteController
                                                    .chooseColor.value,
                                                fontFamily:
                                                    quoteController.font.value),
                                            textAlign:
                                                quoteController.txtAlign.value,
                                          )),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Obx(
                                            () => Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                      onPressed: () {
                                                        quoteController
                                                            .changeValue
                                                            .value = 1;
                                                      },
                                                      icon: quoteController
                                                                  .changeValue
                                                                  .value !=
                                                              1
                                                          ? Icon(
                                                              Icons
                                                                  .font_download_outlined,
                                                              color: Colors.white,
                                                            )
                                                          : Icon(
                                                              Icons
                                                                  .font_download_outlined,
                                                              color: Colors.orange,
                                                              size: 25,
                                                            )),
                                                  IconButton(
                                                      onPressed: () {
                                                        quoteController
                                                            .changeValue
                                                            .value = 2;
                                                      },
                                                      icon: quoteController
                                                                  .changeValue
                                                                  .value !=
                                                              2
                                                          ? Icon(
                                                              Icons
                                                                  .color_lens_outlined,
                                                              color: Colors.white,
                                                            )
                                                          : Icon(
                                                              Icons
                                                                  .color_lens_outlined,
                                                              color: Colors.orange,
                                                              size: 25,
                                                            )),
                                                  IconButton(
                                                      onPressed: () {
                                                        quoteController
                                                            .changeValue
                                                            .value = 3;
                                                      },
                                                      icon: quoteController
                                                                  .changeValue
                                                                  .value !=
                                                              3
                                                          ? Icon(
                                                              Icons
                                                                  .format_align_center,
                                                              color: Colors.white,
                                                            )
                                                          : Icon(
                                                              Icons
                                                                  .format_align_center,
                                                              color: Colors.orange,
                                                              size: 25,
                                                            )),
                                                  IconButton(
                                                      onPressed: () {
                                                        quoteController
                                                            .changeValue
                                                            .value = 4;
                                                      },
                                                      icon: quoteController
                                                                  .changeValue
                                                                  .value !=
                                                              4
                                                          ? Icon(
                                                              Icons.format_size,
                                                              color: Colors.white,
                                                            )
                                                          : Icon(
                                                              Icons.format_size,
                                                              color: Colors.orange,
                                                              size: 25,
                                                            )),
                                                ],
                                              ),
                                            ),
                                          ),
                                          (quoteController.changeValue.value ==
                                                  1)
                                              ? Padding(
                                                padding: const EdgeInsets.all(5),
                                                child: Row(
                                                    children: [
                                                      Text(
                                                        '  Alignment',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                height * 0.020),
                                                      ),
                                                      //todo alignment
                                                      IconButton(
                                                          onPressed: () {
                                                            quoteController
                                                                    .alignSet
                                                                    .value =
                                                                CrossAxisAlignment
                                                                    .start;
                                                            quoteController
                                                                    .txtAlign
                                                                    .value =
                                                                TextAlign.left;
                                                          },
                                                          icon: Icon(
                                                            Icons
                                                                .align_horizontal_left,
                                                            color: Colors.grey,
                                                          )),
                                                      // todo color
                                                      IconButton(
                                                          onPressed: () {
                                                            quoteController
                                                                    .alignSet
                                                                    .value =
                                                                CrossAxisAlignment
                                                                    .center;
                                                            quoteController
                                                                    .txtAlign
                                                                    .value =
                                                                TextAlign.center;
                                                          },
                                                          icon: Icon(
                                                            Icons
                                                                .align_horizontal_center,
                                                            color: Colors.grey,
                                                          )),
                                                      //todo FontStyle
                                                      IconButton(
                                                          onPressed: () {
                                                            quoteController.alignSet.value = CrossAxisAlignment.end;
                                                            quoteController.txtAlign.value = TextAlign.right;
                                                          },
                                                          icon: Icon(
                                                            Icons
                                                                .align_horizontal_right,
                                                            color: Colors.grey,
                                                          )),
                                                      //todo alignment
                                                      IconButton(
                                                          onPressed: () {

                                                          },
                                                          icon: Icon(
                                                            Icons.text_format,
                                                            color: Colors.grey,
                                                            size: height * 0.035,
                                                          ))
                                                    ],
                                                  ),
                                              )
                                              : (quoteController
                                                          .changeValue.value ==
                                                      2)
                                                  ? SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            '  Text color',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    height *
                                                                        0.022),
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                width * 0.010,
                                                          ),
                                                          ...List.generate(
                                                            quoteController
                                                                .color.length,
                                                            (index) =>
                                                                GestureDetector(
                                                              onTap: () {
                                                                quoteController
                                                                        .chooseColor
                                                                        .value =
                                                                    quoteController
                                                                            .color[
                                                                        index];
                                                              },
                                                              child: Container(
                                                                height: height *
                                                                    0.045,
                                                                width: width *
                                                                    0.090,
                                                                margin: EdgeInsets
                                                                    .all(height *
                                                                        0.007),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color: quoteController
                                                                          .color[
                                                                      index],
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .white,
                                                                      width: 2),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  : (quoteController.changeValue
                                                              .value ==
                                                          3)
                                                      ? SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                '  Font style',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        height *
                                                                            0.020),
                                                              ),
                                                              ...List.generate(
                                                                quoteController
                                                                    .chooseFonts
                                                                    .length,
                                                                (index) =>
                                                                    TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    quoteController
                                                                        .font
                                                                        .value = quoteController
                                                                            .chooseFonts[
                                                                        index];
                                                                  },
                                                                  child: Text(
                                                                    'Sample',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontFamily: quoteController
                                                                            .chooseFonts[
                                                                                index]
                                                                            .toString(),
                                                                        fontSize:
                                                                            height *
                                                                                0.023),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      : Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Text(
                                                              'Text size',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      height *
                                                                          0.022),
                                                            ),
                                                            IconButton(
                                                                onPressed: () {
                                                                  quoteController
                                                                      .size++;
                                                                },
                                                                icon: Icon(
                                                                  Icons
                                                                      .text_increase_outlined,
                                                                  color: Colors
                                                                      .grey,
                                                                  size: height *
                                                                      0.027,
                                                                )),
                                                            Text(
                                                              '${quoteController.size.value}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      height *
                                                                          0.022),
                                                            ),
                                                            IconButton(
                                                                onPressed: () {
                                                                  quoteController
                                                                      .size--;
                                                                },
                                                                icon: Icon(
                                                                  Icons
                                                                      .text_decrease_outlined,
                                                                  color: Colors
                                                                      .grey,
                                                                  size: height *
                                                                      0.027,
                                                                )),
                                                          ],
                                                        ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: Icon(
                                Icons.text_fields,
                                color: Colors.white,
                              )),
                          //copy
                          IconButton(
                              onPressed: () {
                                Clipboard.setData(
                                  ClipboardData(
                                      text:
                                          '${quoteController.dataList[index]['quote'].toString()}\n${quoteController.dataList[index]['author'].toString()}'),
                                );
                              },
                              icon: Icon(
                                Icons.copy,
                                color: Colors.white,
                              )),
                          //share
                          IconButton(
                              onPressed: () async {

                                RenderRepaintBoundary boundary = bgImage[selectedIndex]
                                        .currentContext
                                        ?.findRenderObject()
                                    as RenderRepaintBoundary;
                                ui.Image imageUi = await boundary.toImage();
                                ByteData? byteData = await imageUi.toByteData(
                                    format: ui.ImageByteFormat.png);
                                Uint8List img = byteData!.buffer.asUint8List();
                                final path =
                                    await getApplicationCacheDirectory();
                                File file = File("${path.path}/img.png");
                                file.writeAsBytes(img);
                                ShareExtend.share(file.path, "image");
                              },
                              icon: const Icon(
                                Icons.share,
                                color: Colors.white,
                                size: 30,
                              )),
                          //folder show
                          GestureDetector(
                              onTap: () {
                                favouriteController.folderData();
                                Get.toNamed('/fav');
                              },
                              child: const Icon(
                                Icons.image_sharp,
                                color: Colors.white,
                                size: 30,
                              )),
                          //background image choose
                          IconButton(
                            onPressed: openIconButton,
                            icon: Icon(
                              Icons.info,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
