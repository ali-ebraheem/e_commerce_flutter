import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_collage/Cubit/cubit.dart';
import 'package:project_collage/Cubit/states.dart';
import 'package:project_collage/Shared/components/components.dart';

import '../Product/productScreen.dart';

class SavedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<bool> savedd = [];
    return BlocConsumer<ProjectCubit, ProjectStates>(
        listener: (context, state) {},
        builder: (context, state) {
          for (var i = 0; i < 1000; i++) {
            savedd.add(true);
          }
          return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(
                  'Saved',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: textColor),
                ),
                elevation: 0,
                actions: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: secondColor,
                        child: IconButton(
                          onPressed: () {},
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
              body: ConditionalBuilder(
                  condition: state is GetFavoriteLoadingState,
                  builder: (context) => Center(
                          child: CircularProgressIndicator(
                        color: switchColors,
                      )),
                  fallback: (context) => SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 20),
                                  child: InkWell(
                                      onTap: () {
                                        ProjectCubit.get(context).getComment(
                                            productId: ProjectCubit.get(context)
                                                .favoriteModel!
                                                .data![index]
                                                .id);
                                        ProjectCubit.get(context)
                                            .getProfileUser(
                                                id: ProjectCubit.get(context)
                                                    .favoriteModel!
                                                    .data![index]
                                                    .authorId);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductScreen(
                                                    product: ProjectCubit.get(
                                                            context)
                                                        .favoriteModel!
                                                        .data![index],
                                                  )),
                                        );
                                      },
                                      child: categoryItem(
                                        addFavorite: () {
                                          ProjectCubit.get(context).addFavorite(
                                              productId:
                                                  ProjectCubit.get(context)
                                                      .favoriteModel!
                                                      .data![index]
                                                      .id);
                                        },
                                        body: ProjectCubit.get(context)
                                            .favoriteModel!
                                            .data![index]
                                            .body,
                                        image: ProjectCubit.get(context)
                                            .favoriteModel
                                            ?.data![index]
                                            .images![0]
                                            .url,
                                        title: ProjectCubit.get(context)
                                            .favoriteModel
                                            ?.data![index]
                                            .title,
                                        saved: savedd[index],
                                        changeSaved: () {
                                          savedd[index] = ProjectCubit.get(
                                                  context)
                                              .changeSavedState(savedd[index]);
                                        },
                                        context: context,
                                        price: ProjectCubit.get(context)
                                            .favoriteModel
                                            ?.data![index]
                                            .price,
                                        deleteFavorite: () {
                                          ProjectCubit.get(context)
                                              .deleteFavorite(
                                                  productId:
                                                      ProjectCubit.get(context)
                                                          .favoriteModel!
                                                          .data![index]
                                                          .id);
                                        },
                                      ))),
                              separatorBuilder: (context, index) => SizedBox(
                                height: 0,
                              ),
                              itemCount: ProjectCubit.get(context)
                                  .favoriteModel!
                                  .data!
                                  .length,
                              shrinkWrap: true,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ]))));
        });
  }
}
