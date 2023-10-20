// 길을 입력하는 페이지

import 'imports.dart';

class PathSetPage extends StatefulWidget {
  const PathSetPage({Key? key}) : super(key: key);

  @override
  State<PathSetPage> createState() => _PathSetPageState();
}

class _PathSetPageState extends State<PathSetPage> {
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: 50.0, // 위 패딩
          bottom: 30.0, // 아래 패딩
          left: 20.0, // 왼쪽 패딩
          right: 20.0, // 오른쪽 패딩
        ),
        child: Column(
          children: [
            //1번째 행
            GestureDetector(
              onTap: () {
                // 클릭 시 다른 페이지로 이동하는 코드를 추가
                Navigator.pushNamed(context, '/PathSetPage');
              },
              child: Hero(
                tag: "flutter",
                child: Container(
                  //padding: const EdgeInsets.all(0.0),
                  padding: EdgeInsets.only(
                    left: 20.0, // 왼쪽 패딩
                    right: 20.0,
                  ),
                  width: 352.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "경로 검색",
                          // 스타일 설정
                          style: TextStyle(
                              fontSize: 15.0, // 글꼴 크기
                              fontFamily: "Font",
                              fontWeight: FontWeight.bold, //굵게 하고 싶은 경우
                              color: AppColor.mainColor
                              // 검은색 및 50% 투명도
                              ),
                        ),
                      ),
                      //Image.asset(images + 'search.png', width: 28, height: 28),
                    ],
                  ),
                ),
              ),
            ),

            //2번재 행
            Container(
              padding: EdgeInsets.only(
                left: 20.0, // 왼쪽 패딩
                right: 20.0,
              ),
              width: 352.0,
              height: 50.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "길 입력 페이지",
                      // 스타일 설정
                      style: TextStyle(
                          fontSize: 15.0, // 글꼴 크기
                          fontFamily: "Font",
                          fontWeight: FontWeight.bold, //굵게 하고 싶은 경우
                          color: AppColor.mainColor),
                    ),
                  ),
                  //도착지로 수정
                  Icon(
                    Icons.cloudy_snowing,
                    size: 31, // 아이콘 크기
                    color: AppColor.mainColor, // 아이콘 색상
                  )
                ],
              ),
            ),

            //3번째 행
            Container(
              width: 352.0,
              height: 460.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        _focusNode.unfocus(); // 버튼을 누르면 키패드가 사라집니다.
                      },
                      child: Text('Hide Keypad'),
                    ),
                    TextField(
                      focusNode: _focusNode,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Tap here to show number keypad',
                      ),
                    ),
                  ],
                ),
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
