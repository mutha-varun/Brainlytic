import 'package:brainlytic/screens/auth/lineorline.dart';
import 'package:brainlytic/screens/auth/login_username.dart';
import 'package:brainlytic/screens/auth/signingithub.dart';
import 'package:brainlytic/screens/auth/signingoogle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  bool isVisible = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  
  @override
  void initState() {
    isVisible = true;
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose(); 
    nameController.dispose();
    super.dispose();
  }

  Future<void> createUser() async{
    try{
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(), 
        password: passwordController.text.trim()
      );
      await userCredential.user!.updateDisplayName(nameController.text.trim());
      print("User created: ${userCredential.user!.displayName}");
      print(userCredential);
    }on FirebaseAuthException catch(e){
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 20,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text("Brainlytic",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(19),
            child: const Text("Create an account",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16,right: 16, top: 5, bottom: 16),
            width: 400,
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                label: Text("Name"),
                labelStyle: TextStyle(
                  fontSize: 19,
                  color: Colors.grey.shade600
                ),
                floatingLabelStyle: TextStyle(
                  fontSize: 19,
                  color: Colors.indigoAccent.shade400
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                    style: BorderStyle.solid,
                    width: 1.5
                  ),
                  borderRadius: BorderRadius.circular(50)
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: Colors.indigoAccent.shade400,
                    width: 1.5
                  )
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16,right: 16, top: 5, bottom: 16),
            width: 400,
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                label: Text("Email"),
                labelStyle: TextStyle(
                  fontSize: 19,
                  color: Colors.grey.shade600
                ),
                floatingLabelStyle: TextStyle(
                  fontSize: 19,
                  color: Colors.indigoAccent.shade400
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                    style: BorderStyle.solid,
                    width: 1.5
                  ),
                  borderRadius: BorderRadius.circular(50)
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: Colors.indigoAccent.shade400,
                    width: 1.5
                  )
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16,right: 16, top: 5, bottom: 16),
            width: 400,
            child: TextField(
              obscureText: isVisible,
              controller: passwordController,
              decoration: InputDecoration(
                label: Text("Password"),
                labelStyle: TextStyle(
                  fontSize: 19,
                  color: Colors.grey.shade600
                ),
                floatingLabelStyle: TextStyle(
                  fontSize: 19,
                  color: Colors.indigoAccent.shade400
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                suffixIcon: IconButton(
                  onPressed: (){
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  icon: Icon(isVisible? Icons.visibility : Icons.visibility_off,
                    size: 30,
                  )
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                    style: BorderStyle.solid,
                    width: 1.5
                  ),
                  borderRadius: BorderRadius.circular(50)
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: Colors.indigoAccent.shade400,
                    width: 1.5
                  )
                )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            width: 335,
            height: 89,
            child: ElevatedButton(
              onPressed: ()async{
                await createUser();

                if(context.mounted){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => LoginUsername()));
                }
              }, 
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.black),
                elevation: WidgetStatePropertyAll(4)
              ),
              child: Text("Continue",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white
                ),
              )
            ),
          ),
          const Lineorline(),
          const SigninGoogle(),
          const SigninGitHub(),
          
        ],
      ),
    );
  }
}