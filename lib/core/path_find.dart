import 'dart:collection';

import 'model.dart';

List<Coordinates> findShortestPath(List<String> grid, Coordinates start, Coordinates end) {
  List<List<bool>> visited = List<List<bool>>.generate(grid.length, (index) => List<bool>.filled(grid[0].length, false));
  Queue<List<Coordinates>> queue = Queue<List<Coordinates>>();
  queue.add([start]);

  while (queue.isNotEmpty) {
    List<Coordinates> path = queue.removeFirst();
    Coordinates current = path.last;

    if (current.x == end.x && current.y == end.y) {
      return path;
    }

    if (current.x < 0 || current.x >= grid[0].length || current.y < 0 || current.y >= grid.length || grid[current.y][current.x] == 'X' || visited[current.y][current.x]) {
      continue;
    }

    visited[current.y][current.x] = true;

    List<Coordinates> adjacentCoordinates = [
      Coordinates(x: current.x + 1, y: current.y),
      Coordinates(x: current.x - 1, y: current.y),
      Coordinates(x: current.x, y: current.y + 1),
      Coordinates(x: current.x, y: current.y - 1),
      Coordinates(x: current.x + 1, y: current.y + 1),
      Coordinates(x: current.x - 1, y: current.y + 1),
      Coordinates(x: current.x + 1, y: current.y - 1),
      Coordinates(x: current.x - 1, y: current.y - 1),
    ];

    for (Coordinates adjacent in adjacentCoordinates) {
      List<Coordinates> newPath = List<Coordinates>.from(path);
      newPath.add(adjacent);
      queue.add(newPath);
    }
  }

  return [];
}

