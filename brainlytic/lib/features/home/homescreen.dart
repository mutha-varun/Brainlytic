import 'package:brainlytic/core/router/route_constants.dart';
import 'package:brainlytic/core/theme/pallete.dart';
import 'package:brainlytic/features/common/widgets/circularindicator.dart';
import 'package:brainlytic/features/home/quiz_topics_templates.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final userId = FirebaseAuth.instance.currentUser!.uid;
  final name = FirebaseAuth.instance.currentUser!.displayName;

  Stream<Map<String, int>> getUserStars(){
    return FirebaseFirestore.instance.collection('userData').
    doc(userId).collection('quizData').snapshots().
    map((snapshot) {
      final starsMap = <String, int>{};
      for (var doc in snapshot.docs) {
        final quizNumber = doc.id.replaceAll('quiz', '');
        starsMap['quiz$quizNumber'] = doc['stars'] as int;
      }
      return starsMap;
    });
  }

  Color hextoColor(String hex) {
      return Color(int.parse(hex, radix: 16) + 0xFF000000);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Row(
            spacing: 5,
            children: [
              Icon(Icons.home,
                size: 30,
              ),
              Text("Hey! $name",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 20),
            icon: const Icon(Icons.logout),
            onPressed: () {
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                  title: Text("Logout",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge
                  ),
                  content: Text("Are you sure you want to logout?",
                    style: Theme.of(context).textTheme.bodyLarge
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("No",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.blue
                        )
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        context.goNamed(RouteConstants.onboarding);
                      },
                      child:  Text("Logout",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.red
                        )
                      ),
                    ),
                  ],
                );
              });
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<Map<String, int>>(
            stream: getUserStars(),
            builder: (context, asyncSnapshot) {
              return StreamBuilder(
                stream: FirebaseFirestore.instance.collection('quizzes').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // return Container(
                    //   margin: const EdgeInsets.all(20),
                    //   padding: const EdgeInsets.symmetric(horizontal: 30),
                    //   alignment: Alignment.center,
                    //   // child: CircularProgressIndicator(
                    //   //   valueColor: AlwaysStoppedAnimation<Color>(Pallete.blackColor),
                    //   // ),
                    //   ch
                    // );
                    return Center(
                      child: const Circularindicator(),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: 7,
                      itemBuilder: (context, index){
                        final quizData = snapshot.data!.docs[index].data();
                        final quizId = 'quiz${quizData['id']}';
                        final userStars  = asyncSnapshot.data?[quizId] ?? 0;

                        return QuizTopicsTemplates(
                          color: hextoColor(quizData['color']),
                          title: quizData['title'],
                          id: quizData['id'],
                          stars: userStars,
                          totalQuestions: quizData['Questions'],
                        );
                      },
                    ),
                  );
                }
              );
            }
          ),
        ],
      ),
    );
  }
}