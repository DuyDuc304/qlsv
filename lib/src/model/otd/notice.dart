class NoticeOTD {
  String id;
  String time;
  String text;
  NoticeOTD({this.id, this.time, this.text});

  Map<String, dynamic> toJson() => {
        'id': id,
        'time': time,
        'text': text,
      };

  NoticeOTD.fromJson(Map<String, dynamic> json)
      : time = json['time'],
        text = json['text'];
}
