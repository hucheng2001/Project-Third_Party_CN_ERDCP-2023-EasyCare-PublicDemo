import 'dart:io';

import 'package:flutter/material.dart';

class ImageDetail extends StatelessWidget {
  final String imageURL;

  ImageDetail(this.imageURL);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Hero(
                tag: imageURL,
                child: Image.file(
                  File(imageURL,),
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              // Image.network(
              //   this.imageURL,
              //   width: double.infinity,
              //   fit: BoxFit.cover,
              //   errorBuilder: (ctx,err,stackTrace) => Image.asset(
              //       'assets/images/nopic.png',//默认显示图片
              //       fit: BoxFit.cover,
              //   )
              // ),
            )),
      ),
    );
  }
}