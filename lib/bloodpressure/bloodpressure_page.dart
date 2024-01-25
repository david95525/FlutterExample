import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_example/models/response_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_example/models/bloodpressure_model.dart';

class BloodPressurePage extends StatefulWidget {
  const BloodPressurePage({Key? key}) : super(key: key);

  @override
  State<BloodPressurePage> createState() => _BloodPressurePageState();
}

class _BloodPressurePageState extends State<BloodPressurePage> {
  ResponseModel? responsedata;
  late List<BloodPressureModel> bpmdata;

  @override
  void initState() {
    super.initState();
    bpmdata = <BloodPressureModel>[];
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        widthFactor: MediaQuery.of(context).size.width,
        child: DataTable(
            columnSpacing: 0,
            columns: <DataColumn>[
              DataColumn(
                  label: SizedBox(
                width: MediaQuery.of(context).size.width / 6,
                child: const Text('Date Time'),
              )),
              DataColumn(
                  label: SizedBox(
                width: MediaQuery.of(context).size.width / 6,
                child: const Text('Systolic(mmHg)'),
              )),
              DataColumn(
                  label: SizedBox(
                width: MediaQuery.of(context).size.width / 6,
                child: const Text('Diastolic(mmHg)'),
              )),
              DataColumn(
                  label: SizedBox(
                width: MediaQuery.of(context).size.width / 6,
                child: const Text('Pulse (bpm)'),
              )),
              DataColumn(
                  label: SizedBox(
                width: MediaQuery.of(context).size.width / 6,
                child: const Text('Mode'),
              )),
              DataColumn(
                  label: SizedBox(
                width: MediaQuery.of(context).size.width / 6,
                child: const Text('Irregular Pulse'),
              )),
            ],
            rows: List<DataRow>.generate(
                bpmdata.length,
                (index) => DataRow(
                        color: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                          if (index.isEven) {
                            return Colors.grey.withOpacity(0.3);
                          }
                          return null;
                        }),
                        cells: <DataCell>[
                          DataCell(SizedBox(
                              width: (MediaQuery.of(context).size.width / 6),
                              child:
                                  Text(bpmdata[index].updateDate.toString()))),
                          DataCell(SizedBox(
                              width: (MediaQuery.of(context).size.width / 6),
                              child: Text(bpmdata[index].sys.toString()))),
                          DataCell(SizedBox(
                              width: (MediaQuery.of(context).size.width / 6),
                              child: Text(bpmdata[index].dia.toString()))),
                          DataCell(SizedBox(
                              width: (MediaQuery.of(context).size.width / 6),
                              child: Text(bpmdata[index].pul.toString()))),
                          DataCell(SizedBox(
                              width: (MediaQuery.of(context).size.width / 6),
                              child: Text(bpmdata[index].mode == 0
                                  ? "-"
                                  : (bpmdata[index].mode == 1
                                      ? "AFIB"
                                      : (bpmdata[index].mode == 2
                                          ? "MAM"
                                          : "MAM(AFIB)"))))),
                          DataCell(SizedBox(
                              width: (MediaQuery.of(context).size.width / 6),
                              child: Text(bpmdata[index].afib.toString()))),
                        ]))));
  }

  void getData() async {
    var response = await http.get(Uri.https(
        'flutterexample.azurewebsites.net', '/api/BloodPressure/Get'));
    if (response.statusCode == 200) {
      setState(() {
        responsedata = ResponseModel.fromJson(jsonDecode(response.body));
        bpmdata = responsedata?.bpmData ?? [];
      });
    }
  }
}
