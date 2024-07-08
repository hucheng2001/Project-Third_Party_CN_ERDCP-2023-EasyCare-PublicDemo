import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../util/color.dart';
import '../../login/controllers/login_controller.dart';
import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: Get.back,//controller.turnLogin,
        ),
        elevation: 0,
        backgroundColor: ColorUtil.fromHex(LoginController.setColor.value),
        title: const Text('About'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(height: 20,),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Text.rich(
                TextSpan(
                    children: [
                      TextSpan( text: 'EasyCare ',style: TextStyle(fontSize:25.0,color: ColorUtil.fromHex(LoginController.setColor.value),fontWeight: FontWeight.w600),),
                      TextSpan( text: 'A mobile application designed and developed using the Flutter framework combined with GetX technology and sqflite technology.',style: TextStyle(fontSize:15.0,),),
                      TextSpan( text: 'Fully leveraging modern state management and local database storage technologies, EasyCare is committed to providing a secure, convenient, and personalized user experience. Through innovative feature design and technical solutions, EasyCare combines relationship records and data privacy protection to provide users with a trustworthy and user-friendly electronic journal application.',style: TextStyle(fontSize:15.0,),),
                      ]
                )
            ),
          ),
        ],
      ),
    );
  }
}
