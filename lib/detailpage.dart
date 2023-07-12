import 'package:aboutmy_team/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.index});
  final int index;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
    _contentController.text = profile.content;

    return Scaffold(
        appBar: AppBar(
          leading: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 20,
                  ))
            ],
          ),
          title: Text(
            "E1I4",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                Container(
                  margin: EdgeInsets.only(left: 3, right: 3), // 좌우 여백 설정
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
                              alignment: Alignment.center, // 가로 크기에 맞춰 세로 크기 설정
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

                              // 코드 추가
                              onChanged: (text) {
                                profileService.updateProfile(
                                    index: widget.index, content: text);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
