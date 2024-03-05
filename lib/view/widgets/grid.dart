import 'package:flutter/material.dart';

import '../../core/model.dart';

class GridWidget extends StatelessWidget {
  final List<String> field;
  final Coordinates start;
  final Coordinates end;
  final List<Coordinates> steps;

  const GridWidget({super.key, 
    required this.field,
    required this.start,
    required this.end,
    required this.steps,
  });

  bool isInSteps(Coordinates coord) {
    bool res = false;
    for (var element in steps) {
      if (element.x == coord.x && element.y == coord.y) {
        res = true;
      }
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: field[0].length,
        ),
        itemCount: field.length * field[0].length,
        itemBuilder: (BuildContext context, int index) {
          int row = index ~/ field[0].length;
          int column = index % field[0].length;

          Coordinates currentCoordinate = Coordinates(x: column, y: row);

          Color cellColor;
          Color textColor = Colors.black;
          if (currentCoordinate.x == start.x &&
              currentCoordinate.y == start.y) {
            cellColor = const Color(0xFF64FFDA);
          } else if (currentCoordinate.x == end.x &&
              currentCoordinate.y == end.y) {
            cellColor = const Color(0xFF009688);
          } else if (field[row][column] == 'X') {
            cellColor = Colors.black;
            textColor = Colors.white;
          } else if (isInSteps(currentCoordinate)) {
            cellColor = const Color(0xFF4CAF50);
          } else {
            cellColor = Colors.white;
          }

          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
               color: cellColor,
            ),
           
            child: Center(
              child: Text(
                '(${currentCoordinate.x},${currentCoordinate.y})',
                style: TextStyle(color: textColor),
              ),
            ),
          );
        },
      ),
    );
  }
}
