import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../core/model.dart';
import '../widgets/standart_btn.dart';
import 'process_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isCorrectLink = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Home Screen', style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Set valid API base URL in order to continue",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const SizedBox.square(
                  dimension: 10,
                  child: Icon(Icons.compare_arrows, color: Colors.grey),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hintText: "https://example.com/",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    style: const TextStyle(color: Colors.black),
                    onChanged: (value) => {
                      setState(() {
                        _isCorrectLink = true;
                      })
                    },
                  ),
                )
              ]),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Incorrect link",
                style:
                    TextStyle(color: _isCorrectLink ? Colors.white : Colors.red),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
              ),
              Opacity(
                opacity: _controller.text.isNotEmpty || _controller.text != ""
                    ? 1
                    : 0.5,
                child: StandartBtn(
                  text: "Start counting process",
                  onPressed: _controller.text.isNotEmpty || _controller.text != ""
                      ? () {
                          _fetchData(_controller.text);
                        }
                      : () {},
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  // https://flutter.webspark.dev/flutter/api
  Future<void> _fetchData(String url) async {
    try {
       showLoadingDialog(context);
      if (Uri.parse(url).isAbsolute) {
        var response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);
          if (jsonResponse['error'] is bool &&
              jsonResponse['message'] is String &&
              jsonResponse['data'] is List &&
              jsonResponse['data'].isNotEmpty &&
              jsonResponse['data'][0]['id'] is String &&
              jsonResponse['data'][0]['field'] is List &&
              jsonResponse['data'][0]['start'] != null &&
              jsonResponse['data'][0]['end'] != null) {
            bool error = jsonResponse['error'];

            if (error) {
               Navigator.of(context).pop();
              setState(() {
                _isCorrectLink = false;
              });
            } else {
               Navigator.of(context).pop();
              List<MyData> myDataList = [];
              for (var item in jsonResponse['data']) {
                MyData data = MyData.fromJson(item);
                myDataList.add(data);
              }
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProcessScreen(url: url, datas: myDataList)));
            }
          } else {
             Navigator.of(context).pop();
            setState(() {
              _isCorrectLink = false;
            });
          }
        } else {
           Navigator.of(context).pop();
          setState(() {
            _isCorrectLink = false;
          });
        }
      } else {
         Navigator.of(context).pop();
        setState(() {
          _isCorrectLink = false;
        });
      }
    } catch (e) {
       Navigator.of(context).pop();
      setState(() {
        _isCorrectLink = false;
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
