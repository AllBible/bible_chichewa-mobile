import 'package:bible_chichewa/bible_chichewa.dart';
import 'package:chichewa_bible/controllers/bible.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class ScreenChapter extends StatefulWidget {
  const ScreenChapter({Key? key}) : super(key: key);

  @override
  State<ScreenChapter> createState() => _ScreenChapterState();
}

class _ScreenChapterState extends State<ScreenChapter> {
  final _controllerBible = Get.find<BibleController>();

  var verses = <Map<String, dynamic>>[];

  void _onShare(int b, int chapter, int v, String verse) {
    var book = _controllerBible.bible.value.getBooks()[b];
    var reference = "$book $chapter: ${v + 1}";
    var id = "com.m2kdevelopments.biblechichewa";
    var app = "https://play.google.com/store/apps/details?id=$id";
    var subject = "Chichewa Bible - Mawu a Mulungu";
    Share.share('$verse\n--$reference\n\n$app', subject: subject);
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as List<int>;
    final book = data[0];
    final chapter = data[1] + 1;

    if (verses.isEmpty) {
      _controllerBible.bible.value
          .getChapter(BOOK.values[book], chapter)
          .then((list) => setState(() {
                var index = 0;
                for (var item in list) {
                  verses.add({"index": ++index, "verse": item});
                }
              }));
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
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  alignment: Alignment.centerLeft,
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(0, 255, 255, 255)),
                                  elevation: MaterialStateProperty.all(0.0),
                                ),
                                onPressed: () {},
                                onLongPress: () => _onShare(
                                    book,
                                    chapter,
                                    verse['index'] as int,
                                    verse['verse'] as String),
                                child: Text(
                                  verse['verse'],
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.grey),
                                ),
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
