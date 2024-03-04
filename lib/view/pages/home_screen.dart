import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widgets/standart_btn.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller = TextEditingController();
  bool isLink = false;

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
                    controller: controller,
                    decoration: const InputDecoration(
                    
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hintText: "https://example.com/",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    style: const TextStyle(color: Colors.black),
                  ),
                )
              ]),
              
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
              ),
              Opacity(
                opacity: isLink ? 1 : 0.5,
                child: StandartBtn(
                  text: "Start counting process",
                  onPressed: isLink ? () {} : () {},
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
