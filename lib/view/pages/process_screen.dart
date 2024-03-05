import 'package:flutter/material.dart';

import '../../core/model.dart';
import '../../core/path_find.dart';
import '../widgets/standart_btn.dart';

class ProcessScreen extends StatefulWidget {
  final String url;
  final List<MyData> datas;
  const ProcessScreen({super.key, required this.url, required this.datas});

  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  double _progress = 0;
  List<Coordinates> shortestPaths = [];

  @override
  void initState() {
    super.initState();
    _processData();
  }

  void _processData() async {
    for (int i = 0; i < widget.datas.length; i++) {
      await Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          shortestPaths.add(findShortestPath(widget.datas[i].field,
              widget.datas[i].start, widget.datas[i].end)[0]);
          _progress = (i + 1) / widget.datas.length;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Process Screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  _progress * 100 < 100
                      ? "Calculating..."
                      : "All calculations has finished, you can send your results to server",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${(_progress * 100).toStringAsFixed(0)}%",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                    value: _progress,
                    strokeWidth: 5,
                  ),
                ),
                 SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              Opacity(
                opacity:  _progress * 100 < 100
                    ? 0.5
                    : 1,
                child: StandartBtn(
                  text: "Send results to server",
                  onPressed:_progress * 100 < 100
                      ? () {
                        }
                      : () {},
                ),
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
