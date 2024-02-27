import 'package:flutter/material.dart';
import 'package:flutter_example/pages/dashboard/boards/bloodglucose_board.dart';
import 'package:flutter_example/pages/dashboard/boards/bloodpressure_board.dart';
import 'package:flutter_example/pages/dashboard/boards/bodytemperature_board.dart';
import 'package:flutter_example/pages/dashboard/boards/oxygen_board.dart';
import 'package:flutter_example/pages/dashboard/boards/pain_board.dart';
import 'package:flutter_example/pages/dashboard/boards/user_board.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Wrap(children: [
          const UserBoard(),
          const BodyTemperatureBoard(),
          const BloodpressureBoard(),
          const OxygenBoard(),
          const BloodglucoseBoard(),
          const PainBoard(),
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05,left:MediaQuery.of(context).size.width * 0.05 ),
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.1,
            child: TextButton(
              onPressed: () => debugPrint("save"),
              style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 29, 65, 133)),
              child: const Text('Save', style: TextStyle(color: Colors.white,fontSize: 30)),
            ),
          )
        ])
      ]),
    );
  }
}
