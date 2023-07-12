//import 'dart:async';

import 'package:aboutmy_team/detailpage.dart';
import 'package:aboutmy_team/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProfileService()),
      ],
      child: MyApp(),
    ),
  );
}

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
    // ignore: unused_local_variable
    final profileService = Provider.of<ProfileService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('E1I4에 대하여'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          // Align 이랑 ListView를 나란히 놓기 위해 부모 위젯으로 감쌌습니당~!
          children: [
            Align(
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
                    'E1I4가 궁금하시다면?',
                    style: TextStyle(fontSize: 24, height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20), // 필요에 따라 공간 추가
            Expanded(
              child: Consumer<ProfileService>(
                  builder: (context, profileService, index) {
                return ListView.separated(
                  itemCount: profileService.profileList.length,
                  itemBuilder: (context, index) {
                    final profile = profileService.profileList[index];

                    return ListTile(
                      contentPadding: EdgeInsets.only(left: 2),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              index: index,
                            ),
                          ),
                        );
                      },
                      title: Feed(profile: profile),
                    );
                  },
                  // 각 Feed 들을 구분하기 위해서 Divider 추가
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                );
              }),
            )
          ],
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

// Feed 클래스 지정(상기 body에 넣기에는 코드가 길어져서 class로 뺌)

class Feed extends StatelessWidget {
  const Feed({
    Key? key,
    required this.profile,
  }) : super(key: key);

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10), // 사진 테두리 둥글게
          child: Image.network(
            profile.photo,
            width: 130,
            height: 130,
            fit: BoxFit.cover, // 위에 가로세로(Box)에 맞춤, 나머지 자르기
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.name,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                softWrap: false,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                profile.mbti,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                ),
                softWrap: false,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                profile.mytype,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                ),
                softWrap: false,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Spacer(),
                  Text(
                    profile.role,
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
