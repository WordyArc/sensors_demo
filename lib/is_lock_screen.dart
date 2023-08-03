import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:is_lock_screen/is_lock_screen.dart';

@RoutePage()
class IsLockScreen extends StatefulWidget {
  const IsLockScreen({super.key});

  @override
  _IsLockScreenState createState() => _IsLockScreenState();
}

class _IsLockScreenState extends State<IsLockScreen> with WidgetsBindingObserver {
  int counter = 0;
  int counterExit = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {
      print('app inactive, is lock screen: ${await isLockScreen()}');
      bool? status = await isLockScreen();
      setState(() {
        if (status == true) {
          counter++;
        } else {
          counterExit++;
        }
      });
    } else if (state == AppLifecycleState.resumed) {
      print('app resumed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Test by changing app lifecycle (locking device / exiting app). Result will be print in console.'),
              Text('Счетчик заблокированных $counter'),
              Text('Счетчик выходов $counterExit'),
            ],
          ),
        ),
      ),
    );
  }
}