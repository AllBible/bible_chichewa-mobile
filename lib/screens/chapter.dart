import 'dart:math';

import 'package:bible_chichewa/bible_chichewa.dart';
import 'package:chichewa_bible/classes/comment.dart';
import 'package:chichewa_bible/classes/highlight.dart';
import 'package:chichewa_bible/controllers/bible.dart';
import 'package:chichewa_bible/database/comments.dart';
import 'package:chichewa_bible/database/highlights.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toast/toast.dart';

class ScreenChapter extends StatefulWidget {
  const ScreenChapter({Key? key}) : super(key: key);

  @override
  State<ScreenChapter> createState() => _ScreenChapterState();
}

class _ScreenChapterState extends State<ScreenChapter> {
  final _controllerBible = Get.find<BibleController>();
  final _commentTitle = TextEditingController();
  final _verseEnd = TextEditingController();
  final _comment = TextEditingController();
  var _highlights = <Highlight>[];
  final _verses = <Map<String, dynamic>>[];

  @override
  void initState() {
    super.initState();
    ToastContext().init(context);
  }

  @override
  void dispose() {
    _commentTitle.dispose();
    _verseEnd.dispose();
    _comment.dispose();
    super.dispose();
  }

  void _onShare(int b, int chapter, int v, String verse) {
    var book = _controllerBible.bible.value.getBooks()[b];
    var reference = "$book $chapter: ${v + 1}";
    var id = "com.m2kdevelopments.biblechichewa";
    var app = "https://play.google.com/store/apps/details?id=$id";
    var subject = "Chichewa Bible - Mawu a Mulungu";
    Share.share('$verse\n--$reference\n\n$app', subject: subject);
  }

  void _onSettings() => Navigator.pushNamed(context, "/settings");

  void _onNextChapter(int book, int chapter) {
    var count = _controllerBible.bible.value.getChapterCount(BOOK.values[book]);
    if ((chapter + 1) > count) {
      // next book
      if (book != BOOK.revelation.index) {
        Navigator.popAndPushNamed(context, "/chapter",
            arguments: [book + 1, 1]);
      }
    } else {
      //chapter
      Navigator.popAndPushNamed(context, "/chapter",
          arguments: [book, chapter + 1]);
    }
  }

  void _addComment(int book, int chapter, Comment? exists) {
    var title = _commentTitle.text;
    var text = _comment.text;
    var id = exists == null ? Random().nextInt(2534) + 7203859 : exists.id;
    var comment = Comment(
      id: id,
      book: book,
      chapter: chapter,
      title: title,
      comment: text,
    );
    if (exists == null) {
      DatabaseComments.insertComment(comment);
    } else {
      DatabaseComments.updateComment(comment);
    }
    Toast.show("Ndemanga idawonjezedwa");
  }

  void _onComment(int book, int chapter) {
    DatabaseComments.getCommentFrom(book, chapter).then((comment) {
      _commentTitle.text = comment == null ? "" : comment.title;
      _comment.text = comment == null ? "" : comment.comment;
      return showDialog(
        context: context,
        builder: (c) => AlertDialog(
          title: const Text(
            "Ndemanga (Comment)",
            style: TextStyle(
              fontSize: 16,
              color: Colors.brown,
            ),
          ),
          content: SizedBox(
            width: 800,
            child: Column(
              children: [
                Text(
                    "${_controllerBible.bible.value.getBooks()[book]} $chapter"),
                TextFormField(
                  maxLength: 300,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Mutu wa Ndemanga",
                  ),
                  controller: _commentTitle,
                ),
                TextFormField(
                  minLines: 1,
                  maxLines: 10,
                  maxLength: 5000,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Ndemanga",
                  ),
                  controller: _comment,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.brown)),
                    onPressed: () => _addComment(book, chapter, comment),
                    child: const Text("Onjezani Ndemanga"))
              ],
            ),
          ),
        ),
      );
    });
  }

  void _addHighlight(int b, int c, int v, String color) async {
    var list = await DatabaseHighlights.getHighlists(b, c);
    var h = list
        .firstWhereOrNull((e) => e.book == b && e.chapter == c && e.verse == v);
    if (h == null) {
      DatabaseHighlights.insertHighlist(Highlight(
          id: Random().nextInt(2534) + 7203859,
          book: b,
          chapter: c,
          verse: v,
          start: -1,
          end: -1,
          color: color));
    } else {
      DatabaseHighlights.updateHighlight(
        h.id,
        Highlight(
            id: h.id,
            book: b,
            chapter: c,
            verse: v,
            start: -1,
            end: -1,
            color: color),
      );
    }

    list = await DatabaseHighlights.getHighlists(b, c);
    setState(() => _highlights = list);
    Toast.show('Highlighted');
  }

  void _deleteHighlight(int b, int c, int v) async {
    var list = await DatabaseHighlights.getHighlists(b, c);
    var h = list
        .firstWhereOrNull((e) => e.book == b && e.chapter == c && e.verse == v);
    if (h != null) DatabaseHighlights.deleteHighlight(h.id);
    list = await DatabaseHighlights.getHighlists(b, c);
    setState(() => _highlights = list);
    Toast.show('Highlight Removed');
  }

  void _onHighlight(int b, int chapter, int v) {
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(
          "Add Highlight",
          style: TextStyle(
            fontSize: 16,
            color: Colors.brown[900],
          ),
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              tooltip: "Remove Highlight",
              icon: const Icon(
                Icons.block,
                color: Colors.red,
              ),
              onPressed: () => _deleteHighlight(b, chapter, v),
            ),
            IconButton(
              tooltip: "Blue Highlight",
              icon: const Icon(
                Icons.circle,
                color: Colors.blue,
              ),
              onPressed: () => _addHighlight(b, chapter, v, 'blue'),
            ),
            IconButton(
              tooltip: "Orange Highlight",
              icon: const Icon(
                Icons.circle,
                color: Colors.orange,
              ),
              onPressed: () => _addHighlight(b, chapter, v, 'orange'),
            ),
            IconButton(
              tooltip: "Green Highlight",
              icon: const Icon(
                Icons.circle,
                color: Colors.green,
              ),
              onPressed: () => _addHighlight(b, chapter, v, 'green'),
            ),
            IconButton(
              tooltip: "Purple Highlight",
              icon: const Icon(
                Icons.circle,
                color: Colors.purple,
              ),
              onPressed: () => _addHighlight(b, chapter, v, 'purple'),
            )
          ],
        ),
      ),
    );
  }

  Color? _getVerseHighlight(verse) {
    var h =
        _highlights.firstWhereOrNull((r) => r.verse == (verse['index'] as int));
    if (h == null) return null;
    if (_controllerBible.lightMode.value) {
      if (h.color == 'blue') return Colors.blue[50];
      if (h.color == 'green') return Colors.green[50];
      if (h.color == 'orange') return Colors.orange[50];
      if (h.color == 'purple') return Colors.purple[50];
    } else {
      if (h.color == 'blue') return Colors.blue[900];
      if (h.color == 'green') return Colors.green[900];
      if (h.color == 'orange') return Colors.orange[900];
      if (h.color == 'purple') return Colors.purple[900];
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as List<int>;
    final book = data[0];
    final chapter = data[1] + 1;

    if (_verses.isEmpty) {
      DatabaseHighlights.getHighlists(book, chapter)
          .then((value) => setState(() => _highlights = value));

      _controllerBible.bible.value
          .getChapter(BOOK.values[book], chapter)
          .then((list) => setState(() {
                var index = 0;
                for (var item in list) {
                  _verses.add({"index": ++index, "verse": item});
                }
              }));
    }

    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text(
                "${_controllerBible.bible.value.getBooks()[book]} $chapter"),
            elevation: 8.0,
            backgroundColor: Colors.brown,
            actions: [
              IconButton(
                  onPressed: () => _controllerBible.toggleLightMode(),
                  icon: const Icon(Icons.contrast)),
              IconButton(
                  onPressed: _onSettings, icon: const Icon(Icons.settings)),
              IconButton(
                  tooltip: "Ndemanga",
                  onPressed: () => _onComment(book, chapter),
                  icon: const Icon(Icons.comment)),
            ],
          ),
          body: Container(
            color: _controllerBible.lightMode.value
                ? Colors.white
                : Colors.black87,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ..._verses
                      .map((verse) => Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    (_verses.indexOf(verse) + 1).toString(),
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: _controllerBible.lightMode.value
                                            ? Colors.brown
                                            : Colors.brown[300]),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      SelectableText(
                                        verse['verse'],
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            backgroundColor:
                                                _getVerseHighlight(verse),
                                            fontSize:
                                                _controllerBible.fontSize.value,
                                            color:
                                                _controllerBible.lightMode.value
                                                    ? Colors.grey
                                                    : Colors.white),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                              tooltip: "Share",
                                              onPressed: () => _onShare(
                                                  book,
                                                  chapter,
                                                  verse['index'] as int,
                                                  verse['verse'] as String),
                                              icon: const Icon(
                                                Icons.share,
                                                size: 16.0,
                                              ),
                                              color: _controllerBible
                                                      .lightMode.value
                                                  ? Colors.brown
                                                  : Colors.brown[50]),
                                          IconButton(
                                              tooltip: "Highlight",
                                              onPressed: () => _onHighlight(
                                                  book,
                                                  chapter,
                                                  verse['index'] as int),
                                              icon: const Icon(
                                                Icons.edit,
                                                size: 16.0,
                                              ),
                                              color: _controllerBible
                                                      .lightMode.value
                                                  ? Colors.brown
                                                  : Colors.brown[50])
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                  Padding(
                    padding: const EdgeInsets.all(38.0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.brown),
                        ),
                        onPressed: () => _onNextChapter(book, chapter),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Zosatira",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.0),
                            ),
                            Icon(Icons.navigate_next)
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
