import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../db/db_helper.dart';
import '../../../../util/cardList.dart';
import '../../../../util/color.dart';
import '../../../../util/full.dart';
import '../../../../util/image.dart';
import '../../../../util/searchfence.dart';
import '../../../../util/toast.dart';
import '../../login/controllers/login_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    List<Widget> personDataForm= [];
    Drawer drawer = Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            decoration: BoxDecoration(color: ColorUtil.fromHex(LoginController.setColor.value)),
            child:
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (ctx, animation, animation2) {
                            return FadeTransition(
                              opacity: animation,
                              child: Obx(()=>ImageDetail(controller.user['portrait'])),
                            );
                          }));
                    },
                    child: Center(
                      child: Obx(()=>Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(
                              File(controller.user['portrait'],),
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(150),
                          border: Border.all(color: Colors.white, width: 2),// border
                        ),
                      )),
                    ),
                  ),
                ),
                Expanded(
                    flex: 8,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Hello',style: TextStyle(color:Colors.white,fontSize: 24,fontWeight: FontWeight.w600),),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Obx(()=>Text(controller.user['name'],style: const TextStyle(color:Colors.white,fontSize: 36,fontWeight: FontWeight.w600),)),
                          ),
                        ],
                      ),
                    )
                ),

              ],
            ),
          ),
          // FullButton
          // Container(
          //   padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          //   child: Container()
          // ),
          FullButton(
              title: 'MySelf',
              onPressed: () { Get.toNamed('/updateuser',arguments: controller.user.value)?.then((value) async {
                if (value == null) return;
                if (value == true) {
                  MyToast.success('修改成功！');
                  controller.isLogging();
                }
              }); },
              iconPath: '',
              showDivider:true
          ),
          FullButton(
              title: 'About',
              onPressed: () { Get.toNamed('/about'); },
              iconPath: '',
              showDivider:true
          ),
          // FullButton(
          //     title: '数据中心',
          //     onPressed: () {  },
          //     iconPath: '',
          //     showDivider:true
          // ),
          // FullButton(
          //   title: '系统设置',
          //   onPressed: () {  },
          //   iconPath: '',
          // ),
          const Spacer(),
          const Divider(),
          FullButton(
            title: 'Logout',
            onPressed: () { controller.logout(); },
            iconPath: '',
          ),
        ],
      )
    );
    return Scaffold(
      key: scaffoldKey,
      drawer: drawer,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.person,),
          onPressed: (){openDrawer();},//controller.turnLogin,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle,color: Colors.white,),
            onPressed: (){
              Get.toNamed('/addperson',arguments: controller.user.value)?.then((value) async {
                if (value == null) return;
                if (value == true) {
                  MyToast.success('Success！');
                  controller.getPersons();
                }
              });
            },//controller.turnLogin,
          ),
        ],
        elevation: 0,
        backgroundColor: ColorUtil.fromHex(LoginController.setColor.value),
        title: const Text('Easy Care'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child:ConstrainedBox( //约束盒子
          constraints: const BoxConstraints.expand(),//不指定高和宽时则铺满整个屏慕
          child: Stack(
            alignment:Alignment.center , //指定对齐方式为居中
            children: <Widget>[ //子组件列表
              controller.obx((state) => Center(
                child: controller.persons.value.isNotEmpty?MyCardList(
                  FrontHeight: controller.persons.value.length > 5?50:0,
                  onLongPress: (id) {
                    Get.toNamed('/updateperson',arguments: id)?.then((value) async {
                      if (value == null) return;
                      if (value == true) {
                        MyToast.success('修改成功！');
                        controller.getPersons();
                      }
                    });
                  },
                  onTap: (id) async {
                    Map res = await tableDb.getPerson(id);
                    Get.toNamed('/table',arguments: res)?.then((value) async {
                      if (value == null) return;
                      if (value == true) {
                        MyToast.success('Del Success');
                        controller.getPersons();
                      }
                    });
                  },
                  dropdown: () {  },
                  pullup: () {  },
                  onPressed: (value) {  },
                  DataForm: controller.persons.value,
                ):const Text("No record"),
              )),
              Obx(()=>controller.persons.value.length > 5?Positioned(
                top: 0.0,//距离顶部18px（在中轴线上,因为Stack摆放在正中间）
                child: MySearchFence(
                  fontColor: ColorUtil.fromHex(LoginController.setColor.value),
                  onSearch:(value){controller.search.text= value;controller.getPersons();},// 回调函数传值
                  rightIcon: Icons.restart_alt_outlined,
                  hasRightIcon: false,
                  // hasRightIcon: false,
                  onIcon:(value){controller.search.text= value;controller.getPersons();},// 回调函数传值
                  onClean: (value){controller.search.text= value;controller.getPersons();},
                  onChange: (value){controller.search.text= value;controller.getPersons();},
                ),
              ):const SizedBox()),
            ],
          ),
        ),
      ),
    );
  }

  void openDrawer(){
    scaffoldKey.currentState!.openDrawer();
  }
}
