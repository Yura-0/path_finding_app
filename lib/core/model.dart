class Coordinates {
  final int x;
  final int y;

  Coordinates({required this.x, required this.y});

  Map<String, int> toJson() {
    return {'x': x, 'y': y};
  }

  @override
  String toString() {
    return '($x;$y)';
  }
}

class MyData {
  String id;
  List<String> field;
  Coordinates start;
  Coordinates end;
  String path;
  List<Coordinates> steps; 

  MyData({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
    this.path = '',
    this.steps = const [],
  });

  factory MyData.fromJson(Map<String, dynamic> json) {
    return MyData(
      id: json['id'],
      field: List<String>.from(json['field']),
      start: Coordinates(x: json['start']['x'], y: json['start']['y']),
      end: Coordinates(x: json['end']['x'], y: json['end']['y']),
      path: json['path'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'field': field,
      'start': start.toJson(),
      'end': end.toJson(),
      'path': path,
      'result': {
        'steps': steps
            .map((coord) => coord.toJson())
            .toList(), 
        'path': path,
      },
    };
  }
}
