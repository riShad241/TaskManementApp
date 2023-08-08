import 'package:flutter/material.dart';
class sumarreay_card extends StatelessWidget {
  const sumarreay_card({
    super.key, required this.title, required this.number,
  });
  final String title;
  final String number;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(number,style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),),
            Text(title)
          ],
        ),
      ),
    );
  }
}