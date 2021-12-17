// ignore_for_file: prefer_const_constructors


import 'package:file_converter_app/screens/homescreen.dart';
import 'package:file_converter_app/screens/pdf_to_word.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:file_converter_app/screens/imageto_pdf.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Image To Pdf',
        home: HomeScrenScreen());
  }
}
