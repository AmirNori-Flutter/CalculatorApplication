import 'package:calculator/Widget/button.dart';
import 'package:calculator/Widget/buttonseet.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userinput = "";
  String answer = "0";

  List<String> buttonCharacter = [
    'C',
    '%',
    '⌫',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '00',
    '0',
    '.',
    '=',
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Load history from SharedPreferences
  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    history = prefs.getStringList("MyKey") ?? [];
    data = List.from(history);
    setState(() {});
  }

  // Save history to SharedPreferences
  void _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final record = "$userinput = $answer";
    if (history.isEmpty || history.last != record) {
      history.add(record);
      await prefs.setStringList("MyKey", history);
      setState(() {
        data = List.from(history);
      });
    }
  }

  bool isOperator(String text) {
    return ['/', '%', 'C', '⌫', 'x', '-', '+', '='].contains(text);
  }

  Color getButtonColor(bool isDark, String text) {
    if (isOperator(text)) {
      return isDark ? Colors.white : Colors.black;
    } else {
      return isDark ? Colors.black : Colors.white;
    }
  }

  Color getTextColor(bool isDark, String text) {
    if (isOperator(text)) {
      return isDark ? Colors.black : Colors.white;
    } else {
      return isDark ? Colors.white : Colors.black;
    }
  }

  void calculate() {
    if (userinput.isEmpty) return;
    String result = userinput.replaceAll('x', '*');
    final exp = parser.parse(result);
    final resNum = evaluator.evaluate(exp);
    answer = resNum.toString();
    _saveData();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, right: 25),
            child: Align(
              alignment: Alignment.topRight,
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap:
                    () => showModalBottomSheet(
                      context: context,
                      builder: (_) => Buttonseet(),
                    ),
                child: Icon(
                  Icons.history_rounded,
                  color: isDark ? Colors.white : Colors.black,
                  size: 35,
                ),
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 25,
                  ),
                  alignment: Alignment.centerRight,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerRight,
                    child: Text(
                      userinput,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  alignment: Alignment.centerRight,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerRight,
                    child: Text(
                      answer,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Color(0xFF827A7A), height: 0.5),

          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: buttonCharacter.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (context, index) {
                  final text = buttonCharacter[index];

                  void onTap() {
                    setState(() {
                      if (text == 'C') {
                        userinput = "";
                        answer = "0";
                      } else if (text == '⌫') {
                        if (userinput.isNotEmpty) {
                          userinput = userinput.substring(
                            0,
                            userinput.length - 1,
                          );
                        }
                      } else if (text == '=') {
                        calculate();
                      } else {
                        userinput += text;
                      }
                    });
                  }

                  return ButtonWidget(
                    buttonclick: onTap,
                    buttontext: text,
                    color: getButtonColor(isDark, text),
                    textcolor: getTextColor(isDark, text),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
