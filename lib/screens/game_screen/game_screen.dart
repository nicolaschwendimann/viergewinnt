import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viergewinnt/controllers/game_controller.dart';
import 'widgets/game_body.dart';

class GameScreen extends StatelessWidget {
  final GameController gameController = Get.find<GameController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Obx(() => Text(
              gameController.turnYellow
                  ? 'Am Zug: Spieler Gelb'
                  : 'Am Zug: Spieler Rot',
              style: TextStyle(
                  color: gameController.turnYellow
                      ? Colors.yellow
                      : Colors.red[100]))),
        ),
        body: GameBody());
  }
}
