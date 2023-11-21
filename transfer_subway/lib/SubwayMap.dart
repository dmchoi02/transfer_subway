// 지하철 노선도 지도와 관련된 페이지

import 'imports.dart';

class SubwayMapPage extends StatefulWidget {
  const SubwayMapPage({Key? key}) : super(key: key);

  @override
  State<SubwayMapPage> createState() => _SubwayMapPageState();
}

class _SubwayMapPageState extends State<SubwayMapPage> {
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
                Container(
                  padding: EdgeInsets.only(
                    left: 20.0, // 왼쪽 패딩
                    right: 20.0,
                  ),
                  width: 352.0,
                  height: 615,
                  decoration: BoxDecoration(
                    // 모서리 둥글게 만들기
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: Text(
                    "지도 화면",
                    // 스타일 설정
                    style: TextStyle(
                        fontSize: 15.0, // 글꼴 크기
                        fontFamily: "Font",
                        fontWeight: FontWeight.bold, //굵게 하고 싶은 경우
                        color: AppColor.mainColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex = SUBWAY_MAP_PAGE, // 현재 페이지가 두 번째 페이지이므로 해당 인덱스 선택
        onItemTapped: (newIndex) {
          if (newIndex != currentIndex) {
            Navigator.push(context, pageRoute(newIndex));
          }
        },
      ),
    );
  }
}
