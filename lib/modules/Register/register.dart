import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_collage/modules/Home/home.dart';
import 'package:project_collage/modules/Register/cubit/RegisterCubit.dart';
import 'package:project_collage/modules/Register/cubit/RegisterStates.dart';
import 'package:project_collage/shared/components/components.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    bool obsecure = true;
    TextEditingController emailController = TextEditingController();
    TextEditingController passowrdController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    return BlocProvider(
        create: (BuildContext context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterStates>(
            listener: (context, state) {
          if (state is RegisterSuccessfulStates) {
            if (formKey.currentState!.validate()) {}
          }

          if (state is ValidStates) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          }
        }, builder: (context, state) {
          var registerC = RegisterCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
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
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        'Sign up',
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
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your name';
                            }
                            return null;
                          },
                          controller: nameController,
                          decoration: InputDecoration(
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
                              prefixIcon: Padding(
                                padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                                child: SvgPicture.asset(
                                  "assets/icons/User Icon.svg",
                                  height: 18,
                                  width: 18,
                                  color: switchColors,
                                ),
                              ),
                              labelText: 'Enter your Name',
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
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your email';
                            } else if (registerC.validationE) {
                              return 'The Email is invalid';
                            }
                            return null;
                          },
                          controller: emailController,
                          decoration: InputDecoration(
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your passowrd';
                            } else if (registerC.validationP) {
                              return 'The password must be at least 8 characters';
                            }
                            return null;
                          },
                          controller: passowrdController,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(obsecure
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  obsecure = registerC.obsecurechange(
                                      obsecure: obsecure);
                                },
                              ),
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
                    SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () {
                        registerC.validationE = false;
                        registerC.validationP = false;
                        if (formKey.currentState!.validate()) {
                          registerC.registerUser(
                              email: emailController.text,
                              passowrd: passowrdController.text,
                              name: nameController.text);
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
                              condition: state is RegisterLoadingStates,
                              builder: (context) => Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                              fallback: (context) => Text(
                                'Sign up',
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
                      height: 20,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      InkWell(
                        onTap: () {},
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: secondColor,
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
                      InkWell(
                        onTap: () {},
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: secondColor,
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
