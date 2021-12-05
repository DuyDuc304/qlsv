import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qlsv/src/model/otd/calen.dart';
import 'package:qlsv/src/model/otd/coin.dart';

import 'package:qlsv/src/model/public.dart';
import 'package:qlsv/src/utils/httpcall.dart';
import 'package:qlsv/src/utils/url.dart';

class CoinController {
  BuildContext context;
  Public model;
  CoinController({this.context}) {
    model = Provider.of<Public>(context, listen: false);
  }

  Future<bool> postDefaultCoin({@required CoinOTD coin}) async {
    dynamic res = await RestAPI.post(url: '${url}coin', body: coin.toJson());

    if (res == []) {
      return false;
    }
    if (res['err'] != 0) {
      return false;
    }

    return true;
  }

  Future<bool> postCoin({@required HistoryOTD history}) async {
    dynamic res =
        await RestAPI.post(url: '${url}coinDay', body: history.toJson());

    if (res == []) {
      return false;
    }
    if (res['err'] != 0) {
      return false;
    }

    return true;
  }

  Future<CoinOTD> getCoin(@required String id) async {
    dynamic res = await RestAPI.get(url: '${url}coin', query: '?id=$id');
    if (res == []) {
      return null;
    }
    if (res['err'] != 0) {
      return null;
    }

    CoinOTD coin = CoinOTD.fromJson(res['data']);
    return coin;
  }

  Future<List<HistoryOTD>> getHistory(@required String id) async {
    dynamic res = await RestAPI.get(url: '${url}coinDay', query: '?id=$id');
    if (res == []) {
      return null;
    }
    if (res['err'] != 0) {
      return null;
    }

    List<HistoryOTD> history =
        (res['data'] as List).map((e) => HistoryOTD.fromJson(e)).toList();
    return history;
  }
}
