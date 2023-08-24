import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenAboutUs extends StatelessWidget {
  const ScreenAboutUs({Key? key}) : super(key: key);
  final _iconSize = 40.0;

  void _loadUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      if (kDebugMode) print("Cannot Open $url");
    }
  }

  void _onShare() => Share.share(
      'Khalani Wodalitsidwa ndi Mawu a Mulungu\nhttps://play.google.com/store/apps/details?id=com.m2kdevelopments.biblechichewa',
      subject: 'Chichewa Bible - Mawu a Mulungu');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text("Buku Lopatulika"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: 155,
                height: 155,
                child: Image.asset('assets/icons/logo.png'),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Chichewa",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.brown),
                  ),
                  Text(
                    "Bible",
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 24,
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "About Us : Zambiri Zaife",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: ListTile(
                  leading: Icon(Icons.business),
                  title: Text(
                    "Welcome to the Chichewa Bible app, your digital companion to exploring and understanding the Holy Scriptures.",
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    "Takulandirani ku pulogalamu ya m'Baibulo, bwenzi lanu lapakompyuta lophunzira ndi kumvetsa Malemba Opatulika.",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50.0, 0, 50.0, 10.0),
                child: ElevatedButton(
                    onPressed: _onShare,
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blueGrey)),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.share,
                          color: Colors.orangeAccent,
                        ),
                        SizedBox(
                          width: 20,
                          height: 0,
                        ),
                        Text(
                          "Share",
                        )
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () =>
                          _loadUrl('https://facebook.com/m2kdevelopments'),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      icon: SizedBox(
                        width: _iconSize,
                        height: _iconSize,
                        child: Image.asset('assets/icons/facebook.png'),
                      ),
                    ),
                    IconButton(
                      onPressed: () =>
                          _loadUrl('https://instagram.com/m2kdevelopments'),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      icon: SizedBox(
                        width: _iconSize,
                        height: _iconSize,
                        child: Image.asset('assets/icons/instagram.png'),
                      ),
                    ),
                    IconButton(
                      onPressed: () =>
                          _loadUrl('https://twitter.com/developmentsm2k'),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      icon: SizedBox(
                        width: _iconSize,
                        height: _iconSize,
                        child: Image.asset('assets/icons/twitter.png'),
                      ),
                    ),
                    IconButton(
                      onPressed: () =>
                          _loadUrl('https://github.com/m2kdevelopments'),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      icon: SizedBox(
                        width: _iconSize,
                        height: _iconSize,
                        child: Image.asset('assets/icons/github.png'),
                      ),
                    ),
                  ],
                ),
              ),
              const ListTile(
                leading: Icon(Icons.business),
                title: Text("Company"),
                subtitle: Text("M2K Developments"),
              ),
              const ListTile(
                leading: Icon(Icons.location_on),
                title: Text("Location"),
                subtitle: Text("Malawi Blantyre"),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "For any inquiries or support, feel free to contact us at m2kdevelopments@gmail.com.",
                  textAlign: TextAlign.center,
                ),
              ),
              // You can add more sections here, such as Privacy, Mission, History, etc.
            ],
          ),
        ),
      ),
    );
  }
}
