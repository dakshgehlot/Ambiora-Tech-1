// ignore_for_file: file_names

import 'package:ambiora/clues.dart';
import 'package:ambiora/screens/QRScreen/QrScan.dart';
import 'package:flutter/material.dart';

class QrLandingPage extends StatefulWidget {
  const QrLandingPage({super.key});

  @override
  State<QrLandingPage> createState() => _QrLandingPageState();
}

class _QrLandingPageState extends State<QrLandingPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
                        fontWeight: FontWeight.bold,
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
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Image.asset("assets/images/ambiora.jpg"),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Scan QR Code",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins",
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Place the QR code inside the frame to scan. Please avoid shake to get results quickly.",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins",
                        color: Color.fromARGB(255, 153, 158, 161),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Image.asset("assets/images/QR.jpg"),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Scanning code...",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Manrope",
                        color: Color.fromARGB(255, 153, 158, 161),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Icon(
                            Icons.photo_library,
                            color: Color.fromARGB(137, 0, 0, 0),
                          ),
                          Icon(
                            Icons.qr_code,
                            color: Color.fromARGB(137, 0, 0, 0),
                          ),
                          Icon(
                            Icons.flash_on,
                            color: Color.fromARGB(137, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const QrScan(),
                              //QuizScreen(),
                            ),
                          );
                          //  Navigator.of(context).push(
                          //       MaterialPageRoute(

                          //         builder: (context) => const RulesPage(),
                          //       ),
                          //     );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 254, 125, 85),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          alignment: Alignment.center,
                          child: const Text(
                            "Place Camera Code",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
