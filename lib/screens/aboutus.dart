import 'package:flutter/material.dart';

class ScreenAboutUs extends StatelessWidget {
  const ScreenAboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown,
          foregroundColor: Colors.brown,
          title: const Row(
            children: [Icon(Icons.book), Text("Bible")],
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                    width: 300,
                    height: 300,
                    child: Image.asset('assets/icons/logo.png')),
              ],
            ),
          ),
        ));
  }
}
