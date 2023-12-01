//모든 import를 한번에 모으는 페이지
//컴파일 상황에서 코드를 합치므로 성능과 관련이 없다.
//import는 모두 여기 페이지에서 하시면 됩니다.
// ignore_for_file: duplicate_export

export 'package:flutter/material.dart'; // 기본적인 import
export 'package:flutter/services.dart'; // 상태바를 없애기 위한 import

export "TransferInfo.dart";
export "subwaygraph.dart";
export "SubwayData.dart";
export "main.dart"; // 메인 페이지
export 'PathSet.dart'; // 길 입력 페이지
export 'SubwayMap.dart'; // 노선도 페이지
export 'Badges.dart'; // 칭호 페이지
export 'Settings.dart'; //설정 페이지
export 'Game.dart'; //게임 페이지
export 'MyWidget.dart'; // 여러번 사용되는 or 직접 만든 위젯은 여기다 모아 놓는다
export 'MyToast.dart'; // 사용자에게 메시지를 띄울때 사용하는 페이지
export 'MyDialog.dart'; // 팝업창
export "GlobalData.dart"; //전역 데이터 관리


export 'package:transfer_subway/Theme.dart'; //테마 커스텀
export 'package:transfer_subway/ThemeProvider.dart'; //테마 provider
export 'package:shared_preferences/shared_preferences.dart'; //shared_preference 기기 내부에 데이터 저장하는 패키지 - 다크모드 관련
export 'package:provider/provider.dart'; // provider 패키지 - 다크모드 관련
