import 'package:brainlytic/core/router/app_router.dart';
import 'package:brainlytic/core/theme/theme.dart';
import 'package:brainlytic/features/auth/data/datasources/firebase_auth_datasources.dart';
import 'package:brainlytic/features/auth/data/repository/auth_repository_impl.dart';
import 'package:brainlytic/features/auth/domain/usecases/login_usecase.dart';
import 'package:brainlytic/features/auth/domain/usecases/register_usecase.dart';
import 'package:brainlytic/features/auth/domain/usecases/signout_usecase.dart';
import 'package:brainlytic/features/auth/pages/bloc/auth_bloc.dart';
import 'package:brainlytic/features/home/data/datasource/firestore_datasource.dart';
import 'package:brainlytic/features/home/data/repository/home_repository_impl.dart';
import 'package:brainlytic/features/home/domain/usecase/quizdata_usecase.dart';
import 'package:brainlytic/features/home/domain/usecase/star_usecase.dart';
import 'package:brainlytic/features/home/pages/bloc/home_bloc.dart';
import 'package:brainlytic/features/quiz/data/datasource/firestore_quiz_datasource.dart';
import 'package:brainlytic/features/quiz/data/repository/quiz_repository_impl.dart';
import 'package:brainlytic/features/quiz/domain/usecase/first_question_usecase.dart';
import 'package:brainlytic/features/quiz/domain/usecase/update_usecase.dart';
import 'package:brainlytic/features/quiz/pages/bloc/quiz_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Brainlytic extends StatelessWidget {
  const Brainlytic({super.key});

  @override
  Widget build(BuildContext context) {
    final authDatasources = FirebaseAuthDatasources();
    final authRepository = AuthRepositoryImpl(authDatasources);
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_)=>AuthBloc(
            registerUsecase: RegisterUsecase(
              authRepository
            ),
            loginUsecase: LoginUsecase(
              authRepository
            ),
            signoutUsecase: SignoutUsecase(
              authRepository
            )
          )
        ),
        BlocProvider<HomeBloc>(
          create: (_){
            final datasource = FirestoreDatasource();
            final repository = HomeRepositoryImpl(datasource);
            return HomeBloc(
            quizdataUsecase: QuizdataUsecase(
              repository
            ), 
              starUsecase: StarUsecase(
                repository
              )
            );
          }
        ),
        BlocProvider<QuizBloc>(
          create: (_){
            final quizDatasource = FirestoreQuizDatasource();
            final quizRepository = QuizRepositoryImpl(quizDatasource);
            return QuizBloc(
              firstQuestionUsecase: FirstQuestionUsecase(quizRepository),
              updateUsecase: UpdateUsecase(quizRepository)
            );
          }
        )
      ],
      child: MaterialApp.router(
        title: "Brainlytic",
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        // home: StreamBuilder(
        //   stream: FirebaseAuth.instance.authStateChanges(),
        //   builder: (context, snapshot) {
            
        //     if(snapshot.data != null){
        //       return HomeScreen();
        //     }
        //     return Onboarding();
        //   },
        // )
      
        routerConfig: appRouter,
      ),
    );
  }
}