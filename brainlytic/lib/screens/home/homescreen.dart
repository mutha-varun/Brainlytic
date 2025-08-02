import 'package:brainlytic/screens/auth/onboarding.dart';
import 'package:brainlytic/screens/home/quiz_topics_templates.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String name;
  const HomeScreen({
    super.key,
    required this.name
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final userId = FirebaseAuth.instance.currentUser!.uid;

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
              Text("Hey! ${widget.name}"),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.black,
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 20),
            icon: const Icon(Icons.logout, color: Colors.black),
            onPressed: () {
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                  title: const Text("Logout",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: const Text("Are you sure you want to logout?",
                    style: TextStyle(fontSize: 18),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("No",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => const Onboarding()) 
                        );
                      },
                      child: const Text("Logout",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                        ),
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
                    return Container(
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
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