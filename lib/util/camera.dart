import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';

import '../app/modules/login/controllers/login_controller.dart';
import 'color.dart';

class MyCamera extends StatefulWidget {
  // 传入参数
  const MyCamera({
    Key? key,
    this.title = '图片选择', // 高度
    this.max = 1,
    this.cameraLabel = '相机',
    this.galleryLabel = '相册',
    this.camera = true ,
    this.gallery = true ,
    this.width = 20,
    this.height = 25,
    this.defpic = '',
    required this.other,
    required this.values,
  }) : super(key: key,);
  final String title;
  final int max;
  final String cameraLabel;
  final String galleryLabel;
  final bool camera;
  final bool gallery;
  final Widget other;
  final double width;
  final double height;
  final String defpic;
  final ValueChanged<String> values;

  @override
  State<StatefulWidget> createState() => MyCameraState();

}

class MyCameraState extends State<MyCamera> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.other,
        FormBuilder(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    width: widget.width,
                    height: widget.height,
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: widget.defpic == ''?FormBuilderImagePicker(
                      bottomSheetPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      previewHeight: widget.height,
                      previewWidth: widget.width,
                      iconColor: ColorUtil.fromHex(LoginController.setColor.value),
                      name: 'photos',
                      maxImages: widget.max,
                      onChanged:(val){
                        if (widget.max == 1) {
                          if(_formKey.currentState!.saveAndValidate()){
                            List Imgs = _formKey.currentState!.value['photos'];
                            if (Imgs.isNotEmpty) {
                              widget.values(Imgs[0].path);
                            }
                          }
                        }
                      },
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        border: InputBorder.none,
                      ),
                      cameraLabel: widget.camera? Text( widget.cameraLabel):Container(),
                      galleryLabel: widget.gallery?Text(widget.galleryLabel):Container(),
                    ):FormBuilderImagePicker(
                      placeholderImage:FileImage(File(widget.defpic,),),
                      fit: BoxFit.cover,
                      bottomSheetPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      previewHeight: widget.height,
                      previewWidth: widget.width,
                      iconColor: ColorUtil.fromHex(LoginController.setColor.value),
                      name: 'photos',
                      maxImages: widget.max,
                      onChanged:(val){
                        if (widget.max == 1) {
                          if(_formKey.currentState!.saveAndValidate()){
                            List Imgs = _formKey.currentState!.value['photos'];
                            if (Imgs.isNotEmpty) {
                              widget.values(Imgs[0].path);
                            }
                          }
                        }
                      },
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        border: InputBorder.none,
                      ),
                      cameraLabel: widget.camera? Text( widget.cameraLabel):Container(),
                      galleryLabel: widget.gallery?Text(widget.galleryLabel):Container(),
                    ),
                  ),
                ]
            )
        ),
      ],
    );
  }


}