import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_search/cubit/wordsearch_cubit.dart';
import 'package:word_search/form_grid.dart';

class GridData extends StatefulWidget {
  const GridData({super.key});

  @override
  State<GridData> createState() => _GridDataState();
}

class _GridDataState extends State<GridData> {
  TextEditingController rows = TextEditingController();
  TextEditingController col = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    rows.dispose();
    col.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Word Search"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              width: 200,
              child: TextFormField(
                controller: rows,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    hintText: "Enter Rows",
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide(width: 0.5)),
                    focusedBorder:
                        OutlineInputBorder(borderSide: BorderSide(width: 0.5))),
                onChanged: (value) {},
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              width: 200,
              child: TextFormField(
                controller: col,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    hintText: "Enter Column",
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide(width: 0.5)),
                    focusedBorder:
                        OutlineInputBorder(borderSide: BorderSide(width: 0.5))),
                onChanged: (value) {},
              ),
            ),
            Container(
              width: 200,
              height: 50,
              margin: const EdgeInsets.only(top: 30),
              child: ElevatedButton(
                  onPressed: () {
                    int rowCount = int.parse(rows.text);
                    int colCount = int.parse(col.text);

                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MultiBlocProvider(
                        providers: [
                          BlocProvider<PatternCubit>(
                            create: (BuildContext context) => PatternCubit(),
                          ),
                          BlocProvider<GridCubit>(
                            create: (BuildContext context) => GridCubit(),
                          ),
                        ],
                        child: FormGrid(
                          rowCount: rowCount,
                          colCount: colCount,
                        ),
                      ),
                    ));
                  },
                  child: const Text(
                    "Next",
                    style: TextStyle(fontSize: 16),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
