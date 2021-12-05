import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:qlsv/src/controller/note.dart';
import 'package:qlsv/src/model/otd/note.dart';
import 'package:qlsv/src/model/public.dart';
import 'package:qlsv/src/utils/push.dart';
import 'package:qlsv/src/views/home.dart';

class Note extends StatefulWidget {
  const Note({Key key}) : super(key: key);

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  TextEditingController _text = TextEditingController();
  NoteController _controller;
  PageController _pageController;
  int i = 0;
  Widget inputNote(
          {@required bool readOnly,
          @required TextEditingController controller}) =>
      SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                readOnly: readOnly,
                controller: controller,
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            )
          ],
        ),
      );
  @override
  void initState() {
    super.initState();
    _controller = NoteController(context: context);
    print('note: ${_controller.model.lNote.length}');

    if (_controller.model.lNote.length > 0) {
      if (_controller.model.lNote[_controller.model.lNote.length - 1].date !=
          '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}') {
        NoteOTD note = NoteOTD(
            date:
                '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}');
        _controller.model.lNote.add(note);
      }
      i = _controller.model.lNote.length - 1;
      _pageController =
          PageController(initialPage: _controller.model.lNote.length - 1);
    } else {
      NoteOTD note = NoteOTD(
          date:
              '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}');
      _controller.model.lNote.add(note);
      i = 0;
      _pageController = PageController(initialPage: 0);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _text.dispose();
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
      child: Consumer<Public>(builder: (context, value, child) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(0, 133, 255, 0.85),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(32),
                          bottomRight: Radius.circular(32)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(0, 4),
                            blurRadius: 4),
                      ]),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Push.nextPage(
                                  context: context, page: const Home());
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
                                child: const Icon(Icons.arrow_back)),
                          ),
                          const Text(
                            'Nhật Ký',
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            width: 32,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        value.lNote[i].date,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: PageView.builder(
                        onPageChanged: (index) {
                          setState(() {
                            i = index;
                          });
                        },
                        controller: _pageController,
                        itemCount: value.lNote.length,
                        itemBuilder: (context, index) {
                          if (value.lNote[index].date !=
                              '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}') {
                            TextEditingController controller =
                                TextEditingController(
                                    text: value.lNote[index].text);
                            return inputNote(
                                readOnly: true, controller: controller);
                          } else {
                            _text.text = value.lNote[index].text;
                            return inputNote(
                                readOnly: false, controller: _text);
                          }
                        }))
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.save),
              onPressed: () {
                NoteOTD note = NoteOTD(
                    id: _controller.model.user.id,
                    date:
                        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
                    text: _text.text);
                print(note.id);
                _controller.postNote(user: note).then((value) {
                  if (value != null) {
                    // _controller.model.lNote[_controller.model.lNote.length - 1]
                    //     .text = _text.text;
                  }
                });
              },
            ),
          ),
        );
      }),
    );
  }
}
