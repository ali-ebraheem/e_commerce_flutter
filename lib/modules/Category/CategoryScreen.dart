import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_collage/Cubit/cubit.dart';
import 'package:project_collage/Cubit/states.dart';
import 'package:project_collage/Shared/components/components.dart';
import 'package:project_collage/modules/Notification/Notification.dart';
import 'package:project_collage/modules/Product/productScreen.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<bool> savedd = [];
    return BlocConsumer<ProjectCubit, ProjectStates>(
        listener: (context, state) {},
        builder: (context, state) {
          for (var i = 0; i < 1000; i++) {
            savedd.add(false);
          }
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Cars',
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
              body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //Search
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: secondColor,
                              ),
                              width: double.infinity,
                              height: 40,
                              child: TextField(
                                  style: TextStyle(fontSize: 22),
                                  decoration: InputDecoration(
                                    prefixIcon: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      child: SvgPicture.asset(
                                        "assets/icons/Search Icon.svg",
                                        height: 20,
                                        width: 20,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                  ))),
                        ),
                        ConditionalBuilder(
                          condition: state is GetProductLoadingState,
                          builder: (context) => Padding(
                            padding: const EdgeInsets.only(top: 250),
                            child: Center(
                                child: CircularProgressIndicator(
                              color: switchColors,
                            )),
                          ),
                          fallback: (context) => ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 20),
                                child: InkWell(
                                    onTap: () {
                                      ProjectCubit.get(context).getProfileUser(
                                          id: ProjectCubit.get(context)
                                              .categoryProductModel!
                                              .data![index]
                                              .authorId!);
                                      ProjectCubit.get(context).getComment(
                                          productId: ProjectCubit.get(context)
                                              .categoryProductModel!
                                              .data![index]
                                              .id);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProductScreen(
                                                  product:
                                                      ProjectCubit.get(context)
                                                          .categoryProductModel!
                                                          .data![index],
                                                )),
                                      );
                                    },
                                    child: categoryItem(
                                        deleteFavorite: () {
                                          ProjectCubit.get(context)
                                              .deleteFavorite(
                                                  productId:
                                                      ProjectCubit.get(context)
                                                          .categoryProductModel
                                                          ?.data![index]
                                                          .id);
                                        },
                                        addFavorite: () {
                                          ProjectCubit.get(context).addFavorite(
                                              productId:
                                                  ProjectCubit.get(context)
                                                      .categoryProductModel
                                                      ?.data![index]
                                                      .id);
                                        },
                                        price: ProjectCubit.get(context)
                                            .categoryProductModel
                                            ?.data![index]
                                            .price,
                                        body: ProjectCubit.get(context)
                                            .categoryProductModel
                                            ?.data![index]
                                            .body,
                                        image: ProjectCubit.get(context)
                                            .categoryProductModel
                                            ?.data![index]
                                            .images![0]
                                            .url,
                                        title: ProjectCubit.get(context)
                                            .categoryProductModel
                                            ?.data![index]
                                            .title,
                                        saved: savedd[index],
                                        changeSaved: () {
                                          savedd[index] = ProjectCubit.get(
                                                  context)
                                              .changeSavedState(savedd[index]);
                                        },
                                        context: context))),
                            separatorBuilder: (context, index) => SizedBox(
                              height: 0,
                            ),
                            itemCount: ProjectCubit.get(context)
                                .categoryProductModel!
                                .data!
                                .length,
                            shrinkWrap: true,
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),
                      ])));
        });
  }
}
