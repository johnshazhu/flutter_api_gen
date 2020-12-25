import 'package:flutter/material.dart';
import 'package:ivybaby_api/api/base/api_base.dart';
import 'package:ivybaby_api/api/config/api_config.dart';

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
