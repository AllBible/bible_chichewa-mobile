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

  @override
  Widget build(BuildContext context) {
    var search = ModalRoute.of(context)!.settings.arguments as String;
    _controllerBible.searchText(search).then((v) {
      if (_loading) {
        setState(() {
          _loading = false;
          verses = v;
          print(v);
        });
      }
    });

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown,
          title: const Text("Buku Lopatulika"),
        ),
        body: _loading
            ? Center(
                child: Text(
                  "Searching...",
                  style: TextStyle(
                      fontSize: 20.0,
                      color: _controllerBible.lightMode.value
                          ? Colors.grey
                          : Colors.white),
                ),
              )
            : SingleChildScrollView(
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
                                    backgroundColor: MaterialStateProperty.all(
                                        _controllerBible.lightMode.value
                                            ? const Color.fromARGB(
                                                0, 255, 255, 255)
                                            : const Color.fromARGB(0, 0, 0, 0)),
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
                                        color: _controllerBible.lightMode.value
                                            ? Colors.grey
                                            : Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              )));
  }
}
