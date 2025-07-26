import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class QuizTopicsTemplates extends StatelessWidget {
  final Color color;
  final String title;

  const QuizTopicsTemplates(
    {
      super.key,
      required this.color,
      required this.title,
    }
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: color.withValues(alpha: 2),
            ),
            child: Text(title,
              style: const TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Icon(Icons.star,
                color: Colors.white,
                size: 30,
              ),
              const SizedBox(width: 10),
              Text("4/10",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          LinearPercentIndicator(
            percent: 0.6,
            progressColor: Colors.white,
            width: 130,
            animation: true,
            barRadius: const Radius.circular(20),
            lineHeight: 15,
          ),
          const SizedBox(height: 48),
          Center(
            child: TextButton(
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    style: BorderStyle.solid,
                    color: Colors.black,
                    width: 2
                  ),
                )),
                fixedSize: WidgetStatePropertyAll(const Size(200, 50)),
                backgroundColor: WidgetStatePropertyAll(Colors.white),
              ),
              onPressed: (){
                
              }, 
              child: Text("Start",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              )
            ),
          )
        ],
      ),
    );
  }
}