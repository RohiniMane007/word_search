import 'package:flutter_bloc/flutter_bloc.dart';

part 'wordsearch_state.dart';

class PatternCubit extends Cubit<PatternState> {
  PatternCubit() : super(PatternState());
  void wordMatch(
      {required int rowCount,
      required int colCount,
      required String word,
      required List<List<String>> gridCharList}) {
    List<List<String>> subStr = [], newList = [];
    subStr = List.generate(rowCount, (i) => List.filled(colCount, ""),
        growable: false);
    newList = List.generate(rowCount, (i) => List.filled(colCount, ""),
        growable: false);

//--------------Horizontlly----------------//
    for (int i = 0; i < rowCount; ++i) {
      int max =
          gridCharList[i].sublist(0, colCount).join().length - word.length + 1;

      for (int j = 0; j < max; j++) {
        bool flag = true;
        String pattern = word;

        for (int p = 0; p < pattern.length && flag == true; p++) {
          if (pattern[p] !=
              gridCharList[i].sublist(0, colCount).join()[p + j]) {
            flag = false;
          } else {
            subStr[i][j + p] =
                gridCharList[i].sublist(0, colCount).join()[p + j];
          }
        }
        if (flag == true) {
          if (pattern == subStr[i].join()) {
            newList[i] = subStr[i];
          }
        }
      }
    }

    emit(PatternState(wordpattern: newList));
  }
}

class GridCubit extends Cubit<GridState> {
  GridCubit() : super(GridState());
  void getValue({required bool val}) {
    if (val == false) {
      emit(GridState(readText: val));
    }
  }
}
