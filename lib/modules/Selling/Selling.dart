import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_collage/Cubit/cubit.dart';
import 'package:project_collage/Cubit/states.dart';
import 'package:project_collage/Shared/components/components.dart';
import 'package:project_collage/modules/Product/productScreen.dart';

class SellingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<bool> savedd = [
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
    ];
    return BlocConsumer<ProjectCubit, ProjectStates>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
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
                'Selling',
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
                condition: state is GetProductLoadingState,
                builder: (context) => Center(
                        child: CircularProgressIndicator(
                      color: switchColors,
                    )),
                fallback: (context) => SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 20),
                                child: InkWell(
                                    onTap: () {
                                      ProjectCubit.get(context).getProfileUser(
                                          id: ProjectCubit.get(context)
                                              .productModel!
                                              .data![index]
                                              .authorId!);
                                      ProjectCubit.get(context).getComment(
                                          productId: ProjectCubit.get(context)
                                              .productModel!
                                              .data![index]
                                              .id);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProductScreen(
                                                  product:
                                                      ProjectCubit.get(context)
                                                          .productModel!
                                                          .data![index],
                                                )),
                                      );
                                    },
                                    child: categoryItem(
                                        body: ProjectCubit.get(context)
                                            .productModel
                                            ?.data![index]
                                            .body,
                                        image: ProjectCubit.get(context)
                                            .productModel
                                            ?.data![index]
                                            .images![0]
                                            .url,
                                        title: ProjectCubit.get(context)
                                            .productModel!
                                            .data![index]
                                            .title,
                                        saved: savedd[index],
                                        changeSaved: () {
                                          savedd[index] = ProjectCubit.get(
                                                  context)
                                              .changeSavedState(savedd[index]);
                                        },
                                        context: context,
                                        price: ProjectCubit.get(context)
                                            .productModel
                                            ?.data![index]
                                            .price))),
                            separatorBuilder: (context, index) => SizedBox(
                              height: 0,
                            ),
                            itemCount: ProjectCubit.get(context)
                                .productModel!
                                .data!
                                .length,
                            shrinkWrap: true,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ])))));
  }
}
