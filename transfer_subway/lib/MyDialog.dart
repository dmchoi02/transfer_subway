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

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // Dialog를 사용하여 화면 전체 크기에 맞추지 않음
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        width: 320.0,
        height: 500.0,
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
                itemCount: searchHistory.length,
                itemBuilder: (context, index) {
                  if (isBookmarkedList[index]) {
                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              print("Text clicked at index $index");
                            },
                            child: Text(
                              searchHistory[index],
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
                              setState(() {
                                isBookmarkedList[index] =
                                    !isBookmarkedList[index];
                              });
                              if (isBookmarkedList[index]) {
                                print("Add to bookmarks at index $index");
                              } else {
                                print("Remove from bookmarks at index $index");
                              }
                            },
                            child: Icon(
                              isBookmarkedList[index]
                                  ? Icons.bookmarks
                                  : Icons.bookmarks_outlined,
                              size: 30,
                              color: AppColor.mainColor,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {},
                    );
                  } else {
                    return Container(); // 또는 null을 반환하거나, 다른 위젯을 반환할 수 있습니다.
                  }
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
  const MySubwayInfoDialog({Key? key, String? keyword}) : super(key: key);

  @override
  State<MySubwayInfoDialog> createState() => _MySubwayInfoDialogState();
}

class _MySubwayInfoDialogState extends State<MySubwayInfoDialog> {
  // List<String> searchHistory = Global.getSearchHistory();
  String test = "5번 출구에서 80m";

  @override
  Widget build(BuildContext context) {
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
                      child: Text(
                        "역 정보",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Font",
                          fontWeight: FontWeight.bold,
                          //color: Colors.white,
                        ),
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
                        child: Text(
                          "주변 상가",
                          // 텍스트 스타일 설정
                          style: TextStyle(
                            fontSize: 18.0, // 글꼴 크기
                            fontFamily: "Font", // 폰트
                            fontWeight: FontWeight.bold, // 굵게 하고 싶은 경우
                            color: AppColor.mainColor, // 글씨 색깔
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 60,
                            height: 60,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 60,
                            height: 60,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "근처 정류장 : " + test,
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
