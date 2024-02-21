import 'package:flutter/material.dart';

Widget UserBoard(context) {
  return Card(
      margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.02,
          right: MediaQuery.of(context).size.width * 0.02,
          top: MediaQuery.of(context).size.height * 0.02),
      color: const Color.fromARGB(255, 200, 245, 253),
      child: Row(children: [
        Container(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
          child: Icon(
            Icons.people,
            size: MediaQuery.of(context).size.height * 0.2,
            color: const Color.fromARGB(255, 29, 65, 133),
          ),
        ),
        Container(
            height: MediaQuery.of(context).size.height * 0.2,
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.02,
                right: MediaQuery.of(context).size.width * 0.15),
            child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("2023-02-21 22:45"),
                  Text(
                    "Jack Beasley",
                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Age:83                Main/02",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    "Male",
                    style: TextStyle(fontSize: 25),
                  )
                ])),
        Container(
            height: MediaQuery.of(context).size.height * 0.2,
            padding: const EdgeInsets.only(right: 10),
            child: const VerticalDivider(color: Colors.grey, thickness: 1)),
        Container(
            height: MediaQuery.of(context).size.height * 0.2,
            padding: const EdgeInsets.all(0),
            child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.people,
                    size: 50,
                    color: Color.fromARGB(255, 29, 65, 133),
                  ),
                  Text(
                    "height",
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    "178",
                    style: TextStyle(fontSize: 30),
                  )
                ])),
        Container(
            height: MediaQuery.of(context).size.height * 0.2,
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
            child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.thermostat,
                    size: 50,
                    color: Color.fromARGB(255, 29, 65, 133),
                  ),
                  Text(
                    "bloodpressure",
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    "120",
                    style: TextStyle(fontSize: 30),
                  )
                ]))
      ]));
}
