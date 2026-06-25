import 'package:flutter/material.dart';

class Lineorline extends StatelessWidget {
  const Lineorline({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 450,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left:10, right:10, top: 20),
              child: Divider(
                thickness: 2,
              ), 
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text("or",
              style: TextStyle(
                fontSize: 18
              ),
            )
          ),
          Expanded(
            child :Container(
              margin: EdgeInsets.only(left: 10, right:10, top: 20),
              child: Divider(
                thickness: 2
              ),
            )
          )
        ],
      )
    );
  }
}