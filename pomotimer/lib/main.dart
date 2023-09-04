import 'package:flutter/material.dart';
import 'package:pomotimer/widgets/time_button.dart';
import 'dart:async';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _App();
}

class _App extends State<App> {
  static const t15 = 900;
  static const t20 = 1200;
  static const t25 = 1500;
  static const t30 = 1800;
  static const t35 = 2100;
  bool select15 = false;
  bool select20 = false;
  bool select25 = false;
  bool select30 = false;
  bool select35 = false;
  bool isRunning = false;
  int round = 0;
  int goal = 0;
  late int totalSeconds = t25;
  late Timer timer;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        round = round + 1;
        if (round == 4) {
          round = 0;
        }
        goal = goal + 1;
        isRunning = false;
        totalSeconds = 300;
        onStartPressed();
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  void onStartPressed() {
    isRunning = true;
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void initSelect(int selected) {
    switch (selected) {
      case 15:
        setState(() {
          select15 = true;
          select20 = false;
          select25 = false;
          select30 = false;
          select35 = false;
          totalSeconds = t15;
        });
        break;
      case 20:
        setState(() {
          select15 = false;
          select20 = true;
          select25 = false;
          select30 = false;
          select35 = false;
          totalSeconds = t20;
        });
        break;
      case 25:
        setState(() {
          select15 = false;
          select20 = false;
          select25 = true;
          select30 = false;
          select35 = false;
          totalSeconds = t25;
        });
        break;
      case 30:
        setState(() {
          select15 = false;
          select20 = false;
          select25 = false;
          select30 = true;
          select35 = false;
          totalSeconds = t30;
        });
        break;
      case 35:
        setState(() {
          select15 = false;
          select20 = false;
          select25 = false;
          select30 = false;
          select35 = true;
          totalSeconds = t35;
        });
        break;
    }
  }

  String minFormat(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(2, 4);
  }

  String secFormat(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(5, 7);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.red,
      body: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 40,
              ),
              Text(
                'POMOTIMER',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      child: Text(
                        minFormat(totalSeconds),
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 70,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Text(
                    ':',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 70,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      child: Text(
                        secFormat(totalSeconds),
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 70,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => initSelect(15),
                child: TimeButton(
                  time: minFormat(t15),
                  bgColor: select15 ? Colors.white : Colors.red,
                  timeColor: select15 ? Colors.red : Colors.white,
                ),
              ),
              TextButton(
                onPressed: () => initSelect(20),
                child: TimeButton(
                  time: minFormat(t20),
                  bgColor: select20 ? Colors.white : Colors.red,
                  timeColor: select20 ? Colors.red : Colors.white,
                ),
              ),
              TextButton(
                onPressed: () => initSelect(25),
                child: TimeButton(
                  time: minFormat(t25),
                  bgColor: select25 ? Colors.white : Colors.red,
                  timeColor: select25 ? Colors.red : Colors.white,
                ),
              ),
              TextButton(
                onPressed: () => initSelect(30),
                child: TimeButton(
                  time: minFormat(t30),
                  bgColor: select30 ? Colors.white : Colors.red,
                  timeColor: select30 ? Colors.red : Colors.white,
                ),
              ),
              TextButton(
                onPressed: () => initSelect(35),
                child: TimeButton(
                  time: minFormat(t35),
                  bgColor: select35 ? Colors.white : Colors.red,
                  timeColor: select35 ? Colors.red : Colors.white,
                ),
              ),
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: IconButton(
                iconSize: 120,
                onPressed: isRunning ? onPausePressed : onStartPressed,
                icon: Icon(isRunning ? Icons.pause_circle : Icons.play_circle),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      '$round/4',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'ROUND',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '$goal/12',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'GOAL',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
