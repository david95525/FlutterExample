import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_example/models/weather/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  static const String authorizationkey =
      String.fromEnvironment('authorization_key');

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather API Sample'),
      ),
      body: const Center(
        child: Text(
          "",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  void fetchData() async {
    if (authorizationkey.isEmpty) {
      throw AssertionError('TMDB_KEY is not set');
    }
    const timeout = Duration(seconds: 10);
    var url =
        Uri.https('opendata.cwa.gov.tw', '/api/v1/rest/datastore/F-D0047-063', {
      'Authorization': authorizationkey,
      'format': 'JSON',
      'locationName': '南港區',
      'elementName': 'MinT,MaxT,PoP12h,T,Wx,WeatherDescription',
      'sort': 'time',
      'timeFrom': '2024-02-08T00:00:00',
      'timeTo': '2024-02-09T00:00:00'
    });
    var response = await http.get(url).timeout(timeout);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonmap = jsonDecode(response.body);

      int temp = jsonmap['records']['locations'][0]['location'][0]
          ['weatherElement'][1]['time'][0]['elementValue'][0]['value'] as int;
      debugPrint(temp.toString());
    } else {
      throw Exception();
    }
  }
}
