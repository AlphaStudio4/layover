import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:layover/config/theme.dart';

class InterestButton extends StatelessWidget {
  final String text;
  final Color? beginColor;
  final Color? endColor;
  final Color textColor;
  final bool hasBeenPressed;
  final Function()? onpressed;
  const InterestButton(
      {Key? key,
      required this.text,
      this.beginColor,
      this.endColor,
      required this.hasBeenPressed,
      required this.textColor,
      this.onpressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14.0, right: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: LinearGradient(
                colors: hasBeenPressed
                    ? [
                        Color.fromARGB(255, 11, 73, 98),
                        Color.fromARGB(255, 41, 140, 180)
                      ]
                    : [
                        Color.fromARGB(255, 78, 103, 187),
                        theme().secondaryHeaderColor
                      ])),
        child: ElevatedButton(
          onPressed: onpressed,
          style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              elevation: 0,
              fixedSize: Size((Get.context!.width / (Get.context!.width / 100)),
                  (Get.context!.height / (Get.context!.height / 20)))),
          child: Container(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: theme().textTheme.headline4!.copyWith(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
