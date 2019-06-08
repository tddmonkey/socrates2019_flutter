// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

// A simple radial transition. The destination route is basic,
// with no Card, Column, or Text.

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;


void main() {
//  debugPaintSizeEnabled = false; // Remove to suppress visual layout

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  double screenWidth;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      theme: ThemeData.light(),
      home: RowAndColumnThing()
///      ),
    );
  }
}

class RowAndColumnThing extends StatelessWidget {
  double screenWidth;

  Widget buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildRow("images/chair-alpha.png", "I am chair"),
        buildRow("images/binoculars-alpha.png", "I see things"),
        buildRow("images/flippers-alpha.png", "I swim"),
      ],
    );
  }

  var t = TextStyle(
    fontWeight: FontWeight.bold,
     fontFamily: 'Raleway',
    fontFamilyFallback: <String>[
       'Noto Sans CJK SC',
       'Noto Color Emoji',
     ],
   );

  Widget buildRow(String imageUrl, String description) {
    return Row(
      children: [
        Hero(tag: imageUrl, child: SizedBox(width: screenWidth/4, child: Image.asset(imageUrl))),
        Container(
          padding: EdgeInsets.all(15),
          child: Text(description, style: t, textScaleFactor: 2,),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    this.screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter layout demo'),
        ),
        body: buildColumn()
    );
//    return buildColumn();
  }
}

