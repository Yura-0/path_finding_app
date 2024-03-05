class Coordinates {
  final int x;
  final int y;

  Coordinates({required this.x, required this.y});

  Map<String, int> toJson() {
    return {'x': x, 'y': y};
  }
}

class MyData {
  String id;
  List<String> field;
  Coordinates start;
  Coordinates end;

  MyData({required this.id, required this.field, required this.start, required this.end});

  factory MyData.fromJson(Map<String, dynamic> json) {
    return MyData(
      id: json['id'],
      field: List<String>.from(json['field']),
      start: Coordinates(x: json['start']['x'], y: json['start']['y']),
      end: Coordinates(x: json['end']['x'], y: json['end']['y']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'field': field,
      'start': start.toJson(),
      'end': end.toJson(),
    };
  }
}