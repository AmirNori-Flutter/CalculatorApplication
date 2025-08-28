import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> history = [];
List<String> data = [];

final GrammarParser parser = GrammarParser();
final RealEvaluator evaluator = RealEvaluator();

class Buttonseet extends StatefulWidget {
  const Buttonseet({super.key});

  @override
  State<Buttonseet> createState() => _ButtonseetState();
}

class _ButtonseetState extends State<Buttonseet> {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setModalState) {
        return Container(
          padding: EdgeInsets.all(25),
          height: 500,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "History",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.remove("MyKey");
                      setState(() {
                        history.clear();
                        data.clear();
                      });
                      setModalState(() {
                        data.clear();
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child:
                    data.isEmpty
                        ? Center(
                          child: Text(
                            "No Data",
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                        : ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                data[index],
                                style: TextStyle(fontSize: 20),
                              ),
                            );
                          },
                        ),
              ),
            ],
          ),
        );
      },
    );
  }
}
