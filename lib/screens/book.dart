import 'package:chichewa_bible/controllers/bible.dart';
import 'package:flutter/material.dart';
import 'package:bible_chichewa/bible_chichewa.dart';
import 'package:get/get.dart';

class ScreenBook extends StatefulWidget {
  const ScreenBook({Key? key}) : super(key: key);

  @override
  State<ScreenBook> createState() => _ScreenBookState();
}

class _ScreenBookState extends State<ScreenBook> {
  
  final _controllerBible = Get.find<BibleController>();

  void _onChapter(BOOK book, int chapter) =>
      Navigator.pushNamed(context, "/chapter",
          arguments: [book.index, chapter]);


  void _onSettings() => Navigator.pushNamed(context, "/settings");

  @override
  Widget build(BuildContext context) {
    var book = ModalRoute.of(context)!.settings.arguments as BOOK;

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(_controllerBible.bible.value.getBooks()[book.index]),
          elevation: 8.0,
          backgroundColor: Colors.brown,
          actions: [
            IconButton(
                onPressed: () => _controllerBible.toggleLightMode(),
                icon: const Icon(Icons.contrast)),
            IconButton(
                onPressed: _onSettings, icon: const Icon(Icons.settings)),
          ],
        ),
        body: Container(
          color:
              _controllerBible.lightMode.value ? Colors.white : Colors.black87,
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 2.0,
                  mainAxisSpacing: 1.0,
                  mainAxisExtent: 60.0),
              itemCount: _controllerBible.bible.value
                  .getChapterCount(book), // Number of items in the grid
              itemBuilder: (BuildContext context, int index) {
                return ElevatedButton(
                  onPressed: () => _onChapter(book, index),
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0.0),
                      backgroundColor: MaterialStateProperty.all(
                          _controllerBible.lightMode.value
                              ? Colors.white
                              : Colors.black87)),
                  child: Text((index + 1).toString(),
                      style: TextStyle(
                          color: _controllerBible.lightMode.value
                              ? Colors.grey
                              : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: _controllerBible.fontSize.value)),
                );
              }),
        ),
      ),
    );
  }
}
