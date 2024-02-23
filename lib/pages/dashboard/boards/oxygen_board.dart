import 'package:flutter/material.dart';
import 'package:flutter_example/widgets/custom_board.dart';

class OxygenBoard extends StatelessWidget {
  const OxygenBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBoard(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.2,
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.02,
            top: MediaQuery.of(context).size.height * 0.02),
        color: Colors.white,
        children: [
          Wrap(crossAxisAlignment: WrapCrossAlignment.start, children: [
            Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.02),
                child: const Icon(
                  Icons.thermostat,
                  size: 50,
                  color: Color.fromARGB(255, 29, 65, 133),
                )),
            Container(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: const Text("SpO2",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1, top: 10),
                child: const Text(
                  "Pulse",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
          ]),
          Wrap(crossAxisAlignment: WrapCrossAlignment.start, children: [
            Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1),
                child: const Text(
                  "98",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 29, 65, 133)),
                )),
            Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1),
                child: const Text(
                  "86",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 29, 65, 133)),
                ))
          ]),
          Wrap(crossAxisAlignment: WrapCrossAlignment.start, children: [
            Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.15),
                child: const Text("%",
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
          ]),
        ]);
  }
}
