// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, unused_element, prefer_const_literals_to_create_immutables

import 'package:file_converter_app/Widgets/button_pdf_screen.dart';
import 'package:file_converter_app/Widgets/mybottonwidget.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_converter_app/constant/textstyle_constant.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ImageToPdf extends StatefulWidget {
  ImageToPdf({Key? key}) : super(key: key);

  @override
  _ImageToPdf createState() => _ImageToPdf();
}

class _ImageToPdf extends State<ImageToPdf> {
  File? file;
  ImagePicker image = ImagePicker();
  getImage() async {
    var img = await image.pickImage(source: ImageSource.gallery);
    if (img != null) {
      setState(() {
        //null error here
        file = File(img.path);
      });
    }
  }

  getImagecam() async {
    var img = await image.pickImage(source: ImageSource.camera);

    setState(() {
      file = File(img!.path);
    });
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, file) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();

    final showimage = pw.MemoryImage(file.readAsBytesSync());

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Center(
            child: pw.Image(showimage, fit: pw.BoxFit.contain),
          );
        },
      ),
    );

    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color(0xffb93333),
        title: Text("Image To Pdf"),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
      ),
      body: file == null
          ? Container(
              padding: EdgeInsets.all(20),
              color: Colors.white10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Create PDF from image",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  sizedBox15(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PdfScreenButtons(
                        icon: Icon(
                          Icons.folder,
                          size: 40,
                        ),
                        gradient: LinearGradient(colors: <Color>[
                          Color(0xfff23e12),
                          Color(0xfff48516)
                        ]),
                        text: "Select Iamge",
                        onPress: getImage,
                      ),
                      SizedBox(width: 40),
                      PdfScreenButtons(
                        icon: Icon(
                          Icons.camera_alt,
                          size: 40,
                        ),
                        gradient: LinearGradient(colors: <Color>[
                          Color(0xfff23e12),
                          Color(0xfff48516)
                        ]),
                        text: "Capture Image",
                        onPress: getImagecam,
                      )
                    ],
                  ),

                  ///four botton unfunctioneld till now
                  Divider(
                    height: 3,
                    color: Colors.red,
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      PdfScreenButtons(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              Color(0xffbc2f71),
                              Color(0xffe03a5e),
                              Color(0xfff24f45)
                            ]),
                        text: "Edit Image",
                        onPress: () {},
                        icon: Icon(Icons.image, size: 40),
                      ),
                      // SizedBox(width: 60),
                      PdfScreenButtons(
                        gradient: LinearGradient(colors: <Color>[
                          Color(0xff01cd88),
                          Color(0xff049abe)
                        ]),
                        text: "Password",
                        onPress: () {},
                        icon: Icon(Icons.lock, size: 40),
                      ),
                    ],
                  ),
                  sizedBox20(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      PdfScreenButtons(
                        gradient: LinearGradient(colors: <Color>[
                          Color(0xffd7d758),
                          Color(0xff82c94e),
                          Color(0xff1dac4f)
                        ]),
                        text: "Compress Image",
                        onPress: () {},
                        icon: Icon(Icons.image_not_supported, size: 40),
                      ),
                      // SizedBox(width: 60),
                      PdfScreenButtons(
                        gradient: LinearGradient(colors: <Color>[
                          Color(0xff8d4ade),
                          Color(0xffa667d8),
                          Color(0xffc288d2)
                        ]),
                        text: "View Pdf preview",
                        onPress: () {},
                        icon: Icon(Icons.image, size: 40),
                      ),
                    ],
                  ),
                  Spacer()
                ],
              ),
            )
          : PdfPreview(
              build: (format) => _generatePdf(format, file),
            ),
    );
  }

  // getImageFromGallery() async {
  //   final pickedfile = await picker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     if (pickedfile != null) {
  //       _image = File(pickedfile.path);
  //     } else {
  //       print("no image Selected");
  //     }
  //   });
  // }
}
