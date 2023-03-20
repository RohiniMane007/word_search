part of 'wordsearch_cubit.dart';

class PatternState {
  List<List<String>>? wordpattern;
  PatternState({this.wordpattern});
}

class GridState {
  bool readText;
  GridState({this.readText = true});
}
