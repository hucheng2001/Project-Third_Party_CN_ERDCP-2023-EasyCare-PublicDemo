import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../util/card.dart';
import '../../../../util/color.dart';
import '../../../../util/imagebutton.dart';
import '../../../../util/nearEventList.dart';
import '../../login/controllers/login_controller.dart';
import '../controllers/table_controller.dart';

class TableView extends GetView<TableController> {

  void delCheck() async {
    Get.defaultDialog(
      title: 'Check Del',
      radius: 10.0,
      barrierDismissible: false,
      content: Center(
        child: Container(
            padding: const EdgeInsets.all(16.0),
            child: const Text('删除后数据将不可恢复，请确认是否删除！',style: TextStyle(color: Colors.red),)
        ),
      ),
      confirm: MaterialButton(
        color: ColorUtil.fromHex(LoginController.setColor.value),
        textColor: Colors.white,
        child: const Text('confirm', style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600)),
        onPressed: () {
          Get.back();
          controller.delPerson();
        },
      ),
      cancel: MaterialButton(
        color: Colors.white,
        textColor: ColorUtil.fromHex(LoginController.setColor.value),
        child: const Text('cancel', style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600)),
        onPressed: () {
          Get.back();
        },
      ),
    );
  }

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
        title: Text(controller.personData['name']),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            child: controller.obx((state) => ListView(
              scrollDirection: Axis.vertical,
              children: [
                Column(
                  children: [
                    MyCard(
                      showOther: true,
                      other: Column(
                        children: [
                          const SizedBox(height: 3,),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: controller.personData['sex']=='woman'?Icon(Icons.description,color: ColorUtil.fromHex('#e17bbf'),size: 24,):Icon(Icons.description,color: ColorUtil.fromHex('#7dbee3'),size: 24,),
                                  ),
                                  Expanded(
                                    flex: 12,
                                    child: Text(controller.personData['desc'],style: const TextStyle(color:Colors.black87,fontSize: 12,fontWeight: FontWeight.w600),),
                                  ),
                                ],
                              )
                          )
                        ],
                      ),
                      onTap: () { },
                      onLongPress: () { delCheck(); },
                      data: controller.personData,
                    ),
                    // SizedBox(height: 10,),
                    Card(
                        margin: const EdgeInsets.only(right: 16, left: 16, top: 10, bottom: 10,),
                        child: Container(
                          padding: const EdgeInsets.only(right: 0, left: 0, top: 10, bottom: 10,),
                          child: controller.personData['sex'] == 'woman'?Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              MyImgButton(text:'Period',onTap: () { Get.toNamed('/period',arguments: controller.personData); },height: 50.0,width: 50,fontSize: 10,fontColor: Colors.black54,imgPath: 'assets/images/system/01.png',),
                              MyImgButton(text:'Event',onTap: () { Get.toNamed('/event',arguments: controller.personData); },height: 50.0,width: 50,fontSize: 10,fontColor: Colors.black54,imgPath: 'assets/images/system/02.png',),
                              MyImgButton(text:'Todo',onTap: () { Get.toNamed('/todo',arguments: controller.personData); },height: 50.0,width: 50,fontSize: 10,fontColor: Colors.black54,imgPath: 'assets/images/system/03.png',),
                              MyImgButton(text:'Note',onTap: () { Get.toNamed('/notetype',arguments: controller.personData); },height: 50.0,width: 50,fontSize: 10,fontColor: Colors.black54,imgPath: 'assets/images/system/04.png',),
                            ],
                          ):Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              MyImgButton(text:'Event',onTap: () { Get.toNamed('/event',arguments: controller.personData); },height: 50.0,width: 50,fontSize: 10,fontColor: Colors.black54,imgPath: 'assets/images/system/02.png',),
                              MyImgButton(text:'Todo',onTap: () { Get.toNamed('/todo',arguments: controller.personData); },height: 50.0,width: 50,fontSize: 10,fontColor: Colors.black54,imgPath: 'assets/images/system/03.png',),
                              MyImgButton(text:'Note',onTap: () { Get.toNamed('/notetype',arguments: controller.personData); },height: 50.0,width: 50,fontSize: 10,fontColor: Colors.black54,imgPath: 'assets/images/system/04.png',),
                            ],
                          ),
                        )
                    ),
                    Container(
                      // margin: const EdgeInsets.only(right: 16, left: 16, top: 10, bottom: 10,),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Card(
                              margin: const EdgeInsets.only(right: 8, left: 16, top: 10, bottom: 10,),
                              child: Container(
                                padding: const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10,),
                                child: Obx(()=>Column(
                                  children: [
                                    Text.rich(
                                        TextSpan(
                                            children: [
                                              const TextSpan( text: '茫茫人海，我们相遇在',style: TextStyle(fontSize:15.0,),),
                                              TextSpan( text: ' ' + controller.personData['knowDate'] + ' ',style: TextStyle(fontSize:20.0,fontWeight:FontWeight.w600,color: ColorUtil.fromHex(LoginController.setColor.value)),),
                                              const TextSpan( text: ', 已经认识了 ',style: TextStyle(fontSize:15.0,),),
                                              TextSpan( text: "${controller.differenceDays.value} " ,style: TextStyle(fontSize:20.0,fontWeight:FontWeight.w600,color: ColorUtil.fromHex(LoginController.setColor.value)),),
                                              const TextSpan( text: '天了',style: TextStyle(fontSize:15.0,),),
                                            ]
                                        )
                                    ),
                                  ],
                                )),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Card(
                              margin: const EdgeInsets.only(right: 16, left: 8, top: 10, bottom: 10,),
                              child: Container(
                                padding: const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10,),
                                child: Obx(()=>Column(
                                  children: [
                                    Text.rich(
                                        TextSpan(
                                            children: [
                                              TextSpan( text: controller.xingzuo.value,style: TextStyle(fontSize:20.0,fontWeight:FontWeight.w600,color: ColorUtil.fromHex(LoginController.setColor.value)),),
                                              const TextSpan( text: ' 的你出生于',style: TextStyle(fontSize:15.0,),),
                                              TextSpan( text: ' ' + controller.personData['birthday'] + ' ',style: TextStyle(fontSize:20.0,fontWeight:FontWeight.w600,color: ColorUtil.fromHex(LoginController.setColor.value)),),
                                              const TextSpan( text: ', 距离生日还有 ',style: TextStyle(fontSize:15.0,),),
                                              TextSpan( text: "${controller.birthdayDifferenceDays.value} " ,style: TextStyle(fontSize:20.0,fontWeight:FontWeight.w600,color: ColorUtil.fromHex(LoginController.setColor.value)),),
                                              const TextSpan( text: '天',style: TextStyle(fontSize:15.0,),),
                                            ]
                                        )
                                    ),
                                  ],
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                controller.events.value.isNotEmpty?
                MyNearEventList(
                  FrontHeight: 0,
                  onEdit: (item) {},
                  onDel: (item) async {},
                  dropdown: () {  },
                  pullup: () {  },
                  onPressed: (value) {  },
                  DataForm: controller.events.value,
                ):const SizedBox(),
              ],
            ))
          ),
          Positioned(
              right: 5,//左边边距18px
              bottom:100,
              child: MyImgButton(
                text: '',
                width: 50,
                height: 50,
                imgPath: 'assets/images/system/tel.png',
                onTap: () { print('打电话');launch("tel:${controller.personData['tel']}"); },
              )

          ),
        ],
      )

    );
  }
}
