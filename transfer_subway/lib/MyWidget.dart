import 'dart:ffi';

import 'imports.dart';

//메인 페이지 길 입력 됐을 때 정보 안내하는 위젯
class onPathView extends StatefulWidget {
  @override
  _onPathViewState createState() => _onPathViewState();
}

class _onPathViewState extends State<onPathView> {
  List<bool> isBookmarkedList = Global.getIsBookmarkedList();
  bool currentState = false;

  //각 역의 하위역 리스트
  List<List<String>> subwayLowList = [
    [],
    ["다른역", "다른역", "다른도착역2", "다른출발역", "다른도착역1", "다른도착역2"],
    ["다른", "다른1", "다른역2"],
    [],
    //도착역은 하위역이 없으므로 빈 배열
    // 도착역을 제외하고 만약 바로 환승을 한다면 빈배열로 선언하고 cnt는 1로 적어야함
    // 여러 하위역 리스트를 추가할 수 있습니다.
  ];

  //[환승하는 예시 만들어봤어요]
  //312 에서 413으로 환승
  //413 -> 6번 이동해서 513으로 환승
  //513 -> 3번 이동해서 542로 환승
  List<String> subWayList = [
    "모란역 312",
    "다른출발역 413",
    "모란역 513",
    "도착역 542"
  ]; // 출발역 리스트

  //하위역 각 높이 50으로 고정하고 setMyHeight()에서 늘어나면 알아서 조정해줌
  List<double> myheightList = [50, 50, 50, 50]; // 각 역에 대한 높이 리스트

  // 하위역 보는 클릭 여부
  List<bool> isClickedSubwayList = [false, false, false, false];

  //하위 역의 개수
  List<int> isSubwayLowCntList = [1, 6, 3, 0];
  // 도착역을 제외하고 만약 바로 환승을 한다면 빈배열로 선언하고 cnt는 1로 적어야함
  // 즉 무조건 마지막만 0이고 나머지는 최소 1이상 존재함

  void setMyHeight(int index) {
    if (index < myheightList.length) {
      if (myheightList[index] == 50) {
        myheightList[index] += 24 * subwayLowList[index].length;
      } else {
        myheightList[index] = 50;
      }
    }
  }

  bool isCntZero(int index) {
    print(index);
    if (isSubwayLowCntList[index] == 0) {
      return true;
    } else {
      return false;
    }
  }

  List<Widget> getMyWidgets() {
    return List.generate(
      myheightList.length,
      (index) => Container(
        height: myheightList[index],
        //color: Colors.amber,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(images + 'number-3.png', width: 25, height: 25),
                SizedBox(width: 5),
                Text(
                  subWayList[index],
                  style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: "Font",
                    fontWeight: FontWeight.bold,
                    color: AppColor.blackColor,
                  ),
                ),
              ],
            ),

            //일반적인 하위역이 있는 경우
            //참고로 도착역은 하위역이 없다
            Visibility(
              visible: !isCntZero(index),
              child: Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ㅣ",
                      style: TextStyle(
                        fontSize: 17.0,
                        fontFamily: "Font",
                        fontWeight: FontWeight.bold,
                        color: AppColor.mainColor,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "31분 " + //여기 시간도 변수로 바꿔야함
                          isSubwayLowCntList[index].toString() +
                          "개역 이동", //n은 하위역 + 도착역이다 즉 자신의 하위역 개수
                      style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: "Font",
                        fontWeight: FontWeight.bold,
                        color: AppColor.mainColor,
                      ),
                    ),
                    Visibility(
                      visible:
                          !isCntZero(index) && isSubwayLowCntList[index] != 1,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isClickedSubwayList[index] =
                                !isClickedSubwayList[index];
                            setMyHeight(index);
                          });
                        },
                        child: Icon(
                          isClickedSubwayList[index]
                              ? Icons.expand_more
                              : Icons.expand_less,
                          size: 25,
                          color: AppColor.blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //하위역이 있는 경우 하위역 리스트 출력
            Visibility(
              visible: isClickedSubwayList[index],
              child: Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Column(
                  children: List.generate(
                    subwayLowList[index].length,
                    (stationIndex) => Row(
                      children: [
                        Text(
                          "ㅣ",
                          style: TextStyle(
                            fontSize: 17.0,
                            fontFamily: "Font",
                            fontWeight: FontWeight.bold,
                            color: AppColor.mainColor,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          subwayLowList[index][stationIndex],
                          style: TextStyle(
                            fontSize: 13.0,
                            fontFamily: "Font",
                            fontWeight: FontWeight.bold,
                            color: AppColor.mainColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> my = getMyWidgets();
    return getOnPathView(my);
  }

  Widget getOnPathView(List<Widget> my) {
    return Container(
      padding: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 5.0, top: 10.0),
              child: Row(
                children: [
                  Text(
                    "경로 안내",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: "Font",
                      fontWeight: FontWeight.bold,
                      color: AppColor.blackColor,
                    ),
                  ),
                  SizedBox(
                    width: 180,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentState = !currentState;

                          // 여기다가 눌렀을 경우 즐겨찾기 리스트에 추가하면됨
                          // 검색기록은 pathset.dart 에서 이미 추가됨
                          // isBookmarkedList.insert(0, currentState);
                        });
                      },
                      child: Icon(
                        currentState
                            ? Icons.bookmarks
                            : Icons.bookmarks_outlined,
                        size: 32,
                        color: AppColor.mainColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            //color: Colors.blue,
            width: 350,
            height: 350, // ScrollView의 높이
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, right: 10, left: 5),
                    child: Column(
                      children: my,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 길 안내 정보, 게임 버튼
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 350,
                height: 100,
                // color: Colors.amber,
                child: Row(children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        // 게임 페이지로 이동
                      });
                    },
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      child: Icon(
                        Icons.sports_esports_outlined,
                        size: 45,
                        color: AppColor.mainColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Container(
                    width: 156,
                    // color: Colors.black,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "총 안내",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "Font",
                              fontWeight: FontWeight.bold,
                              color: AppColor.blackColor,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "예상 시간 : \n거리 : \n비용 :",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: "Font",
                              fontWeight: FontWeight.bold,
                              color: AppColor.blackColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//메인 페이지 길 입력 안됐을 때 위젯
Widget offPathView = Container(
  padding: EdgeInsets.only(
    left: 20.0, // 왼쪽 패딩
    right: 20.0,
  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center, // 수직 가운데 정렬
    children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 5.0, top: 10.0), // 왼쪽 여백 조정
          child: Text(
            "경로 안내",
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: "Font",
              fontWeight: FontWeight.bold,
              color: AppColor.blackColor,
            ),
          ),
        ),
      ),
      Expanded(
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "현재 길찾기 정보가 없습니다.\n경로를 검색하세요.",
            // 스타일 설정
            style: TextStyle(
              fontSize: 15.0, // 글꼴 크기
              fontFamily: "Font",
              fontWeight: FontWeight.bold, // 굵게 하고 싶은 경우
              color: AppColor.mainColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ],
  ),
);

//바텀네비게이션바 위젯
class BottomNavBar extends StatelessWidget {
  final Function(int) onItemTapped;

  BottomNavBar(
    int i, {
    //required this.selectedIndex,
    required this.onItemTapped,
  });

  final List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.map),
      label: 'Map',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.badge),
      label: 'badge',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'setting',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: items,
      currentIndex: currentIndex,
      selectedItemColor: AppColor.selectedColor,
      unselectedItemColor: Colors.grey,
      onTap: onItemTapped,
      iconSize: 32.0,
      selectedFontSize: 14.0,
      elevation: 0,
    );
  }
}

//페이지 이동(슬라이드 방식)하는 위젯
PageRouteBuilder pageRoute(int newIndex, [int? backIndex]) {
  const curve = Curves.easeInOut;
  Offset begin;
  //print(newIndex);
  //print(currentIndex);
  //인덱스에 맞게 화면 슬라이드 방식을 설정한다.
  if (newIndex == PATH_SET) {
    begin = Offset(0.0, 1.0); //위로 슬라이딩
  } else if (newIndex == GMAE_PAGE) {
    begin = Offset(0.0, -1.0); //아래로 슬라이딩
  } else {
    if (newIndex < currentIndex) {
      begin = Offset(-1.0, 0.0); // 왼쪽으로 슬라이딩
    } else {
      begin = Offset(1.0, 0.0); // 오른쪽으로 슬라이딩
    }
  }

  //index에 맞는 페이지를 불러온다.
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      if (newIndex == SUBWAY_MAP_PAGE) {
        return SubwayMapPage();
      } else if (newIndex == MY_APP_PAGE) {
        return MyApp();
      } else if (newIndex == BADGES_PAGE) {
        return BadgesPage();
      } else if (newIndex == SETTINGS_PAGE) {
        return SettingsPage();
      } else if (newIndex == PATH_SET) {
        return PathSetPage();
      } else if (newIndex == GMAE_PAGE) {
        return GamePage();
      } else {
        return SizedBox(); //else로 들어오는 경우는 없지만 반드시 return 해야하므로 빈 위젯을 돌려준다
      }
    },
    //부드러운 슬라이드를 위해 애니메이션 설정
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const end = Offset.zero;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

// 직접 만든 Appbar 위젯
Widget getMyAppbar() {
  return Container(
    width: 393,
    height: 125,
    padding: EdgeInsets.only(
      left: 20.0,
      right: 20.0,
    ),
    color: AppColor.blueColor,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Icon(
            Icons.cloudy_snowing,
            size: 32,
            color: Colors.white,
          ),
        ),
        Expanded(
          child: Container(
            child: Align(
              alignment: Alignment.centerRight,
              child: Stack(
                children: [
                  Positioned(
                    left: 85, // 텍스트를 왼쪽으로 픽셀 이동
                    top: 38,
                    child: Text(
                      "Hello, 환승철",
                      style: TextStyle(
                        fontSize: 23.0,
                        fontFamily: "hand",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
