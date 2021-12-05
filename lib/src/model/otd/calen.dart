import 'dart:convert';

import 'package:flutter/foundation.dart';

class CalendarOTD {
  String id;
  List<List<CalenOTD>> calen;
  CalendarOTD({this.id, this.calen});

  Map<String, dynamic> toJson() => {
        'id': id,
        'calen': json.encode(
            calen.map((e) => e.map((e) => e.toJson()).toList()).toList())
      };

  CalendarOTD.fromJson(List<List<Map<String, dynamic>>> json)
      : calen = json
            .map((e) => e.map((e) => CalenOTD.fromJson(e)).toList())
            .toList();
}

class CalenOTD {
  String title;
  String text;
  String notice;
  CalenOTD({
    this.title,
    this.text = '',
    this.notice = '',
  });
  Map<String, dynamic> toJson() => {
        'title': '$title',
        'text': '$text',
        'notice': '$notice',
      };
  CalenOTD.fromJson(Map<String, dynamic> json)
      : title = '${json['title']}',
        notice = json['notice'],
        text = json['text'];
}

// class CalendarOTD {
//   String id;
//   List<List<CalenOTD>> calen;
//   CalendarOTD({
//     @required this.id,
//     @required this.calen,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'calen': calen.map((x) => x.asMap())?.toList(),
//     };
//   }

//   factory CalendarOTD.fromMap(Map<String, dynamic> map) {
//     return CalendarOTD(
//       calen: List<List<CalenOTD>>.from(
//           map['calen'].map((x) => CalenOTD.fromMap(x))),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory CalendarOTD.fromJson(String source) =>
//       CalendarOTD.fromMap(json.decode(source));

//   @override
//   String toString() => 'CalendarOTD(id: $id, calen: $calen)';

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is CalendarOTD &&
//         other.id == id &&
//         listEquals(other.calen, calen);
//   }

//   @override
//   int get hashCode => id.hashCode ^ calen.hashCode;
// }

// class CalenOTD {
//   String title;
//   String text;
//   String notice;
//   CalenOTD({
//     this.title,
//     this.text = '',
//     this.notice,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'title': title,
//       'text': text,
//       'notice': notice,
//     };
//   }

//   factory CalenOTD.fromMap(Map<String, dynamic> map) {
//     return CalenOTD(
//       title: map['title'],
//       text: map['text'],
//       notice: map['notice'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory CalenOTD.fromJson(String source) =>
//       CalenOTD.fromMap(json.decode(source));
// }
