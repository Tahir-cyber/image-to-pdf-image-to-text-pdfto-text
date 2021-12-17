// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'dart:math';
import 'package:file_converter_app/constant/textstyle_constant.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:pdf_text/pdf_text.dart';

class PdfToWord extends StatefulWidget {
  @override
  _PdfToWord createState() => _PdfToWord();
}

class _PdfToWord extends State<PdfToWord> {
  bool isLoading = false;
  PDFDoc? _pdfDoc;
  String _text = "";

  bool _buttonsEnabled = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text('Convert PDF to Text'),
          titleTextStyle: appbarTextStyle(),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.amber),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await _pickPDFTexted();
                  await _readWholeDocs();
                  setState(() {
                    isLoading = false;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.text_snippet_rounded),
                    Text("Pick a PDF Document"),
                  ],
                ),
              ),
              TextButton(
                child: Text(
                  "Read random page",
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(
                    padding: EdgeInsets.all(5),
                    backgroundColor: Colors.blueAccent),
                onPressed: _buttonsEnabled ? _readRandomPaged : () {},
              ),
              TextButton(
                child: Text(
                  "Read whole document",
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(
                    padding: EdgeInsets.all(5),
                    backgroundColor: Colors.blueAccent),
                onPressed: _buttonsEnabled ? _readWholeDocs : () {},
              ),
              Padding(
                child: Text(
                  _pdfDoc == null
                      ? "Pick a new PDF document and wait for it to load..."
                      : "PDF document loaded, ${_pdfDoc!.length} pages\n",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                padding: EdgeInsets.all(15),
              ),
              Padding(
                child: Text(
                  _text == "" ? "" : "Text:",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                padding: EdgeInsets.all(15),
              ),
              isLoading == false
                  ? SelectableText(_text)
                  : Center(child: CircularProgressIndicator()),
            ],
          ),
        ));
  }

  /// Picks a new PDF document from the device
  Future _pickPDFTexted() async {
    var filePickerResult = await FilePicker.platform.pickFiles();
    if (filePickerResult != null) {
      _pdfDoc = await PDFDoc.fromPath(filePickerResult.files.single.path!);
      setState(() {});
    }
  }

  /// Reads a random page of the document
  Future _readRandomPaged() async {
    if (_pdfDoc == null) {
      return;
    }
    setState(() {
      _buttonsEnabled = false;
    });

    String text =
        await _pdfDoc!.pageAt(Random().nextInt(_pdfDoc!.length) + 1).text;

    setState(() {
      _text = text;
      _buttonsEnabled = true;
    });
  }

  /// Reads the whole document
  Future _readWholeDocs() async {
    if (_pdfDoc == null) {
      return;
    }
    setState(() {
      _buttonsEnabled = false;
    });

    String text = await _pdfDoc!.text;

    setState(() {
      _text = text;
      _buttonsEnabled = true;
    });
  }
}
