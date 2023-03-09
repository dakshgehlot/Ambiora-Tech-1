import 'package:ambiora/clues.dart';
import 'package:flutter/material.dart';
import '../Scrambled_word_game/mainPage.dart';

class RulesPage extends StatelessWidget {
  const RulesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: Scaffold(
        drawer: Drawer(
          child: Column(children: [
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.blue,
              child: const Center(
                child: Text(
                  "Last Clue",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              (currClueIndex >= 0) ? groupAClues[currClueIndex] : "",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ]),
        ),
        backgroundColor: const Color(0xf8f8f8ff),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0)),
              child: Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          const Text(
                            "SCRAMBLED WORDS",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          const Text(
                            "Game Details:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const Text(
                            "\n1) Scrambled words will be displayed and the player has to unscramble them in the given field."
                            "\n\n2) There is a score counter present. For each correct answer, the score will be incremented by 10."
                            "\n\n3) A scrambled word can be skipped by submitting an empty text field."
                            "\n\n4) If the answer is incorrect or the word has been skipped, the score will be decremented by 5."
                            "\n\n5) Your goal: Earn 40 score points and get the clue."
                            "\n\n6) There is no limit to the number of words used to reach the end goal. New scrambled words will keep on displaying until the goal is reached.",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(height: 35),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.play_circle),
                            onPressed: () {
                              generateScrambledWord("");
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyApp()));
                            },
                            label: const Text(
                              "Play",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 24),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shadowColor: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
