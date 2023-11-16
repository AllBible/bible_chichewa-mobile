import 'package:bible_chichewa/bible_chichewa.dart';
import 'package:chichewa_bible/classes/verse.dart';
import 'package:chichewa_bible/controllers/bible.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenSearch extends StatefulWidget {
  const ScreenSearch({Key? key}) : super(key: key);

  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<ScreenSearch> {
  final _controllerBible = Get.put(BibleController());
  var _loading = true;
  var verses = <Verse>[];
  var _selectedBook = "Genesis";

  void _onSettings() => Navigator.pushNamed(context, "/settings");

  @override
  Widget build(BuildContext context) {
    var search = ModalRoute.of(context)!.settings.arguments as String;
    _controllerBible.searchText(search).then((v) {
      if (_loading) {
        setState(() {
          _loading = false;
          verses = v;
        });
      }
    });

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown,
          title: const Text("Buku Lopatulika"),
          actions: [
            IconButton(
                onPressed: () => _controllerBible.toggleLightMode(),
                icon: const Icon(Icons.contrast)),
            IconButton(
                onPressed: _onSettings, icon: const Icon(Icons.settings)),
          ],
        ),
        body: _loading
            ? Center(
                child: Text(
                  "Searching...",
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: _controllerBible.lightMode.value
                          ? Colors.brown
                          : Colors.white),
                ),
              )
            : Container(
                color: _controllerBible.lightMode.value
                    ? Colors.white
                    : Colors.black87,
                child: SingleChildScrollView(
                    child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: DropdownButton(
                      value: _selectedBook,
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.brown ),
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: _controllerBible.bible.value
                          .getBooks()
                          .map((String name) {
                        var count =
                            verses.where((verse) => verse.book == name).length;

                        return DropdownMenuItem(
                          value: name,
                          child: Text("$name ($count)"),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (value) =>
                          setState(() => _selectedBook = value!),
                    ),
                  ),
                  ...verses
                      .where((verse) => verse.book == _selectedBook)
                      .map((verse) => Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    verse.getRef(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.brown),
                                  ),
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      alignment: Alignment.centerLeft,
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              _controllerBible.lightMode.value
                                                  ? const Color.fromARGB(
                                                      0, 255, 255, 255)
                                                  : const Color.fromARGB(
                                                      0, 0, 0, 0)),
                                      elevation: MaterialStateProperty.all(0.0),
                                    ),
                                    onPressed: () {},
                                    onLongPress: () {},
                                    child: Text(
                                      verse.text,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize:
                                              _controllerBible.fontSize.value,
                                          color:
                                              _controllerBible.lightMode.value
                                                  ? Colors.grey
                                                  : Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ])),
              ));
  }
}
