import 'package:flutter/material.dart';
// import 'package:maifeng_app/app/modules/team/views/team_web_view.dart';
// import 'constants.dart' show Constants, AppColors;

class FullButton extends StatelessWidget {
  static const HORIZONTAL_PADDING = 20.0;
  static const VERTICAL_PADDING = 13.0;

  const FullButton({
    required this.title,
    required this.iconPath,
    required this.onPressed,
    this.showDivider = false,
    this.center = false,
    this.unImg = false,
    this.unIcon = false,
    this.iconData = Icons.arrow_forward_ios,
    this.iconColor = Colors.black38,
  });

  final String title;
  final String iconPath;
  final bool showDivider;
  final IconData iconData;
  final Color iconColor;
  final bool center;
  final bool unImg;
  final bool unIcon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final pureButton = unImg?Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // Image.asset(iconPath, width: 24.0, height: 24.0),
        // const SizedBox(width: HORIZONTAL_PADDING),
        Expanded(child: center?Center(child: Text(title),):Text(title)),
        unIcon?const SizedBox():Icon(iconData, color: iconColor, size: 18.0),
      ],
    ):Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        iconPath.contains('http') ? Image.network(
          iconPath,
          width: 24,
          height: 24,
          fit: BoxFit.cover,
        ): Image(
          image:iconPath=='' ? const AssetImage('assets/images/system/logo.png') : AssetImage(iconPath),
          width: 24.0,
          height: 24.0,
          fit: BoxFit.cover,
        ),

        // Image.asset(iconPath, width: 24.0, height: 24.0),
        const SizedBox(width: HORIZONTAL_PADDING),
        Expanded(child: center?Center(child: Text(title),):Text(title)),
        unIcon?const SizedBox():Icon(iconData, color: iconColor, size: 18.0),
      ],
    );

    final borderButton = Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xffd9d9d9),
            width: 0.5,
          ),
        ),
      ),
      padding: const EdgeInsets.only(bottom: VERTICAL_PADDING),
      child: pureButton,
    );

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.only(
            left: HORIZONTAL_PADDING,
            right: HORIZONTAL_PADDING,
            top: VERTICAL_PADDING,
            bottom: showDivider ? 0.0 : VERTICAL_PADDING),
        color: Colors.white,
        child: showDivider ? borderButton : pureButton,
      ),
    );
  }
}
