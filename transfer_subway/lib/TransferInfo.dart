class StationInfo {
  Map<String, Map<String, dynamic>> info;

  // 생성자에서 초기 데이터 정의
  StationInfo()
      : info = {
          '101': {
            'line': ['number-1', 'number-2']
          },
          '102': {
            'line': ['number-1']
          },
          '103': {
            'line': ['number-1']
          },
          '104': {
            'line': ['number-1', 'number-4']
          },
          '105': {
            'line': ['number-1']
          },
          '106': {
            'line': ['number-1']
          },
          '107': {
            'line': ['number-1', 'number-3']
          },
          '108': {
            'line': ['number-1']
          },
          '109': {
            'line': ['number-1', 'number-5']
          },
          '110': {
            'line': ['number-1']
          },
          '111': {
            'line': ['number-1']
          },
          '112': {
            'line': ['number-1', 'number-9']
          },
          '113': {
            'line': ['number-1', 'number-8']
          },
          '114': {
            'line': ['number-1']
          },
          '115': {
            'line': ['number-1', 'number-4']
          },
          '116': {
            'line': ['number-1', 'number-6']
          },
          '117': {
            'line': ['number-1']
          },
          '118': {
            'line': ['number-1']
          },
          '119': {
            'line': ['number-1', 'number-9']
          },
          '120': {
            'line': ['number-1']
          },
          '121': {
            'line': ['number-1', 'number-6']
          },
          '122': {
            'line': ['number-1', 'number-5']
          },
          '123': {
            'line': ['number-1', 'number-3']
          },
          '201': {
            'line': ['number-2']
          },
          '202': {
            'line': ['number-2', 'number-7']
          },
          '203': {
            'line': ['number-2']
          },
          '204': {
            'line': ['number-2']
          },
          '205': {
            'line': ['number-2']
          },
          '206': {
            'line': ['number-2']
          },
          '207': {
            'line': ['number-2', 'number-3']
          },
          '208': {
            'line': ['number-2']
          },
          '209': {
            'line': ['number-2', 'number-5']
          },
          '210': {
            'line': ['number-2']
          },
          '211': {
            'line': ['number-2', 'number-9']
          },
          '212': {
            'line': ['number-2']
          },
          '213': {
            'line': ['number-2']
          },
          '214': {
            'line': ['number-2', 'number-8']
          },
          '215': {
            'line': ['number-2']
          },
          '216': {
            'line': ['number-2', 'number-4']
          },
          '217': {
            'line': ['number-2']
          },
          '301': {
            'line': ['number-3']
          },
          '302': {
            'line': ['number-3']
          },
          '303': {
            'line': ['number-3', 'number-7']
          },
          '304': {
            'line': ['number-3']
          },
          '305': {
            'line': ['number-3']
          },
          '306': {
            'line': ['number-3']
          },
          '307': {
            'line': ['number-3', 'number-4']
          },
          '308': {
            'line': ['number-3']
          },
          '401': {
            'line': ['number-4']
          },
          '402': {
            'line': ['number-4']
          },
          '403': {
            'line': ['number-4', 'number-5']
          },
          '404': {
            'line': ['number-4']
          },
          '405': {
            'line': ['number-4']
          },
          '406': {
            'line': ['number-4', 'number-9']
          },
          '407': {
            'line': ['number-4']
          },
          '408': {
            'line': ['number-4']
          },
          '409': {
            'line': ['number-4', 'number-8']
          },
          '410': {
            'line': ['number-4']
          },
          '411': {
            'line': ['number-4']
          },
          '412': {
            'line': ['number-4', 'number-6']
          },
          '413': {
            'line': ['number-4']
          },
          '414': {
            'line': ['number-4']
          },
          '415': {
            'line': ['number-4']
          },
          '416': {
            'line': ['number-4', 'number-7']
          },
          '417': {
            'line': ['number-4', 'number-6']
          },
          '501': {
            'line': ['number-5']
          },
          '502': {
            'line': ['number-5']
          },
          '503': {
            'line': ['number-5', 'number-7']
          },
          '504': {
            'line': ['number-5']
          },
          '505': {
            'line': ['number-5']
          },
          '506': {
            'line': ['number-5']
          },
          '507': {
            'line': ['number-5']
          },
          '601': {
            'line': ['number-6', 'number-7']
          },
          '602': {
            'line': ['number-6']
          },
          '603': {
            'line': ['number-6']
          },
          '604': {
            'line': ['number-6']
          },
          '605': {
            'line': ['number-6', 'number-9']
          },
          '606': {
            'line': ['number-6']
          },
          '607': {
            'line': ['number-6']
          },
          '608': {
            'line': ['number-6', 'number-8']
          },
          '609': {
            'line': ['number-6']
          },
          '610': {
            'line': ['number-6']
          },
          '611': {
            'line': ['number-6']
          },
          '612': {
            'line': ['number-6']
          },
          '613': {
            'line': ['number-6']
          },
          '614': {
            'line': ['number-6', 'number-7']
          },
          '615': {
            'line': ['number-6']
          },
          '616': {
            'line': ['number-6']
          },
          '617': {
            'line': ['number-6']
          },
          '618': {
            'line': ['number-6', 'number-8']
          },
          '619': {
            'line': ['number-6']
          },
          '620': {
            'line': ['number-6']
          },
          '621': {
            'line': ['number-6', 'number-9']
          },
          '622': {
            'line': ['number-6']
          },
          '701': {
            'line': ['number-7']
          },
          '702': {
            'line': ['number-7', 'number-9']
          },
          '703': {
            'line': ['number-7']
          },
          '704': {
            'line': ['number-7']
          },
          '705': {
            'line': ['number-7', 'number-8']
          },
          '706': {
            'line': ['number-7']
          },
          '707': {
            'line': ['number-7']
          },
          '801': {
            'line': ['number-8']
          },
          '802': {
            'line': ['number-8']
          },
          '803': {
            'line': ['number-8']
          },
          '804': {
            'line': ['number-8']
          },
          '805': {
            'line': ['number-8']
          },
          '806': {
            'line': ['number-8']
          },
          '901': {
            'line': ['number-9']
          },
          '902': {
            'line': ['number-9']
          },
          '903': {
            'line': ['number-9']
          },
          '904': {
            'line': ['number-9']
          },
          '905': {
            'line': ['number-9']
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

  Map<String, dynamic>? getStation(String key) {
    return info[key];
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
