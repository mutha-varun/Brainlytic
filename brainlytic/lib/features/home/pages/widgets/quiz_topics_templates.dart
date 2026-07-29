import 'package:brainlytic/core/router/route_constants.dart';
import 'package:brainlytic/features/home/pages/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class QuizTopicsTemplates extends StatelessWidget {
  final Color color;
  final String title;
  final int id;
  final int totalQuestions; 
  
  const QuizTopicsTemplates({
      super.key,
      required this.color,
      required this.title,
      required this.id,
      required this.totalQuestions
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 260,
      padding: const EdgeInsets.only(left:16, right: 16, top: 16, bottom: 10),
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
            child: Text(title,
              style: Theme.of(context).textTheme.titleLarge
            ),
          ),
          const SizedBox(height: 15),
          _StarBadge(
            quizId: id,
            totalQuestions: totalQuestions
          ),
          const SizedBox(height: 35),
          Center(
            child: ElevatedButton(
              onPressed: (){
                context.pushNamed(RouteConstants.quizPage,
                  pathParameters: {
                    'quizId': id.toString()
                  }
                );
              }, 
              child: const Text("Start",)
            ),
          )
        ],
      ),
    );
  }
}

class _StarBadge extends StatelessWidget{
  final int quizId;
  final int totalQuestions;
  const _StarBadge({
    required this.quizId,
    required this.totalQuestions
  });
  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, int>(
      selector: (state) {
        if(state is HomeDataFetchSuccess){
          return state.stars['quiz$quizId'] ?? 0;
        }
        return 0;
      }, 
      builder: (context, stars){
        return Column(
          children: [
            Row(
              children: [
                const Icon(Icons.star,
                  color: Colors.white,
                  size: 30,
                ),
                const SizedBox(width: 10),
                Text("$stars/$totalQuestions",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    letterSpacing: 1
                  )
                )
              ],
            ),
            const SizedBox(height: 15),
            LinearPercentIndicator(
              percent: stars/totalQuestions,
              progressColor: Colors.white,
              width: 130,
              animation: true,
              barRadius: const Radius.circular(20),
              lineHeight: 15,
            ),
          ],
        );
      }
    );
  }
}