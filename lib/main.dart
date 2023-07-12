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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E1I4에 대하여'),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  width: double.infinity,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      const url =
                          'https://marble-teacher-477.notion.site/11-S-A-c968936e1ac745b6a2a1d1dc59d9fcf6?pvs=4';
                      launchURL(url);
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Center(
                        child: Text(
                          'E1I4가 궁금하시다면?',
                          style: TextStyle(
                            fontSize: 18,
                            height: 1.5,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer<ProfileService>(
                  builder: (context, profileService, index) {
                return ListView.separated(
                  itemCount: profileService.profileList.length,
                  itemBuilder: (context, index) {
                    final profile = profileService.profileList[index];

                    return ListTile(
                      contentPadding: EdgeInsets.only(left: 0),
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
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            profile.photo,
            width: 130,
            height: 130,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.name,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                softWrap: false,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                profile.mbti,
                style: TextStyle(
                  fontSize: 18,
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
                  fontSize: 18,
                  color: Colors.black54,
                ),
                softWrap: false,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Container(
                      width: 35,
                      height: 25,
                      alignment: Alignment.center,
                      decoration: profile.role == '팀장'
                          ? BoxDecoration(
                              color: Colors.blue.withOpacity(0.3),
                              border: Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(5.0),
                            )
                          : BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              border: Border.all(color: Colors.black54),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                      child: Text(
                        profile.role,
                        style: TextStyle(
                          fontSize: 13,
                          color: profile.role == '팀장'
                              ? Colors.blue
                              : Colors.black54,
                        ),
                      ),
                    ),
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
