import 'package:flutter/material.dart';
import 'package:flutter_example/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  /// 初始化的資料，之後請求到資料後，存在這裡。
  WeatherModel? apidata;

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
      body: Center(
        child: Text(
          apidata == null ? "" : apidata.toString(),
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  void fetchData() async {
    String authorization = 'CWB-A00E9F9E-26D6-4005-B2F7-E8E7B6CEF5DA';
    const timeout = Duration(seconds: 10);
    var url =
        Uri.https('opendata.cwa.gov.tw', '/api/v1/rest/datastore/F-D0047-063', {
      'Authorization': authorization,
      'format': 'JSON',
      'locationName': '南港區',
      'elementName': 'MinT,MaxT,PoP12h,T,Wx,WeatherDescription',
      'sort': 'time',
      'timeFrom': '2024-01-23T00:00:00',
      'timeTo': '2024-01-24T00:00:00'
    });
    var response = await http.get(url).timeout(timeout);
    if (response.statusCode == 200) {
      debugPrint(response.body.toString());
    } else {
      throw Exception();
    }
  }
}
