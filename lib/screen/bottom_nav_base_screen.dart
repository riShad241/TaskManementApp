import 'package:flutter/material.dart';
import 'package:real_todo/screen/Cancle_screen.dart';
import 'package:real_todo/screen/Complete.dart';
import 'package:real_todo/screen/New_Task_screen.dart';
import 'package:real_todo/screen/in_progress.dart';
class BottomNavbaseScreen extends StatefulWidget {
  const BottomNavbaseScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavbaseScreen> createState() => _BottomNavbaseScreenState();
}

class _BottomNavbaseScreenState extends State<BottomNavbaseScreen> {
  int _selectedScreen = 0;
  final List<Widget> _Screen = const[
    NewTaskScreen(),
    In_progress(),
    Cancle(),
    Complete(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_Screen[_selectedScreen] ,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreen,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: TextStyle(
          color: Colors.grey
        ),
        selectedItemColor: Colors.green,
        showUnselectedLabels: true,
        onTap: (int index){
          _selectedScreen = index;
          if(mounted){
            setState(() {

            });
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit),label: 'New'),
          BottomNavigationBarItem(icon: Icon(Icons.account_tree),label: 'In Progrees'),
          BottomNavigationBarItem(icon: Icon(Icons.cancel_outlined),label: 'Cancel'),
          BottomNavigationBarItem(icon: Icon(Icons.done_all),label: 'Completed'),
        ],
      ),
    );
  }
}
