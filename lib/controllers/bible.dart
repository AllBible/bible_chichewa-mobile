import 'package:bible_chichewa/bible_chichewa.dart';
import 'package:chichewa_bible/classes/verse.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BibleController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final bible = Bible().obs;
  var fontSize = 18.0.obs;
  var lightMode = true.obs;
  var comments = [].obs;
  var highlights = [].obs;

  Future load() async => await bible.value.init();

  void toggleLightMode() async {
    lightMode.value = !lightMode.value;
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool('light', lightMode.value);
  }

  void updateFontSize(double font) async {
    fontSize.value = font;
    final SharedPreferences prefs = await _prefs;
    await prefs.setDouble('font', font);
  }

  void loadSettings() async {
    final SharedPreferences prefs = await _prefs;
    var light = prefs.getBool('light');
    var font = prefs.getDouble('font');
    light ??= true;
    font ??= 18.0;
    lightMode.value = light;
    fontSize.value = font;
  }

  void addComment(BuildContext context, String? v1, String? v2, String? c) {
    
  }

  Future<List<Verse>> searchText(String query) async {
    final verses = <Verse>[];
    for (var b = 0; b < bible.value.getBooks().length; b++) {
      var book = BOOK.values[b];
      var name = bible.value.getBooks()[b];
      var chapters = bible.value.getChapterCount(book);
      for (var c = 1; c <= chapters; c++) {
        for (var v = 1; v < await bible.value.getVerseCount(book, c); v++) {
          var verse = await bible.value.getVerse(book, c, v);
          if (verse.toLowerCase().contains(query.toLowerCase())) {
            var index = verse.toLowerCase().indexOf(query.toLowerCase());
            verses.add(
              Verse(
                  book: name,
                  chapter: c,
                  verse: v,
                  text: verse,
                  start: index,
                  end: index + query.length),
            );
          }
        }
      }
    }
    return verses;
  }
}
