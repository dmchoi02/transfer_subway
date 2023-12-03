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
  List<String> searchHistory = Global.getSearchHistory();
  String _setnowsearchlist = Global.getsetnowsearchlist();
  List<double> myheightList = Global.myheightList;

  // 하위역 보는 클릭 여부
  List<bool> isClickedSubwayList = Global.isClickedSubwayList;
  List<int> subwayLowCntList = Global.subwayLowCntList;
  int x = 0; //인덱스값의 간이 주소

  void initState() {
    super.initState();

    // initState에서 추가적인 작업을 수행합니다.
    print('생성');
    x = searchHistory.indexOf(_setnowsearchlist);
    if (x != -1) {
      currentState = isBookmarkedList[x];
    } else {
      print('$_setnowsearchlist 가 없습니다. false로 설정합니다.');
    }
  }

  // 하위역 각 높이 50으로 고정하고 setMyHeight()에서 늘어나면 알아서 조정해줌
  void setMyHeight(int index) {
    if (index < myheightList.length) {
      if (myheightList[index] == 50) {
        myheightList[index] += 24 * Global.subwayLowList[index].length;
      } else {
        myheightList[index] = 50;
      }
    }
  }

  // 하위역의 개수가 0인지 확인하는 함수
  bool isCntZero(int index) {
    //print(index);
    if (subwayLowCntList[index] == 0) {
      //print("트루 반환");
      return true;
    } else {
      //print("flast 반환");
      return false;
    }
  }

  // 안내 역들에 대한 위젯
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
                Image.asset(
                    //수정 필요함
                    images + 'number-' + Global.subwayNumList[index] + '.png',
                    width: 25,
                    height: 25),
                SizedBox(width: 5),
                Text(
                  Subways().stations[Global.subWayList[index]]?['name'] +
                      " " +
                      Global.subWayList[index],
                  //Global.subWayList[index].['name'],
                  style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: "Font",
                    fontWeight: FontWeight.bold,
                    //color: AppColor.blackColor,
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
                      (1 + subwayLowCntList[index]).toString() +
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
                          !isCntZero(index) && subwayLowCntList[index] != 0,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            //print("바뀝니다.");
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
                          //color: AppColor.blackColor,
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
                    Global.subwayLowList[index].length,
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
                          (Subways().stations[Global.subwayLowList[index]
                                      [stationIndex]]?['name'])
                                  .toString() +
                              " " +
                              Global.subwayLowList[index][stationIndex],
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
            //하위역이 없는데 현재 index가 도착역이 아닌 경우
            Visibility(
              visible: subwayLowCntList[index] == 0,
              child: Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Column(
                  children: List.generate(
                    Global.subwayLowList[index].length,
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
                          (1 + subwayLowCntList[index]).toString() +
                              "개역 이동", //n은 하위역 + 도착역이다 즉 자신의 하위역 개수
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

  // 안내하는 경로를 보여주는 위젯
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
                      //color: AppColor.blackColor,
                    ),
                  ),
                  SizedBox(
                    width: 185,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentState = !currentState;
                          //isBookmarkedList[x] = currentState;
                          Global.isBookmarkedList[x] = currentState;
                          Global.saveIsBookmarkedListPrefs(isBookmarkedList);
                          print('is widget book $isBookmarkedList');
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

          // 길 안내 정보
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 350,
                height: 100,
                //color: Colors.amber,
                child: Row(children: [
                  SizedBox(
                    width: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Container(
                      width: 230,
                      //color: Colors.black,
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
                                //color: AppColor.blackColor,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "예상 시간 : " +
                                  Global.guideTime +
                                  "\n거리 : " +
                                  Global.guideDistance +
                                  "\n비용 : " +
                                  Global.guideCost,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: "Font",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
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
              //color: AppColor.blackColor,
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
    required int currentIndex,
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
Widget getMyAppbar(BuildContext context) {
  return Container(
    width: 393,
    height: 125,
    padding: EdgeInsets.only(
      left: 20.0,
      right: 20.0,
    ),
    color: Theme.of(context).colorScheme.secondaryContainer,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 10.0),
            // child: Icon(
            //   Icons.cloudy_snowing,
            //   size: 32,
            //   color: Colors.white,
            // ),
            child: MyWeather()),
        Expanded(
          child: Container(
            child: Align(
              alignment: Alignment.centerRight,
              child: Stack(
                children: [
                  Positioned(
                    left: 55, // 텍스트를 왼쪽으로 픽셀 이동
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
