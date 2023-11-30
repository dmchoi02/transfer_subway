class Subways {
  Map<String, Map<String, dynamic>> stations;

  Subways()
      : stations = {
          '101': {
            //환승역 - 2호선 종속
            'name': '청량리',
            'nearbyShops': ['CU'],
          },
          '102': {
            'name': '제기동',
            'nearbyShops': ['GS25'],
          },
          '103': {
            'name': '신설동',
            'nearbyShops': ['GS25'],
          },
          '104': {
            //환승역 - 4호선 종속
            'name': '동묘앞',
            'nearbyShops': ['이마트24'],
          },
          '105': {
            'name': '동대문',
            'nearbyShops': ['CU'],
          },
          '106': {
            'name': '종로5가',
            'nearbyShops': ['세븐일레븐'],
          },
          '107': {
            //환승역 - 3호선 종속
            'name': '종로3가',
            'nearbyShops': ['미니스톱'],
          },
          '108': {
            'name': '종각',
            'nearbyShops': ['GS25'],
          },
          '109': {
            //환승역 - 5호선 종속
            'name': '시청',
            'nearbyShops': ['CU'],
          },
          '110': {
            'name': '서울역',
            'nearbyShops': ['CU'],
          },
          '111': {
            'name': '남영',
            'nearbyShops': ['세븐일레븐'],
          },
          '112': {
            //환승역 - 9호선 종속
            'name': '용산',
            'nearbyShops': ['이마트24'],
          },
          '113': {
            //환승역 - 8호선 종속
            'name': '노량진',
            'nearbyShops': ['CU'],
          },
          '114': {
            'name': '대방',
            'nearbyShops': ['GS25'],
          },
          '115': {
            //환승역 - 4호선 종속
            'name': '신길',
            'nearbyShops': ['미니스톱'],
          },
          '116': {
            //환승역 - 6호선 종속
            'name': '영등포',
            'nearbyShops': ['CU'],
          },
          '117': {
            'name': '신도림',
            'nearbyShops': ['CU'],
          },
          '118': {
            'name': '구로',
            'nearbyShops': ['CU'],
          },
          '119': {
            //환승역 - 9호선 종속
            'name': '구일(동양미래대)',
            'nearbyShops': ['CU'],
          },
          '120': {
            'name': '개봉',
            'nearbyShops': ['GS25'],
          },
          '121': {
            //환승역 - 6호선 종속
            'name': '오류동',
            'nearbyShops': ['세븐일레븐'],
          },
          '122': {
            //환승역 - 5호선 종속
            'name': '온수',
            'nearbyShops': ['GS25'],
          },
          '123': {
            //환승역 - 3호선 종속
            'name': '역곡',
            'nearbyShops': ['이마트24'],
          },
          '201': {
            'name': '을지로입구',
            'nearbyShops': ['CU'],
          },
          '202': {
            //환승역 - 7호선이라 볼 수 있음
            'name': '을지로3가',
            'nearbyShops': ['미니스톱'],
          },
          '203': {
            'name': '을지로4가',
            'nearbyShops': ['GS25'],
          },
          '204': {
            'name': '동대문역사문화공원',
            'nearbyShops': ['CU'],
          },
          '205': {
            'name': '신당',
            'nearbyShops': ['세븐일레븐'],
          },
          '206': {
            'name': '상왕십리',
            'nearbyShops': ['CU'],
          },
          '207': {
            //환승역 - 3호선 종속
            'name': '왕십리',
            'nearbyShops': ['GS25'],
          },
          '208': {
            'name': '한양대',
            'nearbyShops': ['이마트24'],
          },
          '209': {
            //환승역 - 5호선 종속
            'name': '뚝섬',
            'nearbyShops': ['미니스톱'],
          },
          '210': {
            'name': '성수',
            'nearbyShops': ['CU'],
          },
          '211': {
            //환승역 - 6호선 종속
            'name': '건대입구',
            'nearbyShops': ['세븐일레븐'],
          },
          '212': {
            'name': '구의',
            'nearbyShops': ['GS25'],
          },
          '213': {
            'name': '강변',
            'nearbyShops': ['CU'],
          },
          '214': {
            //환승역 - 8호선 종속
            'name': '잠실나루',
            'nearbyShops': ['세븐일레븐'],
          },
          '215': {
            'name': '잠실',
            'nearbyShops': ['미니스톱'],
          },
          '216': {
            //환승역 - 4호선 종속
            'name': '잠실새내',
            'nearbyShops': ['세븐일레븐'],
          },
          '217': {
            'name': '종합운동장',
            'nearbyShops': ['GS25'],
          },
          '301': {
            'name': '구파발',
            'nearbyShops': ['CU'],
          },
          '302': {
            'name': '연신내',
            'nearbyShops': ['미니스톱'],
          },
          '303': {
            //환승역 - 7호선 종속
            'name': '불광',
            'nearbyShops': ['세븐일레븐'],
          },
          '304': {
            'name': '녹번',
            'nearbyShops': ['이마트24'],
          },
          '305': {
            'name': '홍제',
            'nearbyShops': ['GS25'],
          },
          '306': {
            'name': '무악재',
            'nearbyShops': ['CU'],
          },
          '307': {
            //환승역 - 4호선 종속
            'name': '독립문',
            'nearbyShops': ['세븐일레븐'],
          },
          '308': {
            'name': '경복궁(정부서울청사)',
            'nearbyShops': ['세븐일레븐'],
          },
          '401': {
            'name': '쌍문',
            'nearbyShops': ['CU'],
          },
          '402': {
            'name': '수유',
            'nearbyShops': ['미니스톱'],
          },
          '403': {
            //환승역 - 5호선 종속
            'name': '미아',
            'nearbyShops': ['GS25'],
          },
          '404': {
            'name': '미아사거리',
            'nearbyShops': ['GS25'],
          },
          '405': {
            'name': '길음',
            'nearbyShops': ['CU'],
          },
          '406': {
            //환승역 - 9호선,4호선 종속
            'name': '성신여대입구(돈암)',
            'nearbyShops': ['CU'],
          },
          '407': {
            'name': '한성대입구(삼선교)',
            'nearbyShops': ['세븐일레븐'],
          },
          '408': {
            'name': '혜화(서울대학교병원)',
            'nearbyShops': ['CU'],
          },
          '409': {
            //환승역 - 8호선 종속
            'name': '명동(우리금융타운)',
            'nearbyShops': ['CU'],
          },
          '410': {
            'name': '회현(남대문시장)',
            'nearbyShops': ['GS25'],
          },
          '411': {
            'name': '숙대입구(갈월)',
            'nearbyShops': ['세븐일레븐'],
          },
          '412': {
            'name': '삼각지',
            'nearbyShops': ['CU'],
          },
          '413': {
            'name': '신용산(아모레퍼시픽)',
            'nearbyShops': ['이마트24'],
          },
          '414': {
            'name': '이촌(국립중앙박물관)',
            'nearbyShops': ['CU'],
          },
          '415': {
            'name': '동작(현충원)',
            'nearbyShops': ['미니스톱'],
          },
          '416': {
            'name': '총신대입구(이수)',
            'nearbyShops': ['이마트24'],
          },
          '417': {
            'name': '사단(대항병원)',
            'nearbyShops': ['GS25'],
          },
          '501': {
            'name': '방화',
            'nearbyShops': ['CU'],
          },
          '502': {
            'name': '개화산',
            'nearbyShops': ['세븐일레븐'],
          },
          '503': {
            //환승역 - 7호선 종속
            'name': '김포공항',
            'nearbyShops': ['CU'],
          },
          '504': {
            'name': '송정',
            'nearbyShops': ['이마트24'],
          },
          '505': {
            'name': '마곡(홈앤쇼핑)',
            'nearbyShops': ['CU'],
          },
          '506': {
            'name': '발산(에스앤유서울병원)',
            'nearbyShops': ['CU'],
          },
          '507': {
            'name': '우장산',
            'nearbyShops': ['GS25'],
          },
          '601': {
            //환승역 - 7호선 종속
            'name': '화곡',
            'nearbyShops': ['세븐일레븐'],
          },
          '602': {
            'name': '까치산',
            'nearbyShops': ['CU'],
          },
          '603': {
            'name': '신정(은행정)',
            'nearbyShops': ['이마트24'],
          },
          '604': {
            'name': '목동',
            'nearbyShops': ['CU'],
          },
          '605': {
            //환승역 - 9호선 종속
            'name': '오목교(목동운동장앞)',
            'nearbyShops': ['세븐일레븐'],
          },
          '606': {
            'name': '양평',
            'nearbyShops': ['GS25'],
          },
          '607': {
            'name': '영등포구청',
            'nearbyShops': ['GS25'],
          },
          '608': {
            //환승역 - 8호선 종속
            'name': '영등포시장',
            'nearbyShops': ['미니스톱'],
          },
          '609': {
            'name': '신길',
            'nearbyShops': ['이마트24'],
          },
          '610': {
            'name': '여의도(신한투자증권)',
            'nearbyShops': ['GS25'],
          },
          '611': {
            'name': '여의나루',
            'nearbyShops': ['세븐일레븐'],
          },
          '612': {
            'name': '마포',
            'nearbyShops': ['CU'],
          },
          '613': {
            'name': '공덕',
            'nearbyShops': ['세븐일레븐'],
          },
          '614': {
            //환승역 - 7호선 종속
            'name': '애오개',
            'nearbyShops': ['미니스톱'],
          },
          '615': {
            'name': '충정로(경기대입구)',
            'nearbyShops': ['GS25'],
          },
          '616': {
            'name': '서대문(강북삼성병원)',
            'nearbyShops': ['GS25'],
          },
          '617': {
            'name': '광화문(세종문화회관)',
            'nearbyShops': ['이마트24'],
          },
          '618': {
            //환승역 - 8호선 종속
            'name': '청구',
            'nearbyShops': ['세븐일레븐'],
          },
          '619': {
            'name': '신금호',
            'nearbyShops': ['세븐일레븐'],
          },
          '620': {
            'name': '행당',
            'nearbyShops': ['CU'],
          },
          '621': {
            //환승역 - 9호선 종속
            'name': '마장',
            'nearbyShops': ['CU'],
          },
          '622': {
            'name': '답십리',
            'nearbyShops': ['CU'],
          },
          '701': {
            'name': '까치울',
            'nearbyShops': ['GS25'],
          },
          '702': {
            //환승역 - 9호선 종속
            'name': '부천종합운동장',
            'nearbyShops': ['미니스톱'],
          },
          '703': {
            'name': '춘의',
            'nearbyShops': ['CU'],
          },
          '704': {
            'name': '신중동',
            'nearbyShops': ['GS25'],
          },
          '705': {
            //환승역 - 8호선 종속
            'name': '부천시장(부천아트센터)',
            'nearbyShops': ['CU'],
          },
          '706': {
            'name': '상동',
            'nearbyShops': ['미니스톱'],
          },
          '707': {
            'name': '삼산체육관',
            'nearbyShops': ['GS25'],
          },
          '801': {
            'name': '산성',
            'nearbyShops': ['세븐일레븐'],
          },
          '802': {
            'name': '남한산성입구(성남법원-검찰청)',
            'nearbyShops': ['세븐일레븐'],
          },
          '803': {
            'name': '단대오거리(신구대학교)',
            'nearbyShops': ['CU'],
          },
          '804': {
            'name': '신흥',
            'nearbyShops': ['미니스톱'],
          },
          '805': {
            'name': '수진',
            'nearbyShops': ['GS25'],
          },
          '806': {
            'name': '모란',
            'nearbyShops': ['CU'],
          },
          '901': {
            'name': '기흥(백남준아트센터)',
            'nearbyShops': ['세븐일레븐'],
          },
          '902': {
            'name': '상갈(루터대학교)',
            'nearbyShops': ['CU'],
          },
          '903': {
            'name': '청명',
            'nearbyShops': ['CU'],
          },
          '904': {
            'name': '영통(경희대)',
            'nearbyShops': ['GS25'],
          },
          '905': {
            'name': '망포',
            'nearbyShops': ['CU'],
          }
        };

  List<String> getStationNames() {
    return stations.values.map((station) => station['name'] as String).toList();
  }

  List<String> getStationNumbers() {
    return stations.keys.toList();
  }

  List<String> getMatchingStations(String query) {
    if (_isNumeric(query)) {
      // 숫자로 이루어진 문자열인 경우
      return stations.keys.where((key) => key.startsWith(query)).toList();
    } else {
      // 텍스트인 경우
      return stations.values
          .where((station) => station['name'].startsWith(query))
          .map((station) => station['name'] as String)
          .toList();
    }
  }

  bool _isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  String getKeyFromName(String stationName) {
    for (var entry in stations.entries) {
      if (entry.value['name'] == stationName) {
        return entry.key;
      }
    }
    return '';
  }
}
