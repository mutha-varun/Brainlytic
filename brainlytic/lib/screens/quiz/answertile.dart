import 'package:flutter/material.dart';

class Answertile extends StatelessWidget {
  
  const Answertile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
      height: 85,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(45),
          ),
          
        ),
        onPressed: () {
          // Handle answer selection

        },
        child: Text(
          "Sample Answer",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}