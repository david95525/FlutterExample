import 'package:flutter/material.dart';
import 'package:flutter_example/widgets/custom_board.dart';

class UserBoard extends StatelessWidget {
  const UserBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBoard(
        width: MediaQuery.of(context).size.width * 0.81,
        height: MediaQuery.of(context).size.height * 0.2,
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.02,
            right: MediaQuery.of(context).size.width * 0.02,
            top: MediaQuery.of(context).size.height * 0.02),
        color: const Color.fromARGB(255, 200, 245, 253),
        children: [
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
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.02,
                  right: MediaQuery.of(context).size.width * 0.02),
              child: const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("2023-02-21 22:45"),
                    Text(
                      "Jack Beasley",
                      style:
                          TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
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
              padding: const EdgeInsets.only(right: 10),
              height: MediaQuery.of(context).size.height * 0.2,
              child: const VerticalDivider(color: Colors.grey, thickness: 1)),
          Container(
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
                      "178 cm",
                      style: TextStyle(fontSize: 30),
                    )
                  ])),
          Container(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.2,
                  right: MediaQuery.of(context).size.width * 0.02),
              child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.people,
                      size: 50,
                      color: Color.fromARGB(255, 29, 65, 133),
                    ),
                    Text(
                      "Weight",
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      "158 lb",
                      style: TextStyle(fontSize: 30),
                    )
                  ]))
        ]);
  }
}
