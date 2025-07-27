import 'package:brainlytic/screens/home/quiz_topics_templates.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
          StreamBuilder(
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
              if(!snapshot.hasData){
                return Center(
                  child: const Text("No quizzes found")
                );
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index){
                    return QuizTopicsTemplates(
                      color: hextoColor(snapshot.data!.docs[index].data()['color']),
                      title: snapshot.data!.docs[index].data()['title'],
                      id: snapshot.data!.docs[index].data()['id'],
                      stars: snapshot.data!.docs[index].data()['stars'],
                    );
                  },
                ),
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