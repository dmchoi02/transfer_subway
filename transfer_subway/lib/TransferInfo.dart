class StationInfo {
  Map<String, Map<String, dynamic>> info;

  // 생성자에서 초기 데이터 정의
  StationInfo()
      : info = {
          '101': {
            'line': ['1호선', '2호선']
          },
          '102': {
            'line': ['1호선']
          },
          '103': {
            'line': ['1호선']
          },
          '104': {
            'line': ['1호선', '4호선']
          },
          '105': {
            'line': ['1호선']
          },
          '106': {
            'line': ['1호선']
          },
          '107': {
            'line': ['1호선', '3호선']
          },
          '108': {
            'line': ['1호선']
          },
          '109': {
            'line': ['1호선', '5호선']
          },
          '110': {
            'line': ['1호선']
          },
          '111': {
            'line': ['1호선']
          },
          '112': {
            'line': ['1호선', '9호선']
          },
          '113': {
            'line': ['1호선', '8호선']
          },
          '114': {
            'line': ['1호선']
          },
          '115': {
            'line': ['1호선', '4호선']
          },
          '116': {
            'line': ['1호선', '6호선']
          },
          '117': {
            'line': ['1호선']
          },
          '118': {
            'line': ['1호선']
          },
          '119': {
            'line': ['1호선', '9호선']
          },
          '120': {
            'line': ['1호선']
          },
          '121': {
            'line': ['1호선', '6호선']
          },
          '122': {
            'line': ['1호선', '5호선']
          },
          '123': {
            'line': ['1호선', '3호선']
          },
          '201': {
            'line': ['2호선']
          },
          '202': {
            'line': ['2호선', '7호선']
          },
          '203': {
            'line': ['2호선']
          },
          '204': {
            'line': ['2호선']
          },
          '205': {
            'line': ['2호선']
          },
          '206': {
            'line': ['2호선']
          },
          '207': {
            'line': ['2호선', '3호선']
          },
          '208': {
            'line': ['2호선']
          },
          '209': {
            'line': ['2호선', '5호선']
          },
          '210': {
            'line': ['2호선']
          },
          '211': {
            'line': ['2호선', '9호선']
          },
          '212': {
            'line': ['2호선']
          },
          '213': {
            'line': ['2호선']
          },
          '214': {
            'line': ['2호선', '8호선']
          },
          '215': {
            'line': ['2호선']
          },
          '216': {
            'line': ['2호선', '4호선']
          },
          '217': {
            'line': ['2호선']
          },
          '301': {
            'line': ['3호선']
          },
          '302': {
            'line': ['3호선']
          },
          '303': {
            'line': ['3호선', '7호선']
          },
          '304': {
            'line': ['3호선']
          },
          '305': {
            'line': ['3호선']
          },
          '306': {
            'line': ['3호선']
          },
          '307': {
            'line': ['3호선', '4호선']
          },
          '308': {
            'line': ['3호선']
          },
          '401': {
            'line': ['4호선']
          },
          '402': {
            'line': ['4호선']
          },
          '403': {
            'line': ['4호선', '5호선']
          },
          '404': {
            'line': ['4호선']
          },
          '405': {
            'line': ['4호선']
          },
          '406': {
            'line': ['4호선', '9호선']
          },
          '407': {
            'line': ['4호선']
          },
          '408': {
            'line': ['4호선']
          },
          '409': {
            'line': ['4호선', '8호선']
          },
          '410': {
            'line': ['4호선']
          },
          '411': {
            'line': ['4호선']
          },
          '412': {
            'line': ['4호선', '6호선']
          },
          '413': {
            'line': ['4호선']
          },
          '414': {
            'line': ['4호선']
          },
          '415': {
            'line': ['4호선']
          },
          '416': {
            'line': ['4호선', '7호선']
          },
          '417': {
            'line': ['4호선', '6호선']
          },
          '501': {
            'line': ['5호선']
          },
          '502': {
            'line': ['5호선']
          },
          '503': {
            'line': ['5호선', '7호선']
          },
          '504': {
            'line': ['5호선']
          },
          '505': {
            'line': ['5호선']
          },
          '506': {
            'line': ['5호선']
          },
          '507': {
            'line': ['5호선']
          },
          '601': {
            'line': ['6호선', '7호선']
          },
          '602': {
            'line': ['6호선']
          },
          '603': {
            'line': ['6호선']
          },
          '604': {
            'line': ['6호선']
          },
          '605': {
            'line': ['6호선', '9호선']
          },
          '606': {
            'line': ['6호선']
          },
          '607': {
            'line': ['6호선']
          },
          '608': {
            'line': ['6호선', '8호선']
          },
          '609': {
            'line': ['6호선']
          },
          '610': {
            'line': ['6호선']
          },
          '611': {
            'line': ['6호선']
          },
          '612': {
            'line': ['6호선']
          },
          '613': {
            'line': ['6호선']
          },
          '614': {
            'line': ['6호선', '7호선']
          },
          '615': {
            'line': ['6호선']
          },
          '616': {
            'line': ['6호선']
          },
          '617': {
            'line': ['6호선']
          },
          '618': {
            'line': ['6호선', '8호선']
          },
          '619': {
            'line': ['6호선']
          },
          '620': {
            'line': ['6호선']
          },
          '621': {
            'line': ['6호선', '9호선']
          },
          '622': {
            'line': ['6호선']
          },
          '701': {
            'line': ['7호선']
          },
          '702': {
            'line': ['7호선', '9호선']
          },
          '703': {
            'line': ['7호선']
          },
          '704': {
            'line': ['7호선']
          },
          '705': {
            'line': ['7호선', '8호선']
          },
          '706': {
            'line': ['7호선']
          },
          '707': {
            'line': ['7호선']
          },
          '801': {
            'line': ['8호선']
          },
          '802': {
            'line': ['8호선']
          },
          '803': {
            'line': ['8호선']
          },
          '804': {
            'line': ['8호선']
          },
          '805': {
            'line': ['8호선']
          },
          '806': {
            'line': ['8호선']
          },
          '901': {
            'line': ['9호선']
          },
          '902': {
            'line': ['9호선']
          },
          '903': {
            'line': ['9호선']
          },
          '904': {
            'line': ['9호선']
          },
          '905': {
            'line': ['9호선']
          }
        };

  List<String> getTransferStations(List<String> path) {
    List<String> transferStations = [];

    for (int i = 1; i < path.length - 1; i++) {
      String prevStation = path[i - 1];
      String station = path[i];
      String nextStation = path[i + 1];

      List<String> stationLines = info[station]!['line'];
      List<String> prevStationLines = info[prevStation]!['line'];
      List<String> nextStationLines = info[nextStation]!['line'];

      List<String> commonLinesWithPrevStation = stationLines
          .where((line) => prevStationLines.contains(line))
          .toList();
      List<String> commonLinesWithNextStation = stationLines
          .where((line) => nextStationLines.contains(line))
          .toList();

      if (commonLinesWithPrevStation.isEmpty ||
          commonLinesWithNextStation.isEmpty ||
          !commonLinesWithPrevStation
              .any((line) => commonLinesWithNextStation.contains(line))) {
        transferStations.add(station);
      }
    }

    return transferStations;
  }

  //라인 개수 세기
  int getLineCount(String stationId) {
    if (info.containsKey(stationId) && info[stationId]!['line'] != null) {
      return info[stationId]!['line'].length;
    } else {
      return 0;
    }
  }
}
