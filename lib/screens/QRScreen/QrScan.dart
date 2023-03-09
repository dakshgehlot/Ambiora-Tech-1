// ignore_for_file: file_names
import 'dart:io';
import 'package:ambiora/Scrambled_word_game/rules.dart';
import 'package:ambiora/cards.dart';
import 'package:ambiora/clues.dart';
import 'package:ambiora/jumpingGame/homepage.dart';
import 'package:ambiora/screens/Quiz/QuizScreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScan extends StatefulWidget {
  const QrScan({super.key});

  @override
  State<QrScan> createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  late String code = '';

  MobileScannerController cameraController = MobileScannerController();
  bool isFlash = false;

  File? _imageFile;

  _getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    // ignore: unnecessary_new
    _imageFile = new File(image!.path);
    cameraController.analyzeImage(_imageFile!.path);
  }

  Widget _mobileScanner() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 254, 125, 85),
          width: 12,
        ),
      ),
      margin: const EdgeInsets.only(top: 50),
      // ignore: avoid_unnecessary_containers
      child: Container(
        // ignore: unnecessary_new
        child: new MobileScanner(
          controller: cameraController,
          onDetect: (barcode, args) {
            if (barcode.rawValue == null) {
              debugPrint('Failed to scan');
            } else {
              setState(() {
                code = barcode.rawValue!;
              });
              debugPrint('Scanned code: $code');
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return true;
        },
        child: Scaffold(
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
          floatingActionButton: Container(
            margin: const EdgeInsets.only(bottom: 30, right: 30),
            child: SizedBox(
              height: 60,
              width: 60,
              child: FloatingActionButton(
                backgroundColor: const Color.fromARGB(255, 254, 125, 85),
                onPressed: () {
                  _getImage();
                },
                child: const Icon(Icons.photo),
              ),
            ),
          ),
          body: Container(
            margin: const EdgeInsets.only(top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: Color.fromARGB(57, 0, 0, 0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            cameraController.toggleTorch();
                            if (isFlash) {
                              setState(() {
                                isFlash = false;
                              });
                            } else {
                              setState(() {
                                isFlash = true;
                              });
                            }
                          },
                          icon: isFlash
                              ? const Icon(Icons.flash_on)
                              : const Icon(Icons.flash_off),
                        ),
                        const Text(
                            'Ambiora',
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _mobileScanner(),
                code == ''
                    ? Container()
                    : Container(
                        margin: const EdgeInsets.only(top: 50),
                        width: 180,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 254, 125, 85)
                          ),
                          onPressed: () {
                            if (code == groupAClues[currClueIndex + 1]) {
                              if (currClueIndex + 1 == 0) {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const Cards(),
                                  ),
                                );
                              } else if (currClueIndex + 1 == 1) {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ),
                                );
                              } else if (currClueIndex + 1 == 2) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const QuizScreen(),
                                  ),
                                );
                              } else if (currClueIndex + 1 == 3) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RulesPage(),
                                  ),
                                );
                              } else if (currClueIndex + 1 == 4) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const QuizScreen(),
                                  ),
                                );
                              }
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Wrong QR Code'),
                                    content: const Text(
                                        'Please scan the correct QR Code'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.gamepad_rounded),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                  'Play Game',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
