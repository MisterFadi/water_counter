import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const counterName = "counter";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();

  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  void _loadCounter() async {
    final rememberedCounter = await prefs.getInt(counterName) ?? 0;
    setState(() {
      _counter = rememberedCounter;
    });
  }

  void _incrementCounter() async {
    setState(() {
      _counter++;
    });
    await prefs.setInt(counterName, _counter);
  }

  void _decrementCounter() async {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
    await prefs.setInt(counterName, _counter);
  }

  void _resetCounter() async {
    setState(() {
      _counter = 0;
    });

    await prefs.setInt(counterName, _counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8.0,
        title: const Text("WaterCounter"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Anzahl der Getränke"),
            Text(
              "$_counter",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 64),
            Padding(
              padding: EdgeInsets.only(left: 32.0, right: 32.0),
              child: WCButton(
                onPressed: _incrementCounter,
                text: "Trinken",
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.only(left: 32.0, right: 32.0),
              child: WCButton(
                onPressed: _decrementCounter,
                text: "Getränk entfernen",
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.only(left: 32.0, right: 32.0),
              child: WCButton(
                onPressed: _resetCounter,
                text: "Zähler zurücksetzen",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WCButton extends StatelessWidget {
  const WCButton({super.key, required this.onPressed, required this.text});

  final VoidCallback? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    // Make Button as wide as it can be.
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
