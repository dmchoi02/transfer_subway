import 'imports.dart';

//메인 페이지 길 입력 안됐을 때 위젯
Widget offPathView = Container(
  padding: EdgeInsets.only(
    left: 20.0, // 왼쪽 패딩
    right: 20.0,
  ),
  width: 312.0,
  height: 108.0,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center, // 수직 가운데 정렬
    children: [
      Text(
        "현재 길찾기 정보가 없습니다.\n경로를 검색하세요.",
        textAlign: TextAlign.center, // 수평 가운데 정렬
        style: TextStyle(
          fontSize: 15.0, // 글꼴 크기
          fontFamily: "Font",
          color: AppColor.mainColor,
        ),
      ),
    ],
  ),
);

//메인 페이지 길 입력 됐을 때 정보 안내하는 위젯
Widget onPathView = Text(
  "경로 설정된 상태",
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
PageRouteBuilder pageRoute(int newIndex) {
  const curve = Curves.easeInOut;
  Offset begin;

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
