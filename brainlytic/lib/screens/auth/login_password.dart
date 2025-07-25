import 'package:flutter/material.dart';

class LoginPassword extends StatefulWidget {
  const LoginPassword({super.key});

  @override
  State<LoginPassword> createState() => _LoginPasswordState();
}

class _LoginPasswordState extends State<LoginPassword> {

  bool showPasswordField = false;
  bool isVisible = false;
  
  @override
  void initState() {
    isVisible = true;
    super.initState();
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 23,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Brainlytic",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              // decoration: TextDecoration.underline,
              // decorationColor: Colors.blue.shade200
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 35),
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text("Enter your password",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16,right: 16, top: 5, bottom: 16),
            child: SizedBox(
              width: 400,
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                        style: BorderStyle.solid,
                        width: 1.5
                      ),
                      borderRadius: BorderRadius.circular(50)
                    ),
                  labelText: "Email",
                  labelStyle: TextStyle(
                    fontSize: 20
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16,right: 16, top: 5, bottom:0),
            child: SizedBox(
              width: 400,
              child: TextField(
                obscureText: isVisible,
                autofocus: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      style: BorderStyle.solid
                    ),
                    borderRadius: BorderRadius.circular(50)
                  ),
                  labelText: "Password",
                  labelStyle: TextStyle(
                    fontSize: 20
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
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                        color: Colors.indigoAccent.shade400,
                        width: 1.5
                    )
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(right: 12, bottom: 16),
            child: TextButton(
              onPressed: () {
               
              }, 
              child: Text("Forgot Password?",
                style: TextStyle(
                  color: Colors.indigoAccent.shade700,
                  fontSize: 17
                ),
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8, top:6),
            child: SizedBox(
              width: 340,
              height: 60,
              child: ElevatedButton(
                onPressed: () {

                }, 
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.black),
                ),
                child: Text("Continue",
                  style: TextStyle(
                    fontSize: 21.3,
                    color: Colors.white
                  ),
                )
              ),
            ),
          ),
          SizedBox(
            width: 450,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left:10, right:10, top: 20),
                    child: Divider(
                      thickness: 2,
                    ), 
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text("or",
                    style: TextStyle(
                      fontSize: 18
                    ),
                  )
                ),
                Expanded(
                  child :Container(
                    margin: EdgeInsets.only(left: 10, right:10, top: 20),
                    child: Divider(
                      thickness: 2
                    ),
                  )
                )
              ],
            )
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top:25, bottom: 15),
            child: SizedBox(
              width: 340,
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.white)
                ),
                onPressed: (){
                  
                }, 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/google-favicon.jpg",
                      height: 24,
                    ),
                    Text(
                      "  Continue with Google",
                      style: TextStyle(
                        fontSize: 21.3,
                        color: Colors.black
                      ),
                    ),
                  ],
                )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:20, right: 20, bottom: 20, top:7),
            child: SizedBox(
              width: 340,
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.white)
                ),
                onPressed: (){
                  
                }, 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/apple-favicon.jpg",
                      height: 26,
                    ),
                    Text(
                      "  Continue with Apple",
                      style: TextStyle(
                        fontSize: 21.3,
                        color: Colors.black,
                      ),
                    ),
                  ],
                )
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account?",
                style: TextStyle(
                  fontSize: 17
                ),
              ),
              TextButton(
                onPressed: (){

                }, 
                child: Text("Sign up",
                  style: TextStyle(
                    color: Color.fromRGBO(102, 110, 169, 1),
                    decoration: TextDecoration.underline,
                    decorationColor: Color.fromRGBO(102, 110, 169, 1),
                    fontSize: 17
                  ),
                )
              )
            ],
          )
        ],
      ),
    );
  }
}