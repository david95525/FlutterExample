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
          Wrap(children: [
            Container(
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Container(
                padding: EdgeInsets.only(
                    top: 10, left: MediaQuery.of(context).size.width * 0.1),
                child: const Text(
                  "Pulse",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
          ]),
          Wrap(children: [
            Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.02,
                    right: MediaQuery.of(context).size.width * 0.02),
                child: const Icon(
                  Icons.monitor_heart,
                  size: 40,
                  color: Color.fromARGB(255, 29, 65, 133),
                )),
            Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.02,
                    right: MediaQuery.of(context).size.width * 0.02),
                child: const Text(
                  "130/84",
                  style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 29, 65, 133)),
                )),
            Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.15),
                child: const Text(
                  "88",
                  style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 29, 65, 133)),
                ))
          ]),
          Wrap(crossAxisAlignment: WrapCrossAlignment.start, children: [
            Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.2),
                child: const Text("mmHg",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ))),
            Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.15),
                child: const Text("bpm",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    )))
          ])
        ]);
  }
}
