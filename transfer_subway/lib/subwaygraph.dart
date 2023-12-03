library subway_library;

class SubwayGraph {
  Dijkstra temp = Dijkstra();
  Map<String, Map<String, Map<String, int>>> adjacencyList;

  // 생성자에서 초기 데이터 정의
  SubwayGraph()
      : adjacencyList = {
          '101': {
            '102': {'time': 200, 'distance': 500, 'cost': 200},
            '201': {'time': 1000, 'distance': 500, 'cost': 300},
            '123': {'time': 480, 'distance': 400, 'cost': 200}
          },
          '102': {
            '101': {'time': 200, 'distance': 500, 'cost': 200},
            '103': {'time': 300, 'distance': 400, 'cost': 300}
          },
          '103': {
            '102': {'time': 300, 'distance': 400, 'cost': 300},
            '104': {'time': 1000, 'distance': 600, 'cost': 500}
          },
          '104': {
            '105': {'time': 500, 'distance': 200, 'cost': 340},
            '401': {'time': 1000, 'distance': 600, 'cost': 650},
            '103': {'time': 1000, 'distance': 600, 'cost': 500}
          },
          '105': {
            '104': {'time': 500, 'distance': 200, 'cost': 340},
            '106': {'time': 150, 'distance': 600, 'cost': 450}
          },
          '106': {
            '105': {'time': 150, 'distance': 600, 'cost': 450},
            '107': {'time': 320, 'distance': 200, 'cost': 120}
          },
          '107': {
            '106': {'time': 320, 'distance': 200, 'cost': 120},
            '108': {'time': 400, 'distance': 700, 'cost': 650},
            '308': {'time': 400, 'distance': 400, 'cost': 120}
          },
          '108': {
            '107': {'time': 400, 'distance': 700, 'cost': 650},
            '109': {'time': 800, 'distance': 350, 'cost': 200}
          },
          '109': {
            '108': {'time': 800, 'distance': 350, 'cost': 200},
            '110': {'time': 900, 'distance': 250, 'cost': 430},
            '507': {'time': 1000, 'distance': 700, 'cost': 540}
          },
          '110': {
            '109': {'time': 900, 'distance': 250, 'cost': 430},
            '111': {'time': 500, 'distance': 650, 'cost': 120}
          },
          '111': {
            '110': {'time': 500, 'distance': 650, 'cost': 120},
            '112': {'time': 1000, 'distance': 400, 'cost': 890}
          },
          '112': {
            '111': {'time': 1000, 'distance': 400, 'cost': 890},
            '113': {'time': 2000, 'distance': 500, 'cost': 800},
            '901': {'time': 600, 'distance': 300, 'cost': 700}
          },
          '113': {
            '112': {'time': 2000, 'distance': 500, 'cost': 800},
            '114': {'time': 500, 'distance': 500, 'cost': 700},
            '801': {'time': 600, 'distance': 300, 'cost': 430}
          },
          '114': {
            '113': {'time': 500, 'distance': 500, 'cost': 700},
            '115': {'time': 220, 'distance': 400, 'cost': 540}
          },
          '115': {
            '114': {'time': 220, 'distance': 400, 'cost': 540},
            '407': {'time': 320, 'distance': 400, 'cost': 330},
            '116': {'time': 230, 'distance': 600, 'cost': 330},
            '408': {'time': 480, 'distance': 500, 'cost': 280},
          },
          '116': {
            '115': {'time': 230, 'distance': 600, 'cost': 330},
            '117': {'time': 300, 'distance': 200, 'cost': 280},
            '606': {'time': 320, 'distance': 400, 'cost': 650},
            '607': {'time': 250, 'distance': 200, 'cost': 440}
          },
          '117': {
            '116': {'time': 300, 'distance': 200, 'cost': 280},
            '118': {'time': 500, 'distance': 600, 'cost': 800}
          },
          '118': {
            '117': {'time': 500, 'distance': 600, 'cost': 800},
            '119': {'time': 480, 'distance': 200, 'cost': 1000}
          },
          '119': {
            '118': {'time': 480, 'distance': 200, 'cost': 1000},
            '120': {'time': 500, 'distance': 700, 'cost': 2000},
            '902': {'time': 430, 'distance': 200, 'cost': 800},
            '903': {'time': 1000, 'distance': 700, 'cost': 1000}
          },
          '120': {
            '119': {'time': 500, 'distance': 700, 'cost': 2000},
            '121': {'time': 400, 'distance': 350, 'cost': 700}
          },
          '121': {
            '120': {'time': 400, 'distance': 350, 'cost': 700},
            '122': {'time': 900, 'distance': 250, 'cost': 650},
            '602': {'time': 700, 'distance': 250, 'cost': 280},
            '603': {'time': 500, 'distance': 650, 'cost': 800}
          },
          '122': {
            '121': {'time': 900, 'distance': 250, 'cost': 650},
            '123': {'time': 300, 'distance': 650, 'cost': 440},
            '504': {'time': 320, 'distance': 400, 'cost': 430},
            '505': {'time': 480, 'distance': 600, 'cost': 120},
          },
          '123': {
            '122': {'time': 300, 'distance': 650, 'cost': 440},
            '101': {'time': 480, 'distance': 400, 'cost': 200},
            '304': {'time': 250, 'distance': 250, 'cost': 200},
            '305': {'time': 300, 'distance': 650, 'cost': 300}
          },
          '201': {
            '101': {'time': 1000, 'distance': 500, 'cost': 300},
            '202': {'time': 250, 'distance': 500, 'cost': 500}
          },
          '202': {
            '303': {'time': 1000, 'distance': 200, 'cost': 2000},
            '201': {'time': 250, 'distance': 500, 'cost': 500},
            '203': {'time': 480, 'distance': 400, 'cost': 340}
          },
          '203': {
            '202': {'time': 480, 'distance': 400, 'cost': 340},
            '204': {'time': 400, 'distance': 600, 'cost': 450}
          },
          '204': {
            '205': {'time': 250, 'distance': 200, 'cost': 120},
            '203': {'time': 400, 'distance': 600, 'cost': 450}
          },
          '205': {
            '204': {'time': 250, 'distance': 200, 'cost': 120},
            '206': {'time': 500, 'distance': 600, 'cost': 650}
          },
          '206': {
            '207': {'time': 320, 'distance': 200, 'cost': 200},
            '205': {'time': 500, 'distance': 600, 'cost': 650}
          },
          '207': {
            '206': {'time': 320, 'distance': 200, 'cost': 200},
            '301': {'time': 300, 'distance': 600, 'cost': 2000},
            '208': {'time': 250, 'distance': 700, 'cost': 430}
          },
          '208': {
            '209': {'time': 300, 'distance': 350, 'cost': 120},
            '207': {'time': 250, 'distance': 700, 'cost': 430}
          },
          '209': {
            '208': {'time': 300, 'distance': 350, 'cost': 120},
            '501': {'time': 320, 'distance': 650, 'cost': 450},
            '210': {'time': 150, 'distance': 250, 'cost': 890}
          },
          '210': {
            '211': {'time': 900, 'distance': 650, 'cost': 800},
            '209': {'time': 150, 'distance': 250, 'cost': 890}
          },
          '211': {
            '210': {'time': 900, 'distance': 650, 'cost': 800},
            '212': {'time': 320, 'distance': 400, 'cost': 700},
            '621': {'time': 300, 'distance': 400, 'cost': 440}
          },
          '212': {
            '213': {'time': 150, 'distance': 500, 'cost': 540},
            '211': {'time': 320, 'distance': 400, 'cost': 700}
          },
          '213': {
            '212': {'time': 150, 'distance': 500, 'cost': 540},
            '214': {'time': 500, 'distance': 500, 'cost': 330}
          },
          '214': {
            '215': {'time': 210, 'distance': 400, 'cost': 280},
            '213': {'time': 500, 'distance': 500, 'cost': 330},
            '618': {'time': 700, 'distance': 200, 'cost': 2000}
          },
          '215': {
            '214': {'time': 210, 'distance': 400, 'cost': 280},
            '216': {'time': 150, 'distance': 600, 'cost': 800}
          },
          '216': {
            '217': {'time': 500, 'distance': 200, 'cost': 1000},
            '417': {'time': 900, 'distance': 250, 'cost': 340},
            '215': {'time': 150, 'distance': 600, 'cost': 800}
          },
          '217': {
            '216': {'time': 500, 'distance': 200, 'cost': 1000}
          },
          '301': {
            '207': {'time': 300, 'distance': 600, 'cost': 2000},
            '302': {'time': 300, 'distance': 200, 'cost': 700},
          },
          '302': {
            '303': {'time': 480, 'distance': 700, 'cost': 650},
            '301': {'time': 300, 'distance': 200, 'cost': 700}
          },
          '303': {
            '202': {'time': 1000, 'distance': 200, 'cost': 2000},
            '302': {'time': 480, 'distance': 700, 'cost': 650},
            '304': {'time': 400, 'distance': 350, 'cost': 440},
            '503': {'time': 700, 'distance': 300, 'cost': 700}
          },
          '304': {
            '123': {'time': 250, 'distance': 250, 'cost': 200},
            '303': {'time': 400, 'distance': 350, 'cost': 440}
          },
          '305': {
            '123': {'time': 300, 'distance': 650, 'cost': 300},
            '306': {'time': 250, 'distance': 400, 'cost': 500}
          },
          '306': {
            '307': {'time': 900, 'distance': 500, 'cost': 340},
            '305': {'time': 250, 'distance': 400, 'cost': 500}
          },
          '307': {
            '306': {'time': 900, 'distance': 500, 'cost': 340},
            '308': {'time': 480, 'distance': 500, 'cost': 450},
            '401': {'time': 150, 'distance': 200, 'cost': 200},
            '402': {'time': 300, 'distance': 600, 'cost': 430}
          },
          '308': {
            '107': {'time': 400, 'distance': 400, 'cost': 120},
            '307': {'time': 480, 'distance': 500, 'cost': 450}
          },
          '401': {
            '104': {'time': 1000, 'distance': 600, 'cost': 650},
            '307': {'time': 150, 'distance': 200, 'cost': 200}
          },
          '402': {
            '307': {'time': 300, 'distance': 600, 'cost': 430},
            '403': {'time': 210, 'distance': 200, 'cost': 120}
          },
          '403': {
            '404': {'time': 320, 'distance': 700, 'cost': 890},
            '402': {'time': 210, 'distance': 200, 'cost': 120},
            '506': {'time': 320, 'distance': 600, 'cost': 800},
            '507': {'time': 300, 'distance': 200, 'cost': 700},
          },
          '404': {
            '403': {'time': 320, 'distance': 700, 'cost': 890},
            '405': {'time': 210, 'distance': 350, 'cost': 700}
          },
          '405': {
            '406': {'time': 500, 'distance': 250, 'cost': 700},
            '404': {'time': 210, 'distance': 350, 'cost': 700}
          },
          '406': {
            '405': {'time': 500, 'distance': 250, 'cost': 700},
            '407': {'time': 300, 'distance': 650, 'cost': 540},
            '901': {'time': 300, 'distance': 400, 'cost': 650},
            '605': {'time': 210, 'distance': 200, 'cost': 440}
          },
          '407': {
            '115': {'time': 320, 'distance': 400, 'cost': 330},
            '406': {'time': 300, 'distance': 650, 'cost': 540}
          },
          '408': {
            '115': {'time': 480, 'distance': 500, 'cost': 280},
            '409': {'time': 300, 'distance': 340, 'cost': 800}
          },
          '409': {
            '803': {'time': 600, 'distance': 600, 'cost': 800},
            '410': {'time': 480, 'distance': 500, 'cost': 1000},
            '408': {'time': 300, 'distance': 340, 'cost': 800},
            '608': {'time': 500, 'distance': 200, 'cost': 700}
          },
          '410': {
            '409': {'time': 480, 'distance': 500, 'cost': 1000},
            '411': {'time': 300, 'distance': 400, 'cost': 2000}
          },
          '411': {
            '412': {'time': 900, 'distance': 600, 'cost': 700},
            '410': {'time': 300, 'distance': 400, 'cost': 2000}
          },
          '412': {
            '411': {'time': 900, 'distance': 600, 'cost': 700},
            '413': {'time': 400, 'distance': 200, 'cost': 650},
            '609': {'time': 320, 'distance': 700, 'cost': 500},
            '610': {'time': 1000, 'distance': 350, 'cost': 340}
          },
          '413': {
            '414': {'time': 430, 'distance': 600, 'cost': 440},
            '412': {'time': 400, 'distance': 200, 'cost': 650}
          },
          '414': {
            '413': {'time': 430, 'distance': 600, 'cost': 440},
            '415': {'time': 150, 'distance': 200, 'cost': 200}
          },
          '415': {
            '416': {'time': 1000, 'distance': 700, 'cost': 300},
            '414': {'time': 150, 'distance': 200, 'cost': 200}
          },
          '416': {
            '415': {'time': 1000, 'distance': 700, 'cost': 300},
            '417': {'time': 500, 'distance': 350, 'cost': 500},
            '706': {'time': 300, 'distance': 650, 'cost': 120},
            '707': {'time': 430, 'distance': 400, 'cost': 650}
          },
          '417': {
            '216': {'time': 900, 'distance': 250, 'cost': 340},
            '416': {'time': 500, 'distance': 350, 'cost': 500},
            '616': {'time': 480, 'distance': 200, 'cost': 890},
            '617': {'time': 320, 'distance': 600, 'cost': 800}
          },
          '501': {
            '209': {'time': 320, 'distance': 650, 'cost': 450},
            '502': {'time': 320, 'distance': 400, 'cost': 120}
          },
          '502': {
            '501': {'time': 320, 'distance': 400, 'cost': 120},
            '503': {'time': 430, 'distance': 500, 'cost': 650},
          },
          '503': {
            '504': {'time': 210, 'distance': 500, 'cost': 200},
            '502': {'time': 430, 'distance': 500, 'cost': 650},
            '303': {'time': 700, 'distance': 300, 'cost': 700},
            '601': {'time': 500, 'distance': 400, 'cost': 650}
          },
          '504': {
            '503': {'time': 210, 'distance': 500, 'cost': 200},
            '122': {'time': 320, 'distance': 400, 'cost': 430},
          },
          '505': {
            '506': {'time': 300, 'distance': 200, 'cost': 890},
            '122': {'time': 480, 'distance': 600, 'cost': 120},
          },
          '506': {
            '505': {'time': 300, 'distance': 200, 'cost': 890},
            '403': {'time': 320, 'distance': 600, 'cost': 800},
          },
          '507': {
            '403': {'time': 300, 'distance': 200, 'cost': 700},
            '109': {'time': 1000, 'distance': 700, 'cost': 540}
          },
          '601': {
            '622': {'time': 150, 'distance': 400, 'cost': 1000},
            '602': {'time': 150, 'distance': 350, 'cost': 330},
            '503': {'time': 500, 'distance': 400, 'cost': 650},
            '701': {'time': 430, 'distance': 200, 'cost': 440}
          },
          '602': {
            '601': {'time': 150, 'distance': 350, 'cost': 330},
            '121': {'time': 700, 'distance': 250, 'cost': 280}
          },
          '603': {
            '121': {'time': 500, 'distance': 650, 'cost': 800},
            '604': {'time': 300, 'distance': 400, 'cost': 1000}
          },
          '604': {
            '605': {'time': 430, 'distance': 200, 'cost': 2000},
            '603': {'time': 300, 'distance': 400, 'cost': 1000}
          },
          '605': {
            '604': {'time': 430, 'distance': 200, 'cost': 2000},
            '606': {'time': 480, 'distance': 300, 'cost': 700},
            '406': {'time': 210, 'distance': 200, 'cost': 440},
            '902': {'time': 480, 'distance': 600, 'cost': 280}
          },
          '606': {
            '116': {'time': 320, 'distance': 400, 'cost': 650},
            '605': {'time': 480, 'distance': 300, 'cost': 700}
          },
          '607': {
            '608': {'time': 500, 'distance': 600, 'cost': 200},
            '116': {'time': 250, 'distance': 200, 'cost': 440}
          },
          '608': {
            '607': {'time': 500, 'distance': 600, 'cost': 200},
            '609': {'time': 700, 'distance': 200, 'cost': 300},
            '409': {'time': 500, 'distance': 200, 'cost': 700},
            '804': {'time': 700, 'distance': 700, 'cost': 540}
          },
          '609': {
            '412': {'time': 320, 'distance': 700, 'cost': 500},
            '608': {'time': 700, 'distance': 200, 'cost': 300}
          },
          '610': {
            '412': {'time': 1000, 'distance': 350, 'cost': 340},
            '611': {'time': 700, 'distance': 250, 'cost': 450}
          },
          '611': {
            '612': {'time': 700, 'distance': 650, 'cost': 120},
            '610': {'time': 700, 'distance': 250, 'cost': 450}
          },
          '612': {
            '611': {'time': 700, 'distance': 650, 'cost': 120},
            '613': {'time': 150, 'distance': 400, 'cost': 650}
          },
          '613': {
            '614': {'time': 430, 'distance': 200, 'cost': 200},
            '612': {'time': 150, 'distance': 400, 'cost': 650}
          },
          '614': {
            '613': {'time': 430, 'distance': 200, 'cost': 200},
            '615': {'time': 500, 'distance': 300, 'cost': 430},
            '707': {'time': 480, 'distance': 200, 'cost': 200}
          },
          '615': {
            '616': {'time': 700, 'distance': 400, 'cost': 120},
            '614': {'time': 500, 'distance': 300, 'cost': 430}
          },
          '616': {
            '615': {'time': 700, 'distance': 400, 'cost': 120},
            '417': {'time': 480, 'distance': 200, 'cost': 890}
          },
          '617': {
            '417': {'time': 320, 'distance': 600, 'cost': 800},
            '618': {'time': 300, 'distance': 200, 'cost': 700}
          },
          '618': {
            '619': {'time': 250, 'distance': 700, 'cost': 540},
            '617': {'time': 300, 'distance': 200, 'cost': 700},
            '705': {'time': 250, 'distance': 400, 'cost': 1000},
            '214': {'time': 700, 'distance': 200, 'cost': 2000}
          },
          '619': {
            '618': {'time': 250, 'distance': 700, 'cost': 540},
            '620': {'time': 700, 'distance': 350, 'cost': 330}
          },
          '620': {
            '621': {'time': 320, 'distance': 250, 'cost': 280},
            '619': {'time': 700, 'distance': 350, 'cost': 330}
          },
          '621': {
            '620': {'time': 320, 'distance': 250, 'cost': 280},
            '622': {'time': 480, 'distance': 650, 'cost': 800},
            '904': {'time': 250, 'distance': 650, 'cost': 650},
            '211': {'time': 300, 'distance': 400, 'cost': 440}
          },
          '622': {
            '601': {'time': 150, 'distance': 400, 'cost': 1000},
            '621': {'time': 480, 'distance': 650, 'cost': 800}
          },
          '701': {
            '601': {'time': 430, 'distance': 200, 'cost': 440},
            '702': {'time': 150, 'distance': 600, 'cost': 200}
          },
          '702': {
            '703': {'time': 600, 'distance': 200, 'cost': 300},
            '701': {'time': 150, 'distance': 600, 'cost': 200},
            '903': {'time': 150, 'distance': 350, 'cost': 2000},
            '904': {'time': 500, 'distance': 250, 'cost': 700}
          },
          '703': {
            '702': {'time': 600, 'distance': 200, 'cost': 300},
            '704': {'time': 700, 'distance': 700, 'cost': 500}
          },
          '704': {
            '705': {'time': 250, 'distance': 350, 'cost': 340},
            '703': {'time': 700, 'distance': 700, 'cost': 500}
          },
          '705': {
            '704': {'time': 250, 'distance': 350, 'cost': 340},
            '706': {'time': 600, 'distance': 250, 'cost': 450},
            '806': {'time': 600, 'distance': 650, 'cost': 800},
            '618': {'time': 250, 'distance': 400, 'cost': 1000}
          },
          '706': {
            '416': {'time': 300, 'distance': 650, 'cost': 120},
            '705': {'time': 600, 'distance': 250, 'cost': 450}
          },
          '707': {
            '416': {'time': 430, 'distance': 400, 'cost': 650},
            '614': {'time': 480, 'distance': 200, 'cost': 200}
          },
          '801': {
            '802': {'time': 1000, 'distance': 400, 'cost': 120},
            '113': {'time': 600, 'distance': 300, 'cost': 430}
          },
          '802': {
            '801': {'time': 1000, 'distance': 400, 'cost': 120},
            '803': {'time': 700, 'distance': 200, 'cost': 890}
          },
          '803': {
            '409': {'time': 600, 'distance': 600, 'cost': 800},
            '802': {'time': 700, 'distance': 200, 'cost': 890}
          },
          '804': {
            '608': {'time': 700, 'distance': 700, 'cost': 540},
            '805': {'time': 150, 'distance': 350, 'cost': 330}
          },
          '805': {
            '806': {'time': 210, 'distance': 250, 'cost': 280},
            '804': {'time': 150, 'distance': 350, 'cost': 330}
          },
          '806': {
            '805': {'time': 210, 'distance': 250, 'cost': 280},
            '705': {'time': 600, 'distance': 650, 'cost': 800}
          },
          '901': {
            '112': {'time': 600, 'distance': 300, 'cost': 700},
            '406': {'time': 300, 'distance': 400, 'cost': 650},
          },
          '902': {
            '605': {'time': 480, 'distance': 600, 'cost': 280},
            '119': {'time': 430, 'distance': 200, 'cost': 800}
          },
          '903': {
            '119': {'time': 1000, 'distance': 700, 'cost': 1000},
            '702': {'time': 150, 'distance': 350, 'cost': 2000}
          },
          '904': {
            '702': {'time': 500, 'distance': 250, 'cost': 700},
            '621': {'time': 250, 'distance': 650, 'cost': 650}
          },
        };

  // SubwayGraph 클래스의 Dijkstra 알고리즘을 실행하는 함수
  Map<String, dynamic> runDijkstra(
      String startStation, String endStation, String weightType) {
    return Dijkstra.run(this, startStation, endStation, weightType);
  }

  // SubwayGraph 클래스의 findShortestPath 알고리즘을 실행하는 함수
  List<String> runfindpath(
      String startStation, String endStation, String weightType) {
    return Dijkstra.findShortestPath(
        adjacencyList, startStation, endStation, weightType);
  }
}

// Dijkstra 알고리즘을 구현한 클래스
class Dijkstra {
  static Map<String, dynamic> run(
      SubwayGraph subway, String startNode, String endNode, String weightType) {
    // 그래프 및 거리, 이전 노드, 방문된 노드 초기화
    var graph = subway.adjacencyList;
    var distances = <String, Map<String, dynamic>>{};
    var predecessors = <String, String>{};
    var visitedNodes = <String>{};

    // 초기 거리 설정
    for (var node in graph.keys) {
      distances[node] = node == startNode
          ? {'time': 0, 'distance': 0, 'cost': 0}
          : {'time': 999999, 'distance': 999999, 'cost': 999999};
    }

    while (visitedNodes.length < graph.length) {
      var currentNode = _getClosestNode(distances, visitedNodes, weightType);
      visitedNodes.add(currentNode);

      for (var neighbor in graph[currentNode]!.keys) {
        var weights = graph[currentNode]![neighbor]!;
        var timeWeight = weights['time']!;
        var distanceWeight = weights['distance']!;
        var costWeight = weights['cost']!;

        var totalTime = distances[currentNode]!['time']! + timeWeight;
        var totalDistance =
            distances[currentNode]!['distance']! + distanceWeight;
        var totalCost = distances[currentNode]!['cost']! + costWeight;

        if (totalTime < distances[neighbor]!['time']!) {
          distances[neighbor]!['time'] = totalTime;
        }
        if (totalDistance < distances[neighbor]!['distance']!) {
          distances[neighbor]!['distance'] = totalDistance;
        }
        if (totalCost < distances[neighbor]!['cost']!) {
          distances[neighbor]!['cost'] = totalCost;
        }
        if (distances[neighbor]![weightType]! <
            distances[currentNode]![weightType]!) {
          predecessors[neighbor] = currentNode;
        }
      }
    }

    var shortestPath = <String, dynamic>{};

    for (var node in graph.keys) {
      var path = _getPath(predecessors, node);
      shortestPath[node] = {
        'time': distances[node]!['time'],
        'distance': distances[node]!['distance'],
        'cost': distances[node]!['cost'],
        'path': path,
      };
    }

    return shortestPath;
  }

  // 최단 경로를 찾기 위한 함수
  static List<String> _getPath(Map<String, String> predecessors, String node) {
    var path = <String>[];
    while (predecessors.containsKey(node)) {
      path.insert(0, node);
      node = predecessors[node]!;
    }
    path.insert(0, node);
    return path;
  }

  // 방문하지 않은 노드 중 가장 가까운 노드를 찾는 함수
  static String _getClosestNode(
      Map<String, dynamic> distances, Set<String> visited, String weightType) {
    String closestNode = '';
    int minDistance = double.maxFinite.toInt();

    for (var entry in distances.entries) {
      if (!visited.contains(entry.key) &&
          entry.value[weightType] < minDistance) {
        closestNode = entry.key;
        minDistance = entry.value[weightType];
      }
    }

    return closestNode;
  }

  // 최단 경로를 찾기 위한 내부 함수
  static List<String> findShortestPath(
      Map<String, Map<String, Map<String, int>>> graph,
      String startNode,
      String endNode,
      String weightType) {
    var distances = <String, int>{};
    var predecessors = <String, String>{};
    var unvisitedNodes = graph.keys.toSet();

    for (var node in graph.keys) {
      distances[node] = node == startNode ? 0 : 999999;
    }

    while (unvisitedNodes.isNotEmpty) {
      var currentNode = _getClosestNode2(distances, unvisitedNodes);
      unvisitedNodes.remove(currentNode);

      for (var neighbor in graph[currentNode]!.keys) {
        var weight = graph[currentNode]![neighbor]![weightType]!;

        var totalWeight = distances[currentNode]! + weight;

        if (totalWeight < distances[neighbor]!) {
          distances[neighbor] = totalWeight;
          predecessors[neighbor] = currentNode;
        }
      }
    }

    return _getPath2(predecessors, startNode, endNode);
  }

  // 방문하지 않은 노드 중 가장 가까운 노드를 찾는 내부 함수
  static String _getClosestNode2(
      Map<String, int> distances, Set<String> unvisitedNodes) {
    return unvisitedNodes.reduce((closestNode, node) =>
        distances[node]! < distances[closestNode]! ? node : closestNode);
  }

  // 최단 경로를 찾기 위한 내부 함수
  static List<String> _getPath2(
      Map<String, String> predecessors, String startNode, String endNode) {
    var path = <String>[];
    var currentNode = endNode;

    while (currentNode != startNode) {
      path.insert(0, currentNode);
      currentNode = predecessors[currentNode]!;
    }

    path.insert(0, startNode);

    return path;
  }
}
