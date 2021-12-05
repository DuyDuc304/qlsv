import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:qlsv/src/model/otd/note.dart';
import 'package:qlsv/src/model/otd/user.dart';
import 'package:qlsv/src/model/public.dart';
import 'package:qlsv/src/utils/httpcall.dart';
import 'package:qlsv/src/utils/url.dart';

class LoginController {
  final BuildContext context;
  Public model;
  LoginController({@required this.context}) {
    model = Provider.of<Public>(context, listen: false);
  }

  Future<UserOTD> login({@required UserOTD user}) async {
    dynamic res =
        await RestAPI.post(url: '${url}login', body: user.toJsonLogin());

    if (res == []) {
      return null;
    }
    if (res['err'] != 0) {
      return null;
    }

    UserOTD json = UserOTD.fromJson(res['data']);
    return json;
  }

  Future<UserOTD> signup({@required UserOTD user}) async {
    dynamic res =
        await RestAPI.post(url: '${url}signup', body: user.toJsonSignup());

    if (res == []) {
      return null;
    }
    if (res['err'] != 0) {
      return null;
    }

    UserOTD json = UserOTD.fromJson(res['data']);
    return json;
  }
}
