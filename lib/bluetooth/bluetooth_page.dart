import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({super.key});

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  final flutterReactiveBle = FlutterReactiveBle();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String deviceid = "";
  @override
  void initState() {
    super.initState();
    _scanDevice();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("deviceid:$deviceid",
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.left),
              ElevatedButton(
                key: const Key('saveButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () => _scanDevice(),
                child: const Text('scan'),
              ),
            ],
          ),
        ));
  }
  void _scanDevice() {
    flutterReactiveBle.scanForDevices(
        withServices: [], scanMode: ScanMode.lowLatency).listen((device) {
      deviceid = device.id;
    }, onError: (err) {});
  }
}
