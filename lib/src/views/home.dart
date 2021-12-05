import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qlsv/src/controller/calen.dart';
import 'package:qlsv/src/controller/coin.dart';
import 'package:qlsv/src/controller/note.dart';
import 'package:qlsv/src/controller/notice.dart';
import 'package:qlsv/src/model/otd/coin.dart';
import 'package:qlsv/src/model/otd/notice.dart';
import 'package:qlsv/src/model/public.dart';
import 'package:qlsv/src/utils/push.dart';

import 'note.dart';
import 'calendar.dart';
import 'login.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<int> lHistory = [0, 1, 2, 3];
  NoteController _noteController;
  CalenController _calenController;
  CoinController _coinController;
  NoticeController _noticeController;
  // Tiết kiệm
  TextEditingController _coin = TextEditingController();
  TextEditingController _coinDay = TextEditingController();
  TextEditingController _nameCoin = TextEditingController();
  // Nhắc nhở text controller
  TextEditingController _time = TextEditingController();
  TextEditingController _text = TextEditingController();

  CoinOTD coin = CoinOTD(
      timeStart:
          '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
      time: '1');

  Widget btnTag(
          {@required String text,
          @required String icon,
          @required Function press}) =>
      Column(
        children: [
          GestureDetector(
            onTap: () {
              press();
            },
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color.fromRGBO(244, 244, 244, 1),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                icon,
                width: 24,
                height: 24,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            text,
            style:
                GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w700),
          )
        ],
      );

  Widget cardNoicte({String time, String text}) => Container(
        width: 220,
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black.withOpacity(0.25)),
        ),
        child: Row(
          children: [
            Text(
              time,
              style:
                  GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.7)),
              ),
            )
          ],
        ),
      );

  Widget title({@required String text}) => Text(
        text,
        style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w700),
      );

  Widget cardTarget({
    String coin,
    String name,
    String time,
    String datDuoc,
    String conLai,
  }) =>
      Container(
        height: 150,
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  offset: Offset(0, 4),
                  blurRadius: 4),
              BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  offset: Offset(0, -4),
                  blurRadius: 4),
            ]),
        child: Row(
          children: [
            Container(
              width: 104,
              height: 104,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                      width: 5, color: Color.fromRGBO(0, 133, 255, 1))),
              child: Text(
                coin,
                style: GoogleFonts.nunito(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  name,
                  style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(0, 133, 255, 1)),
                ),
                Text(
                  'Hoàn thành trong ${time} ngày',
                  style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.7)),
                ),
                Text(
                  'Số tiền hiện tại đạt được: ${datDuoc}đ',
                  style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.7)),
                ),
                Text(
                  'Số tiền còn lại: ${conLai}đ',
                  style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.7)),
                ),
              ],
            ))
          ],
        ),
      );

  Widget cardHistory({
    String name,
    String coin,
    String time,
  }) =>
      Container(
        height: 100,
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  offset: Offset(0, 4),
                  blurRadius: 4),
              BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  offset: Offset(0, -4),
                  blurRadius: 4),
            ]),
        child: Row(
          children: [
            Container(
              width: 84,
              height: 84,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                      width: 5, color: Color.fromRGBO(0, 133, 255, 1))),
              child: Text(
                coin,
                style: GoogleFonts.nunito(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  name,
                  style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(0, 133, 255, 1)),
                ),
                Text(
                  'Hoàn thành trong ${time} Ngày',
                  style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.7)),
                ),
              ],
            ))
          ],
        ),
      );

  Widget btnSetDate({
    @required String text,
    @required Function press,
  }) =>
      GestureDetector(
        onTap: () {
          press();
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black.withOpacity(0.3))),
          child: Row(
            children: [
              Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.alarm,
                      size: 24,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(text,
                        style: GoogleFonts.nunito(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black.withOpacity(0.7)))
                  ],
                ),
              )
            ],
          ),
        ),
      );
  Widget btnSetcoins({
    @required TextEditingController textEditingController,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 46,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black.withOpacity(0.3))),
        child: Row(
          children: [
            Image.asset(
              'assets/coins.png',
              width: 24,
              height: 24,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: TextField(
              keyboardType: TextInputType.number,
              controller: textEditingController,
              decoration: const InputDecoration(border: InputBorder.none),
            ))
          ],
        ),
      );

  Future<DateTime> timePicker() async {
    return await DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime.now(),
        maxTime: DateTime(2030, 1, 1),
        onConfirm: (date) {},
        currentTime: DateTime.now(),
        locale: LocaleType.vi);
  }

  Future<void> showcoins() async => await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white.withOpacity(0),
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter mystate) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: 250,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  Text('Tiết kiệm',
                      style: GoogleFonts.nunito(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: btnSetDate(
                                    text: coin.time,
                                    press: () {
                                      timePicker().then((value) {
                                        mystate(() {
                                          coin.time =
                                              '${(value.difference(DateTime.now())).inDays + 1}';
                                        });
                                      });
                                    })),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child:
                                    btnSetcoins(textEditingController: _coin))
                          ],
                        ),
                        TextField(
                          controller: _nameCoin,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Nhập mục tiêu tiết kiệm'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            TextButton(
                                onPressed: () {
                                  coin.id = _coinController.model.user.id;
                                  coin.coin = _coin.text;
                                  coin.name = _nameCoin.text;
                                  _coinController
                                      .postDefaultCoin(coin: coin)
                                      .then((value) {
                                    Navigator.pop(context);
                                  });
                                },
                                child: Text('Xác nhận'))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
      });
  Future<void> showCoinDay() async => await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white.withOpacity(0),
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter mystate) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: 250,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  Text('Tiết kiệm',
                      style: GoogleFonts.nunito(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        Row(
                          children: [
                            Expanded(
                                child: btnSetDate(
                                    text:
                                        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
                                    press: () {})),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: btnSetcoins(
                                    textEditingController: _coinDay))
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {
                                print('Click');
                                HistoryOTD history = HistoryOTD(
                                  id: _coinController.model.user.id,
                                  coin: _coinDay.text,
                                  time:
                                      '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
                                );
                                _coinController
                                    .postCoin(history: history)
                                    .then((value) {
                                  Navigator.pop(context);
                                });
                              },
                              child: Text('Xác nhận')),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
      });
  Future<void> showNotice() async => await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white.withOpacity(0),
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter mystate) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: 250,
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
                  Text('Thêm nhắc nhở mới',
                      style: GoogleFonts.nunito(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        btnSetDate(
                            text: '${_time.text} Giờ',
                            press: () async {
                              TimeOfDay t = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());
                              mystate(() {
                                _time.text = '${t.hour}:${t.minute}';
                              });
                            }),
                        const SizedBox(
                          width: 30,
                        ),
                        TextField(
                          controller: _text,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Nhập thông báo'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(),
                            TextButton(
                                onPressed: () {
                                  NoticeOTD notice = NoticeOTD(
                                      id: _noticeController.model.user.id,
                                      time: _time.text,
                                      text: _text.text);
                                  _noticeController
                                      .postNotice(notice: notice)
                                      .then((value) {
                                    _noticeController
                                        .getNotice(
                                            _coinController.model.user.id)
                                        .then((value) {
                                      _coinController.model
                                          .changeListNotice(value);
                                      Navigator.pop(context);
                                    });
                                  });
                                },
                                child: Text('Xác nhận'))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
      });

  Future<void> showCacel() async => await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white.withOpacity(0),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            height: 250,
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
                Text('Tiết kiệm',
                    style: GoogleFonts.nunito(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      Column(
                        children: [
                          Text('Hiện tại bạn chưa hoàn thành mục tiêu đề ra',
                              style: GoogleFonts.nunito(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Text('Bạn có muốn hủy ?',
                              style: GoogleFonts.nunito(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          TextButton(
                              onPressed: () {
                                _coinController
                                    .postDefaultCoin(
                                        coin: CoinOTD(
                                            id: _coinController.model.user.id,
                                            coin: 'false'))
                                    .then((value) {
                                  Navigator.pop(context);
                                });
                              },
                              child: Text('Xác nhận'))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      });

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _noteController = NoteController(context: context);
    _calenController = CalenController(context: context);
    _coinController = CoinController(context: context);
    _noticeController = NoticeController(context: context);
    _noticeController.getNotice(_noticeController.model.user.id).then((value) {
      if (value != null) {
        _noticeController.model.changeListNotice(value);
      }
      _coinController.getCoin(_coinController.model.user.id).then((value) {
        _coinController.model.changeCoin(value);
        if (value != null) {
          _coinController
              .getHistory(_coinController.model.user.id)
              .then((value) {
            _coinController.model.changeListHistory(value);
            double count = 0;
            if (_coinController.model.lHistory != null) {
              _coinController.model.lHistory.forEach((element) {
                count += double.parse(element.coin);
              });
            }
            _coinController.model.changeCountCoin(count);
          });
        }
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _coin.dispose();
    _nameCoin.dispose();
    _coinDay.dispose();
    _text.dispose();
    _time.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Public>(builder: (context, value, child) {
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
              color: const Color.fromRGBO(244, 244, 244, 1),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 220,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(32),
                          bottomRight: Radius.circular(32),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              offset: const Offset(0, 4),
                              blurRadius: 4)
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text('Chào mừng, ${value.user.name}',
                                  style: GoogleFonts.nunito(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            const SizedBox(
                              width: 120,
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                        title: Text(
                                          'User',
                                          textAlign: TextAlign.center,
                                        ),
                                        actions: [
                                          Align(
                                            alignment: Alignment.center,
                                            child: TextButton(
                                                onPressed: () {
                                                  Push.newPage(
                                                      context: context,
                                                      page: const Login());
                                                },
                                                child: Text('Đăng xuất')),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Hủy')),
                                          )
                                        ],
                                      );
                                    });
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(244, 244, 244, 1),
                                    shape: BoxShape.circle),
                                child: Image.asset(
                                  'assets/user.png',
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                btnTag(
                                    text: 'Thời khóa biểu',
                                    icon: 'assets/calendar.png',
                                    press: () {
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
                                      _calenController
                                          .getCalen(
                                              _calenController.model.user.id)
                                          .then((value) {
                                        if (value != null) {
                                          _calenController.model
                                              .changeListCalendar(value);
                                        }
                                        Push.nextPage(
                                            context: context,
                                            page: const Calendar());
                                      });
                                    }),
                                btnTag(
                                    text: 'Nhật ký',
                                    icon: 'assets/note.png',
                                    press: () {
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
                                      _noteController
                                          .getNote(
                                              _noteController.model.user.id)
                                          .then((value) {
                                        if (value != null) {
                                          _noteController.model
                                              .changeListNote(value);
                                        }
                                        Push.nextPage(
                                            context: context,
                                            page: const Note());
                                      });
                                    }),
                                btnTag(
                                    text: 'Tiết kiệm',
                                    icon: 'assets/coins.png',
                                    press: () {
                                      _coinController
                                          .getCoin(
                                              _coinController.model.user.id)
                                          .then((value) {
                                        if (value != null) {
                                          _coinController.model
                                              .changeCoin(value);
                                          showCoinDay().then((value) {
                                            _coinController
                                                .getCoin(_coinController
                                                    .model.user.id)
                                                .then((value) {
                                              _coinController.model
                                                  .changeCoin(value);
                                              if (value != null) {
                                                _coinController
                                                    .getHistory(_coinController
                                                        .model.user.id)
                                                    .then((value) {
                                                  _coinController.model
                                                      .changeListHistory(value);
                                                  double count = 0;
                                                  if (_coinController
                                                          .model.lHistory !=
                                                      null) {
                                                    _coinController
                                                        .model.lHistory
                                                        .forEach((element) {
                                                      count += double.parse(
                                                          element.coin);
                                                    });
                                                  }
                                                  _coinController.model
                                                      .changeCountCoin(count);
                                                });
                                              } else {
                                                _coinController.model.lHistory =
                                                    null;
                                              }
                                            });
                                          });
                                        } else {
                                          showcoins().then((value) {
                                            _coinController
                                                .getCoin(_coinController
                                                    .model.user.id)
                                                .then((value) {
                                              if (value != null) {
                                                _coinController.model
                                                    .changeCoin(value);
                                              }
                                            });
                                          });
                                        }
                                      });
                                    }),
                                btnTag(
                                    text: 'Nhắc nhở mới',
                                    icon: 'assets/add-file.png',
                                    press: () {
                                      showNotice();
                                    }),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                                width: 100,
                                child: Divider(
                                  thickness: 3,
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              title(text: 'Thời gian biểu'),
                              value.lNotice != null
                                  ? Text(
                                      '${value.lNotice.length} thông báo',
                                      style: GoogleFonts.nunito(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black.withOpacity(0.5)),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                        value.lNotice != null
                            ? SizedBox(
                                width: double.infinity,
                                height: 100,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: value.lNotice.length,
                                    itemBuilder: (context, index) {
                                      return cardNoicte(
                                          time: value.lNotice[index].time,
                                          text: value.lNotice[index].text);
                                    }),
                              )
                            : const Center(
                                child: Text('Bạn hãy thêm nhắc nhở'),
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              title(text: 'Mục tiêu tiết kiệm'),
                              value.coin != null
                                  ? TextButton(
                                      onPressed: () {
                                        showCacel().then((value) {
                                          _coinController
                                              .getCoin(
                                                  _coinController.model.user.id)
                                              .then((value) {
                                            _coinController.model
                                                .changeCoin(value);
                                          });
                                        });
                                      },
                                      child: Text('Xét lại'))
                                  : const SizedBox()
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        value.coin != null
                            ? cardTarget(
                                coin: value.coin.coin,
                                time: value.coin.time,
                                name: value.coin.name,
                                datDuoc: '${value.countCoin}',
                                conLai:
                                    '${double.parse(value.coin.coin) - value.countCoin}',
                              )
                            : Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  'Hiện tại chưa có mục tiêu nào',
                                  style: GoogleFonts.nunito(
                                      fontSize: 14,
                                      color: Colors.black.withOpacity(0.3),
                                      letterSpacing: 1.5),
                                ),
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: title(text: 'Lịch sử'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        (value.lHistory != null && value.coin != null)
                            ? Column(
                                children: value.lHistory
                                    .map((e) => Column(
                                          children: [
                                            cardHistory(
                                                time: value.coin.time,
                                                name: value.coin.name,
                                                coin: e.coin),
                                            const SizedBox(
                                              height: 20,
                                            )
                                          ],
                                        ))
                                    .toList(),
                              )
                            : Center(
                                child: Text('Hiện tại chưa có lịch sử nào'),
                              )
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
