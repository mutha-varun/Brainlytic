import 'package:brainlytic/core/errors/appfailure.dart';
import 'package:brainlytic/features/quiz/data/datasource/firestore_quiz_datasource.dart';
import 'package:brainlytic/features/quiz/data/model/question_model.dart';
import 'package:brainlytic/features/quiz/domain/repository/quiz_repository.dart';
import 'package:fpdart/fpdart.dart';


class QuizRepositoryImpl extends QuizRepository{
  final FirestoreQuizDatasource _datasource;
  QuizRepositoryImpl(this._datasource);
  @override
  Future<Either<AppFailure,List<QuestionModel>>> fetch({required String quizId}) {
    return _datasource.fetch(quizId: quizId);
  }
  
}

