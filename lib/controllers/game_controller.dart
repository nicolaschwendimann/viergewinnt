import 'package:get/get.dart';
import 'package:viergewinnt/screens/game_screen/widgets/cell.dart';

class GameController extends GetxController {
  RxList<List<int>> _board = RxList<List<int>>();
  List<List<int>> get board => _board.value;
  set board(List<List<int>> value) => _board.value = value;

  RxBool _turnYellow = true.obs;
  bool get turnYellow => _turnYellow.value;

  void _buildBoard() {
    _turnYellow.value = true;
    board = [
      List.filled(6, 0),
      List.filled(6, 0),
      List.filled(6, 0),
      List.filled(6, 0),
      List.filled(6, 0),
      List.filled(6, 0),
      List.filled(6, 0),
    ];
    update();
  }

  @override
  void onInit() {
    super.onInit();
    _buildBoard();
  }

  void playColumn(int columnNumber) {
    final int playerNumber = turnYellow ? 1 : 2;
    final selectedColumn = board[columnNumber];
    if (selectedColumn.contains(0)) {
      final int rowIndex = selectedColumn.indexWhere((cell) => cell == 0);
      selectedColumn[rowIndex] = playerNumber;
      _turnYellow.value = !_turnYellow.value;
      update();

      int resultHorizontal = checkHorizontals();
      int resultVertical = checkVerticals();

      if (resultHorizontal == 1 || resultVertical == 1) {
        Get.defaultDialog(
          title: 'Gelb Gewinnt',
          content: Cell(
            currentCellMode: cellMode.YELLOW,
          ),
        ).then((value) => _buildBoard());
      } else if (resultHorizontal == 2 || resultVertical == 2) {
        Get.defaultDialog(
          title: 'Rot Gewinnt',
          content: Cell(
            currentCellMode: cellMode.RED,
          ),
        ).then((value) => _buildBoard());
      }
    } else {
      Get.snackbar(
          'ungültiger Zug', 'Diese Spalte ist bereits voll. Wähle eine andere!',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  int checkHorizontals() {
    int yellowInARow = 0;
    int redInARow = 0;
    List<List<int>> rows = [];

    for (var i = 0; i < 6; i++) {
      final List<int> currentRow = getRowList(i);
      rows.add(currentRow);
    }

    for (final row in rows) {
      for (final cell in row) {
        if (yellowInARow >= 4) {
          return 1;
        } else if (redInARow >= 4) {
          return 2;
        } else {
          if (cell == 1) {
            yellowInARow++;
            redInARow = 0;
          } else if (cell == 2) {
            redInARow++;
            yellowInARow = 0;
          } else {
            yellowInARow = 0;
            redInARow = 0;
          }
        }
      }
    }
    return 0;
  }

  List<int> getRowList(int rowNumber) {
    List<int> rowList = [];
    for (final column in board) {
      rowList.add(column[rowNumber]);
    }
    return rowList;
  }

  int checkVerticals() {
    int yellowInARow = 0;
    int redInARow = 0;

    for (final column in board) {
      for (final cell in column) {
        if (yellowInARow >= 4) {
          return 1;
        } else if (redInARow >= 4) {
          return 2;
        } else {
          if (cell == 1) {
            yellowInARow++;
            redInARow = 0;
          } else if (cell == 2) {
            redInARow++;
            yellowInARow = 0;
          } else {
            yellowInARow = 0;
            redInARow = 0;
          }
        }
      }
    }
    return 0;
  }
}
