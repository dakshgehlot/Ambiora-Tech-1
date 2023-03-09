// ignore_for_file: file_names

import 'dart:convert';
import 'package:ambiora/All_Task_Completion_page.dart';
import 'package:ambiora/ClueScreen.dart';
import 'package:ambiora/clues.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final List<Question> questions = [
  Question(
      "<script type='text/javascript'>\nvar num1 = 2;\nvar num2 = 3;\nvar product = num1 x num2;\nalert('the product of ' + num1 + ' and ' + num2 + ' is ' + product);\n</script>",
      "Identify the error from the following code:",
      [
        "‘const’ keyword should be used for num1 and num2 declaration.",
        "‘let’ keyword should be used for num1 and num2 declaration.",
        "Use of concatenation operator is syntactically wrong.",
        "Multiplication operator is lexically wrong."
      ],
      3)
];

class Question {
  final String question;
  final String statement;
  final List<String> answers;
  final int correctAnswer;

  Question(this.question, this.statement, this.answers, this.correctAnswer);

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      json['question'],
      json['statement'],
      List<String>.from(json['answers']),
      json['correctAnswer'],
    );
  }
}

Future<void> readJson() async {
  final String response =
      await rootBundle.loadString('lib/questions/questions.json');
  final data = await json.decode(response);
  for (var i = 0; i < data["questions"].length; i++) {
    questions.add(Question.fromJson(data["questions"][i]));
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestion = 0;
  bool isExpanded = false;
  bool isCorrect = false;
  bool isWrong = false;
  bool isCooldown = false;
  bool isCooldownover = false;
  int time = 15;

  @override
  void initState() {
    super.initState();
    readJson();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  Future<void> wait() async {
    await Future.delayed(const Duration(seconds: 15), () {
      setState(() {
        isCooldownover = true;
      });
    });
  }

  Widget _option(String answer, int index) {
    return Container(
      margin:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.0125),
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: (isCorrect &&
                  index == questions[currentQuestion].correctAnswer)
              ? MaterialStateProperty.all(Colors.green)
              : (isWrong && index != questions[currentQuestion].correctAnswer)
                  ? MaterialStateProperty.all(Colors.red)
                  : (isWrong &&
                          index == questions[currentQuestion].correctAnswer)
                      ? MaterialStateProperty.all(Colors.green)
                      : MaterialStateProperty.all(Colors.grey),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          minimumSize: MaterialStateProperty.all(
            Size(MediaQuery.of(context).size.width * 0.75,
                MediaQuery.of(context).size.height * 0.05),
          ),
        ),
        onPressed: () {
          setState(() {
            if (index == questions[currentQuestion].correctAnswer) {
              isCorrect = true;
            } else {
              isWrong = true;
            }
          });
        },
        child: Container(
          padding: const EdgeInsets.all(6),
          child: Text(
            answer,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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
        floatingActionButton: (isCorrect || isWrong)
            ? FloatingActionButton(
                onPressed: () {
                  if (isCorrect) {
                    // navigate
                    if (currClueIndex != 4) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => ClueScreen(
                            clue: groupAClues[currClueIndex],
                          ),
                        ),
                      );
                    }
                    currClueIndex++;

                  } else {
                    if (isCooldown == false) {
                      setState(() {
                        isCooldown = true;
                        isCooldownover = false;
                      });
                      wait();
                      Future.doWhile(() async {
                        await Future.delayed(const Duration(seconds: 1), () {
                          setState(() {
                            time--;
                          });
                        });
                        return time > 0;
                      }).then((value) {
                        setState(() {
                          time = 15;
                        });
                      });
                    }
                    if (isCooldownover) {
                      (currentQuestion + 1 == questions.length)
                          ? currentQuestion = 0
                          : currentQuestion++;
                      setState(() {
                        isCorrect = false;
                        isWrong = false;
                        isCooldown = false;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'You have to wait for $time seconds! try pressing the button again!'),
                        ),
                      );
                    }
                  }
                },
                backgroundColor: isCorrect
                    ? const Color.fromARGB(255, 53, 226, 70)
                    : Colors.red,
                child: const Icon(Icons.arrow_forward),
              )
            : Container(),
        body: Center(
          child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.red, Colors.blue],
                ),
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration:
                              Duration(milliseconds: isExpanded ? 500 : 0),
                          width: MediaQuery.of(context).size.width * 0.75,
                          height: isExpanded
                              ? MediaQuery.of(context).size.height * 0.675
                              : MediaQuery.of(context).size.height * 0.3,
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.0125),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 235, 234, 233),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            children: [
                              SingleChildScrollView(
                                child: Container(
                                  padding: const EdgeInsets.all(12.5),
                                  width:
                                      MediaQuery.of(context).size.width * 0.67,
                                  child: Text(
                                    questions[currentQuestion].question,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: IconButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(255, 235, 234, 233),
                                    ),
                                    shape: MaterialStateProperty.all(
                                      const CircleBorder(),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isExpanded = !isExpanded;
                                    });
                                  },
                                  icon: Icon(
                                    isExpanded
                                        ? Icons.zoom_in_map_rounded
                                        : Icons.zoom_out_map_rounded,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        isExpanded
                            ? Container()
                            : Container(
                                width: MediaQuery.of(context).size.width * 0.72,
                                margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.0125,
                                ),
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.red,
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    questions[currentQuestion].statement,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                        isExpanded
                            ? Container()
                            : SizedBox(
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 4,
                                  itemBuilder: (context, index) {
                                    return _option(
                                        questions[currentQuestion]
                                            .answers[index],
                                        index);
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
