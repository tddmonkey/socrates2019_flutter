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

  runApp(KeithAndColinDoFlutter());
}

class KeithAndColinDoFlutter extends StatelessWidget {
  double screenWidth;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter layout demo',
        theme: ThemeData.light(),
        home: HomePage()

        ///      ),
        );
  }
}

class Item {
  String name;
  String imageUrl;
  String description;

  Item(String name, String imageUrl, String description) {
    this.name = name;
    this.imageUrl = imageUrl;
    this.description = description;
  }
}

//class Item(String name, String imageUrl, String description) {
//
//}

class HomePage extends StatelessWidget {
  double screenWidth;

  BuildContext context;

  var chair = new Item("I am Chair", "images/chair-alpha.png", "Sit on me");
  var binoculars = new Item("I see things", "images/binoculars-alpha.png", "An optical instrument with a lens for each eye, used for viewing distant objects.");
  var flippers = new Item("Flipping Hell", "images/flippers-alpha.png", """a broad flat limb without fingers, used for swimming by various sea animals such as seals, whales, and turtles.
        a flat rubber attachment worn on the foot for underwater swimming.
        a pivoted arm in a pinball machine, controlled by the player and used for sending the ball back up the table.""");

  Widget buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        createItemView(chair),
        createItemView(binoculars),
        createItemView(flippers),
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

  Widget createItemView(Item item) {
    return Row(
      children: [
        expandableImage(item),
        Container(
          padding: EdgeInsets.all(15),
          child: Text(
            item.name,
            style: t,
            textScaleFactor: 2,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    this.screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter layout demo'),
        ),
        body: buildColumn());
//    return buildColumn();
  }

  Widget expandableImage(Item item) {
//    return Hero(tag: imageUrl, child: SizedBox(width: screenWidth/4, child: Image.asset(imageUrl)));
    return InkWell(
        onTap: navToSomeOtherPage(item),
        child: SizedBox(width: screenWidth / 4, child: Image.asset(item.imageUrl))
    );
  }

//  Widget addNavButton() {
//    return Center(
//        child: RaisedButton(
//            child: Text("Click Me"), onPressed: navToSomeOtherPage()));
//  }

  navToSomeOtherPage(Item item) {
    return () => {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => GarbageScreen(item)))
        };
  }
}

class GarbageScreen extends StatelessWidget {
  Item item;

  GarbageScreen(Item item) {
    this.item = item;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: FullPageLayoutForItem(item)
    );
  }
}

class FullPageLayoutForItem extends StatelessWidget {
  double imageSize;

  Item item;

  FullPageLayoutForItem(Item item) {
    this.item = item;
  }

  @override
  Widget build(BuildContext context) {
    this.imageSize = MediaQuery.of(context).size.width * 0.75;

    return ListView(
        children: [
          imageBox(imageSize),
          textBox()
        ]
    );
  }

  Widget imageBox(double imageSize) {
    return Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
                width: imageSize,
                child: Image.asset(item.imageUrl)
              )
          )
    ;
  }

  Widget textBox() {
    return Container(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          item.description,
          textScaleFactor: 1.3
      )
    )
    ;
  }
}
