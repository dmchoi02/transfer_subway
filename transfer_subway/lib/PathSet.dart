// 길을 입력하는 페이지

import 'dart:io';

import 'package:transfer_subway/subwaygraph.dart';

import 'imports.dart';

class PathSetPage extends StatefulWidget {
  const PathSetPage({Key? key}) : super(key: key);

  @override
  State<PathSetPage> createState() => _PathSetPageState();
}

class _PathSetPageState extends State<PathSetPage> with WidgetsBindingObserver {
  TextEditingController departureController = TextEditingController();
  TextEditingController destinationController = TextEditingController();

  final TextEditingController _filter = TextEditingController();
  final Subways subways = Subways();
  final SubwayGraph graph = SubwayGraph();
  List<String> _searchList = [];
  final departureFocusNode = FocusNode();
  final destinationFocusNode = FocusNode();
  int WhatIsNowController = 0;
  String departureValue = '';
  String destinationValue = '';

  double containerHeight = 560.0; //초기 컨테이너 높이
  bool okInputPath = false;
  bool onPathOrPathInput = false;
  int focusCnt = 0;

  // 출발지와 도착지 값을 저장하고 화면에서 포커스를 해제합니다.

  void _saveValues() {
    if (_isNumeric(departureController.text) == true) {
      departureValue = departureController.text;
      destinationValue = destinationController.text;
    } else {
      departureValue = subways.getKeyFromName(departureController.text);
      destinationValue = subways.getKeyFromName(destinationController.text);
    }

    // 여기에서 변수에 저장하거나 다른 로직을 수행할 수 있습니다.
    print('출발지: $departureValue');
    print('도착지: $destinationValue');

    // 출발지와 도착지 값이 비어있지 않으면 포커스를 해제합니다.
    if (departureValue.isNotEmpty && destinationValue.isNotEmpty) {
      FocusScope.of(context).unfocus(); // 두개의 값이 입력되었으므로 키보드 창이 사라짐
      print("호출됨");
      okInputPath = true;
      onPathOrPathInput = true;
    } else {
      myShowToast(context, '모든 경로를 입력해주세요!'); // 하나라도 입력 안된 경우 메시지 출력
    }
  }

  //해당 텍스트가 숫자인지 이름인지 확인
  bool _isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  // 위젯의 상태가 초기화될 때 호출되는 메서드
  @override
  void initState() {
    super.initState();
    // 위젯 바인딩 이벤트 옵저버를 추가합니다.
    WidgetsBinding.instance!.addObserver(this);
  }

  // 위젯이 파괴될 때 호출되는 메서드
  @override
  void dispose() {
    // 위젯 바인딩 이벤트 옵저버를 제거하고 컨트롤러들을 해제합니다.
    WidgetsBinding.instance!.removeObserver(this);
    departureController.dispose();
    destinationController.dispose();
    super.dispose();
  }

  // 화면 크기가 변경될 때 호출되는 메서드
  @override
  void didChangeMetrics() {
    // 다음 프레임까지 기다린 후 화면 높이를 조정합니다.
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _adjustContainerHeight();
    });
  }

  // 키보드 상태에 따라 화면의 높이를 조절하는 메서드

  void _adjustContainerHeight() {
    if (MediaQuery.of(context).viewInsets.bottom > 0) {
      // 키보드가 올라온 상태일 때의 화면 높이
      setState(() {
        containerHeight = 330.0;
      });
    } else {
      // 키보드가 내려간 상태일 때의 화면 높이
      setState(() {
        containerHeight = 560.0;
      });
    }
  }

  // 검색기록들의 즐겨찾기 아이콘에 대한 상태
  // false는 아이콘이 꺼져있는 것을 의미한다.
  List<bool> isBookmarkedList = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  // 검색기록들
  List<String> searchHistory = [
    '158 -> 343',
    '검색 기록 2',
    '검색 기록 3',
    '158 -> 343',
    '158 -> 343',
    '검색 기록 2',
    '검색 기록 3',
    '158 -> 343',
    '검색 기록 3',
    '158 -> 343',
  ];

  // 거리 안내 클릭 여부
  // 차례대로 최소 (시간, 거리, 비용)을 의미함.
  List<bool> isGuideClicked = [
    false,
    false,
    false,
  ];

  // 거리 안내 클릭 시 동작
  void setGuideClicked(int n) {
    // 클릭 방식 1번쨰
    isGuideClicked[0] = n == 0;
    isGuideClicked[1] = n == 1;
    isGuideClicked[2] = n == 2;

    /* 클릭 방식 2번째 (이미 선택된 클릭 다시 클릭하면 꺼짐)
    isGuideClicked[0] = n == 0 ? !isGuideClicked[0] : false;
    isGuideClicked[1] = n == 1 ? !isGuideClicked[1] : false;
    isGuideClicked[2] = n == 2 ? !isGuideClicked[2] : false;
    */
  }

  // 최근 검색 기록 위젯
  Widget getSearchHistory() {
    return Container(
      padding: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
      ),
      width: 352.0,
      height: containerHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: 5.0,
                top: 10.0,
              ),
              child: Text(
                "최근 검색 기록",
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
            child: ListView.builder(
              itemExtent: 40,
              itemCount: searchHistory.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          print("Text clicked at index $index");
                        },
                        child: Text(
                          searchHistory[index],
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: "Font",
                            fontWeight: FontWeight.bold,
                            color: AppColor.mainColor,
                          ),
                        ),
                      ),
                      //SizedBox(width: 140),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isBookmarkedList[index] = !isBookmarkedList[index];
                          });
                          if (isBookmarkedList[index]) {
                            print("Add to bookmarks at index $index");
                          } else {
                            print("Remove from bookmarks at index $index");
                          }
                        },
                        child: Icon(
                          isBookmarkedList[index]
                              ? Icons.bookmarks
                              : Icons.bookmarks_outlined,
                          size: 32,
                          color: AppColor.mainColor,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    //print("ListTile clicked at index $index");
                  },
                );
              },
            ),
          ),
          Container(
            width: 352,
            height: 70,
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 12,
                right: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.collections_bookmark,
                    size: 32,
                    color: AppColor.blackColor,
                  ),
                  Text(
                    '즐겨찾기',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: "Font",
                      fontWeight: FontWeight.bold,
                      color: AppColor.mainColor,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // 거리 안내 위젯
  Widget getGuidePath() {
    print("DD");
    print("$departureValue");
    print("$destinationValue");
    print("DD");
    if (MediaQuery.of(context).viewInsets.bottom == 0) {
      print("작업 수행");
      var result_time =
          graph.runDijkstra(departureValue, destinationValue, 'time');
      var result_cost =
          graph.runDijkstra(departureValue, destinationValue, 'cost');
      var result_distance =
          graph.runDijkstra(departureValue, destinationValue, 'distance');
      // 작업이 완료되면 상태를 변경하여 원하는 위젯을 화면에 불러옵니다.
      return Container(
        padding: EdgeInsets.only(
          left: 20.0, // 왼쪽 패딩
          right: 20.0,
        ),
        width: 352.0,
        height: 560,
        decoration: BoxDecoration(
          // 모서리 둥글게 만들기
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 5.0,
                  top: 10.0,
                ),
                child: Text(
                  "거리 안내",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Font",
                    fontWeight: FontWeight.bold,
                    color: AppColor.blackColor,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 7.0), // 왼쪽 여백 조정
                child: Text(
                  "원하는 경로 안내를 선택하세요!",
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
            SizedBox(height: 10),
            GestureDetector(
              // onTap 이벤트를 사용하여 클릭 시 상태를 변경
              onTap: () {
                setState(() {
                  setGuideClicked(0);
                });
              },
              child: Container(
                width: 352,
                height: 130,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isGuideClicked[0]
                        ? AppColor.selectedColor
                        : AppColor.mainColor, // 테두리 색상
                    width: 3.0, // 테두리 굵기
                  ),
                ),
                child: Column(children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 15,
                        left: 20,
                      ),
                      child: Text(
                        "최소 시간 ",

                        // 스타일 설정
                        style: TextStyle(
                          fontSize: 18.0, // 글꼴 크기
                          fontFamily: "Font",
                          fontWeight: FontWeight.bold, //굵게 하고 싶은 경우
                          color: AppColor.blackColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                      ),
                      child: Text(
                        "총 예상 시간 : ${result_time[destinationValue]?['time'] ?? 'N/A'}",
                        // 스타일 설정
                        style: TextStyle(
                          fontSize: 15.0, // 글꼴 크기
                          fontFamily: "Font",
                          fontWeight: FontWeight.bold, //굵게 하고 싶은 경우
                          color: AppColor.blackColor,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                      ),
                      child: Text(
                        "거리 : ${(result_time[destinationValue]?['distance']) ?? 'N/A'} km",
                        // 스타일 설정
                        style: TextStyle(
                          fontSize: 15.0, // 글꼴 크기
                          fontFamily: "Font",
                          fontWeight: FontWeight.bold, //굵게 하고 싶은 경우
                          color: AppColor.blackColor,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                      ),
                      child: Text(
                        "비용 : ${result_time[destinationValue]?['cost'] ?? 'N/A'} 원",
                        // 스타일 설정
                        style: TextStyle(
                          fontSize: 15.0, // 글꼴 크기
                          fontFamily: "Font",
                          fontWeight: FontWeight.bold, //굵게 하고 싶은 경우
                          color: AppColor.blackColor,
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              // onTap 이벤트를 사용하여 클릭 시 상태를 변경
              onTap: () {
                setState(() {
                  setGuideClicked(1);
                });
              },
              child: Container(
                width: 352,
                height: 130,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isGuideClicked[1]
                        ? AppColor.selectedColor
                        : AppColor.mainColor, // 테두리 색상
                    width: 3.0, // 테두리 굵기
                  ),
                ),
                child: Column(children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 15,
                        left: 20,
                      ),
                      child: Text(
                        "최소 거리 ",

                        // 스타일 설정
                        style: TextStyle(
                          fontSize: 18.0, // 글꼴 크기
                          fontFamily: "Font",
                          fontWeight: FontWeight.bold, //굵게 하고 싶은 경우
                          color: AppColor.blackColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                      ),
                      child: Text(
                        "총 예상 시간 : ${result_distance[destinationValue]?['time'] ?? 'N/A'} 초",
                        // 스타일 설정
                        style: TextStyle(
                          fontSize: 15.0, // 글꼴 크기
                          fontFamily: "Font",
                          fontWeight: FontWeight.bold, //굵게 하고 싶은 경우
                          color: AppColor.blackColor,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                      ),
                      child: Text(
                        "거리 : ${result_distance[destinationValue]?['distance'] ?? 'N/A'} km",
                        // 스타일 설정
                        style: TextStyle(
                          fontSize: 15.0, // 글꼴 크기
                          fontFamily: "Font",
                          fontWeight: FontWeight.bold, //굵게 하고 싶은 경우
                          color: AppColor.blackColor,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                      ),
                      child: Text(
                        "비용 : ${result_distance[destinationValue]?['cost'] ?? 'N/A'} 원",
                        // 스타일 설정
                        style: TextStyle(
                          fontSize: 15.0, // 글꼴 크기
                          fontFamily: "Font",
                          fontWeight: FontWeight.bold, //굵게 하고 싶은 경우
                          color: AppColor.blackColor,
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              // onTap 이벤트를 사용하여 클릭 시 상태를 변경
              onTap: () {
                setState(() {
                  setGuideClicked(2);
                });
              },
              child: Container(
                width: 352,
                height: 130,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isGuideClicked[2]
                        ? AppColor.selectedColor
                        : AppColor.mainColor, // 테두리 색상
                    width: 3.0, // 테두리 굵기
                  ),
                ),
                child: Column(children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 15,
                        left: 20,
                      ),
                      child: Text(
                        "최소 비용 ",

                        // 스타일 설정
                        style: TextStyle(
                          fontSize: 18.0, // 글꼴 크기
                          fontFamily: "Font",
                          fontWeight: FontWeight.bold, //굵게 하고 싶은 경우
                          color: AppColor.blackColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                      ),
                      child: Text(
                        "총 예상 시간 : ${result_cost[destinationValue]?['time'] ?? 'N/A'} 초",
                        // 스타일 설정
                        style: TextStyle(
                          fontSize: 15.0, // 글꼴 크기
                          fontFamily: "Font",
                          fontWeight: FontWeight.bold, //굵게 하고 싶은 경우
                          color: AppColor.blackColor,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                      ),
                      child: Text(
                        "거리 : ${result_cost[destinationValue]?['distance'] ?? 'N/A'} km",
                        // 스타일 설정
                        style: TextStyle(
                          fontSize: 15.0, // 글꼴 크기
                          fontFamily: "Font",
                          fontWeight: FontWeight.bold, //굵게 하고 싶은 경우
                          color: AppColor.blackColor,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                      ),
                      child: Text(
                        "비용 : ${result_cost[destinationValue]?['cost'] ?? 'N/A'} 원",
                        // 스타일 설정
                        style: TextStyle(
                          fontSize: 15.0, // 글꼴 크기
                          fontFamily: "Font",
                          fontWeight: FontWeight.bold, //굵게 하고 싶은 경우
                          color: AppColor.blackColor,
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),

            SizedBox(
              height: 10,
            ),
            // 안내 버튼
            IconButton(
              icon: Icon(
                Icons.play_circle_filled_rounded, // Play Circle 아이콘
                size: 45.0, // 아이콘 크기 설정
                color: AppColor.blueColor, // 아이콘 색상 설정
              ),
              onPressed: () {
                // 버튼을 눌렀을 때 다른 페이지로 이동
                // 예외로 돌아갈 때는 슬라이드를 사용하지 않는다.
                if (isGuideClicked.contains(true)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                } else {
                  myShowToast(context, "경로 안내를 클릭하세요!");
                }
              },
            ),
          ],
        ),
      );
    }
    return Container();
  }

  // 자동 완성 화면
  Widget getAutoCompletion() {
    return Container(
      padding: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
      ),
      width: 352.0,
      height: containerHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: 5.0,
                top: 10.0,
              ),
              child: Text(
                "자동 완성",
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
            child: ListView.builder(
              itemExtent: 40,
              itemCount: _searchList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (WhatIsNowController == 1) {
                              departureController.text = _searchList[index];
                            } else if (WhatIsNowController == 2) {
                              destinationController.text = _searchList[index];
                            }
                            WhatIsNowController = 0;
                          });
                        },
                        child: Text(
                          _searchList[index],
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: "Font",
                            fontWeight: FontWeight.bold,
                            color: AppColor.mainColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            //인포 클릭된 경우 동작
                            isBookmarkedList[index] = !isBookmarkedList[index];
                          });
                        },
                        child: Icon(
                          Icons.info_outline,
                          size: 32,
                          color: AppColor.mainColor,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    //print("ListTile clicked at index $index");
                  },
                );
              },
            ),
          ),
          Container(
            width: 352,
            height: 70,
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 12,
                right: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.collections_bookmark,
                    size: 32,
                    color: AppColor.blackColor,
                  ),
                  Text(
                    '즐겨찾기',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: "Font",
                      fontWeight: FontWeight.bold,
                      color: AppColor.mainColor,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Pigeon code
    if (focusCnt != 2) {
      FocusScope.of(context).unfocus();
      focusCnt++;
      print("호출됨됨");
    }
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: GestureDetector(
        onTap: () {
          // 화면을 클릭할 때 키보드 숨기기
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Stack(
              children: [
                getMyAppbar(), // 직접 만든 Appbar 호출
                Positioned(
                  left: 334,
                  top: 44,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        departureController.clear();
                        destinationController.clear();
                        onPathOrPathInput = false;
                        okInputPath = false;
                      });
                    },
                    child: Visibility(
                      visible: onPathOrPathInput,
                      child: Icon(
                        Icons.delete_forever,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 90.0, // 위 패딩
                left: 20.0, // 왼쪽 패딩
                right: 20.0, // 오른쪽 패딩
              ),
              child: Column(
                children: [
                  //1번째 행
                  Container(
                    padding: EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                    ),
                    width: 352.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 48.0,
                                child: TextField(
                                  focusNode: departureFocusNode,
                                  readOnly: okInputPath, // 입력 완료인 경우 입력창 클릭 불가
                                  keyboardType: TextInputType.text,
                                  controller: departureController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '출발역을 입력하세요!',
                                    hintStyle: TextStyle(fontSize: 15.0),
                                  ),
                                  onChanged: (text) {
                                    //number를 실시간으로 읽어 searchList를 갱신.
                                    setState(() {
                                      _searchList =
                                          subways.getMatchingStations(text);
                                    });
                                  },
                                  onEditingComplete: () {
                                    // 사용자가 "확인" 버튼을 누르면 호출될 콜백
                                    _saveValues();
                                    // 확인 후에 WhatIsNowController 값을 0으로 되돌리기
                                    WhatIsNowController = 0;
                                  },
                                  onTap: () {
                                    // TextField가 탭될 때 WhatIsNowController 값을 1로 설정
                                    WhatIsNowController = 1;
                                  },
                                ),
                              ),
                            ),
                            Text(
                              "출발역",
                              style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: "Font",
                                fontWeight: FontWeight.bold,
                                color: AppColor.blackColor,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 300,
                          height: 1,
                          color: AppColor.mainColor,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 48.0,
                                child: TextField(
                                  focusNode: destinationFocusNode,
                                  readOnly: okInputPath, // 입력 완료인 경우 입력창 클릭 불가
                                  keyboardType: TextInputType.text,
                                  controller: destinationController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '도착역을 입력하세요!',
                                    hintStyle: TextStyle(fontSize: 15.0),
                                  ),
                                  onChanged: (text) {
                                    //number를 실시간으로 읽어 searchList를 갱신.
                                    setState(() {
                                      _searchList =
                                          subways.getMatchingStations(text);
                                    });
                                  },
                                  onEditingComplete: () {
                                    // 사용자가 "확인" 버튼을 누르면 호출될 콜백
                                    _saveValues();
                                    // 확인 후에 WhatIsNowController 값을 0으로 되돌리기 (입력 전 상태로)
                                    WhatIsNowController = 0;
                                  },
                                  onTap: () {
                                    //먼저 선수조치로 0 적용
                                    WhatIsNowController = 2;
                                  },
                                ),
                              ),
                            ),
                            Text(
                              "도착역",
                              style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: "Font",
                                fontWeight: FontWeight.bold,
                                color: AppColor.blackColor,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),

                  // 각 박스 사이에 여백을 준다.
                  SizedBox(
                    height: 10.0,
                  ),

                  //3번째 행
                  //getSearchHistory(),
                  //getGuidePath(),
                  //getAutoCompletion(),

                  Visibility(
                    visible: !departureController.text.isNotEmpty &&
                        !destinationController.text.isNotEmpty &&
                        !FocusScope.of(context).hasFocus,
                    child: getSearchHistory(),
                  ),

                  Visibility(
                    visible: okInputPath,
                    child: getGuidePath(),
                  ),

                  Visibility(
                    visible: FocusScope.of(context).hasFocus,
                    child: getAutoCompletion(),
                  ),

                  ////
                ],
              ),
            ),
          ],
        ),
      ),
      /* 나중에 변경
      bottomNavigationBar: BottomNavBar(
        currentIndex = currentIndex,
        onItemTapped: (int newIndex) {
          if (newIndex != currentIndex) {
            Navigator.push(context, pageRoute(newIndex));
          }
        },
      ),
      */
    );
  }
}
