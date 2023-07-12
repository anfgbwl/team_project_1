import 'package:aboutmy_team/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController _textFieldController = TextEditingController();
  late SharedPreferences _prefs;
  String _savedText = "";
  bool _isModified = false;

  @override
  void initState() {
    super.initState();
    _loadSavedText(); // 저장된 텍스트 로드
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  Future<void> _loadSavedText() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedText = _prefs.getString(_getSavedTextKey()) ?? "";
      _textFieldController.text = _savedText; // 텍스트 필드에 로드한 텍스트 설정
    });
  }

  Future<void> _saveText(String text) async {
    setState(() {
      _savedText = text;
      _isModified = false;
    });
    await _prefs.setString(_getSavedTextKey(), text); // 텍스트 저장
  }

  String _getSavedTextKey() {
    return 'savedText${widget.index}';
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    ProfileService profileService = context.read<ProfileService>();
    Profile profile = profileService.profileList[widget.index];

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
                color: Color.fromARGB(255, 255, 255, 255),
                size: 20,
              ),
            )
          ],
        ),
        title: Text(
          "E1I4",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (_isModified) {
                _saveText(_textFieldController.text);
                _showSnackBar(context, '수정되었습니다.');
              }
            },
            icon: Icon(
              Icons.check,
              color: const Color.fromARGB(255, 255, 255, 255),
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
              Container(
                margin: EdgeInsets.only(left: 3, right: 3),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10.0),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.center,
                          width: 250,
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
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: MediaQuery.of(context).size.width * 0.34,
                          height: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              profile.photo,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      // 너가 작업할 곳.
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: double.infinity,
                      height: 500,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: TextField(
                          controller: _textFieldController,
                          decoration: InputDecoration(
                            hintText: "자신의 스타일, 장점, 그 외 TMI",
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            setState(() {
                              _isModified = true;
                            });
                          },
                          autofocus: false,
                          maxLines: null,
                          expands: true,
                          keyboardType: TextInputType.multiline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    if (_isModified) {
                      _saveText(_textFieldController.text);
                      _showSnackBar(context, '수정되었습니다.');
                    }
                  },
                  child: Text("수정하기"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
