import 'package:flutter/material.dart';
import 'package:ivybaby_api/api/base/api_base.dart';
import 'package:ivybaby_api/api/config/api_config.dart';
import 'package:ivybaby_api/api/config/global_data.dart';

import 'package:ivybaby_api_example/util/extension.api.impls.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    GlobalData.appDevice.deviceNo = 'B4:F1:DA:B3:48:39';
    GlobalData.appDevice.uuid = '19d430e3-08dd-4a38-9dc9-e829f87bb28f';
    GlobalData.appDevice.loginType = '5';
    ApiConfig.inst.init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Example app'),
        ),
        body: Center(
            child: GestureDetector(
              onTap: () {
                ApiUtils.inst.identityAuth('', '');
              },
              child: Text('Flutter api gen'),
            ),
        ),
      ),
    );
  }
}
