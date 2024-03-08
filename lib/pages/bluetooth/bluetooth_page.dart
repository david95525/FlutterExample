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
  List<String> buttonTextList = [];
  List<String> nameList = [];
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
              Expanded(
                child: ListView.builder(
                  itemCount: deviceList.length,
                  itemBuilder: (context, index) {
                    final item = deviceList[index];
                    return ListTile(
                      title: Text(item.id),
                      subtitle: Text(item.name),
                      trailing: Wrap(
                        children: [
                          ElevatedButton(
                            key: const Key('connect'),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                backgroundColor:
                                    buttonTextList[index] == "Connect"
                                        ? Colors.white70
                                        : Colors.lightGreen),
                            onPressed: () => buttonTextList[index] == "Connect"
                                ? _connectDevice(index)
                                : _disconnectDevice(index),
                            child: Text(buttonTextList[index]),
                          ),
                          ElevatedButton(
                            key: const Key('find'),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                backgroundColor: Colors.lightBlue),
                            onPressed: () => _discoverServices(index),
                            child: const Text("Find",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
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
      if (device.name.isNotEmpty && !nameList.contains(device.name)) {
        buttonTextList.add("Connect");
        nameList.add(device.name);
        setState(() {
          deviceList.add(device);
        });
      }
      if (deviceList.length >= 5) {
        _streamSubscription?.cancel();
      }
    }, onError: (e) {
      debugPrint("onError = $e");
    });
  }

  void _connectDevice(int index) {
    debugPrint(index.toString());
    DiscoveredDevice device = deviceList[index];
    _connectionStreamSubscription = flutterReactiveBle
        .connectToDevice(
      id: device.id,
      servicesWithCharacteristicsToDiscover: {},
      connectionTimeout: const Duration(seconds: 3),
    )
        .listen((connectionState) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      if (connectionState.connectionState == DeviceConnectionState.connecting) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [CircularProgressIndicator(), Text("Connecting...")],
          ),
          backgroundColor: Colors.grey,
        ));
      }
      if (connectionState.connectionState == DeviceConnectionState.connected) {
        setState(() {
          buttonTextList[index] = "Disconnect";
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [CircularProgressIndicator(), Text("Connect Success")],
          ),
          backgroundColor: Colors.green,
        ));
        Timer(const Duration(seconds: 1), () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        });
      }
      if (connectionState.connectionState ==
          DeviceConnectionState.disconnected) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [CircularProgressIndicator(), Text("Connect Fail")],
          ),
          backgroundColor: Colors.grey,
        ));
        Timer(const Duration(seconds: 1), () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        });
      }
    }, onError: (Object error) {
      debugPrint("error1 =$error");
    });
  }

  void _disconnectDevice(int index) {
    setState(() {
      buttonTextList[index] = "Connect";
    });
    _connectionStreamSubscription?.cancel();
  }

  _discoverServices(int index) async {
    DiscoveredDevice device = deviceList[index];
    List<Service> serviceList =
        await flutterReactiveBle.getDiscoveredServices(device.id);
    debugPrint("services=$serviceList");
    debugPrint(
        "deviceId:${serviceList[0].characteristics[0].service.deviceId}");
    for (int i = 0; i < serviceList.length; i++) {
      Service discoveredService = serviceList[i];
      for (int i = 0; i < discoveredService.characteristics.length; i++) {
        debugPrint(
            "uuid:${discoveredService.characteristics[i].service.id.toString()}");
      }
    }
  }

  void _qualifiedCharacteristic(
      Uuid serviceId, Uuid characteristicId, String deviceId) async {
    final characteristic = QualifiedCharacteristic(
        serviceId: serviceId,
        characteristicId: characteristicId,
        deviceId: deviceId);
    flutterReactiveBle.subscribeToCharacteristic(characteristic).listen((data) {
      debugPrint("data = $data");
    }, onError: (dynamic error) {});
    //Read characteristic
    final response =
        await flutterReactiveBle.readCharacteristic(characteristic);
    //Write with response
    await flutterReactiveBle
        .writeCharacteristicWithResponse(characteristic, value: [0x00]);
    //Write without response
    await flutterReactiveBle
        .writeCharacteristicWithoutResponse(characteristic, value: [0x00]);
    //Negotiate MTU size
    final mtu =
        await flutterReactiveBle.requestMtu(deviceId: deviceId, mtu: 250);

    /**Android specific operations**/
    //Request connection priority
    //Be cautious when setting the priority when communicating with multiple devices because
    //if you set highperformance for all devices the effect of increasing the priority will be lower
    await flutterReactiveBle.requestConnectionPriority(
        deviceId: deviceId, priority: ConnectionPriority.highPerformance);
    //Clear GATT cache
    await flutterReactiveBle.clearGattCache(deviceId);
  }
}
