import 'package:flutter/cupertino.dart';
import 'package:qlsv/src/model/otd/calen.dart';
import 'package:qlsv/src/model/otd/coin.dart';
import 'package:qlsv/src/model/otd/note.dart';
import 'package:qlsv/src/model/otd/notice.dart';
import 'package:qlsv/src/model/otd/user.dart';

class Public extends ChangeNotifier {
  UserOTD user;

  List<NoteOTD> lNote = [];

  List<List<CalenOTD>> lCalendar = [
    [],
    [],
    [],
    [],
    [],
    [],
    [],
  ];

  CoinOTD coin;

  List<HistoryOTD> lHistory;

  double countCoin = 0;

  List<NoticeOTD> lNotice;

  void changeListHistory(List<HistoryOTD> lHistory) {
    this.lHistory = lHistory;
    notifyListeners();
  }

  void changeListNotice(List<NoticeOTD> lNotice) {
    this.lNotice = lNotice;
    notifyListeners();
  }

  void changeCountCoin(double countCoin) {
    this.countCoin = countCoin;
    notifyListeners();
  }

  void changeUser(UserOTD user) {
    this.user = user;
    notifyListeners();
  }

  void changeCoin(CoinOTD coin) {
    this.coin = coin;
    notifyListeners();
  }

  void changeListNote(List<NoteOTD> lNote) {
    this.lNote = lNote;
    notifyListeners();
  }

  void changeListCalendar(List<List<CalenOTD>> lCalendar) {
    this.lCalendar = lCalendar;
    notifyListeners();
  }
}
