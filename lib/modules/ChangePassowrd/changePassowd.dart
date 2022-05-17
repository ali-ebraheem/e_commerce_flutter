import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_collage/Cubit/cubit.dart';
import 'package:project_collage/Cubit/states.dart';
import 'package:project_collage/Shared/components/components.dart';

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    TextEditingController oldPassordController = TextEditingController();
    TextEditingController newPassordController = TextEditingController();
    TextEditingController cNewPassowrdController = TextEditingController();
    return BlocConsumer<ProjectCubit, ProjectStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: Builder(
                builder: (context) => IconButton(
                  onPressed: () {
                    ProjectCubit.get(context)
                        .changePassword(
                            newPassowrd: newPassordController.text,
                            cNewPassowrd: cNewPassowrdController.text,
                            oldPassorwd: oldPassordController.text)
                        .then((value) {
                      if (formKey.currentState!.validate()) {
                        Navigator.pop(context);
                      }
                    });
                  },
                  icon: CircleAvatar(
                    radius: 20,
                    backgroundColor: secondColor,
                    child: Icon(
                      Icons.done_rounded,
                      color: switchColors,
                      size: 26,
                    ),
                  ),
                ),
              ),
              title: Text(
                'Change Passowrd',
                style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
              ),
              elevation: 0,
              actions: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: secondColor,
                      child: IconButton(
                        onPressed: () {
                          ProjectCubit.get(context).imagesDashboard.clear();
                          ProjectCubit.get(context).images.clear();
                          print(ProjectCubit.get(context).images);
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close_rounded,
                          color: switchColors,
                          size: 26,
                        ),
                      ),
                    )),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 120,
                        ),
                        //prouduct name
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: TextFormField(
                                  validator: (value) {
                                    if (ProjectCubit.get(context)
                                            .validOldPassword!
                                            .isNotEmpty &&
                                        ProjectCubit.get(context)
                                                .validOldPassword !=
                                            'null') {
                                      return ProjectCubit.get(context)
                                          .validOldPassword;
                                    }
                                    return null;
                                  },
                                  controller: oldPassordController,
                                  style: TextStyle(fontSize: 18),
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: secondColor),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    hintText: 'The Old Passowrd....',
                                    hintStyle: TextStyle(fontSize: 18),
                                  ),
                                ))),
                        SizedBox(
                          height: 20,
                        ),
                        // condition and brand
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (ProjectCubit.get(context)
                                                  .validNewPassword!
                                                  .isNotEmpty &&
                                              ProjectCubit.get(context)
                                                      .validNewPassword !=
                                                  'null') {
                                            return ProjectCubit.get(context)
                                                .validNewPassword;
                                          }
                                          return null;
                                        },
                                        controller: newPassordController,
                                        style: TextStyle(fontSize: 20),
                                        keyboardType: TextInputType.text,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: InputDecoration(
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1, color: Colors.red),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1, color: Colors.red),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1, color: secondColor),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          hintText: 'The New Passowrd....',
                                          hintStyle: TextStyle(fontSize: 18),
                                        ),
                                      ))),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // description
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: TextFormField(
                              validator: (value) {
                                if (ProjectCubit.get(context)
                                        .validConfirmPassword!
                                        .isNotEmpty &&
                                    ProjectCubit.get(context)
                                            .validConfirmPassword !=
                                        'null') {
                                  return ProjectCubit.get(context)
                                      .validConfirmPassword;
                                }
                                return null;
                              },
                              controller: cNewPassowrdController,
                              style: TextStyle(fontSize: 20),
                              keyboardType: TextInputType.text,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.red),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.red),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: secondColor),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                hintText: 'Conform The New Passowrd....',
                                hintStyle: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 50,
                        ),
                      ],
                    )),
              ),
            ),
          );
        });
  }
}
