part of subway_library;

class Dijkstra {
  static Map<String, dynamic> run(
      Subway subway, String startNode, String endNode, String weightType) {
    var graph = subway.adjacencyList;
    var distances = <String, int>{};
    var predecessors = <String, String>{};
    var visitedNodes = <String>{};

    for (var node in graph.keys) {
      distances[node] = node == startNode ? 0 : 999999;
    }

    while (visitedNodes.length < graph.length) {
      var currentNode = _getClosestNode(distances, visitedNodes);
      visitedNodes.add(currentNode);

      for (var neighbor in graph[currentNode]!.keys) {
        var weight = graph[currentNode]![neighbor]![weightType]!;

        var totalWeight = distances[currentNode]! + weight;

        if (totalWeight < distances[neighbor]!) {
          distances[neighbor] = totalWeight;
          predecessors[neighbor] = currentNode;
        }
      }
    }

    var shortestPath = <String, dynamic>{};

    for (var node in graph.keys) {
      var path = _getPath(predecessors, node);
      shortestPath[node] = {
        'distance': distances[node],
        'path': path,
      };
    }

    return shortestPath;
  }

  static List<String> _getPath(Map<String, String> predecessors, String node) {
    var path = <String>[];
    while (predecessors.containsKey(node)) {
      path.insert(0, node);
      node = predecessors[node]!;
    }
    path.insert(0, node);
    return path;
  }

  static String _getClosestNode(
      Map<String, int> distances, Set<String> visited) {
    return distances.entries
        .where((entry) => !visited.contains(entry.key))
        .reduce((min, entry) => entry.value < min.value ? entry : min)
        .key;
  }
}

//실행 예시
void main() {
  var subway = Subway();

  var startStation = '116';
  var endStation = '702';
  var weightType = 'time';
  var result = subway.runDijkstra(startStation, endStation, weightType);

  print('$startStation 에서 $endStation 까지');
  print('$weightType : ${result[endStation]['distance']}');
  print('경로: ${result[endStation]['path'].join(' -> ')}');
}
