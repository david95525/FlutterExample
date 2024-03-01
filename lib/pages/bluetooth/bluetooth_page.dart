import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({super.key});

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  StreamSubscription<DiscoveredDevice>? _streamSubscription;
  StreamSubscription<ConnectionStateUpdate>? _connectionStreamSubscription;
  List<DiscoveredDevice> deviceList = [];
  List<String> idList = [];
  final flutterReactiveBle = FlutterReactiveBle();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String deviceid = "";
  @override
  void initState() {
    super.initState();
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
              ElevatedButton(
                key: const Key('show'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () => {_showDevice()},
                child: const Text('show'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: deviceList.length,
                  itemBuilder: (context, index) {
                    final item = deviceList[index];
                    return ListTile(
                      title: Text(item.id),
                      subtitle: Text(item.name),
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }

  void _scanDevice() {
    _streamSubscription = flutterReactiveBle.scanForDevices(
        withServices: [], scanMode: ScanMode.lowLatency).listen((device) {
      if (device.id == "C8:58:C0:5F:A7:61") {
        idList.add(device.id);
        setState(() {
          deviceList.add(device);
        });
        _streamSubscription?.cancel();
      }
    }, onError: (e) {
      debugPrint("onError = $e");
    });

    // if (deviceList.isNotEmpty) {
    //   DiscoveredDevice device = deviceList[0];
    //   _connectionStreamSubscription = flutterReactiveBle
    //       .connectToDevice(
    //     id: device.id,
    //     servicesWithCharacteristicsToDiscover: {},
    //     connectionTimeout: const Duration(seconds: 3),
    //   )
    //       .listen((connectionState) {
    //     if (connectionState.connectionState ==
    //         DeviceConnectionState.connected) {
    //       debugPrint(" connectionState=${connectionState.deviceId}");
    //     }
    //   }, onError: (Object error) {
    //     debugPrint("error1 =$error");
    //   });
    //   _connectionStreamSubscription?.cancel();
    // }
  }

  void _showDevice() {
    debugPrint(deviceList.length.toString());
    for (int i = 0; i < deviceList.length; i++) {
      debugPrint(deviceList[i].id);
    }
  }
}
