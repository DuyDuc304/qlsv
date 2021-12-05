import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qlsv/src/model/otd/calen.dart';

import 'package:qlsv/src/model/public.dart';
import 'package:qlsv/src/utils/httpcall.dart';
import 'package:qlsv/src/utils/url.dart';

class CalenController {
  BuildContext context;
  Public model;
  CalenController({this.context}) {
    model = Provider.of<Public>(context, listen: false);
  }

  Future<bool> postCalen({@required CalendarOTD calen}) async {
    dynamic res = await RestAPI.post(url: '${url}calen', body: calen.toJson());

    if (res == []) {
      return false;
    }
    if (res['err'] != 0) {
      return false;
    }

    return true;
  }

  Future<List<List<CalenOTD>>> getCalen(@required String id) async {
    dynamic res = await RestAPI.get(url: '${url}calen', query: '?id=$id');
    if (res == []) {
      return null;
    }
    if (res['err'] != 0) {
      return null;
    }
    List<List<CalenOTD>> list = [];
    (res['data'] as List).forEach((element) {
      list.add([]);
      (element as List).forEach((e) {
        list[list.length - 1].add(CalenOTD.fromJson(e));
      });
    });
    print(list.length);
    if (list.length == 0) {
      return null;
    }
    return list;
  }
}
