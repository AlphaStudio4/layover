import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:layover/config/theme.dart';

class CustomTextContainer extends StatelessWidget {
  final TabController? tabController;
  final String text;
  final Function(String)? onClick;
  const CustomTextContainer(
      {Key? key, this.tabController, required this.text, this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: (Get.context!.height / (Get.context!.height / 17))),
      child: Container(
        padding:
            EdgeInsets.all((Get.context!.height / (Get.context!.height / 12))),
        margin: const EdgeInsets.only(top: 5.0, right: 5.0),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [theme().primaryColor, theme().secondaryHeaderColor]),
            borderRadius: BorderRadius.circular(7)),
        child: Text(text,
            style: theme().textTheme.headline6?.copyWith(color: Colors.white)),
      ),
    );
  }
}
