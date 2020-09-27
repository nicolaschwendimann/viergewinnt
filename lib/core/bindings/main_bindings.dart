import 'package:get/get.dart';
import 'package:viergewinnt/controllers/game_controller.dart';

class MainBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GameController>(() => GameController());
  }
}
