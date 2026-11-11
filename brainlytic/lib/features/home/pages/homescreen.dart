import 'package:brainlytic/core/entities/quiz.dart';
import 'package:brainlytic/core/router/app_router.dart';
import 'package:brainlytic/core/router/route_constants.dart';
import 'package:brainlytic/core/theme/pallete.dart';
import 'package:brainlytic/features/auth/pages/bloc/auth_bloc.dart';
import 'package:brainlytic/features/common/methods/fromhex.dart';
import 'package:brainlytic/features/common/widgets/circularindicator.dart';
import 'package:brainlytic/features/home/pages/bloc/home_bloc.dart';
import 'package:brainlytic/features/home/pages/widgets/confirmation.dart';
import 'package:brainlytic/features/home/pages/widgets/quiz_topics_templates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware{

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    
    context.read<HomeBloc>().add(HomeDataFetch());
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    context.read<HomeBloc>().add(StarRefreshed());
    super.didPopNext();
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          context.goNamed(RouteConstants.onboarding);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 45,
          title: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              spacing: 10,
              children: [
                Icon(Icons.home,
                  size: 26,
                ),
                Text("Hey!",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              style: IconButton.styleFrom(
                shape: const CircleBorder(), 
              ),
              padding: EdgeInsets.symmetric(horizontal: 20),
              splashRadius: 6,
              
              icon: const Icon(Icons.logout),
              onPressed: () {
                showDialog(
                  context: context, 
                  builder: (context){
                    return Confirmation();
                  }
                );
              },
            ),
          ],
          backgroundColor: Pallete.focusedBorderColor,
        ),
        body: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state){
            if(state is HomeError){
              
            }
          },
          builder: (context, state){
            if(state is HomeLoading){
              return Center(
                child: Circularindicator()
              );
            }

            else if(state is HomeDataFetchSuccess){
              final List<Quiz> quizzes = state.quizzes;
              final  stars = state.stars;

              return ListView.builder(
                itemCount: quizzes.length,
                itemBuilder: (context, index){
                  final quiz = quizzes[index];
                  return QuizTopicsTemplates(
                    key: ValueKey(quiz.id),
                    color: hextoColor(quiz.color), 
                    title: quiz.title, 
                    id: quiz.id , 
                    totalQuestions: quiz.totalQuestions
                  );
                }
              );
            }
            return Center(child: Circularindicator());
          }, 
        )
      ),
    );
  }
}