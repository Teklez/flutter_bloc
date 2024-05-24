import 'package:flutter/material.dart';
import 'package:frontend/presentation/widgets/input_form.dart';
import 'package:frontend/presentation/screens/login.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 211, 47, 47),
        ),
        body: Container(
          margin: EdgeInsets.only(bottom: 20.0),
          child: content(context),
        ));
  }

  Widget content(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.dstATop,
          ),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/pexels-raka-miftah-4253690.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 211, 47, 47),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(60, 60),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Color.fromARGB(255, 59, 2, 2),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome to BetEbet",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Sign up to continue.",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    inputForm("User Name"),
                    const SizedBox(
                      height: 20,
                    ),
                    inputForm("Email"),
                    const SizedBox(
                      height: 20,
                    ),
                    inputForm("Password"),
                    const SizedBox(
                      height: 20,
                    ),
                    inputForm("Confirm Password"),
                    const SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Container(
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 211, 47, 47),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/');
                          },
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 221, 4, 4)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    ));
  }
}
