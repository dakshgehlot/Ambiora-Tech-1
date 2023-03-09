// ignore_for_file: non_constant_identifier_names

import 'package:ambiora/ClueScreen.dart';
import 'package:ambiora/clues.dart';
import 'package:flutter/material.dart';
import 'package:scratcher/scratcher.dart';

bool isR = false;
String codeR = "";
List<String> _generate() {
  List<String> codes = [];
  for (int i = 0; i < 5; i++) {
    codes.add("Try Again");
  }
  codes.add("Congratulations!");
  codes.shuffle();
  return codes;
}

List<String> codes = _generate();

class Cards extends StatefulWidget {
  const Cards({super.key});

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  final scratchKey = GlobalKey<ScratcherState>();

  Widget Card(String code) {
    return GestureDetector(
      onTap: () {
        scratchDialog(
          code,
        );
      },
      child: Container(
        height: 170,
        width: 170,
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.height * 0.05,
        ),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 70, 103, 160),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(
          child: Icon(
            Icons.card_giftcard,
            size: 50,
            color: Colors.orange,
          ),
        ),
      ),
    );
  }

  Widget actionButton(String word) {
    return TextButton(
      onPressed: () {
        if (codeR == "Congratulations!" && isR) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ClueScreen(clue: groupAClues[currClueIndex]),
            ),
          );
          currClueIndex++;
        } else {
          Navigator.pop(context);
        }
      },
      child: Text(
        word,
        style: const TextStyle(
          color: Colors.red,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Future scratchDialog(String code) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              title: Column(
                children: const [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "You Earned Gift",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25, right: 25),
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              content: Scratcher(
                key: scratchKey,
                accuracy: ScratchAccuracy.low,
                threshold: 50,
                brushSize: 30,
                color: const Color.fromARGB(255, 70, 103, 160),
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      code,
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                onThreshold: () {
                  codeR = code;
                  isR = true;
                },
              ),
              actions: [
                actionButton("Next"),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scratch Cards"),
        centerTitle: true,
        toolbarHeight: 70,
      ),
      backgroundColor: const Color.fromARGB(255, 182, 181, 181),
      body: GridView.builder(
        itemCount: 6,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Card(codes[index]);
        },
      ),
    );
  }
}
