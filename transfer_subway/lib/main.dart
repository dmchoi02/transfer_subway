// 메인 페이지
import 'imports.dart';

// 화면의 사이즈는 392x783 고정 -> 392 759로 바뀜(기존 figma 디자인 360 x 800이라서 코딩시 조절이 필요함)
// size는 조정하지 마세용 (추후에 디자인 수정 예정)
//
// 안드로이드 에뮬레이터 실행시 1080x2240 5.6인치로 설정
// 변수 이름은 상수를 제외하고 모두 낙타 표기법(Camel Case) 사용 ex. printImage, printAll

// 기본 컬러 모음집 사용할 때는 ex. AppColor.mainColor
class AppColor {
  static const Color mainColor = Color.fromARGB(255, 149, 148, 148); // 기본 색상
  static const Color selectedColor = Color(0xFF2B79C2); // 선택을 강조하는 파랑색
  static const Color blueColor = Color(0xFF475FF3); // 앱바에 사용되는 색깔
  static const Color backgroundColor = Color(0xFFE9E9E9); // 기본 회색 배경
  static const Color blackColor = Color.fromARGB(220, 0, 0, 0);

  static const Color navyColor = Color.fromARGB(255, 62, 68, 107); //다크모드 앱바 색깔
}

// 이미지 할당은 아래 변수를 이용 ex. images + "이미지 이름"
String images = 'assets/images/';

// 기본 초기화 변수들(앱을 처음 킬 때 세팅되어야하는 변수는 여기다 작성)
int currentIndex = 1; //기본 초기 화면은 홈화면 index인 1로 세팅

//각 페이지 인덱스 상수로 선언
const int SUBWAY_MAP_PAGE = 0;
const int MY_APP_PAGE = 1;
const int BADGES_PAGE = 2;
const int SETTINGS_PAGE = 3;
const int PATH_SET = 4;
const int GMAE_PAGE = 5;

// void main() => runApp(
//       MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: MyApp(),
//       ),
//     );

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // shared_preferences 초기화.
  final prefs = await SharedPreferences.getInstance();

  // ThemeMode값 초기화. 기본값은 light로 정했습니다.
  ThemeMode themeMode = ThemeMode.light;

  // 저장된 테마모드 가져오기.
  final String? savedThemeMode = prefs.getString('themeMode');

  // 기존 themeMode 설정을 안해놨을 경우(null) 시작 테마를 light로 지정합니다.
  // savedThemeMode가 null이 아닐 경우 저장된 테마모드에 따라 themeMode를 설정합니다.
  if (savedThemeMode == null) {
    themeMode = ThemeMode.light;
  } else if (savedThemeMode == "light") {
    themeMode = ThemeMode.light;
  } else if (savedThemeMode == "dark") {
    themeMode = ThemeMode.dark;
  }

// 설정된, 또는 불러온 테마모드를 MyApp에 넘겨줍니다.
  runApp(MyStatelessApp(themeMode: themeMode));
}

class MyStatelessApp extends StatelessWidget {
  final themeMode;
  const MyStatelessApp({
    Key? key,
    required this.themeMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Provider 사용.
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              // 어플리케이션이 실행되면서 Provider를 적용할 때 불러온 테마모드를 ThemeProvider에 넘겨줍니다.
              create: (_) => ThemeProvider(initThemeMode: themeMode)),
        ],
        builder: (context, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            // lib/theme.dart 에서 작성한 테마를 사용합니다.
            theme: MyThemes.light,
            darkTheme: MyThemes.dark,

            //ThemeProvider에서 현재 테마 모드를 불러옵니다.
            themeMode: Provider.of<ThemeProvider>(context).themeMode,
            home: const MyApp(),
          );
        });
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // 사이즈 확인
    bool noticeIssue = false;
    String? notice = null;
    if (noticeIssue == true) {
      //여기에서 서버가 도입될 시 공지를 가져와 notice에 가져오는 작업을 수행합니다.
    } else {
      notice = 'ㅡ';
    }
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    //print(screenWidth); // 현재 가로 사이즈
    //print(screenHeight); // 현재 세로 사이즈
    Widget onPathview = onPathView();
    // 위에 상태바 없애기
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyThemes.light,
      darkTheme: MyThemes.dark,
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
      home: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: [
            getMyAppbar(context),
            //직접 만든 Appbar 호출, 기존에 flutter Appbar 사용시 현재 화면을 구현하기 어려우므로 appbar를 위젯으로 만듬

            Positioned(
              left: 334,
              top: 44,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    Global.setIsPathSet(false);
                  });
                },
                child: Visibility(
                  visible: Global.getIsPathSet(),
                  child: Icon(
                    Icons.delete_forever,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                top: 90.0, // 위 패딩
                left: 20.0, // 왼쪽 패딩
                right: 20.0, // 오른쪽 패딩
              ),
              child: Column(
                children: [
                  // 1번째 박스
                  GestureDetector(
                    onTap: () {
                      // 클릭 시 길찾기 페이지로 이동

                      Navigator.push(context, pageRoute(4));
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                      width: 352.0, // 가로 길이
                      height: 55.0, // 세로 길이

                      // 박스 스타일 설정
                      decoration: BoxDecoration(
                        // 색 설정, 모서리 둥글게 만들기
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "경로 검색",
                              // 텍스트 스타일 설정
                              style: TextStyle(
                                fontSize: 15.0, // 글꼴 크기
                                fontFamily: "Font", // 폰트
                                fontWeight: FontWeight.bold, // 굵게 하고 싶은 경우
                                color: AppColor.mainColor, // 글씨 색깔
                              ),
                            ),
                          ),
                          Image.asset(images + 'search.png',
                              width: 28, height: 28), // 이미지 불러오기
                        ],
                      ),
                    ),
                  ),

                  // 2번재 박스
                  Visibility(
                    visible: !Global.getIsPathSet(),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                        ),
                        width: 352.0,
                        height: 110.0,
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
                                    left: 5.0, top: 10.0), // 왼쪽 여백 조정
                                child: Text(
                                  "공지",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: "Font",
                                    fontWeight: FontWeight.bold,
                                    //color: AppColor.blackColor,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Expanded(
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "$notice",
                                  // 스타일 설정
                                  style: TextStyle(
                                    fontSize: 15.0, // 글꼴 크기
                                    fontFamily: "Font",
                                    fontWeight: FontWeight.bold, // 굵게 하고 싶은 경우
                                    //color: AppColor.blackColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // 각 박스 사이에 여백을 준다.
                  SizedBox(
                    height: 10.0,
                  ),

                  // 3번째 박스
                  Container(
                    width: 352.0,
                    height: !Global.getIsPathSet() ? 407 : 527, // 조건에 따라 높이 설정
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: (Global.getIsPathSet()) ? onPathview : offPathView,
                  ),
                ],
              ),
            ),
          ],
        ),

        // 바텀 네비게이션바
        bottomNavigationBar: BottomNavBar(
          currentIndex = MY_APP_PAGE,
          onItemTapped: (int newIndex) {
            if (newIndex != currentIndex) {
              Navigator.push(context, pageRoute(newIndex));
            }
          },
        ),
      ),
    );
  }
}
