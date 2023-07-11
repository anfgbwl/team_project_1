//import 'dart:async';

import 'package:aboutmy_team/detailpage.dart';
import 'package:aboutmy_team/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
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
                    // GestureDetector는 사용자 동작을 감시하는 코드임(대충 클릭하면 어떻게 하겠다 조건을 지정하는 코드)
                    return GestureDetector(
                      onTap: () {
                        // Feed를 눌렀을 때 DetailPage로 이동하는 코드
                        // !!!!! 상세페이지 작업 시 ListView의 index 값에 따라 다른 값을 보여줘야 함 !!!!!
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPage(
                                      index: index,
                                    )));
                      },
                      child: Feed(profile: profile),
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
