// 길을 입력하는 페이지

import 'dart:io';

import 'imports.dart';

class PathSetPage extends StatefulWidget {
  const PathSetPage({Key? key}) : super(key: key);

  @override
  State<PathSetPage> createState() => _PathSetPageState();
}

class _PathSetPageState extends State<PathSetPage> with WidgetsBindingObserver {
  // 팝업을 표시하는 함수
  Future<void> showPopup(String msg, String stationKey) async {
    // 즐겨찾기인 경우의 팝업
    if (msg == "BookMark") {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyBookmarkDialog();
        },
      ).then((value) {
        // 팝업이 닫힌 후의 동작
        setState(() {
          // 검색 기록을 다시 가져옴
          searchHistory = Global.getSearchHistory();

          //현재 즐겨찾기 내용을 기기에 저장
          Global.saveIsBookmarkedListPrefs(Global.getIsBookmarkedList());
        });
      });
    }
    //지하철 정보인 경우의 팝업
    else if (msg == "SubwayInfo") {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return MySubwayInfoDialog(keyword: stationKey); // 'keyword:'를 추가.
        },
      ).then((value) {
        // 팝업이 닫힌 후의 동작
        setState(() {
          // 검색 기록을 다시 가져옴
          searchHistory = Global.getSearchHistory();
        });
      });
    }
  }

  TextEditingController departureController = TextEditingController();
  TextEditingController destinationController = TextEditingController();

  List<String> pathToNode = Global.pathToNode;
  List<String> pathToTransferNode = Global.pathToTransferNode;

  StationInfo stationInfo = StationInfo();

  final TextEditingController _filter = TextEditingController();
  final Subways subways = Subways();
  String _searchText = "";
  final SubwayGraph graph =
      SubwayGraph(); //지하철 노선도와 다익스트라 알고리즘을 품고있는 정적 데이터 클래스
  List<String> _searchList =
      Global.getSearchList(); //이렇게 사용하면 필요한 경우 다른 페이지에서도 모두 사용 가능
  final departureFocusNode = FocusNode();
  final destinationFocusNode = FocusNode();

  int whatIsNowController = 0;
  String departureValue = Global.getdepartureValue(); //출발역의 Key값. 한글은 불가능 하다.
  String destinationValue =
      Global.getdestinationValue(); //도착역의 key값. 한글은 불가능 하다.
  _PathSetPageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";

          Global.setClearSearchList();
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  bool okInputPath = false;
  bool onPathOrPathInput = false;
  int focusCnt = 0;

  // 출발지와 도착지 값을 저장하고 화면에서 포커스를 해제하는 함수.
  bool _saveValues() {
    if (_isNumeric(departureController.text) == true &&
        _isNumeric(destinationController.text) == true) {
      departureValue = departureController.text;
      destinationValue = destinationController.text;
    } else {
      departureValue = subways.getKeyFromName(departureController.text);
      destinationValue = subways.getKeyFromName(destinationController.text);
    }

    // 여기에서 변수에 저장하거나 다른 로직을 수행할 수 있습니다.
    print('출발지: $departureValue');
    print('도착지: $destinationValue');

    void onSearch(String query) {
      // 검색 기능을 구현하는 코드...
      // 검색어가 이미 검색 기록에 있는지 확인
      if (!searchHistory.contains(query)) {
        isBookmarkedList.insert(0, false);
        // 검색어를 검색 기록에 추가
        searchHistory.insert(0, query);
        // 검색기록을 기기에 저장
        Global.saveSearchHistoryPrefs(Global.getSearchHistory());
        print("검색 기록 저장 완료");
        Global.saveIsBookmarkedListPrefs(isBookmarkedList);
      } else {
        print("최근 검색 기록에 존재함");
        // 최근 검색 기록에 있는 경우
        // 해당 인덱스와 북마크 상태를 가져온다.
        int index = searchHistory.indexOf(query);
        bool state = isBookmarkedList[index];

        // 기존 리스트에서 삭제
        isBookmarkedList.removeAt(index);
        searchHistory.removeAt(index);
        // 맨 앞으로 다시 땡긴다
        isBookmarkedList.insert(0, state);
        searchHistory.insert(0, query);

        // 검색기록을 기기에 저장
        Global.saveSearchHistoryPrefs(Global.getSearchHistory());
        print("검색 기록 저장 완료");
        Global.saveIsBookmarkedListPrefs(isBookmarkedList);
      }
    }

    // 출발지와 도착지 값이 비어있지 않으면 포커스를 해제합니다.
    if (departureController.text.isNotEmpty &&
            destinationController.text.isNotEmpty ||
        departureValue.isNotEmpty && destinationValue.isNotEmpty) {
      //print("출발과 도착이 유효한지 확인");
      //print(departureController.text);
      //print(destinationController.text);

      if (!subways.doesMatchingStationExist(departureValue) ||
          !subways.doesMatchingStationExist(destinationValue)) {
        //print("유효하지 않음");
        myShowToast(context, '유효하지 않는 역이 존재합니다! \n 확인해 주세요!');
        //departureController.clear();
        //destinationController.clear();
        return false;
      } else if (departureValue != destinationValue) {
        FocusScope.of(context).unfocus(); // 두개의 값이 입력되었으므로 키보드 창이 사라짐
        //print("호출됨");
        okInputPath = true;
        onPathOrPathInput = true;
        String temp =
            departureController.text + ' --> ' + destinationController.text;
        Global.setsetnowsearchlist(temp);
        onSearch(temp);
        return true;
      } else {
        print(departureValue.isNotEmpty);
        print(destinationValue.isNotEmpty);
        myShowToast(context, '출발역과 도착역이 같습니다! \n 확인해 주세요!');
        return false;
      }
    } else {
      myShowToast(context, '모든 경로를 입력해주세요!'); // 하나라도 입력 안된 경우 메시지 출력
      print(departureController.text);
      print(destinationController.text);
      return false;
    }
  }

  // 해당 텍스트가 숫자인지 이름인지 확인
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

  List<bool> isBookmarkedList = Global.getIsBookmarkedList();
  List<String> searchHistory = Global.getSearchHistory();

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
    if (MediaQuery.of(context).viewInsets.bottom == 0) {
      //print("작업 수행");
      // 여기서 필요한 비동기 작업을 수행합니다.
      Future.delayed(Duration(seconds: 2), () {
        isBookmarkedList = Global.getIsBookmarkedList();
        print('is book $isBookmarkedList');
      });
      return Container(
        padding: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
        ),
        width: 352.0,
        height: 546,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer, //컬러 수정
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
                    //color: AppColor.blackColor,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemExtent: 40,
                itemCount: searchHistory.length,
                itemBuilder: (context, index) {
                  //print(searchHistory.length);
                  //print('didx $index');
                  //print('searchHis $searchHistory');
                  if (searchHistory != null && index < searchHistory.length) {
                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              print("Text clicked at index $index");
                              // query를 ' --> ' 문자열로 분리하여 departureValue와 destinationValue를 가져옵니다.
                              List<String> values =
                                  searchHistory[index].split(' --> ');
                              departureController.text = values[0];
                              destinationController.text = values[1];
                              departureValue =
                                  subways.getKeyFromName(values[0]);
                              destinationValue =
                                  subways.getKeyFromName(values[1]);
                              destinationFocusNode.requestFocus();
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
                                isBookmarkedList[index] =
                                    !isBookmarkedList[index];
                                Global.saveIsBookmarkedListPrefs(
                                    isBookmarkedList);
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
                  } else {
                    return Container();
                  }
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
                child: GestureDetector(
                  onTap: () async {
                    // async 키워드를 추가합니다.
                    var data = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return MyBookmarkDialog();
                      }, // 즐겨찾기 팝업 호출
                    );
                    // 이제 'data' 변수에는 팝업창에서 반환된 데이터가 있습니다.
                    if (data != null) {
                      // 데이터를 받았을 때의 행동을 여기에 작성합니다.
                      print('데이터 : $data');
                      departureController.text = data[0];
                      destinationController.text = data[1];
                      destinationFocusNode.requestFocus();
                    } else {
                      setState(() {});
                      print('데이터 없음.종료키 눌림 예상. 그 외 오류');
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.collections_bookmark,
                        size: 32,
                        //color: AppColor.blackColor,
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
              ),
            )
          ],
        ),
      );
    }
    return Container();
  }

  Widget getGuidePath() {
    //print("DD");
    //print("$departureValue");
    //print("$destinationValue");
    //print("DD");
    if (MediaQuery.of(context).viewInsets.bottom == 0) {
      //print("작업 수행");
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
        height: 546,
        decoration: BoxDecoration(
          // 모서리 둥글게 만들기
          color: Theme.of(context).colorScheme.primaryContainer, //컬러 수정
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
                  // 모서리 둥글게 만들기
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
                          //color: AppColor.blackColor,
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
                        "총 예상 시간 : ${Global.convertToFormat((result_time[destinationValue]?['time'] ?? 'N/A').toString(), 'time')}",
                        // 스타일 설정
                        style: TextStyle(
                          fontSize: 15.0, // 글꼴 크기
                          fontFamily: "Font",
                          fontWeight: FontWeight.bold, //굵게 하고 싶은 경우
                          //color: AppColor.blackColor,
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
                        "거리 : ${Global.convertToFormat((result_time[destinationValue]?['distance'] ?? 'N/A').toString(), 'distance')}",

                        // 스타일 설정
                        style: TextStyle(
                          fontSize: 15.0, // 글꼴 크기
                          fontFamily: "Font",
                          fontWeight: FontWeight.bold, //굵게 하고 싶은 경우
                          //color: AppColor.blackColor,
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
                        "비용 : ${Global.convertToFormat((result_time[destinationValue]?['cost'] ?? 'N/A').toString(), 'cost')}",
                        // 스타일 설정
                        style: TextStyle(
                          fontSize: 15.0, // 글꼴 크기
                          fontFamily: "Font",
                          fontWeight: FontWeight.bold, //굵게 하고 싶은 경우
                          //color: AppColor.blackColor,
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
                  // 모서리 둥글게 만들기
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
                          //color: AppColor.blackColor,
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
                        "총 예상 시간 : ${Global.convertToFormat((result_distance[destinationValue]?['time'] ?? 'N/A').toString(), 'time')}",

                        // 스타일 설정
                        style: TextStyle(
                          fontSize: 15.0, // 글꼴 크기
                          fontFamily: "Font",
                          fontWeight: FontWeight.bold, //굵게 하고 싶은 경우
                          //color: AppColor.blackColor,
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
                        "거리 : ${Global.convertToFormat((result_distance[destinationValue]?['distance'] ?? 'N/A').toString(), 'distance')}",
                        // 스타일 설정
                        style: TextStyle(
                          fontSize: 15.0, // 글꼴 크기
                          fontFamily: "Font",
                          fontWeight: FontWeight.bold, //굵게 하고 싶은 경우
                          //color: AppColor.blackColor,
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
                        "비용 : ${Global.convertToFormat((result_distance[destinationValue]?['cost'] ?? 'N/A').toString(), 'cost')}",

                        // 스타일 설정
                        style: TextStyle(
                          fontSize: 15.0, // 글꼴 크기
                          fontFamily: "Font",
                          fontWeight: FontWeight.bold, //굵게 하고 싶은 경우
                          //color: AppColor.blackColor,
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
                  // 모서리 둥글게 만들기
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
                          //color: AppColor.blackColor,
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
                        "총 예상 시간 : ${Global.convertToFormat((result_cost[destinationValue]?['time'] ?? 'N/A').toString(), 'time')}",
                        // 스타일 설정
                        style: TextStyle(
                          fontSize: 15.0, // 글꼴 크기
                          fontFamily: "Font",
                          fontWeight: FontWeight.bold, //굵게 하고 싶은 경우
                          //color: AppColor.blackColor,
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
                        "거리 : ${Global.convertToFormat((result_cost[destinationValue]?['distance'] ?? 'N/A').toString(), 'distance')}",
                        // 스타일 설정
                        style: TextStyle(
                          fontSize: 15.0, // 글꼴 크기
                          fontFamily: "Font",
                          fontWeight: FontWeight.bold, //굵게 하고 싶은 경우
                          //color: AppColor.blackColor,
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
                        "비용 : ${Global.convertToFormat((result_cost[destinationValue]?['cost'] ?? 'N/A').toString(), 'cost')}",
                        // 스타일 설정
                        style: TextStyle(
                          fontSize: 15.0, // 글꼴 크기
                          fontFamily: "Font",
                          fontWeight: FontWeight.bold, //굵게 하고 싶은 경우
                          //color: AppColor.blackColor,
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),

            // 안내 버튼
            IconButton(
              icon: Icon(
                Icons.play_circle_filled_rounded, // Play Circle 아이콘
                size: 45.0, // 아이콘 크기 설정
                color: AppColor.blueColor, // 아이콘 색상 설정
              ),
              onPressed: () {
                List<String> pathToNode = result_time[departureValue]['path'];
                print(pathToNode);
                // 버튼을 눌렀을 때 다른 페이지로 이동
                // 예외로 돌아갈 때는 슬라이드를 사용하지 않는다.
                setState(() {
                  // 버튼을 눌렀을 때 다른 페이지로 이동
                  // 예외로 돌아갈 때는 슬라이드를 사용하지 않는다.
                  print("현재 셋패스값 : ");
                  print(Global.getIsPathSet());
                  Global.setIsPathSet(true); //패스 설정이 완료된 걸로 바꿈
                  print("셋 실생후 현재 셋패스값 : ");
                  print(Global.getIsPathSet());
                  if (isGuideClicked.contains(true)) {
                    if (isGuideClicked[0] == true) {
                      pathToNode = graph.runfindpath(
                          departureValue, destinationValue, 'time');
                      print('now time');
                      setState(() {
                        //안내 값 시간으로 세팅
                        Global.setGuideValue(
                          result_time[destinationValue]?['time'] ?? 'N/A',
                          result_time[destinationValue]?['distance'] ?? 'N/A',
                          result_time[destinationValue]['cost'] ?? 'N/A',
                        );
                      });
                    } else if (isGuideClicked[1] == true) {
                      pathToNode = graph.runfindpath(
                          departureValue, destinationValue, 'distance');
                      print('now distance');

                      setState(() {
                        //안내 값 거리로 세팅
                        Global.setGuideValue(
                          result_distance[destinationValue]?['time'] ?? 'N/A',
                          result_distance[destinationValue]?['distance'] ??
                              'N/A',
                          result_distance[destinationValue]?['cost'] ?? 'N/A',
                        );
                      });
                    } else if (isGuideClicked[2] == true) {
                      pathToNode = graph.runfindpath(
                          departureValue, destinationValue, 'cost');
                      print('now cost');

                      setState(() {
                        //안내 값 비용으로 세팅
                        Global.setGuideValue(
                          result_cost[destinationValue]?['time'] ?? 'N/A',
                          result_cost[destinationValue]?['distance'] ?? 'N/A',
                          result_cost[destinationValue]?['cost'] ?? 'N/A',
                        );
                      });
                    }
                    pathToTransferNode =
                        stationInfo.getTransferStations(pathToNode);
                    print('최단경로 : $pathToNode');
                    print('환승역만 담긴 최소 경로 : $pathToTransferNode');

                    setState(() {
                      // 입력된 경로 데이터들로 onpathview에 표시할 수 있도록 값 세팅
                      Global.setSubWayList(pathToNode, pathToTransferNode);
                      Global.setSubWayLowList();
                      Global.setSubwayLowCntList(Global.subwayLowList);
                      Global.setSubwayNumList(pathToNode, Global.subWayList);
                      Global.setMyheightList(
                          Global.subWayList); // 리스트 개수 만큼 높이 설정
                      Global.setIsClickedSubwayList(Global.subWayList);
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  } else {
                    myShowToast(context, "경로 안내를 클릭하세요!");
                  }
                });
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
      height: 250,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer, //컬러 수정
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
                  //color: AppColor.blackColor,
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
                            if (whatIsNowController == 1) {
                              departureController.text = _searchList[index];
                            } else if (whatIsNowController == 2) {
                              destinationController.text = _searchList[index];
                            }
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
                            String temp = _searchList[index];
                            showPopup("SubwayInfo", temp);
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Pigeon code
    print("현재 화면 인덱스 $currentIndex");
    if (currentIndex == PATH_SET) {
      // 경로 검색 페이지로 들어오면 초기화
      // 이전 페이지로 돌아가도 기록 안남음
      Global.setIsPathSet(false);
    }
    //Global.setIsPathSet(false);
    if (focusCnt != 2) {
      FocusScope.of(context).unfocus();
      focusCnt++;
      //print("호출됨됨");
    }
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // 컬러 수정
      body: GestureDetector(
        onTap: () {
          // 화면을 클릭할 때 키보드 숨기기
          // FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Stack(
              children: [
                getMyAppbar(context), // 직접 만든 Appbar 호출
                // 쓰레기통 아이콘 표시
                // 단 경로 입력을 마쳤을 경우에만.
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
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Image.asset(images + 'reset.png',
                            width: 28, height: 28),
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
                      color: Theme.of(context)
                          .colorScheme
                          .primaryContainer, //컬러 수정
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
                                    bool chk = _saveValues();
                                    // 확인 후에 WhatIsNowController 값을 0으로 되돌리기
                                    whatIsNowController = 0;

                                    if (chk == false) {
                                      whatIsNowController = 1;
                                    }
                                  },
                                  onTap: () {
                                    // TextField가 탭될 때 WhatIsNowController 값을 1로 설정
                                    whatIsNowController = 1;
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
                                //color: AppColor.blackColor,
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
                                    bool chk = _saveValues();
                                    // 확인 후에 WhatIsNowController 값을 0으로 되돌리기 (입력 전 상태로)
                                    whatIsNowController = 0;
                                    if (chk == false) {
                                      whatIsNowController = 2;
                                    }
                                    currentIndex = MY_APP_PAGE;
                                  },
                                  onTap: () {
                                    //먼저 선수조치로 적용
                                    whatIsNowController = 2;
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
                                //color: AppColor.blackColor,
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
                    visible: FocusScope.of(context).hasFocus && !okInputPath,
                    child: getAutoCompletion(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
