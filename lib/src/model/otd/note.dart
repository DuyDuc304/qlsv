class NoteOTD {
  String id;
  String date;
  String text;
  NoteOTD({this.id, this.date, this.text});

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'text': text,
      };

  NoteOTD.fromJson(Map<String, dynamic> json)
      : date = json['date'],
        text = json['text'];
}
