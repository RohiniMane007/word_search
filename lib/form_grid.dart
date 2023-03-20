import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/wordsearch_cubit.dart';
import 'grid_data.dart';

class FormGrid extends StatefulWidget {
  const FormGrid({super.key, this.rowCount = 1, this.colCount = 1});
  final int rowCount, colCount;

  @override
  State<FormGrid> createState() => _FormGridState();
}

class _FormGridState extends State<FormGrid> {
  TextEditingController searchController = TextEditingController();
  late List<List<String>> gridCharList;

  @override
  void initState() {
    super.initState();
    gridCharList = List.generate(
        widget.rowCount, (i) => List.filled(widget.colCount, ""),
        growable: false);
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Grid Data"),
      ),
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: 400,
              height: MediaQuery.of(context).size.height - 350,
              child: GridView.builder(
                  itemCount: widget.rowCount * widget.colCount,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.colCount,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 20),
                  itemBuilder: buildGridItem),
            ),
            BlocBuilder<GridCubit, GridState>(
              builder: (context, state) {
                return Column(
                  children: [
                    state.readText
                        ? Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: 200,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<GridCubit>(context)
                                    .getValue(val: false);
                              },
                              child: const Text(
                                "Form Grid",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.zero,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.zero,
                                  width: 200,
                                  child: TextField(
                                    controller: searchController,
                                    decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(width: 0.5)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(width: 0.5))),
                                    onChanged: (value) {},
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: 200,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      BlocProvider.of<PatternCubit>(context)
                                          .wordMatch(
                                              rowCount: widget.rowCount,
                                              colCount: widget.colCount,
                                              word: searchController.text,
                                              gridCharList: gridCharList);
                                    },
                                    child: const Text(
                                      "Search",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: 200,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        gridCharList = [];
                                      });

                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const GridData()),
                                          (route) => false);
                                    },
                                    child: const Text(
                                      "Reset",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                  ],
                );
              },
            ),
          ],
        ),
      )),
    );
  }

  Widget buildGridItem(BuildContext context, int index) {
    int gridTotalLength = widget.colCount;
    int x, y = 0;
    x = (index / gridTotalLength).floor();
    y = (index % gridTotalLength);
    return GestureDetector(
      onTap: () => getIndexValue(x, y),
      child: Container(
        margin: const EdgeInsets.all(5),
        child: Align(
            alignment: Alignment.center,
            child: BlocBuilder<PatternCubit, PatternState>(
              builder: (context, state) {
                return buildTextField(
                    x: x, y: y, index: index, subGridItem: state.wordpattern);
              },
            )),
      ),
    );
  }

  Widget buildTextField(
      {required int x,
      required int y,
      int index = 0,
      List<List<String>>? subGridItem}) {
    return BlocBuilder<GridCubit, GridState>(
      builder: (context, state) {
        return TextFormField(
          readOnly: state.readText ? false : true,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
          ],
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              filled: true,
              fillColor: subGridItem?[x][y] != '' && subGridItem != null
                  ? Colors.blue
                  : state.readText
                      ? Colors.white
                      : Colors.blueGrey,
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 0.5)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 0.5)),
              contentPadding: const EdgeInsets.symmetric(vertical: 20)),
          onChanged: (value) {
            gridCharList[x][y] = value;
          },
        );
      },
    );
  }

  getIndexValue(int x, int y) {}
}
