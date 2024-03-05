import 'package:flutter/material.dart';

import '../../core/model.dart';
import 'preview_screen.dart';

class ResListScreen extends StatelessWidget {
  final List<MyData> datas;
  const ResListScreen({super.key, required this.datas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Result list screen',
            style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: ListView.separated(
            itemCount: datas.length,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                height: 1,
                color: Colors.grey,
              );
            },
            itemBuilder: (context, index) {
              return ListTile(
                title: Center(
                  child: Text(
                    datas[index].path,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PreviewScreen(
                        data: datas[index],
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
