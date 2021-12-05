import 'package:flutter/cupertino.dart';

class UserOTD {
  String id;
  String user;
  String pass;
  String name;
  UserOTD({this.pass, this.user, this.name, this.id});

  UserOTD.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        name = json['name'],
        user = json['user'],
        pass = json['pass'];
  Map<String, dynamic> toJsonLogin() => {
        'user': user,
        'pass': pass,
      };
  Map<String, dynamic> toJsonSignup() => {
        'user': user,
        'pass': pass,
        'name': name,
      };
}
