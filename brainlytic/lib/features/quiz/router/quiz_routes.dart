import 'package:brainlytic/core/router/route_constants.dart';
import 'package:brainlytic/features/quiz/quizpage.dart';
import 'package:go_router/go_router.dart';

class QuizRoutes {
  static final route = [
    GoRoute(
      name: RouteConstants.quizPage,
      path: '/quiz/:quizId',
      builder: (context, state){
        final quizId = state.pathParameters['quizId']!;
        return Quizpage(qid: quizId);
      }
    )
  ];
}