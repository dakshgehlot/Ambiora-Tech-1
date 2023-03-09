// ignore_for_file: file_names, camel_case_types

import 'package:ambiora/clues.dart';
import 'package:flutter/material.dart';
import "package:lottie/lottie.dart";

class lastPage extends StatefulWidget {
  const lastPage({super.key});

  @override
  State<lastPage> createState() => _lastPageState();
}

class _lastPageState extends State<lastPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 250, 250, 250),
            elevation: 0,
            leading: Builder(
              builder: (context) => // Ensure Scaffold is in context
                  IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.black,
                      ),
                      onPressed: () => Scaffold.of(context).openDrawer()),
            ),
          ),
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
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold
                    ),
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
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: "Poppins"
                  ),
                ),
              ),
            ]),
          ),
          body: Stack(
            children: [
              SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Lottie.asset('./assets/json/background.json')),
              Center(
                  child: Column(
                children: [
                  LottieBuilder.asset('./assets/json/congrats.json'),
                  const Text(
                    "Congratulations!\nYou have completed all the tasks.",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.orangeAccent,
                      fontFamily: "Poppins",
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
