// 전 페이지에서 공유하는 전역 데이터 페이지
// 사용할 때는 Global.get함수
// static이지만 외부에서 접근할 수 없어서 반드시 함수를 통해 접근하세요

import 'imports.dart';

class Global {
  static List<String> _searchList = [];
  static List<String> searchHistory = [
    '158 -> 343',
    '검색 기록 2',
    '검색 기록 3',
    '158 -> 343',
    '158 -> 343',
    '검색 기록 2',
    '검색 기록 3',
    '158 -> 343',
    '검색 기록 3',
    '158 -> 343'
  ];
// 검색기록들의 즐겨찾기 아이콘에 대한 상태
// false는 아이콘이 꺼져있는 것을 의미한다.
  static List<bool> isBookmarkedList = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

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
}
