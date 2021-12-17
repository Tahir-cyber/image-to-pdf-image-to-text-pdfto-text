// // ignore_for_file: prefer_const_constructors, library_prefixes
// import 'dart:convert';

// import 'package:file_converter_app/constant/textstyle_constant.dart';
// import 'package:file_converter_app/screens/parsedtext.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;

// import 'dart:io' as Io;

// class ImageToText extends StatefulWidget {
//   ImageToText({Key? key}) : super(key: key);

//   @override
//   _ImageToTextState createState() => _ImageToTextState();
// }

// class _ImageToTextState extends State<ImageToText> {
//   String parsedtext = '';
//   parsethetext() async {
//     // pick a image
//     final imagefile = await ImagePicker()
//         .pickImage(source: ImageSource.gallery, maxWidth: 670, maxHeight: 970);

//     // prepare the image
//     var bytes = Io.File(imagefile!.path.toString()).readAsBytesSync();
//     String img64 = base64Encode(bytes);
//     print(img64.toString());

//     // send to api
//     var url = Uri.parse('https://api.ocr.space/parse/image');
//     var payload = {"base64Image": "data:image/jpg;base64,${img64.toString()}"};
//     var header = {"apikey": '13d95900e888957'};
//     var post = await http.post(url = url, body: payload, headers: header);

//     // get result from api
//     var result = jsonDecode(post.body);

//     setState(() {
//       parsedtext = result['ParsedResults'][0]['ParsedText'];
//     });
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) => ParsedTextScreen(
//                   text: parsedtext,
//                 )));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         title: Text(
//           "Image To Text",
//           style: appbarTextStyle(),
//         ),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Center(
//             child: Container(
//                 width: MediaQuery.of(context).size.width / 2,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(primary: Colors.amber),
//                   onPressed: () => parsethetext(),
//                   child: Row(
//                     children: [
//                       Icon(Icons.text_snippet_rounded),
//                       Text("Upload an image")
//                     ],
//                   ),
//                 )),
//           ),
//         ],
//       ),
//     );
//   }
// }
