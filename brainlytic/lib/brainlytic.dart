import 'package:brainlytic/core/router/app_router.dart';
import 'package:brainlytic/core/theme/theme.dart';
import 'package:brainlytic/features/auth/data/datasources/firebase_auth_datasources.dart';
import 'package:brainlytic/features/auth/data/repository/auth_repository_impl.dart';
import 'package:brainlytic/features/auth/domain/usecases/login_usecase.dart';
import 'package:brainlytic/features/auth/domain/usecases/register_usecase.dart';
import 'package:brainlytic/features/auth/pages/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Brainlytic extends StatelessWidget {
  const Brainlytic({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_)=>AuthBloc(
            registerUsecase: RegisterUsecase(
              AuthRepositoryImpl(
                FirebaseAuthDatasources()
              )
            ),
            loginUsecase: LoginUsecase(
              AuthRepositoryImpl(
                FirebaseAuthDatasources()
              )
            )
          )
        ),
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