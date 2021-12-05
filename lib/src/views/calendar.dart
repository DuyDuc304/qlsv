import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qlsv/src/controller/calen.dart';
import 'package:qlsv/src/model/otd/calen.dart';
import 'package:qlsv/src/utils/push.dart';

import 'home.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final List<String> _datePicker = [
    'Thứ 2',
    'Thứ 3',
    'Thứ 4',
    'Thứ 5',
    'Thứ 6',
    'Thứ 7',
    'Chủ Nhật',
  ];

  List<List<CalenOTD>> lCalen = [
    [],
    [],
    [],
    [],
    [],
    [],
    [],
  ];

  int index = 0;

  CalenController _controller;

  Widget date({
    @required int i,
    @required Function press,
    @required int count,
  }) =>
      GestureDetector(
        onTap: () {
          press();
        },
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Divider(
                thickness: 2,
                color: Colors.black.withOpacity(0.3),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _datePicker[i],
                      style: GoogleFonts.nunito(
                          fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    Row(
                      children: [
                        Text(
                          '$count',
                          style: GoogleFonts.nunito(fontSize: 18),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 133, 255, 1),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );

  Future<void> showNullDay({@required int i}) async =>
      await showModalBottomSheet(
          context: context,
          backgroundColor: Colors.white.withOpacity(0),
          isScrollControlled: true,
          builder: (context) {
            if (lCalen[i].length == 0) {
              lCalen[i].add(CalenOTD(title: '1'));
            }
            return StatefulBuilder(
                builder: (BuildContext context, StateSetter mystate) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.475,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text('Tiết học',
                          style: GoogleFonts.nunito(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                              children: lCalen[i].map((e) {
                            TextEditingController _textController =
                                TextEditingController(text: e.text);
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 60,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          width: 1.5,
                                          color: Colors.blue,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                      ),
                                      child: Text('Tiết ${e.title}'),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: TextField(
                                      controller: _textController,
                                      onChanged: (str) {
                                        lCalen[i][lCalen[i].indexWhere(
                                                (element) =>
                                                    element.title == e.title)]
                                            .text = str;
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8))),
                                    )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        lCalen[i].add(CalenOTD(
                                            title:
                                                '${int.parse(lCalen[i][lCalen[i].length - 1].title) + 1}'));
                                        mystate(() {});
                                      },
                                      child: Icon(
                                        Icons.add,
                                        size: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          }).toList()),
                        ),
                      )
                    ],
                  ),
                ),
              );
            });
          });

  Widget lesson({
    @required String title,
    @required String text,
    @required String notice,
    @required int i,
  }) =>
      Row(
        children: [
          Container(
            width: 80,
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 133, 255, 1),
            ),
            alignment: Alignment.center,
            child: Text('Tiết ${title}',
                style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    text,
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: notice == ''
                            ? Colors.black.withOpacity(0.7)
                            : Colors.red),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          TextEditingController _editingController =
                              TextEditingController(
                                  text: lCalen[i][lCalen[i].indexWhere(
                                          (element) => element.title == title)]
                                      .notice);
                          return AlertDialog(
                            title: Text('Thêm Chú Thích'),
                            actions: [
                              const SizedBox(
                                height: 20,
                              ),
                              TextField(
                                controller: _editingController,
                                onChanged: (str) {
                                  notice = str;
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    labelText: 'Nhập chú thích'),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                    onPressed: () {
                                      lCalen[i][lCalen[i].indexWhere(
                                              (element) =>
                                                  element.title == title)]
                                          .notice = notice;
                                      Navigator.pop(context);
                                    },
                                    child: Text('Xác Nhận')),
                              )
                            ],
                          );
                        }).then((value) {
                      setState(() {});
                    });
                  },
                  child: Icon(
                    Icons.edit,
                    size: 18,
                  ),
                )
              ],
            ),
          ))
        ],
      );

  Widget card({@required String date, @required int i}) => Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 80,
                  height: 50,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 133, 255, 1),
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(12))),
                  ),
                ),
                Expanded(
                    child: Center(
                        child: GestureDetector(
                  onTap: () {
                    showNullDay(i: i).then((value) {
                      List<CalenOTD> l = [];
                      for (int j = 0; j < lCalen[i].length; j++) {
                        if (lCalen[i][j].text != '') {
                          l.add(lCalen[i][j]);
                        }
                      }
                      lCalen[i] = l;
                      setState(() {});
                    });
                  },
                  child: Text(
                    date,
                    style: GoogleFonts.nunito(
                        fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                )))
              ],
            ),
            Column(
              children: lCalen[i]
                  .map((e) => lesson(
                      title: '${e.title}',
                      text: '${e.text}',
                      notice: '${e.notice}',
                      i: i))
                  .toList(),
            ),
            Row(
              children: [
                SizedBox(
                  width: 80,
                  height: 10,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 133, 255, 1),
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(12))),
                  ),
                ),
                Expanded(child: SizedBox())
              ],
            ),
          ],
        ),
      );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CalenController(context: context);
    print('calen:' + '${_controller.model.lCalendar.length}');
    if (_controller.model.lCalendar != null) {
      print('calen:' + '${_controller.model.lCalendar.length}');
      lCalen = _controller.model.lCalendar;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
      child: SafeArea(
          child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Color.fromRGBO(244, 244, 244, 1),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Push.nextPage(context: context, page: const Home());
                      },
                      child: Container(
                          width: 32,
                          height: 32,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.25))),
                          child: Icon(Icons.arrow_back)),
                    ),
                    Text(
                      'Thời khóa biểu',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 32,
                    )
                  ],
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: _datePicker
                          .map((e) => Column(
                                children: [
                                  card(
                                      date: e,
                                      i: _datePicker.indexWhere(
                                          (element) => element == e)),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ))
                          .toList(),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            CalendarOTD calendar =
                CalendarOTD(id: _controller.model.user.id, calen: lCalen);
            _controller.postCalen(calen: calendar);
          },
          child: Icon(Icons.save),
        ),
      )),
    );
  }
}
