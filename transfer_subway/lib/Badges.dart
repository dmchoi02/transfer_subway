// 칭호와 관련된 페이지

import 'imports.dart';

const List<dynamic> badgeContents = [
  [Icons.directions_subway, "탐험가", "지금까지 방문한 역 : 60개"],
  [Icons.sunny, "아침의 달인", "아침에 길찾기를 이용한 횟수 : 45번"],
  [Icons.looks_3, "3호선의 왕", "3호선을 이용한 횟수 : 42번"],
  [Icons.sports_esports, "프로게이머", "퍼즐 게임을 바로 성공한 횟수 : 56번"],
  [Icons.nightlife, "저녁의 달인", "저녁에 길찾기를 이용한 횟수 : 45번"],
  [Icons.blur_circular, "환승의 왕", "환승을 이용한 횟수 : 30번"],
];

class BadgesPage extends StatefulWidget {
  const BadgesPage({Key? key}) : super(key: key);

  @override
  State<BadgesPage> createState() => _BadgesPageState();
}

class _BadgesPageState extends State<BadgesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          getMyAppbar(
              context), //직접 만든 Appbar 호출, 기존에 flutter Appbar 사용시 현재 화면을 구현하기 어려우므로 appbar를 위젯으로 만듬
          Padding(
            padding: EdgeInsets.only(
              top: 90.0, // 위 패딩
              left: 20.0, // 왼쪽 패딩
              right: 20.0, // 오른쪽 패딩
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: 20.0, // 왼쪽 패딩
                    right: 20.0,
                  ),
                  width: 352.0,
                  height: 615 - 23,
                  decoration: BoxDecoration(
                    // 모서리 둥글게 만들기
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 5.0, top: 10.0), // 왼쪽, 위 여백 조정
                          child: Text(
                            "칭호",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: "Font",
                              fontWeight: FontWeight.bold,
                              //color: AppColor.blackColor,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 7.0), // 왼쪽 여백 조정
                          child: Text(
                            "아래와 같은 칭호를 가지고 있습니다!",
                            // 스타일 설정
                            style: TextStyle(
                              fontSize: 15.0, // 글꼴 크기
                              fontFamily: "Font",
                              fontWeight: FontWeight.bold, //굵게 하고 싶은 경우
                              color: AppColor.mainColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: 530,
                          child: ListView.builder(
                            //padding: EdgeInsets.only(left : 0.7),
                            itemCount: badgeContents.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: Card(
                                  margin:
                                      EdgeInsets.fromLTRB(5.0, 6.0, 5.0, 6.0),
                                  //color: Colors.white,
                                  child: ListTile(
                                    isThreeLine: true,
                                    leading:
                                        Icon(badgeContents[index][0], size: 50),
                                    title: Row(children: <Widget>[
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(badgeContents[index][1]),
                                      ),
                                      // Spacer(),
                                      // Container(
                                      //   alignment: Alignment.topRight,
                                      //   child: Text("some text"),
                                      // ),
                                    ]),
                                    subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(badgeContents[index][2]),
                                        ]),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ClipOval(
                                          child: Material(
                                            color: AppColor
                                                .selectedColor, // Button color
                                            child: InkWell(
                                              splashColor:
                                                  Colors.yellow, // Splash color
                                              onTap: () {},
                                              child: SizedBox(
                                                  width: 40,
                                                  height: 40,
                                                  child: Icon(Icons.menu)),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex = BADGES_PAGE, // 현재 페이지가 두 번째 페이지이므로 해당 인덱스 선택
        onItemTapped: (newIndex) {
          if (newIndex != currentIndex) {
            Navigator.push(context, pageRoute(newIndex));
          }
        },
      ),
    );
  }
}
