import 'package:bible_chichewa/bible_chichewa.dart';
import 'package:chichewa_bible/controllers/bible.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenChapter extends StatefulWidget {
  const ScreenChapter({Key? key}) : super(key: key);

  @override
  State<ScreenChapter> createState() => _ScreenChapterState();
}

class _ScreenChapterState extends State<ScreenChapter> {
  final _controllerBible = Get.find<BibleController>();

  var verses = <String>[];

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as List<int>;
    final book = data[0];
    final chapter = data[1] + 1;

    if (verses.isEmpty) {
      _controllerBible.bible.value
          .getChapter(BOOK.values[book], chapter)
          .then((list) => setState(() => verses = list));
    }

    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text(
                "${_controllerBible.bible.value.getBooks()[book]} $chapter"),
            elevation: 8.0,
            backgroundColor: Colors.brown,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: verses
                  .map((verse) => Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                (verses.indexOf(verse) + 1).toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.brown),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                verse,
                                style: const TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
        ));
  }
}
