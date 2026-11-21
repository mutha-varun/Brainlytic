import 'package:brainlytic/features/home/data/datasource/firestore_datasource.dart';
import 'package:brainlytic/features/home/data/models/quiz_model.dart';
import 'package:brainlytic/features/home/domain/repository/home_repository.dart';


class HomeRepositoryImpl implements HomeRepository{

  final FirestoreDatasource _firestoreDatasource;

  HomeRepositoryImpl(this._firestoreDatasource);
  
  @override
  Future<List<QuizModel>> getQuizData() async{
    final data = await _firestoreDatasource.getQuizData();
    return data.docs.map(QuizModel.fromDoc).toList();
  }
  
  @override
  Future<Map<String, int>> getUserStars() async{
    final data = await _firestoreDatasource.getUserStars();
    return {
      for(final entry in data) 'quiz${entry.quizId}': entry.star,
    };
  }
}