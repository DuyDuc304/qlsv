import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qlsv/src/model/otd/note.dart';
import 'package:qlsv/src/model/otd/user.dart';
import 'package:qlsv/src/model/public.dart';
import 'package:qlsv/src/utils/httpcall.dart';
import 'package:qlsv/src/utils/url.dart';

class NoteController {
  BuildContext context;
  Public model;
  NoteController({this.context}) {
    model = Provider.of<Public>(context, listen: false);
  }
  Future<UserOTD> postNote({@required NoteOTD user}) async {
    dynamic res = await RestAPI.post(url: '${url}note', body: user.toJson());

    if (res == []) {
      return null;
    }
    if (res['err'] != 0) {
      return null;
    }

    // UserOTD json = UserOTD.fromJson(res['data']);
    return null;
  }

  Future<List<NoteOTD>> getNote(@required String id) async {
    dynamic res = await RestAPI.get(url: '${url}note', query: '?id=$id');
    if (res == []) {
      return null;
    }
    if (res['err'] != 0) {
      return null;
    }

    List<NoteOTD> json =
        (res['data'] as List).map((e) => NoteOTD.fromJson(e)).toList();
    if (json.length == 0) {
      return null;
    }
    return json;
  }
}
