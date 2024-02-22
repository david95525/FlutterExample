import 'package:flutter/material.dart';
import 'package:flutter_example/widgets/custom_board.dart';

class BodyTemperatureBoard extends StatelessWidget {
  const BodyTemperatureBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBoard(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.2,
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.02,
            top: MediaQuery.of(context).size.height * 0.02),
        color: Colors.white,
        children: [
          Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 10),
              child: const Icon(
                Icons.thermostat,
                size: 50,
                color: Color.fromARGB(255, 29, 65, 133),
              )),
          Container(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: const Text("Body Temperature",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ),
          Container(
              padding: EdgeInsets.only(left: 10),
              child: const Text(
                "97 °F",
                style: TextStyle(fontSize: 30),
              ))
        ]);
  }
}
