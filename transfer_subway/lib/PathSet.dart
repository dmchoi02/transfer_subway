// 길을 입력하는 페이지

import 'imports.dart';

class PathSetPage extends StatefulWidget {
  const PathSetPage({Key? key}) : super(key: key);

  @override
  State<PathSetPage> createState() => _PathSetPageState();
}

class _PathSetPageState extends State<PathSetPage> with WidgetsBindingObserver {
  TextEditingController departureController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  double containerHeight = 550.0; //초기 컨테이너 높이

  // 출발지와 도착지 값을 저장하고 화면에서 포커스를 해제합니다.
  void _saveValues() {
    String departureValue = departureController.text;
    String destinationValue = destinationController.text;

    // 여기에서 변수에 저장하거나 다른 로직을 수행할 수 있습니다.
    print('출발지: $departureValue');
    print('도착지: $destinationValue');

    // 출발지와 도착지 값이 비어있지 않으면 포커스를 해제합니다.
    if (departureValue.isNotEmpty && destinationValue.isNotEmpty) {
      FocusScope.of(context).unfocus(); // 두개의 값이 입력되었으므로 키보드 창이 사라짐
    } else {
      myShowToast(context, '모든 경로를 입력해주세요!'); // 하나라도 입력 안된 경우 메시지 출력
    }
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
        containerHeight = 550.0;
      });
    }
  }

  List<bool> isBookmarkedList = [false, false, false]; // 각 즐겨찾기 아이콘에 대한 상태
  List<String> searchHistory = [
    '158 -> 343',
    '검색 기록 2',
    '검색 기록 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Stack(
        children: [
          myAppbar, //직접 만든 Appbar 호출, 기존에 flutter Appbar 사용시 현재 화면을 구현하기 어려우므로 appbar를 위젯으로 만듬
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
                                keyboardType: TextInputType.number,
                                controller: departureController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '출발역을 입력하세요!',
                                  hintStyle: TextStyle(fontSize: 15.0),
                                ),
                                onEditingComplete: () {
                                  // 사용자가 "확인" 버튼을 누르면 호출될 콜백
                                  _saveValues();
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
                                keyboardType: TextInputType.number,
                                controller: destinationController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '도착역을 입력하세요!',
                                  hintStyle: TextStyle(fontSize: 15.0),
                                ),
                                onEditingComplete: () {
                                  // 사용자가 "확인" 버튼을 누르면 호출될 콜백
                                  _saveValues();
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
                Container(
                  padding: EdgeInsets.only(
                    left: 20.0, // 왼쪽 패딩
                    right: 20.0,
                  ),
                  width: 352.0,
                  height: containerHeight,
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
                            "최근 검색 기록",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: "Font",
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0), // 간격 추가

                      // 검색 기록을 보여주는 리스트
                      Expanded(
                        child: ListView.builder(
                          itemCount: searchHistory.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // Text를 클릭했을 때 처리
                                      print("Text clicked at index $index");
                                      //여기서 검색 기록이 출발역 도착역으로 적용 되도록 하면됨
                                    },
                                    child: Text(searchHistory[index]),
                                  ),

                                  SizedBox(width: 160), // 여백 추가

                                  GestureDetector(
                                    onTap: () {
                                      // icon를 클릭했을 때 수행할 동작
                                      setState(() {
                                        isBookmarkedList[index] =
                                            !isBookmarkedList[index]; // 상태를 반전
                                      });

                                      // 특정 이벤트 수행
                                      if (isBookmarkedList[index]) {
                                        // 즐겨찾기 추가
                                        print(
                                            "Add to bookmarks at index $index");
                                      } else {
                                        // 즐겨찾기 제거
                                        print(
                                            "Remove from bookmarks at index $index");
                                      }
                                    },
                                    child: Icon(
                                      isBookmarkedList[index]
                                          ? Icons.bookmarks
                                          : Icons.bookmarks_outlined,
                                      size: 32,
                                      color: AppColor.blueColor,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                // 다른 부분을 클릭했을 때 처리
                                //print("ListTile clicked at index $index");
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
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

/*
Image.asset(
                                      images + 'outlined_bookmarks.png',
                                      width: 60,
                                    ), // 이미지 불러오기

*/
