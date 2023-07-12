import 'package:aboutmy_team/profile_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
          "Profile",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        actions: [
          //저장버튼
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
              size: 20,
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(80, 80, 80, 50),
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: Image.network(
                      profile.photo,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Text(
                profile.name,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      profile.mbti,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      "  /  ",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      profile.mytype,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  // alignment: Alignment.center,
                  width: 120,
                  height: 30,
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.blue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          CupertinoIcons.link,
                          color: Colors.white,
                          size: 15,
                        ),
                        Text(
                          "Blog",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 40, 10, 0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: double.infinity,
                  height: 300,
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
              ),
            ],
          ),
        ),
      ),

      // body: SingleChildScrollView(
      //   child: Padding(
      //     padding: EdgeInsets.symmetric(horizontal: 8.0),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         SizedBox(height: 15),
      //         Container(
      //           margin: EdgeInsets.only(left: 3, right: 3),
      //           child: Column(
      //             children: [
      //               Row(
      //                 children: [
      //                   Flexible(
      //                     flex: 2,
      //                     child: Container(
      //                       margin: EdgeInsets.only(right: 10.0),
      //                       decoration: BoxDecoration(
      //                         border: Border.all(),
      //                         borderRadius: BorderRadius.circular(20),
      //                       ),
      //                       alignment: Alignment.center,
      //                       height: 150,
      //                       child: Column(
      //                         mainAxisAlignment:
      //                             MainAxisAlignment.spaceEvenly,
      //                         crossAxisAlignment: CrossAxisAlignment.start,
      //                         children: [
      //                           Text(
      //                             profile.name,
      //                             style: TextStyle(
      //                               fontWeight: FontWeight.bold,
      //                               fontSize: 30,
      //                             ),
      //                           ),
      //                           Text(profile.mbti),
      //                           Text(profile.blog),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                   Flexible(
      //                     flex: 1,
      //                     child: Container(
      //                       decoration: BoxDecoration(
      //                         border: Border.all(),
      //                         borderRadius: BorderRadius.circular(20),
      //                       ),
      //                       alignment: Alignment.center, // 가로 크기에 맞춰 세로 크기 설정
      //                       height: 150,
      //                       child: ClipRRect(
      //                         borderRadius: BorderRadius.circular(20),
      //                         child: Image.network(
      //                           profile.photo,
      //                           width:
      //                               MediaQuery.of(context).size.width * 0.34,
      //                           height: 150,
      //                           fit: BoxFit.cover,
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //               SizedBox(height: 10),
      //               Container(
      //                 decoration: BoxDecoration(
      //                   border: Border.all(),
      //                   borderRadius: BorderRadius.circular(20),
      //                 ),
      //                 width: double.infinity,
      //                 height: 600,
      //                 child: GestureDetector(
      //                   onTap: () {
      //                     FocusScope.of(context).unfocus();
      //                   },
      //                   child: Padding(
      //                     padding: EdgeInsets.all(15.0),
      //                     child: TextField(
      //                       controller: _contentController,
      //                       decoration: InputDecoration(
      //                         hintText: "자신의 스타일, 장점, 그 외 TMI",
      //                         border: InputBorder.none,
      //                       ),
      //                       autofocus: false,
      //                       maxLines: null,
      //                       expands: true,
      //                       keyboardType: TextInputType.multiline,
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // )
    );
  }
}

class WebViewPage extends StatelessWidget {
  WebViewPage({super.key, required this.url});

  String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(initialUrl: url),
    );
  }
}
