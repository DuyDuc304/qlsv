import 'dart:convert';

class CoinOTD {
  String id;
  String timeStart;
  String coin;
  String name;
  String time;
  CoinOTD(
      {this.id,
      this.timeStart = '',
      this.time = '',
      this.coin = '',
      this.name = ''});

  Map<String, dynamic> toJson() => {
        'id': id,
        'timeStart': timeStart,
        'coin': coin,
        'name': name,
        'time': time,
      };
  CoinOTD.fromJson(Map<String, dynamic> json)
      : timeStart = json['timeStart'],
        coin = json['coin'],
        name = json['name'],
        time = json['time'];
}

class HistoryOTD {
  String id;
  String coin;
  String time;
  HistoryOTD({this.coin, this.id, this.time});

  Map<String, dynamic> toJson() => {
        'id': id,
        'coin': coin,
        'time': time,
      };
  HistoryOTD.fromJson(Map<String, dynamic> json)
      : coin = json['coin'],
        time = json['time'];
}
