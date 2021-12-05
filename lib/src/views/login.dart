import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qlsv/src/controller/login.dart';
import 'package:qlsv/src/model/otd/user.dart';
import 'package:qlsv/src/utils/push.dart';

import 'home.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _user = TextEditingController();
  TextEditingController _pass = TextEditingController();
  LoginController _controller;

  Widget scaffold({@required BuildContext context}) => SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(4, 200, 242, 1),
                  Color.fromRGBO(0, 133, 255, 1)
                ],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 150,
                ),
                Expanded(
                    child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: Offset(0, -4),
                            blurRadius: 4)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Đăng Nhập',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tên đăng nhập',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                                TextField(
                                  controller: _user,
                                  decoration: InputDecoration(
                                      hintText: 'Nhập tên đăng nhập của bạn',
                                      hintStyle: TextStyle(
                                          fontSize: 12,
                                          color:
                                              Colors.black.withOpacity(0.5))),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  'Mật khẩu',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                                TextField(
                                  controller: _pass,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: 'Nhập mật khẩu của bạn',
                                      hintStyle: TextStyle(
                                          fontSize: 12,
                                          color:
                                              Colors.black.withOpacity(0.5))),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                color: Color.fromRGBO(
                                                    0, 133, 255, 1),
                                              )),
                                            ));
                                    UserOTD user = UserOTD(
                                        pass: _pass.text, user: _user.text);
                                    _controller.login(user: user).then((value) {
                                      if (value != null) {
                                        print(value.name);
                                        _controller.model.changeUser(value);
                                        Push.nextPage(
                                            context: context,
                                            page: const Home());
                                      } else {
                                        Navigator.pop(context);
                                      }
                                    });
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.black.withOpacity(0.25),
                                        )),
                                    child: Text(
                                      'Xác Nhận',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Bạn chưa có tài khoản?',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Push.nextPage(
                                              context: context, page: SignUp());
                                        },
                                        child: Text('đăng ký'))
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
      );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = LoginController(context: context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _user.dispose();
    _pass.dispose();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.white.withOpacity(0.7),
            content: Text('Không hỗ trợ tác vụ này',
                style: GoogleFonts.nunito(
                    color: Colors.red,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    letterSpacing: 1.5))));
        return false;
      },
      child: scaffold(context: context));
}
