// 지하철 노선도 지도와 관련된 페이지

import 'imports.dart';

class SubwayMapPage extends StatefulWidget {
  const SubwayMapPage({Key? key}) : super(key: key);

  @override
  State<SubwayMapPage> createState() => _SubwayMapPageState();
}

class _SubwayMapPageState extends State<SubwayMapPage> {
  String selectedLine = '전체';

  // 선택된 호선 업데이트 메서드
  void _updateSelectedLine(String newLine) {
    setState(() {
      selectedLine = newLine;
      // TODO: 선택된 호선에 따라 화면 업데이트 처리 추가
    });
  }

  // 선택된 호선에 따른 이미지 경로 변환
  String getImagePath(String selectedLine) {
    switch (selectedLine) {
      case '전체':
        return 'assets/images/subwaymap/노선도 전체.png';
      case '1호선':
        return 'assets/images/subwaymap/1호선.png';
      case '2호선':
        return 'assets/images/subwaymap/2호선.png';
      case '3호선':
        return 'assets/images/subwaymap/3호선.png';
      case '4호선':
        return 'assets/images/subwaymap/4호선.png';
      case '5호선':
        return 'assets/images/subwaymap/5호선.png';
      case '6호선':
        return 'assets/images/subwaymap/6호선.png';
      case '7호선':
        return 'assets/images/subwaymap/7호선.png';
      case '8호선':
        return 'assets/images/subwaymap/8호선.png';
      case '9호선':
        return 'assets/images/subwaymap/9호선.png';
      default:
        return ''; // 예외 처리: 선택된 호선이 없거나 알 수 없는 경우
    }
  }

  @override
  Widget build(BuildContext context) {
    String imagePath = getImagePath(selectedLine);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          getMyAppbar(context),
          Padding(
            padding: EdgeInsets.only(
              top: 90.0,
              left: 20.0,
              right: 20.0,
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                  ),
                  width: 352.0,
                  height: 592,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.0, top: 10.0),
                          child: Text(
                            "노선도",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: "Font",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.0, top: 2.0),
                          child: Text(
                            "호선을 확인하세요!",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: "Font",
                              fontWeight: FontWeight.bold,
                              color: AppColor.mainColor,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 7.0),
                          child: Column(
                            children: [
                              SizedBox(height: 20.0), // 20 픽셀의 공간을 추가합니다.
                              Padding(
                                padding: const EdgeInsets.only(left: 235.0),
                                child: DropdownButton<String>(
                                  value: selectedLine,
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      _updateSelectedLine(newValue);
                                    }
                                  },
                                  items: <String>[
                                    '전체',
                                    '1호선',
                                    '2호선',
                                    '3호선',
                                    '4호선',
                                    '5호선',
                                    '6호선',
                                    '7호선',
                                    '8호선',
                                    '9호선',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Container(
                                  width: 320,
                                  height: 420,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    border: Border.all(
                                      color: Color.fromARGB(255, 62, 68,
                                          107), // 다크모드시 상단 AppBar와 같은 색상
                                      width: 1, // 윤곽선 두께
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width:
                                          300.0, // InteractiveViewer 위젯의 폭 제한
                                      height:
                                          400.0, // InteractiveViewer 위젯의 높이 제한
                                      child: InteractiveViewer(
                                        panEnabled: true,
                                        constrained: false,
                                        boundaryMargin: EdgeInsets.all(0.0),
                                        minScale: 0.5,
                                        maxScale: 4.0,
                                        child: Image.asset(
                                          imagePath,
                                          width: 300.0, //윤곽선 길이 제외
                                          height: 400.0, //윤곽선 길이 제외
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
      bottomNavigationBar: BottomNavBar(
        currentIndex = SUBWAY_MAP_PAGE,
        onItemTapped: (newIndex) {
          print('현재 뉴인덱스 $newIndex');
          print('현재 커런트인덱스 $currentIndex');
          if (newIndex != SUBWAY_MAP_PAGE) {
            Navigator.push(context, pageRoute(newIndex));
          }
        },
        currentIndex: SUBWAY_MAP_PAGE,
      ),
    );
  }
}
