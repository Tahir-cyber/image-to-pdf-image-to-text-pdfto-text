import 'package:file_converter_app/constant/textstyle_constant.dart';
import 'package:flutter/material.dart';

class PdfScreenButtons extends StatelessWidget {
  final Gradient? gradient;
  final String text;
  final Color? color;
  final VoidCallback onPress;
  final String? image;
  Icon? icon;
  PdfScreenButtons(
      {Key? key,
      this.gradient,
      required this.text,
      this.color,
      required this.onPress,
      this.image,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), gradient: gradient),
              child: icon,
            ),
            sizedBox15(),
            Container(
              width: 80,
              child: Text(
                text,
                style: kButtonSmallTextStyle(),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
