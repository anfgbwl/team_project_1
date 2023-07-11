import 'package:flutter/cupertino.dart';

class Profile {
  Profile({
    required this.photo,
    required this.name,
    required this.mbti,
    required this.blog,
    required this.mytype,
  });
  String photo;
  String name;
  String mbti;
  String blog;
  String mytype;
}

class ProfileService extends ChangeNotifier {
  List<Profile> profileList = [
    Profile(
      photo: '사진 url',
      name: '한동연',
      mbti: 'INTP',
      blog: 'https://progressing.tistory.com/',
      mytype: '공부는 마라톤',
    ),
    Profile(
      photo: '사진 url',
      name: '김서진',
      mbti: 'ISFP',
      blog: 'zzin2990.tistory.com',
      mytype: '열심히 허자',
    ),
    Profile(
      photo:
          'https://teamsparta.notion.site/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2Fb9308949-ab1a-4a06-8258-f1b6f60cce90%2FEBE8BF9D-5BD7-4AD4-8FC4-84157068BC52.jpeg?id=26769fd9-5881-44f4-90fb-84c279204552&table=block&spaceId=83c75a39-3aba-4ba4-a792-7aefe4b07895&width=1310&userId=&cache=v2',
      name: '김서온',
      mbti: 'ENTP',
      blog: 'https://ahrzosel.tistory.com/',
      mytype: '나는 끝까지 살아남을꺼야',
    ),
    Profile(
      photo: '사진 u',
      name: '정기현',
      mbti: 'INFP',
      blog: 'https://jkh0013011.tistory.com/',
      mytype: '포기하지 말자',
    ),
    Profile(
      photo: '사진 url',
      name: '차재영',
      mbti: 'ISTP',
      blog: 'https://jblog1229.tistory.com/',
      mytype: '하면된다',
    ),
  ];
}
