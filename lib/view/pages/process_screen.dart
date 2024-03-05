import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../core/model.dart';
import '../../core/path_find.dart';
import '../widgets/standart_btn.dart';
import 'res_list_screen.dart';

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
  bool _isPosted = true;

  @override
  void initState() {
    super.initState();
    _processData();
  }

  void _processData() async {
    for (int i = 0; i < widget.datas.length; i++) {
      await Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          shortestPaths.addAll(findShortestPath(widget.datas[i].field,
              widget.datas[i].start, widget.datas[i].end));
          widget.datas[i].path =
              shortestPaths.map((coord) => coord.toString()).join('->');
          widget.datas[i].steps = shortestPaths;
          _progress = (i + 1) / widget.datas.length;
          shortestPaths = [];
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
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "${(_progress * 100).toStringAsFixed(0)}%",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.blue),
                    value: _progress,
                    strokeWidth: 5,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Error uploading to server",
                  style:
                      TextStyle(color: _isPosted ? Colors.white : Colors.red),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                Opacity(
                  opacity: _progress * 100 < 100 ? 0.5 : 1,
                  child: StandartBtn(
                    text: "Send results to server",
                    onPressed: _progress * 100 < 100
                        ? () {}
                        : () {
                            setState(() {
                              _isPosted = true;
                            });
                            postData(widget.datas, widget.url);
                          },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void postData(List<MyData> dataList, String url) async {
    List<Map<String, dynamic>> dataToSend = dataList
        .map((data) => {
              'id': data.id,
              'result': {
                'steps': data.steps.map((step) => step.toJson()).toList(),
                'path': data.path,
              }
            })
        .toList();

    String jsonData = json.encode(dataToSend);

    try {
      showLoadingDialog(context);
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonData,
      );
      if (response.statusCode == 200) {
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResListScreen(
              datas: dataList,
            ),
          ),
        );
      } else {
        Navigator.of(context).pop();
        setState(() {
          _isPosted = false;
        });
      }
    } catch (e) {
      Navigator.of(context).pop();
      setState(() {
        _isPosted = false;
      });
    }
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Stack(
          children: <Widget>[
            ModalBarrier(
              color: Colors.white.withOpacity(0.5),
              dismissible: false,
            ),
            const Center(
              child: CircularProgressIndicator(),
            ),
          ],
        );
      },
    );
  }
}
