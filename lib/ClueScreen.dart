// ignore_for_file: file_names

import 'package:ambiora/All_Task_Completion_page.dart';
import 'package:ambiora/clues.dart';
import 'package:ambiora/screens/QRScreen/QrLandingPage.dart';
import 'package:flutter/material.dart';

class ClueScreen extends StatefulWidget {
  final String clue;
  const ClueScreen({super.key, required this.clue});

  @override
  State<ClueScreen> createState() => _ClueScreenState();
}

class _ClueScreenState extends State<ClueScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: Drawer(
            child: Column(children: [
              Container(
                height: 100,
                width: double.infinity,
                color: const Color.fromARGB(255, 254, 125, 85),
                child: const Center(
                  child: Text(
                    "Last Clue",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: "Poppins"),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  (currClueIndex >= 0) ? groupAClues[currClueIndex] : "",
                  style: const TextStyle(fontSize: 20, fontFamily: "Poppins"),
                ),
              ),
            ]),
          ),
          // Display congratulations you got the clue and display the clue below it also navigate to the next screen
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Congratulations!\nYou got the clue.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins",
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    widget.clue,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins",
                      color: Color.fromARGB(255, 153, 158, 161),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  SizedBox(
                    width: 175,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        if (currClueIndex == 4) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const lastPage(),
                            ),
                          );
                        } else {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const QrLandingPage(),
                            ),
                          ); // Navigate to the next scree
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 254, 125, 85),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
