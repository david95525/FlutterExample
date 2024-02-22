import 'package:flutter/material.dart';
import 'package:flutter_example/widgets/custom_board.dart';

class BloodpressureBoard extends StatelessWidget {
  const BloodpressureBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBoard(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.2,
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.01,
            right: MediaQuery.of(context).size.width * 0.02,
            top: MediaQuery.of(context).size.height * 0.02),
        color: Colors.white,
        children: [
          Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.02),
              child: const Icon(
                Icons.monitor_heart,
                size: 50,
                color: Color.fromARGB(255, 29, 65, 133),
              )),
          Container(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: const Text("Blood Pressure",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ),
          Container(
              padding: const EdgeInsets.only(top: 10),
              child: const Text(
                "130/84",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 29, 65, 133)),
              )),
          Container(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.01),
              child: const Text(
                "Pulse",
                style: TextStyle(fontSize: 30),
              )),
          Container(
              padding: const EdgeInsets.only(top: 10),
              child: const Text(
                "88",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 29, 65, 133)),
              )),
        ]);
  }
}
