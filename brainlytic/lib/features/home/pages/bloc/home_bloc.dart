import 'package:bloc/bloc.dart';
import 'package:brainlytic/core/entities/quiz.dart';
import 'package:brainlytic/features/home/domain/usecase/quizdata_usecase.dart';
import 'package:brainlytic/features/home/domain/usecase/star_usecase.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final QuizdataUsecase _quizdataUsecase;
  final StarUsecase _starUsecase;

  HomeBloc(
    {
      required QuizdataUsecase quizdataUsecase,
      required StarUsecase starUsecase
    }
  ) : 
  _quizdataUsecase = quizdataUsecase,
  _starUsecase = starUsecase
  ,super(HomeLoading()) {
    
    on<HomeDataFetch>((event, emit) async {
      try{
        final res = await _quizdataUsecase();
        final stars = await _starUsecase();

        emit(HomeDataFetchSuccess(res, stars));
      }catch(e){
        emit(HomeError(e.toString()));
      }
    });
  
  
    on<StarRefreshed>((event, emit) async {
      final current = state;
      if(current is! HomeDataFetchSuccess){
        return;
      }
      try{
        final stars = await _starUsecase();
        emit(HomeDataFetchSuccess(current.quizzes, stars));
      }catch(e){
        emit(HomeError(e.toString()));
      }
    });
  }
}
