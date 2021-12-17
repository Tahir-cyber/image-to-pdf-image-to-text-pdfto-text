// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io' as Io;
import 'package:file_converter_app/screens/parsedtext.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:file_converter_app/Widgets/mybottonwidget.dart';
import 'package:file_converter_app/screens/imageto_pdf.dart';
import 'package:file_converter_app/screens/pdf_to_word.dart';

class HomeScrenScreen extends StatefulWidget {
  const HomeScrenScreen({Key? key}) : super(key: key);

  @override
  State<HomeScrenScreen> createState() => _HomeScrenScreenState();
}

class _HomeScrenScreenState extends State<HomeScrenScreen> {
  bool isLoading = false;
  String parsedtext = '';
  parsethetext() async {
    // pick a image
    var imagefile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxWidth: 670, maxHeight: 970);

    if (imagefile != null) {
      //print("hey you have image");
      // prepare the image
      var bytes = Io.File(imagefile.path.toString()).readAsBytesSync();
      String img64 = base64Encode(bytes);
       //print(img64.toString());

      // send to api
      var url = Uri.parse('https://api.ocr.space/parse/image');
      var payload = {
        "base64Image": "data:image/jpg;base64,${img64.toString()}"
      };
      var header = {"apikey": '13d95900e888957'};
      var post = await http.post(url = url, body: payload, headers: header);
      if (post.body.isNotEmpty) {
        // get result from api
        var result = jsonDecode(post.body);

        setState(() {
          parsedtext = result['ParsedResults'][0]['ParsedText'];
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ParsedTextScreen(
                      text: parsedtext,
                    ))).then((value) {
          setState(() {
            isLoading = false;
          });
        });
      } else {
        CircularProgressIndicator();
      }
    } else {
      print("in else state");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff770707),
        centerTitle: true,
        title: Text("Image Converter"),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: isLoading == false
          ? Container(
              margin: EdgeInsets.symmetric(vertical: 30),

              width: MediaQuery.of(context).size.width,

              color: Colors.white,
              //decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                children: [
                  //first button
                  //convert Image to pdf
                  MyButtonWidget(
                    gradient: LinearGradient(
                        colors: <Color>[Color(0xffa850ff), Color(0xff7092fe)]),
                    text: "Convert Image To Pdf",
                    color: Colors.white,
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImageToPdf()));
                    },
                    image: "assets/images/imagetotext.png",
                  ),

                  //Second button
                  //image to text
                  MyButtonWidget(
                    gradient: LinearGradient(
                        colors: <Color>[Color(0xfff23e12), Color(0xfff48516)]),
                    onPress: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await parsethetext();
                    },
                    image: "assets/images/imagetopdf.png",
                    text: "Convert Image To Text",
                  ),

                  //3rd button
                  //convert pdf to word and pdf viewer
                  MyButtonWidget(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[
                            Color(0xfffe575f),
                            Color(0xfffb577d),
                            Color(0xfff857a1)
                          ]),
                      text: "Convert PDF To Text",
                      color: Colors.white,
                      onPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PdfToWord()));
                      },
                      image: "assets/images/imagetext.png"),
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
