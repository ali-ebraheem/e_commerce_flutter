import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_collage/modules/Home/home.dart';

import 'package:project_collage/modules/Login/cubit/LoginCubit.dart';
import 'package:project_collage/modules/Login/cubit/LoginStates.dart';
import 'package:project_collage/modules/Register/register.dart';
import 'package:project_collage/shared/components/components.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    bool obsecure = true;
    TextEditingController emailController = TextEditingController();
    TextEditingController passowrdController = TextEditingController();
    return BlocProvider(
        create: (BuildContext context) => LoginCubit(),
        child:
            BlocConsumer<LoginCubit, LoginStates>(listener: (context, state) {
          if (state is LoginSuccessfulStates) {
            if (formKey.currentState!.validate()) {}
          }
          if (state is ValidStates) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          }
        }, builder: (context, state) {
          var loginC = LoginCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      color: switchColors,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 50.0,
                            color: textColor),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your email';
                            } else if (loginC.validationE) {
                              return 'The Email is invalid';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                                child: SvgPicture.asset(
                                  "assets/icons/Mail.svg",
                                  height: 18,
                                  width: 18,
                                  color: switchColors,
                                ),
                              ),
                              labelText: 'Enter your Email',
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: Colors.red),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.red),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: textColor),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: switchColors),
                                borderRadius: BorderRadius.circular(20),
                              ))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                          obscureText: obsecure,
                          controller: passowrdController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your passowrd';
                            } else if (loginC.validationP) {
                              return 'The password is invalid';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(obsecure
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  obsecure =
                                      loginC.obsecurechange(obsecure: obsecure);
                                },
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                                child: SvgPicture.asset(
                                  "assets/icons/Lock.svg",
                                  height: 25,
                                  width: 25,
                                  color: switchColors,
                                ),
                              ),
                              labelText: 'Enter your password',
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: Colors.red),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.red),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: textColor),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: switchColors),
                                borderRadius: BorderRadius.circular(20),
                              ))),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterScreen()),
                              );
                            },
                            child: Text(
                              'Create Account',
                              style: TextStyle(color: textColor),
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forget Passowrd',
                              style: TextStyle(color: textColor),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () {
                        loginC.validationE = false;
                        loginC.validationP = false;
                        if (formKey.currentState!.validate()) {
                          print(emailController.text);
                          loginC.loginUser(
                              email: emailController.text,
                              passowrd: passowrdController.text);
                        }
                      },
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Container(
                            decoration: BoxDecoration(
                                color: switchColors,
                                borderRadius: BorderRadius.circular(20)),
                            width: double.infinity,
                            height: 50,
                            child: Center(
                                child: ConditionalBuilder(
                              condition: state is LoginLoadingStates,
                              builder: (context) => Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                              fallback: (context) => Text(
                                'Sign in',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                          )),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: secondColor,
                        child: InkWell(
                          onTap: () {},
                          child: SvgPicture.asset(
                            "assets/icons/google-icon.svg",
                            height: 25,
                            width: 25,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: secondColor,
                        child: InkWell(
                          onTap: () {},
                          child: SvgPicture.asset(
                            "assets/icons/facebook-2.svg",
                            height: 25,
                            width: 25,
                            color: switchColors,
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
