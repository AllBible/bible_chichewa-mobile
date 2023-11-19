import 'package:chichewa_bible/screens/about.dart';
import 'package:chichewa_bible/screens/app.dart';
import 'package:chichewa_bible/screens/book.dart';
import 'package:chichewa_bible/screens/chapter.dart';
import 'package:chichewa_bible/screens/search.dart';
import 'package:chichewa_bible/screens/settings.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buku Lopatulika',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const ScreenApp(),
        '/about': (context) => const ScreenAboutUs(),
        '/search': (context) => const ScreenSearch(),
        '/settings': (context) => const ScreenSettings(),
        '/chapter': (context) => const ScreenChapter(),
        '/book': (context) => const ScreenBook()
      },
    );
  }
}
