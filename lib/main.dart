import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E1I4에 대하여'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2.0,
              ),
            ),
            child: GestureDetector(
              onTap: () {
                const url =
                    'https://marble-teacher-477.notion.site/11-S-A-c968936e1ac745b6a2a1d1dc59d9fcf6?pvs=4';
                launchURL(url);
              },
              child: Text(
                'E1i4가 궁금하시다면?',
                style: TextStyle(fontSize: 24, height: 1.5),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

void main() {
  runApp(MyApp());
}
