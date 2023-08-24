import 'package:bible_chichewa/bible_chichewa.dart';
import 'package:chichewa_bible/controllers/bible.dart';
import 'package:chichewa_bible/widget/searchmenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:new_version_plus/new_version_plus.dart';

class ScreenApp extends StatefulWidget {
  const ScreenApp({Key? key}) : super(key: key);

  @override
  State<ScreenApp> createState() => _ScreenAppState();
}

class _ScreenAppState extends State<ScreenApp> {
  final _controllerBible = Get.put(BibleController());

  var loading = true;

  // Bible configuration
  var book = BOOK.genesis;
  var chapter = 0;

  @override
  void initState() {
    super.initState();
    // Instantiate NewVersion manager object (Using GCP Console app as example)
    // try {
    //   final newVersion = NewVersionPlus(
    //     //iOSId: 'com.m2kdevelopments.biblechichewa',
    //     androidId: 'com.m2kdevelopments.biblechichewa',
    //   );
    //   newVersion.showAlertIfNecessary(context: context);
    // } catch (e) {
    //   print(e.toString());
    // }

    _controllerBible.load().then((value) => setState(() => loading = false));
  }

  void _onBook(int index) =>
      Navigator.pushNamed(context, "/book", arguments: BOOK.values[index]);

  void _onAbout() => Navigator.pushNamed(context, "/about");

  void _onSearch(BuildContext context) {
    showSearch(
        context: context,
        delegate: WidgetSearchMenu(_controllerBible.bible.value.getBooks()));
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Scaffold(
            body: Container(
              color: Colors.black87,
              child: Center(
                child: Column(children: [
                  SizedBox(
                    width: 500,
                    height: 500,
                    child: Image.asset('assets/icons/logo.png'),
                  ),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Lottie.asset('assets/anim/loading.json'),
                  )
                ]),
              ),
            ),
          )
        : Obx(
            () => Scaffold(
                appBar: AppBar(
                  title: const Text("Buku Lopatulika"),
                  elevation: 8.0,
                  backgroundColor: Colors.brown,
                  actions: [
                    IconButton(
                        onPressed: () => _onSearch(context),
                        icon: const Icon(Icons.search)),
                    IconButton(
                        onPressed: _onAbout,
                        icon: const Icon(Icons.info_outline))
                  ],
                ),
                body: Container(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 2.0,
                            mainAxisSpacing: 1.0,
                            mainAxisExtent: 60.0),
                    itemCount: _controllerBible.bible.value
                        .getBooks()
                        .length, // Number of items in the grid
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 1.0, 8.0, 0.0),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0.0),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white)),
                              onPressed: () => _onBook(index),
                              child: Row(
                                children: [
                                  Text(
                                    _controllerBible.bible.value
                                        .getBooks()[index],
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  const Spacer(),
                                  Text(
                                    _controllerBible.bible.value
                                        .getChapterCount(BOOK.values[index])
                                        .toString(),
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  const Icon(
                                    Icons.book,
                                    color: Color.fromARGB(255, 226, 187, 161),
                                  )
                                ],
                              )));
                    },
                  ),
                )),
          );
  }
}
