import 'dart:ffi';

import 'imports.dart';

class MyBookmarkDialog extends StatefulWidget {
  const MyBookmarkDialog({Key? key}) : super(key: key);

  @override
  State<MyBookmarkDialog> createState() => _MyBookmarkDialogState();
}

class _MyBookmarkDialogState extends State<MyBookmarkDialog> {
  List<String> searchHistory = Global.getSearchHistory(); // 추후 수정해야함
  List<bool> isBookmarkedList = Global.getIsBookmarkedList();
  String departureValue = Global.getdepartureValue();
  String destinationValue = Global.getdestinationValue();
  final Subways subways = Subways();

  @override
  Widget build(BuildContext context) {
    // 즐겨찾기된 항목만 필터링하여 새로운 리스트를 만듭니다.
    List<String> bookmarkedItems = [];
    for (int i = 0; i < searchHistory.length; i++) {
      if (isBookmarkedList[i]) {
        bookmarkedItems.add(searchHistory[i]);
      }
    }

    return Dialog(
      // Dialog를 사용하여 화면 전체 크기에 맞추지 않음
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        width: 320.0,
        height: 500.0,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 5),
                      child: Text(
                        "즐겨찾기",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Font",
                          fontWeight: FontWeight.bold,
                          //color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0, top: 5),
                      child: IconButton(
                        icon: Icon(Icons.close),
                        iconSize: 32,
                        //color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Expanded(
              child: ListView.builder(
                itemExtent: 40,
                itemCount: bookmarkedItems.length, // 즐겨찾기된 항목의 수만큼 아이템을 생성합니다.
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            print("Text clicked at index $index");
                            // query를 ' --> ' 문자열로 분리하여 departureValue와 destinationValue를 가져옵니다.
                            List<String> values =
                                bookmarkedItems[index].split(' --> ');
                            departureValue = subways.getKeyFromName(values[0]);
                            destinationValue =
                                subways.getKeyFromName(values[1]);
                            print(values);
                            Navigator.pop(context, values);
                          },
                          child: Text(
                            bookmarkedItems[index], // 즐겨찾기된 항목을 표시합니다.
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
                            // 즐겨찾기 상태를 변경합니다.
                            int originalIndex =
                                searchHistory.indexOf(bookmarkedItems[index]);
                            setState(() {
                              isBookmarkedList[originalIndex] =
                                  !isBookmarkedList[originalIndex];
                            });
                            if (isBookmarkedList[originalIndex]) {
                              print("Add to bookmarks at index $originalIndex");
                            } else {
                              print(
                                  "Remove from bookmarks at index $originalIndex");
                            }
                          },
                          child: Icon(
                            Icons.bookmarks,
                            size: 30,
                            color: AppColor.mainColor,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 역 정보 다이얼로그
class MySubwayInfoDialog extends StatefulWidget {
  final String? keyword;

  const MySubwayInfoDialog({Key? key, this.keyword}) : super(key: key);

  @override
  State<MySubwayInfoDialog> createState() => _MySubwayInfoDialogState();
}

class _MySubwayInfoDialogState extends State<MySubwayInfoDialog> {
  // List<String> searchHistory = Global.getSearchHistory();
  Subways st = Subways(); //지하철 정보 정적데이터
  Map<String, dynamic>? target = {}; //호출된 역의 맵
  String stationId = ''; //호출된 역의 키
  String _keyword = ''; //호출된 키워드. widjet에서 얻어온걸 적용한다.
  String name = ''; //호출된 역의 이름
  List<String> nearbyShops = []; //호출된 역의 상가
  String infoX = ''; //호출된 역의 가까운 정류장으로 가는 출구
  String infoY = ''; //호출된 역의 가까운 정류장으로 가는 출구로 나와서 가야하는 거리
  StationInfo sti = StationInfo();
  Map<String, dynamic>? transtarget = {};
  List<String> trans = [];
  @override
  void initState() {
    if (widget.keyword != null) {
      // widget.keyword가 null이 아닌 경우의 동작
      _keyword = widget.keyword!;
    } else {
      // widget.keyword가 null인 경우의 동작. do notthing.
    }
    super.initState();
    print(widget.keyword);
    if (int.tryParse(_keyword) != null || double.tryParse(_keyword) != null) {
      stationId = _keyword;
    } else {
      stationId = st.getKeyFromName(_keyword);
    }
    // 여기서 keyword를 사용하여 초기화를 수행.
    target = st.getStation(stationId);
    transtarget = sti.getStation(stationId);
    name = target?['name'] ?? [];
    trans = transtarget?['line'] ?? [];
    nearbyShops = target?['nearbyShops'] ?? [];
    infoX = target?['infoToStation'][0] ?? [];
    infoY = target?['infoToStation'][1] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    // 여기서 widget.keyword를 사용하여 인수에 접근할 수 있습니다.
    return Dialog(
      // Dialog를 사용하여 화면 전체 크기에 맞추지 않음

      child: Container(
        width: 240.0,
        height: 230.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "A.K.A $stationId",
                            style: TextStyle(
                              fontSize: 10.0,
                              fontFamily: "Font",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "$name역",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: "Font",
                              fontWeight: FontWeight.bold,
                              //color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 0.0, top: 5),
                      child: IconButton(
                        icon: Icon(Icons.close),
                        iconSize: 32,
                        //color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Container(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: <Widget>[
                            Text(
                              "주변 시설",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: "Font",
                                fontWeight: FontWeight.bold,
                                color: AppColor.mainColor,
                              ),
                            ),
                            SizedBox(width: 10.0), // 공간 추가
                            ...trans.map((info) {
                              return Row(
                                children: <Widget>[
                                  Container(
                                    height: 20.0,
                                    width: 20.0,
                                    child: Image.asset(
                                      'assets/images/$info.png',
                                    ),
                                  ),
                                  SizedBox(width: 10.0), // 리스트들 사이 공간 추가
                                ],
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: nearbyShops
                            .map((item) => Image.asset(images + '$item.png',
                                width: 60, height: 60))
                            .toList(),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "근처 정류장 : " + infoX + "번 출구에서 " + infoY + "m",
                          // 텍스트 스타일 설정
                          style: TextStyle(
                            fontSize: 15.0, // 글꼴 크기
                            fontFamily: "Font", // 폰트
                            fontWeight: FontWeight.bold, // 굵게 하고 싶은 경우
                            color: AppColor.mainColor, // 글씨 색깔
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
