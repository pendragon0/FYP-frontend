// ignore_for_file: camel_case_types, prefer_const_constructors

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_scalable_ocr/flutter_scalable_ocr.dart';

class ocrTool extends StatefulWidget {
  const ocrTool({super.key});

  @override
  State<ocrTool> createState() => _ocrToolState();
}

class _ocrToolState extends State<ocrTool> {

  String extracted_text = '';
  final StreamController<String> controller = StreamController<String>();

  void setText(value){
    controller.add(value);
  }

  @override
  void dispose(){
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SCANNING'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ScalableOCR(
              paintboxCustom: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 4.0
                ..color = const Color.fromARGB(153, 102, 160, 241),
                boxLeftOff: 5,
                boxBottomOff: 2.5,
                boxRightOff: 5,
                boxTopOff: 2.5,
                boxHeight: MediaQuery.of(context).size.height / 3,
                getRawData: (value) {
                  inspect(value);
                },
                getScannedText: (value) {
                  setText(value);
                },
            ),
            StreamBuilder(
              stream: controller.stream,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return Result(text: snapshot.data != null? snapshot.data! : "");
              }
            )
          ],
        ),
      ),
    );
  }
}

class Result extends StatelessWidget {
  const Result({super.key, required this.text});


  final String text;
  @override
  Widget build(BuildContext context) {
    return Text("Readed text: $text");
  }
}