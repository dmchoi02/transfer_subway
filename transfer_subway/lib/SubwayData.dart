class Subways {
  Map<String, Map<String, dynamic>> stations;

  Subways()
      : stations = {
          '101': {
            //환승역 - 2호선 종속
            'name': '청량리',
            'nearbyShops': ['CU', '올리브영'],
            'infoToStation': ['1', '200']
          },
          '102': {
            'name': '제기동',
            'nearbyShops': ['GS25'],
            'infoToStation': ['5', '300']
          },
          '103': {
            'name': '신설동',
            'nearbyShops': ['GS25'],
            'infoToStation': ['2', '230']
          },
          '104': {
            //환승역 - 4호선 종속
            'name': '동묘앞',
            'nearbyShops': ['이마트24', '올리브영'],
            'infoToStation': ['3', '120']
          },
          '105': {
            'name': '동대문',
            'nearbyShops': ['CU'],
            'infoToStation': ['7', '60']
          },
          '106': {
            'name': '종로5가',
            'nearbyShops': ['세븐일레븐'],
            'infoToStation': ['8', '70']
          },
          '107': {
            //환승역 - 3호선 종속
            'name': '종로3가',
            'nearbyShops': ['미니스톱'],
            'infoToStation': ['8', '90']
          },
          '108': {
            'name': '종각',
            'nearbyShops': ['GS25', '올리브영'],
            'infoToStation': ['6', '300']
          },
          '109': {
            //환승역 - 5호선 종속
            'name': '시청',
            'nearbyShops': ['CU', '올리브영'],
            'infoToStation': ['3', '30']
          },
          '110': {
            'name': '서울역',
            'nearbyShops': ['CU'],
            'infoToStation': ['8', '60']
          },
          '111': {
            'name': '남영',
            'nearbyShops': ['세븐일레븐'],
            'infoToStation': ['1', '440']
          },
          '112': {
            //환승역 - 9호선 종속
            'name': '용산',
            'nearbyShops': ['이마트24'],
            'infoToStation': ['2', '550']
          },
          '113': {
            //환승역 - 8호선 종속
            'name': '노량진',
            'nearbyShops': ['CU', '올리브영'],
            'infoToStation': ['2', '230']
          },
          '114': {
            'name': '대방',
            'nearbyShops': ['GS25'],
            'infoToStation': ['6', '340']
          },
          '115': {
            //환승역 - 4호선 종속
            'name': '신길',
            'nearbyShops': ['미니스톱'],
            'infoToStation': ['7', '130']
          },
          '116': {
            //환승역 - 6호선 종속
            'name': '영등포',
            'nearbyShops': ['CU'],
            'infoToStation': ['4', '140']
          },
          '117': {
            'name': '신도림',
            'nearbyShops': ['CU', '올리브영'],
            'infoToStation': ['4', '160']
          },
          '118': {
            'name': '구로',
            'nearbyShops': ['CU'],
            'infoToStation': ['3', '220']
          },
          '119': {
            //환승역 - 9호선 종속
            'name': '구일',
            'nearbyShops': ['CU'],
            'infoToStation': ['3', '30']
          },
          '120': {
            'name': '개봉',
            'nearbyShops': ['GS25', '올리브영'],
            'infoToStation': ['3', '60']
          },
          '121': {
            //환승역 - 6호선 종속
            'name': '오류동',
            'nearbyShops': ['세븐일레븐'],
            'infoToStation': ['1', '90']
          },
          '122': {
            //환승역 - 5호선 종속
            'name': '온수',
            'nearbyShops': ['GS25', '올리브영'],
            'infoToStation': ['3', '120']
          },
          '123': {
            //환승역 - 3호선 종속
            'name': '역곡',
            'nearbyShops': ['이마트24'],
            'infoToStation': ['2', '320']
          },
          '201': {
            'name': '을지로입구',
            'nearbyShops': ['CU', '올리브영'],
            'infoToStation': ['4', '200']
          },
          '202': {
            //환승역 - 7호선이라 볼 수 있음
            'name': '을지로3가',
            'nearbyShops': ['미니스톱'],
            'infoToStation': ['3', '20']
          },
          '203': {
            'name': '을지로4가',
            'nearbyShops': ['GS25'],
            'infoToStation': ['7', '60']
          },
          '204': {
            'name': '동대문역사문화공원',
            'nearbyShops': ['CU'],
            'infoToStation': ['7', '230']
          },
          '205': {
            'name': '신당',
            'nearbyShops': ['세븐일레븐'],
            'infoToStation': ['3', '430']
          },
          '206': {
            'name': '상왕십리',
            'nearbyShops': ['CU', '올리브영'],
            'infoToStation': ['1', '60']
          },
          '207': {
            //환승역 - 3호선 종속
            'name': '왕십리',
            'nearbyShops': ['GS25'],
            'infoToStation': ['8', '50']
          },
          '208': {
            'name': '한양대',
            'nearbyShops': ['이마트24'],
            'infoToStation': ['7', '200']
          },
          '209': {
            //환승역 - 5호선 종속
            'name': '뚝섬',
            'nearbyShops': ['미니스톱'],
            'infoToStation': ['7', '230']
          },
          '210': {
            'name': '성수',
            'nearbyShops': ['CU', '올리브영'],
            'infoToStation': ['4', '60']
          },
          '211': {
            //환승역 - 6호선 종속
            'name': '건대입구',
            'nearbyShops': ['세븐일레븐'],
            'infoToStation': ['5', '70']
          },
          '212': {
            'name': '구의',
            'nearbyShops': ['GS25'],
            'infoToStation': ['5', '300']
          },
          '213': {
            'name': '강변',
            'nearbyShops': ['CU', '올리브영'],
            'infoToStation': ['3', '120']
          },
          '214': {
            //환승역 - 8호선 종속
            'name': '잠실나루',
            'nearbyShops': ['세븐일레븐'],
            'infoToStation': ['6', '230']
          },
          '215': {
            'name': '잠실',
            'nearbyShops': ['롯데월드', '미니스톱', '올리브영'],
            'infoToStation': ['7', '40']
          },
          '216': {
            //환승역 - 4호선 종속
            'name': '잠실새내',
            'nearbyShops': ['세븐일레븐'],
            'infoToStation': ['7', '10']
          },
          '217': {
            'name': '종합운동장',
            'nearbyShops': ['GS25'],
            'infoToStation': ['3', '320']
          },
          '301': {
            'name': '구파발',
            'nearbyShops': ['CU'],
            'infoToStation': ['2', '210']
          },
          '302': {
            'name': '연신내',
            'nearbyShops': ['미니스톱', '올리브영'],
            'infoToStation': ['2', '140']
          },
          '303': {
            //환승역 - 7호선 종속
            'name': '불광',
            'nearbyShops': ['세븐일레븐'],
            'infoToStation': ['1', '400']
          },
          '304': {
            'name': '녹번',
            'nearbyShops': ['이마트24'],
            'infoToStation': ['1', '215']
          },
          '305': {
            'name': '홍제',
            'nearbyShops': ['GS25', '올리브영'],
            'infoToStation': ['4', '25']
          },
          '306': {
            'name': '무악재',
            'nearbyShops': ['CU'],
            'infoToStation': ['5', '120']
          },
          '307': {
            //환승역 - 4호선 종속
            'name': '독립문',
            'nearbyShops': ['세븐일레븐'],
            'infoToStation': ['8', '145']
          },
          '308': {
            'name': '경복궁',
            'nearbyShops': ['세븐일레븐', '올리브영'],
            'infoToStation': ['3', '225']
          },
          '401': {
            'name': '쌍문',
            'nearbyShops': ['CU'],
            'infoToStation': ['2', '325']
          },
          '402': {
            'name': '수유',
            'nearbyShops': ['미니스톱'],
            'infoToStation': ['4', '155']
          },
          '403': {
            //환승역 - 5호선 종속
            'name': '미아',
            'nearbyShops': ['GS25'],
            'infoToStation': ['4', '525']
          },
          '404': {
            'name': '미아사거리',
            'nearbyShops': ['GS25', '올리브영'],
            'infoToStation': ['1', '530']
          },
          '405': {
            'name': '길음',
            'nearbyShops': ['CU'],
            'infoToStation': ['8', '20']
          },
          '406': {
            //환승역 - 9호선,4호선 종속
            'name': '성신여대입구',
            'nearbyShops': ['CU'],
            'infoToStation': ['7', '360']
          },
          '407': {
            'name': '한성대입구',
            'nearbyShops': ['세븐일레븐'],
            'infoToStation': ['6', '180']
          },
          '408': {
            'name': '혜화',
            'nearbyShops': ['CU', '올리브영'],
            'infoToStation': ['2', '160']
          },
          '409': {
            //환승역 - 8호선 종속
            'name': '명동',
            'nearbyShops': ['CU'],
            'infoToStation': ['5', '140']
          },
          '410': {
            'name': '회현',
            'nearbyShops': ['GS25'],
            'infoToStation': ['7', '220']
          },
          '411': {
            'name': '숙대입구',
            'nearbyShops': ['세븐일레븐', '올리브영'],
            'infoToStation': ['5', '200']
          },
          '412': {
            'name': '삼각지',
            'nearbyShops': ['CU'],
            'infoToStation': ['1', '210']
          },
          '413': {
            'name': '신용산',
            'nearbyShops': ['이마트24'],
            'infoToStation': ['2', '110']
          },
          '414': {
            'name': '이촌',
            'nearbyShops': ['CU', '올리브영'],
            'infoToStation': ['2', '220']
          },
          '415': {
            'name': '동작',
            'nearbyShops': ['미니스톱'],
            'infoToStation': ['5', '130']
          },
          '416': {
            'name': '총신대입구',
            'nearbyShops': ['이마트24'],
            'infoToStation': ['1', '230']
          },
          '417': {
            'name': '사당',
            'nearbyShops': ['GS25', '올리브영'],
            'infoToStation': ['5', '140']
          },
          '501': {
            'name': '방화',
            'nearbyShops': ['CU'],
            'infoToStation': ['7', '240']
          },
          '502': {
            'name': '개화산',
            'nearbyShops': ['세븐일레븐'],
            'infoToStation': ['7', '110']
          },
          '503': {
            //환승역 - 7호선 종속
            'name': '김포공항',
            'nearbyShops': ['CU', '올리브영'],
            'infoToStation': ['2', '150']
          },
          '504': {
            'name': '송정',
            'nearbyShops': ['이마트24'],
            'infoToStation': ['5', '130']
          },
          '505': {
            'name': '마곡',
            'nearbyShops': ['CU'],
            'infoToStation': ['5', '30']
          },
          '506': {
            'name': '발산',
            'nearbyShops': ['CU', '올리브영'],
            'infoToStation': ['1', '120']
          },
          '507': {
            'name': '우장산',
            'nearbyShops': ['GS25'],
            'infoToStation': ['2', '110']
          },
          '601': {
            //환승역 - 7호선 종속
            'name': '화곡',
            'nearbyShops': ['세븐일레븐', '올리브영'],
            'infoToStation': ['7', '60']
          },
          '602': {
            'name': '까치산',
            'nearbyShops': ['CU'],
            'infoToStation': ['1', '80']
          },
          '603': {
            'name': '신정',
            'nearbyShops': ['이마트24', '올리브영'],
            'infoToStation': ['4', '230']
          },
          '604': {
            'name': '목동',
            'nearbyShops': ['CU', '올리브영'],
            'infoToStation': ['4', '50']
          },
          '605': {
            //환승역 - 9호선 종속
            'name': '오목교',
            'nearbyShops': ['세븐일레븐'],
            'infoToStation': ['6', '320']
          },
          '606': {
            'name': '양평',
            'nearbyShops': ['GS25'],
            'infoToStation': ['5', '330']
          },
          '607': {
            'name': '영등포구청',
            'nearbyShops': ['GS25', '올리브영'],
            'infoToStation': ['8', '120']
          },
          '608': {
            //환승역 - 8호선 종속
            'name': '영등포시장',
            'nearbyShops': ['미니스톱'],
            'infoToStation': ['2', '170']
          },
          '609': {
            'name': '수원',
            'nearbyShops': ['이마트24'],
            'infoToStation': ['7', '110']
          },
          '610': {
            'name': '여의도',
            'nearbyShops': ['GS25', '올리브영'],
            'infoToStation': ['1', '90']
          },
          '611': {
            'name': '여의나루',
            'nearbyShops': ['세븐일레븐'],
            'infoToStation': ['4', '230']
          },
          '612': {
            'name': '마포',
            'nearbyShops': ['CU', '올리브영'],
            'infoToStation': ['2', '130']
          },
          '613': {
            'name': '공덕',
            'nearbyShops': ['세븐일레븐'],
            'infoToStation': ['1', '160']
          },
          '614': {
            //환승역 - 7호선 종속
            'name': '애오개',
            'nearbyShops': ['미니스톱'],
            'infoToStation': ['6', '220']
          },
          '615': {
            'name': '충정로',
            'nearbyShops': ['GS25', '올리브영'],
            'infoToStation': ['6', '230']
          },
          '616': {
            'name': '서대문',
            'nearbyShops': ['GS25'],
            'infoToStation': ['7', '140']
          },
          '617': {
            'name': '광화문',
            'nearbyShops': ['이마트24'],
            'infoToStation': ['1', '150']
          },
          '618': {
            //환승역 - 8호선 종속
            'name': '청구',
            'nearbyShops': ['세븐일레븐'],
            'infoToStation': ['3', '160']
          },
          '619': {
            'name': '신금호',
            'nearbyShops': ['세븐일레븐', '올리브영'],
            'infoToStation': ['6', '70']
          },
          '620': {
            'name': '행당',
            'nearbyShops': ['CU'],
            'infoToStation': ['4', '80']
          },
          '621': {
            //환승역 - 9호선 종속
            'name': '마장',
            'nearbyShops': ['CU'],
            'infoToStation': ['1', '90']
          },
          '622': {
            'name': '답십리',
            'nearbyShops': ['CU', '올리브영'],
            'infoToStation': ['7', '110']
          },
          '701': {
            'name': '까치울',
            'nearbyShops': ['GS25'],
            'infoToStation': ['7', '40']
          },
          '702': {
            //환승역 - 9호선 종속
            'name': '부천종합운동장',
            'nearbyShops': ['미니스톱'],
            'infoToStation': ['3', '130']
          },
          '703': {
            'name': '춘의',
            'nearbyShops': ['CU', '올리브영'],
            'infoToStation': ['4', '220']
          },
          '704': {
            'name': '신중동',
            'nearbyShops': ['GS25'],
            'infoToStation': ['1', '230']
          },
          '705': {
            //환승역 - 8호선 종속
            'name': '부천시장',
            'nearbyShops': ['CU'],
            'infoToStation': ['2', '40']
          },
          '706': {
            'name': '상동',
            'nearbyShops': ['미니스톱'],
            'infoToStation': ['4', '240']
          },
          '707': {
            'name': '삼산체육관',
            'nearbyShops': ['GS25'],
            'infoToStation': ['7', '220']
          },
          '801': {
            'name': '산성',
            'nearbyShops': ['세븐일레븐', '올리브영'],
            'infoToStation': ['6', '120']
          },
          '802': {
            'name': '남한산성입구',
            'nearbyShops': ['세븐일레븐'],
            'infoToStation': ['1', '240']
          },
          '803': {
            'name': '단대오거리',
            'nearbyShops': ['CU'],
            'infoToStation': ['5', '140']
          },
          '804': {
            'name': '신흥',
            'nearbyShops': ['미니스톱'],
            'infoToStation': ['4', '130']
          },
          '805': {
            'name': '수진',
            'nearbyShops': ['GS25', '올리브영'],
            'infoToStation': ['2', '110']
          },
          '806': {
            'name': '모란',
            'nearbyShops': ['CU'],
            'infoToStation': ['7', '220']
          },
          '901': {
            'name': '기흥',
            'nearbyShops': ['세븐일레븐'],
            'infoToStation': ['4', '170']
          },
          '902': {
            'name': '상갈',
            'nearbyShops': ['CU'],
            'infoToStation': ['3', '90']
          },
          '903': {
            'name': '청명',
            'nearbyShops': ['CU', '올리브영'],
            'infoToStation': ['1', '80']
          },
          '904': {
            'name': '영통',
            'nearbyShops': ['GS25'],
            'infoToStation': ['5', '70']
          },
          '905': {
            'name': '망포',
            'nearbyShops': ['CU', '올리브영'],
            'infoToStation': ['3', '110']
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

  Map<String, dynamic>? getStation(String key) {
    return stations[key];
  }

  String getKeyFromName(String stationName) {
    if (_isNumeric(stationName) == true) {
      return stationName;
    } else {
      for (var entry in stations.entries) {
        if (entry.value['name'] == stationName) {
          return entry.key;
        }
      }
      return '';
    }
  }
}
