import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_collage/Cubit/cubit.dart';
import 'package:project_collage/Cubit/states.dart';
import 'package:project_collage/Shared/components/components.dart';
import 'package:project_collage/modules/Category/CategoryScreen.dart';
import 'package:project_collage/modules/Notification/Notification.dart';

class CtaegoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectCubit, ProjectStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var categories = ProjectCubit.get(context).allCtaegories;
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Categories',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: textColor),
                ),
                elevation: 0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                actions: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: secondColor,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NotificationScreen()),
                            );
                          },
                          icon: SvgPicture.asset(
                            "assets/icons/Bell.svg",
                            height: 22,
                            width: 22,
                            color: switchColors,
                          ),
                        ),
                      )),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: ConditionalBuilder(
                  condition: state is GetCategoriesLoadingState,
                  builder: (context) => Center(
                    child: CircularProgressIndicator(
                      color: switchColors,
                    ),
                  ),
                  fallback: (context) => GridView.count(
                    physics: BouncingScrollPhysics(),
                    crossAxisCount: 2,
                    children: List.generate(
                        7,
                        (index) => Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                              left: 20,
                            ),
                            child: InkWell(
                                onTap: () {
                                  ProjectCubit.get(context).getCategoryProduct(
                                      indexCategory: index + 1);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CategoryScreen()),
                                  );
                                },
                                child: categoriesItem(
                                    name: categories[index]['name'],
                                    image: 'assets/images/tshirt.png')))),
                    shrinkWrap: true,
                  ),
                ),
              ));
        });
  }
}
