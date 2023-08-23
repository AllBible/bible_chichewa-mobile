import 'package:bible_chichewa/bible_chichewa.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ScreenApp extends StatefulWidget {
  const ScreenApp({Key? key}) : super(key: key);

  @override
  State<ScreenApp> createState() => _ScreenAppState();
}

class _ScreenAppState extends State<ScreenApp> {
  final bible = Bible();
  var loading = true;

  // Bible configuration
  var book = BOOK.genesis;
  var chapter = 0;

  @override
  void initState() {
    super.initState();
    // bible.init().then((value) => setState(() => loading = false));
  }

  void _onBook(String b) {
    var index = bible.getBooks().indexOf(b);
    setState(() {
      book = BOOK.values[index];
    });
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
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.brown,
              foregroundColor: Colors.brown,
              title: const Row(
                children: [Icon(Icons.book), Text("Bible")],
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: bible
                    .getBooks()
                    .map((book) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 0.9,
                            child: Column(
                              children: [
                                Text(book),
                                ElevatedButton(
                                    onPressed: () => _onBook(book),
                                    child: const Row(
                                      children: [
                                        Icon(Icons.book),
                                        Text("Read")
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          );
  }
}
