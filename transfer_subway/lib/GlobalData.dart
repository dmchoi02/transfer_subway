// 전 페이지에서 공유하는 전역 데이터 페이지
// 사용할 때는 Global.get함수
// static이지만 외부에서 접근할 수 없어서 반드시 함수를 통해 접근하세요

import 'imports.dart';

class Global {
  static List<String> _searchList = [];
  static List<String> searchHistory = [];
  static String departureValue = ''; //출발역의 Key값. 한글은 불가능 하다.
  static String destinationValue = ''; //도착역의 Key값. 한글은 불가능 하다.

  static bool isPathSet = false; //경로 입력이 됐는지 구분하는 변수

// 지하철 관련 데이터
  static String guideTime = "";
  static String guideDistance = "";
  static String guideCost = "";

  static List<String> pathToNode = []; // 최단 경로
  static List<String> pathToTransferNode = []; // 환승역만 담긴 최단 경로
  static List<String> subWayList = []; // 출발, 환승, 도착 담긴 경로
  static List<String> subwayNumList = []; // 자신의 노선 아이콘 번호를 가지고 있는 리스트
  static List<List<String>> subwayLowList = [
    []
  ]; // 각 subWayList 역들의 하위리스트만 담겨 있음
  static List<double> myheightList = [];
  // 하위역 보는 클릭 여부
  static List<bool> isClickedSubwayList = [];
  static List<int> subwayLowCntList = [];

  // 위젯 변수
  static Widget onPathview = onPathView();

  //
// 검색기록들의 즐겨찾기 아이콘에 대한 상태
// false는 아이콘이 꺼져있는 것을 의미한다.
  static List<bool> isBookmarkedList = [];

  static String getdepartureValue() {
    return departureValue;
  }

  static String getdestinationValue() {
    return destinationValue;
  }

  static void setCleardepartureValue() {
    departureValue = '';
  }

  static void setCleardestinationValue() {
    destinationValue = '';
  }

  static List<String> getSearchList() {
    return _searchList;
  }

  static void setClearSearchList() {
    _searchList = [];
  }

  static List<String> getSearchHistory() {
    return searchHistory;
  }

  static void setClearSearchHistory() {
    searchHistory = [];
  }

  static List<bool> getIsBookmarkedList() {
    return isBookmarkedList;
  }

  static bool getIsPathSet() {
    return isPathSet;
  }

  static void setIsPathSet(bool val) {
    isPathSet = val;
  }

  static Widget getOnPathview() {
    return onPathview;
  }

// 지하철 관련 함수들
  // 출발역, 환승역, 도착역을 포함한 대표 경로 세팅
  static void setSubWayList(
      List<String> _pathToNode, List<String> _pathToTransferNode) {
    // pathToTransferNode 리스트의 각 원소를 subWayList에 추가
    // pathToTransferNode 는 환승역의 정보만 가지고 있다.
    pathToNode = _pathToNode;
    pathToTransferNode = _pathToTransferNode;

    // 출발역 추가
    subWayList.add(pathToNode.first);

    // 환승역들 추가
    for (String item in pathToTransferNode) {
      subWayList.add(item);
    }
    // 도착역 추가
    subWayList.add(pathToNode.last);
    //print("역 모두 추가하였음");
    print(subWayList);
  }

  static void clearSubWayList() {
    print(
        "pathToNode, pathToTransferNode, subWayList subwayLowList , 안내 value 초기화");
    pathToNode = [];
    pathToTransferNode = [];
    subWayList = [];
    subwayLowList = [[]];
    subwayLowCntList = [];
    myheightList = [];
    isClickedSubwayList = [];
    subwayNumList = [];

    guideTime = "";
    guideDistance = "";
    guideCost = "";
    //print(pathToNode);
    //print(pathToTransferNode);
    //print(subWayList);
    //print(subwayLowList);
  }

  //역의 하위 역들을 찾아냄
  static void setSubWayLowList() {
    if (isPathSet) {
      List<String> list1 = pathToNode;
      List<String> list2 = subWayList;

      subwayLowList = [];

      for (int i = 0; i < list2.length; i++) {
        int startIndex = list1.indexOf(list2[i]);
        int endIndex =
            i == list2.length - 1 ? list1.length : list1.indexOf(list2[i + 1]);

        List<String> sublist = list1.sublist(startIndex + 1, endIndex);
        subwayLowList.add(sublist);

        // 마지막 원소가 아닌데 개수가 0이면 1로 설정
        if (sublist.isEmpty && i != list2.length - 1) {
          subwayLowList[i].add("");
        }
      }

      print('하위역 리스트 , $subwayLowList');
    }
  }

  static void setMyheightList(List<String> subWayList) {
    //myheightList = [];
    // 매개변수로 들어온 리스트의 길이만큼 반복하면서 50씩 값을 추가
    for (int i = 0; i < subWayList.length; i++) {
      myheightList.add(50); // 50씩 추가하고 싶은 값으로 수정 가능
    }
    // 이제 myheightList에는 매개변수로 들어온 리스트의 길이만큼 50씩 값이 추가된 상태
  }

// 각 메인 역의 아이콘 번호 설정
  static void setSubwayNumList(
      List<String> pathToNode, List<String> subWayList) {
    StationInfo stationInfo = StationInfo();
    int firstCnt = stationInfo.getLineCount(subWayList[0]);
    int firstNextCnt = stationInfo.getLineCount(pathToNode[1]);

    // 리스트의 맨 첫번째 원소 처리
    if (firstCnt == 1 && firstNextCnt == 1) {
      subwayNumList.add(subWayList.first[0]);
    } else if (firstCnt == 1 && firstNextCnt == 2) {
      subwayNumList.add(subWayList.first[0]);
    } else if (firstCnt == 2 && firstNextCnt == 1) {
      String flIdxone = stationInfo.info[subWayList[0]]?['line'][0]; //514
      String flIdxTwo = stationInfo.info[subWayList[0]]?['line'][1]; //752
      String flNextIdxone = stationInfo.info[pathToNode[1]]?['line'][0]; //752

      if (flIdxone[7] == flNextIdxone[7]) {
        subwayNumList.add(flIdxone[7]);
      } else {
        print("여기이ㅣㅇ이");

        subwayNumList.add(flIdxTwo[7]);
      }
    } else if (firstCnt == 2 && firstNextCnt == 2) {
      String flIdxone = stationInfo.info[subWayList[0]]?['line'][0]; //514
      String flIdxTwo = stationInfo.info[subWayList[0]]?['line'][1]; //752
      String flNextIdxone = stationInfo.info[pathToNode[1]]?['line'][0]; //752
      String flNextIdxtwo = stationInfo.info[pathToNode[1]]?['line'][1]; //814

      if (flIdxone[7] == flNextIdxone[7]) {
        subwayNumList.add(flIdxone[7]);
      } else if (flIdxone[7] == flNextIdxtwo[7]) {
        subwayNumList.add(flIdxone[7]);
      } else {
        print("여기이ㅣㅇ이");

        subwayNumList.add(flIdxTwo[7]);
      }
    } else {
      subwayNumList.add(subWayList.first[0]);
    }

    // 나머지 원소 처리
    for (int i = 1; i < subWayList.length - 1; i++) {
      int index = pathToNode.indexOf(subWayList[i]);
      //print(index);

      if (subwayLowCntList[i] == 0) {
        // 내가 환승역인데 하위역이 1개도 없을 때
        // 즉, 환승역인데 다음 역도 환승역일 때
        // 이때 노선은 경로에 안나와있지만 지도에는 나와있다

        int chk = stationInfo.getLineCount(subWayList[i]);

        // 내 다음역이 두가지의 라인을 가지고 있는 경우
        if (chk == 2) {
          // 내 다음역이 나와 같을 경우
          if (pathToNode[index][0] == pathToNode[index + 1][0]) {
            subwayNumList.add(pathToNode[index + 1][0]);
          } else {
            // 내 다음역이 나와 다를 경우
            String key = StationInfo().info[subWayList[i]]?['line'][1];
            subwayNumList.add(key[7]);
          }
        } else {
          subwayNumList.add(pathToNode[index + 1][0]);
        }
      } else {
        // 내가 환승역이고 하위 역이 1개라도 있을 때
        subwayNumList.add(pathToNode[index + 1][0]);
      }
    }

    List<String> reversePathToNode = pathToNode.reversed.toList();
    int endCnt = stationInfo.getLineCount(reversePathToNode[0]);
    int endBackCnt = stationInfo.getLineCount(reversePathToNode[1]);

    if (endCnt == 1 && endBackCnt == 1) {
      subwayNumList.add(reversePathToNode.first[0]);
    } else if (endCnt == 1 && endBackCnt == 2) {
      subwayNumList.add(reversePathToNode.first[0]);
    } else if (endCnt == 2 && endBackCnt == 1) {
      String edIdxone =
          stationInfo.info[reversePathToNode[0]]?['line'][0]; //514
      String edIdxTwo =
          stationInfo.info[reversePathToNode[0]]?['line'][1]; //752
      String edBackIdxone =
          stationInfo.info[reversePathToNode[1]]?['line'][0]; //752

      if (edIdxone[7] == edBackIdxone[7]) {
        subwayNumList.add(edIdxone[7]);
      } else {
        print("여기이ㅣㅇ이");

        subwayNumList.add(edIdxTwo[7]);
      }
    } else if (endCnt == 2 && endBackCnt == 2) {
      String edIdxone =
          stationInfo.info[reversePathToNode[0]]?['line'][0]; //514
      String edIdxTwo =
          stationInfo.info[reversePathToNode[0]]?['line'][1]; //752
      String edBackIdxone =
          stationInfo.info[reversePathToNode[1]]?['line'][0]; //752
      String edBackIdxTwo =
          stationInfo.info[reversePathToNode[1]]?['line'][1]; //814

      if (edIdxone[7] == edBackIdxone[7]) {
        subwayNumList.add(edIdxone[7]);
      } else if (edIdxone[7] == edBackIdxTwo[7]) {
        subwayNumList.add(edIdxone[7]);
      } else {
        print("여기이ㅣㅇ이");

        subwayNumList.add(edIdxTwo[7]);
      }
    } else {
      subwayNumList.add(subWayList.last[7]);
    }

    //리스트의 맨 마지막 원소 처리
    //subwayNumList.add(subWayList.last[0]);
    print('앞자리 수 $subwayNumList');
  }

// 매개변수로 들어온 리스트의 길이만큼 반복하면서 false 값을 추가
  static void setIsClickedSubwayList(List<String> subWayList) {
    //isClickedSubwayList = [];
    for (int i = 0; i < subWayList.length; i++) {
      isClickedSubwayList.add(false);
    }
  }

  //하위 역의 개수
  static void setSubwayLowCntList(List<List<String>> inputList) {
    subwayLowCntList = [];
    print('input $inputList');
    for (int i = 0; i < inputList.length; i++) {
      int count = inputList[i].length;

      // 마지막 원소인 경우 항상 0으로 추가
      if (i == inputList.length - 1 || inputList[i][0].isEmpty) {
        print("0들어가요  $count");
        subwayLowCntList.add(0);
      } else {
        print("cnt들어가요  $count");
        subwayLowCntList.add(count);
      }
    }

    print("ddd $subwayLowCntList");
  }

  //세팅하면서 값도 보기편하게 변경
  static void setGuideValue(
      int _guideTime, int _guideDistance, int _guideCost) {
    guideTime = convertToFormat(_guideTime.toString(), 'time');
    guideDistance = convertToFormat(_guideDistance.toString(), 'distance');
    guideCost = convertToFormat(_guideCost.toString(), 'cost');
  }

  //시간,거리,비용 스트링 보기 편하게 하는 함수
  static String convertToFormat(String inputString, String format) {
    int value = int.parse(inputString);

    if (format == 'time') {
      int hours = value ~/ 3600;
      int minutes = (value % 3600) ~/ 60;
      int seconds = value % 60;

      String result = '';

      if (hours > 0) {
        result += '$hours시간 ';
      }

      if (minutes > 0 || hours > 0) {
        result += '$minutes분 ';
      }

      result += '$seconds초';

      return result;
    } else if (format == 'distance') {
      if (value >= 1000) {
        double kilometers = value / 1000.0;
        return '${kilometers.toStringAsFixed(2)} km';
      } else {
        return '$value m';
      }
    } else if (format == 'cost') {
      String formattedWon = value.toString().replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (match) => '${match[1]},',
          );
      return '$formattedWon원';
    } else {
      return '지원하지 않는 형식입니다.';
    }
  }
}
