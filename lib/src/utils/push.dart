import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qlsv/src/model/public.dart';

class Push {
  static void nextPage({BuildContext context, Widget page}) {
    Public model = Provider.of<Public>(context, listen: false);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                      create: (context) => model,
                    ),
                  ],
                  child: page,
                )));
  }

  static void newPage({BuildContext context, Widget page}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                      create: (context) => Public(),
                    ),
                  ],
                  child: page,
                )));
  }
}
