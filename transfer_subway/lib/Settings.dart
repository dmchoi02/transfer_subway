// 설정 페이지

import 'imports.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    ThemeMode currentThemeMode = themeProvider.themeMode;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          getMyAppbar(
              context), //직접 만든 Appbar 호출, 기존에 flutter Appbar 사용시 현재 화면을 구현하기 어려우므로 appbar를 위젯으로 만듬
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
                    height: 592,
                    decoration: BoxDecoration(
                      // 모서리 둥글게 만들기
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: ListView(children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 5.0, top: 10.0), // 왼쪽, 위 여백 조정
                          child: Text(
                            "설정",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: "Font",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                          leading: Text(
                            "다크모드",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: "Font",
                              fontWeight: FontWeight.bold,
                              color: (currentThemeMode == ThemeMode.dark)
                                  ? Colors.white
                                  : AppColor.mainColor,
                            ),
                          ),
                          trailing:
                              Row(mainAxisSize: MainAxisSize.min, children: [
                            IconButton(
                                onPressed: () {
                                  final themeProvider =
                                      Provider.of<ThemeProvider>(context,
                                          listen: false);
                                  themeProvider.setThemeMode(ThemeMode.light);
                                },
                                color: Theme.of(context).colorScheme.primary,
                                icon: Icon(
                                  Icons.light_mode,
                                )),
                            IconButton(
                                onPressed: () {
                                  final themeProvider =
                                      Provider.of<ThemeProvider>(context,
                                          listen: false);
                                  themeProvider.setThemeMode(ThemeMode.dark);
                                },
                                color: Theme.of(context).colorScheme.secondary,
                                icon: Icon(Icons.dark_mode)),
                          ])),
                      ListTile(
                        leading: Text(
                          "언어설정",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: "Font",
                            fontWeight: FontWeight.bold,
                            color: (currentThemeMode == ThemeMode.dark)
                                ? Colors.white
                                : AppColor.mainColor,
                          ),
                        ),
                        trailing: PopupMenuButton(itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              value: 'korean',
                              child: Text(
                                '한국어',
                                style: TextStyle(
                                  fontFamily: "Font",
                                  color: (currentThemeMode == ThemeMode.dark)
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                            PopupMenuItem(
                              value: 'english',
                              child: Text(
                                'English',
                                style: TextStyle(
                                  fontFamily: "Font",
                                  color: (currentThemeMode == ThemeMode.dark)
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            )
                          ];
                        }),
                      )
                    ])),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex = SETTINGS_PAGE, // 현재 페이지가 두 번째 페이지이므로 해당 인덱스 선택
        onItemTapped: (newIndex) {
          if (newIndex != SETTINGS_PAGE) {
            currentIndex = newIndex;

            Navigator.push(context, pageRoute(newIndex));
          }
        },
        currentIndex: SETTINGS_PAGE,
      ),
    );
  }
}
