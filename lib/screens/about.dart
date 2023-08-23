import 'package:flutter/material.dart';

class ScreenAboutUs extends StatelessWidget {
  const ScreenAboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const  Text("Buku Lopatulika"),

      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: 300,
                height: 300,
                child: Image.asset('assets/icons/logo.png'),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "About Us",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Welcome to the Bible app, your digital companion to exploring and understanding the Holy Scriptures.",
                  textAlign: TextAlign.center,
                ),
              ),
              const ListTile(
                leading: Icon(Icons.business),
                title: Text("Company Name"),
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
                  "Our dedicated team of developers and designers strive to provide you with a seamless and enriching Bible study experience.",
                  textAlign: TextAlign.center,
                ),
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
