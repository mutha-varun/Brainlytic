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

  Color hextoColor(String hex){
    return Color(int.parse(hex,  radix: 16) + 0xFF000000);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Hey! ${widget.name}"),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.black,
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
                      child: LinearProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      )
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}