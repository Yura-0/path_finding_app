import 'package:flutter/material.dart';

import '../../core/model.dart';
import '../widgets/grid.dart';

class PreviewScreen extends StatelessWidget {
  final MyData data;
  const PreviewScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Preview screen',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GridWidget(
                  field: data.field,
                  start: data.start,
                  end: data.end,
                  steps: data.steps),
              const SizedBox(
                height: 10,
              ),
              Text(
                data.path,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
