import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/bottombar/screenA.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});



  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  static Future<User?>loginUsingEmailPassword({required String email, required String password, required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;

    } on FirebaseAuthException catch (e) {
      if(e.code == "user not found"){
        print("No User found for that email");
      }
    }

    return user;
  }


  @override
  Widget build(BuildContext context) {

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),

      body: SizedBox(
        height: 400.0,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Username",
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Password",
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
                onPressed: () async{
                  User? user = await loginUsingEmailPassword(email: emailController.text, password: passwordController.text, context: context);
                  print(user);
                  if (user != null) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ScreenA()));
                  }
                },


                child: const Text("Login")),

          ],
        ),
      ),
    );
  }
}