import 'package:brainlytic/core/entities/quiz.dart';
import 'package:brainlytic/core/router/app_router.dart';
import 'package:brainlytic/core/theme/pallete.dart';
import 'package:brainlytic/features/auth/pages/bloc/auth_bloc.dart';
import 'package:brainlytic/features/common/methods/fromhex.dart';
import 'package:brainlytic/features/common/widgets/circularindicator.dart';
import 'package:brainlytic/features/home/pages/bloc/home_bloc.dart';
import 'package:brainlytic/features/home/pages/widgets/quiz_topics_templates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware{

//   void signOut(){
//     showDialog(context: context, builder: (context) {
//       return AlertDialog(
//         title: Text("Logout",
//           textAlign: TextAlign.center,
//           style: Theme.of(context).textTheme.titleLarge
//         ),
//         content: Text("Are you sure you want to logout?",
//           style: Theme.of(context).textTheme.bodyLarge
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text("No",
//               style: Theme.of(context).textTheme.titleSmall!.copyWith(
//                 color: Colors.blue
//               )
//             ),
//           ),
//           TextButton(
//             onPressed: () {
//               FirebaseAuth.instance.signOut();
//               context.goNamed(RouteConstants.onboarding);
//             },
//             child:  Text("Logout",
//               style: Theme.of(context).textTheme.titleSmall!.copyWith(
//                 color: Colors.red
//               )
//             ),
//           ),
//         ],
//       );
//     });
//   }


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
    return Scaffold(
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
            },
          ),
        ],
        backgroundColor: Pallete.focusedBorderColor,
      ),
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
        //   StreamBuilder<Map<String, int>>(
        //     stream: getUserStars(),
        //     builder: (context, asyncSnapshot) {
        //       return StreamBuilder(
        //         stream: FirebaseFirestore.instance.collection('quizzes').snapshots(),
        //         builder: (context, snapshot) {
        //           if (snapshot.connectionState == ConnectionState.waiting) {
        //             return Center(
        //               child: const Circularindicator(),
        //             );
        //           }
        //           return Expanded(
        //             child: ListView.builder(
        //               itemCount: 7,
        //               itemBuilder: (context, index){
        //                 final quizData = snapshot.data!.docs[index].data();
        //                 final quizId = 'quiz${quizData['id']}';
        //                 final userStars  = asyncSnapshot.data?[quizId] ?? 0;

        //                 return QuizTopicsTemplates(
        //                   color: hextoColor(quizData['color']),
        //                   title: quizData['title'],
        //                   id: quizData['id'],
        //                   stars: userStars,
        //                   totalQuestions: quizData['Questions'],
        //                 );
        //               },
        //             ),
        //           );
        //         }
        //       );
        //     }
        //   ),
        // ],
      //),
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
    );
  }
}