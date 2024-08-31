import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app/controller/quote_Controller.dart';
import 'package:quotes_app/modal/quote_modal.dart';
import 'package:quotes_app/utils/imageList/list.dart';

import '../utils/global.dart';
import 'detail.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    QuoteController quoteController = Get.put(QuoteController());
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white70,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xFF2D2D2D),
        title: Text(
          'Status & Quotes',
          style: TextStyle(
              color: Colors.white,
              letterSpacing: height * 0.001,
              fontFamily: 'OFL',
              fontWeight: FontWeight.w600,
              fontSize: height * 0.027),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: Colors.yellow,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height * 0.260,
              width: double.infinity,
              margin: EdgeInsets.only(bottom: height * 0.020),
              decoration: BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/img/images/cate.jpg')),
                borderRadius: BorderRadius.circular(height * 0.015),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/detail');
                      },
                      child: Container(
                        height: height * 0.065,
                        width: width * 0.140,
                        margin: EdgeInsets.only(bottom: height * 0.007),
                        decoration: BoxDecoration(
                          color: Color(0xFFA15485),
                          borderRadius: BorderRadius.circular(height * 0.010),
                        ),
                        child: Icon(
                          Icons.grid_view,
                          color: Colors.white,
                          size: height * 0.040,
                        ),
                      ),
                    ),
                    Text(
                      'Categories',
                      style: TextStyle(
                          fontSize: height * 0.020,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: height * 0.065,
                      width: width * 0.140,
                      margin: EdgeInsets.only(bottom: height * 0.007),
                      decoration: BoxDecoration(
                        color: Color(0xFFB78F42),
                        borderRadius: BorderRadius.circular(height * 0.010),
                      ),
                      child: Icon(
                        Icons.image_outlined,
                        color: Colors.white,
                        size: height * 0.040,
                      ),
                    ),
                    Text(
                      'Quotes',
                      style: TextStyle(
                          fontSize: height * 0.020,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: height * 0.065,
                      width: width * 0.140,
                      margin: EdgeInsets.only(bottom: height * 0.007),
                      decoration: BoxDecoration(
                        color: Color(0xFF7488C6),
                        borderRadius: BorderRadius.circular(height * 0.010),
                      ),
                      child: Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: height * 0.035,
                      ),
                    ),
                    Text(
                      'Latest',
                      style: TextStyle(
                          fontSize: height * 0.020,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: height * 0.065,
                      width: width * 0.140,
                      margin: EdgeInsets.only(bottom: height * 0.007),
                      decoration: BoxDecoration(
                        color: Color(0xFF6B9877),
                        borderRadius: BorderRadius.circular(height * 0.010),
                      ),
                      child: Icon(
                        Icons.menu_book_outlined,
                        color: Colors.white,
                        size: height * 0.040,
                      ),
                    ),
                    Text(
                      'Articles',
                      style: TextStyle(
                          fontSize: height * 0.020,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: height * 0.020,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                ' Most Popular',
                style: TextStyle(
                    letterSpacing: height * 0.0005,
                    color: Colors.black,
                    fontFamily: 'chocolate',
                    fontSize: height * 0.024,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: height * 0.010,
            ),
            Expanded(
              child: GridView.builder(
                itemCount: imageList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) => Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        selectedIndex = index;
                        quote = quoteController.dataList[index]['category'];
                        print(quote);
                        Get.toNamed('/detail');
                      },
                      child: Container(
                        height: height * 0.160,
                        width: width * 0.430,
                        margin: EdgeInsets.only(
                          top: height * 0.020,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(imageList[index]['img'])),
                        ),
                      ),
                    ),
                    Text(
                      '${quoteController.dataList[index]['category']} Status',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'OFL',
                          fontWeight: FontWeight.w600,
                          fontSize: height * 0.020),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
