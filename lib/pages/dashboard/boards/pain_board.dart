import 'package:flutter/material.dart';
import 'package:flutter_example/widgets/custom_board.dart';

class PainBoard extends StatelessWidget {
  const PainBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBoard(
        width: MediaQuery.of(context).size.width * 0.64,
        height: MediaQuery.of(context).size.height * 0.2,
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.02,
            top: MediaQuery.of(context).size.height * 0.02),
        color: Colors.white,
        children: [
          Container(
              padding: const EdgeInsets.only(top: 10),
              child: const Text(
                "Pain Level",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              )),
          Container(
              margin: const EdgeInsets.only(left: 10),
              height: 20,
              child: Row(
                children: [
                  TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          )),
                      child: const Text("0")),
                  Container(
                      margin: EdgeInsets.zero,
                      width: 1,
                      height: 20,
                      child: const VerticalDivider(
                          color: Colors.grey, thickness: 1)),
                  TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          )),
                      child: const Text("1")),
                  Container(
                      margin: EdgeInsets.zero,
                      width: 1,
                      height: 20,
                      child: const VerticalDivider(
                          color: Colors.grey, thickness: 1)),
                  TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          )),
                      child: const Text("2")),
                  Container(
                      margin: EdgeInsets.zero,
                      width: 1,
                      height: 20,
                      child: const VerticalDivider(
                          color: Colors.grey, thickness: 1)),
                  TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          )),
                      child: const Text("3")),
                  Container(
                      margin: EdgeInsets.zero,
                      width: 1,
                      height: 20,
                      child: const VerticalDivider(
                          color: Colors.grey, thickness: 1)),
                  TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          )),
                      child: const Text("4")),
                ],
              )),
        ]);
  }
}
