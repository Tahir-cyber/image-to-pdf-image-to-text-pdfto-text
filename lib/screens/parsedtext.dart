import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;

class ParsedTextScreen extends StatefulWidget {
  String text;
  ParsedTextScreen({required this.text, Key? key}) : super(key: key);

  @override
  _ParsedTextScreenState createState() => _ParsedTextScreenState();
}

class _ParsedTextScreenState extends State<ParsedTextScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(border: Border.all()),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: SelectableText(
                widget.text,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
