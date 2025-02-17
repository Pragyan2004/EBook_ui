import 'package:flutter/material.dart';

class AppTab extends StatelessWidget {
final Color color;
final String text;
  const AppTab({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width:120,
      height: 50,
      child: Text(this.text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: this.color,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
            )
          ]
      ),
    );

  }
}
