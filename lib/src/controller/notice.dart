import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qlsv/src/model/otd/notice.dart';
import 'package:qlsv/src/model/public.dart';
import 'package:qlsv/src/utils/httpcall.dart';
import 'package:qlsv/src/utils/url.dart';

class NoticeController {
  BuildContext context;
  Public model;
  NoticeController({this.context}) {
    model = Provider.of<Public>(context, listen: false);
  }

  Future<bool> postNotice({@required NoticeOTD notice}) async {
    dynamic res =
        await RestAPI.post(url: '${url}notice', body: notice.toJson());

    if (res == []) {
      return false;
    }
    if (res['err'] != 0) {
      return false;
    }

    return true;
  }

  Future<List<NoticeOTD>> getNotice(@required String id) async {
    dynamic res = await RestAPI.get(url: '${url}notice', query: '?id=$id');
    if (res == []) {
      return null;
    }
    if (res['err'] != 0) {
      return null;
    }
    List<NoticeOTD> list =
        (res['data'] as List).map((e) => NoticeOTD.fromJson(e)).toList();
    return list;
  }
}
