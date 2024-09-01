import 'dart:io';
import 'dart:typed_data';

import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quotes_app/controller/favourite_controller.dart';
import 'package:quotes_app/utils/imageList/list.dart';
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
            url: bgList[quoteController.bgIndex.value],
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
            url: bgList[quoteController.bgIndex.value],
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
            url: bgList[quoteController.bgIndex.value],
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
          key: bgImage[quoteController.selectedIndex.value],
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                      bgList[quoteController.bgIndex.value]['bg'].toString())),
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
                                quoteController.favourite(
                                    1, quoteController.dataList[index]['id']);
                                favouriteController.insertData(
                                  quoteController.dataList[index]['category'],
                                  quoteController.dataList[index]['quote'],
                                  quoteController.dataList[index]['author'],
                                  quoteController.dataList[index]
                                      ['description'],
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
                            onPressed: () {
                              Clipboard.setData(ClipboardData(
                                  text:
                                      '${quoteController.dataList[index]['quote']}\n${quoteController.dataList[index]['author']}'));

                              const ScaffoldMessenger(
                                child: SnackBar(
                                  content: Text('save quote'),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.copy,
                              color: Colors.white,
                            )),
                        IconButton(
                            onPressed: () async {
                              quoteController.selectedIndex.value = index;
                              RenderRepaintBoundary boundary = bgImage[index]
                                  .currentContext
                                  ?.findRenderObject() as RenderRepaintBoundary;
                              ui.Image imageUi = await boundary.toImage();
                              ByteData? byteData = await imageUi.toByteData(
                                  format: ui.ImageByteFormat.png);
                              Uint8List img = byteData!.buffer.asUint8List();
                              final path = await getApplicationCacheDirectory();
                              File file = File("${path.path}/img.png");
                              file.writeAsBytes(img);
                              ShareExtend.share(file.path, "image");
                            },
                            icon: const Icon(
                              Icons.share,
                              color: Colors.white,
                              size: 30,
                            )),
                        IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: 230,
                                    decoration: const BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            topLeft: Radius.circular(20))),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Divider(
                                          thickness: 2,
                                          color: Colors.grey,
                                          indent: 190,
                                          endIndent: 190,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          "Set as Wallpaper\n",
                                          style: TextStyle(
                                              color: Colors.purple,
                                              fontSize: 20),
                                        ),
                                        ...List.generate(
                                          _iconList.length,
                                          (index) => GestureDetector(
                                            onTap: () {
                                              _selectMenuItem(
                                                  _dropdownItems[index]);
                                            },
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    _iconList[index],
                                                    color: Colors.white,
                                                    size: 25,
                                                  ),
                                                ),
                                                Text(
                                                  _dropdownItems[index],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            icon: Icon(
                              Icons.wallpaper,
                              color: Colors.white,
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
                            child: const Icon(
                              Icons.image_sharp,
                              color: Colors.white,
                              size: 30,
                            )),
                        IconButton(
                          onPressed: openIconButton,
                          icon: Icon(
                            Icons.info,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
