import 'package:aboutmy_team/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    ProfileService profileService = context.read<ProfileService>();
    Profile profile = profileService.profileList[index];
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                }, //뒤로가기

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 15,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(20)),
                          alignment: Alignment.center,
                          width: 200,
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profile.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Text(profile.mbti),
                              Text(profile.blog),
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(20)),
                          alignment: Alignment.center,
                          width: 150,
                          height: 150,
                          child: Text(profile.photo),
                        )
                      ],
                    ),
                    SizedBox(height: 20, width: double.infinity),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(20)),
                        width: double.infinity,
                        height: 500,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "자신의 스타일, 장점, 그 외 TMI",
                              border: InputBorder.none,
                            ),
                            autofocus: true,
                            maxLines: null,
                            expands: true,
                            keyboardType: TextInputType.multiline,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("수정하기"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
