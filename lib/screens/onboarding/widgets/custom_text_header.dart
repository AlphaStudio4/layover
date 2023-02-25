import 'package:flutter/material.dart';
import 'package:layover/config/theme.dart';

class CustomTextHeader extends StatelessWidget {
  final String text;
  final TabController? tabController;

  const CustomTextHeader({
    Key? key,
    required this.text,
    this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline2!.copyWith(
          fontWeight: FontWeight.normal,
          fontSize: (MediaQuery.of(context).size.height /
              (MediaQuery.of(context).size.height / 26)),
          height: 1.4,
          wordSpacing: 3,
          color: Color.fromARGB(255, 35, 41, 82)),
    );
  }
}
