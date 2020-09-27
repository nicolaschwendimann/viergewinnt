import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viergewinnt/core/bindings/main_bindings.dart';
import 'screens/game_screen/game_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: MainBindings(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => GameScreen()),
      ],
    );
  }
}
