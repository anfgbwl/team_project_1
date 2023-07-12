import 'package:aboutmy_team/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ProfileService profileService = context.read<ProfileService>();
    Profile profile = profileService.profileList[widget.index];
    _contentController.text = profile.content;
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProfileService profileService = context.read<ProfileService>();
    Profile profile = profileService.profileList[widget.index];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 20,
          ),
        ),
        title: Text(
          "E1I4",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (_contentController.text != profile.content) {
                profileService.updateProfile(
                  index: widget.index,
                  content: _contentController.text,
                );
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('저장'),
                      content: Text('변경되었습니다.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('확인'),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  launch(profile.blog);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 3, right: 3),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            flex: 2,
                            child: Container(
                              margin: EdgeInsets.only(right: 10.0),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              alignment: Alignment.center,
                              height: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    profile.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(profile.mbti),
                                  Text(profile.blog),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              alignment: Alignment.center,
                              height: 150,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  profile.photo,
                                  width:
                                      MediaQuery.of(context).size.width * 0.34,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: double.infinity,
                        height: 600,
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: TextField(
                              controller: _contentController,
                              decoration: InputDecoration(
                                hintText: "자신의 스타일, 장점, 그 외 TMI",
                                border: InputBorder.none,
                              ),
                              autofocus: false,
                              maxLines: null,
                              expands: true,
                              keyboardType: TextInputType.multiline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
