import 'package:flutter/material.dart';
import 'package:frontend/presentation/widgets/input_form.dart';
import 'register.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 211, 47, 47),
      ),
      body: Container(
        margin: EdgeInsets.only(bottom: 20.0),
        child: content(context),
      ),
    );
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
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 211, 47, 47),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(60, 60),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Color.fromARGB(255, 48, 1, 1),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Sign in to continue.",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    inputForm("Email"),
                    const SizedBox(
                      height: 20,
                    ),
                    inputForm("Password"),
                    const SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Container(
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 211, 47, 47),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 211, 47, 47),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                          ),
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/", (route) => false);
                          },
                          child: const Text(
                            "LogIn",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Center(
                      child: Container(
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 68, 5, 1),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                          ),
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/admin", (route) => false);
                          },
                          child: const Text(
                            "Admin",
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
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("New User? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegistrationPage(),
                              ),
                            );
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 249, 4, 4)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }
}
