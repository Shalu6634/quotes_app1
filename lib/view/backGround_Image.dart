import 'package:flutter/material.dart';

import '../utils/imageList/list.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      GridView.builder(
        itemCount: bgList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 3 / 4),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
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
    );
  }
}
