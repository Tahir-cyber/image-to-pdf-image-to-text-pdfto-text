// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables


import 'package:file_converter_app/constant/textstyle_constant.dart';
import 'package:flutter/material.dart';

class MyButtonWidget extends StatelessWidget {
  final Gradient? gradient;
  final String text;
  final Color? color;
  final VoidCallback onPress;
  final String image;
  MyButtonWidget({
    Key? key,
    this.gradient,
    required this.text,
    this.color,
    required this.onPress,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                  
                    scale: 10, image: AssetImage(
                 
                    image)),
                  borderRadius: BorderRadius.circular(35),
                  gradient: gradient),
            ),
            SizedBox(height: 5),
            Text(
              text,
              style: kButtonTextStyle(),
            )
          ],
        ),
      ),
    );
  }
}
