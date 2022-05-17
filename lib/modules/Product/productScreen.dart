import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_collage/Cubit/cubit.dart';
import 'package:project_collage/Cubit/states.dart';
import 'package:project_collage/Shared/components/components.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:project_collage/modules/Notification/Notification.dart';
import 'package:project_collage/modules/Profile/profile.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductScreen extends StatelessWidget {
  final dynamic product;
  ProductScreen({this.product});
  @override
  Widget build(BuildContext context) {
    double offcet = 0;
    bool savedd = false;
    TextEditingController commentConteoller = TextEditingController();

    return BlocConsumer<ProjectCubit, ProjectStates>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
            appBar: AppBar(
              title: Text(
                'Item',
                style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
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
            body: ConditionalBuilder(
              condition: state is GetProfileLoadingState ||
                  ProjectCubit.get(context).commentModel == null ||
                  ProjectCubit.get(context).profile == null,
              builder: (context) => Center(
                  child: CircularProgressIndicator(
                color: switchColors,
              )),
              fallback: (context) => SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //product image
                          Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                Column(children: [
                                  CarouselSlider.builder(
                                      itemCount: product.images?.length,
                                      itemBuilder: (context, index, realIndex) {
                                        return Container(
                                          width: double.infinity,
                                          color: secondColor,
                                          child: Image(
                                            fit: BoxFit.contain,
                                            image: NetworkImage(
                                                '${product.images![index].url}'),
                                          ),
                                        );
                                      },
                                      options: CarouselOptions(
                                        onPageChanged: (index, reason) {
                                          offcet = ProjectCubit.get(context)
                                              .changeIndex(indeex: index);
                                        },
                                        viewportFraction: 1,
                                        enableInfiniteScroll: false,
                                        scrollPhysics: BouncingScrollPhysics(),
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: SmoothIndicator(
                                        offset: offcet,
                                        count: product.images!.length,
                                        effect: WormEffect(
                                          dotColor: secondColor,
                                          dotHeight: 8,
                                          dotWidth: 8,
                                          activeDotColor: switchColors,
                                        )),
                                  ),
                                ]),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 3,
                                            color: Colors.black54,
                                            spreadRadius: 0.3)
                                      ],
                                    ),
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.white,
                                      child: InkWell(
                                        onTap: () {
                                          savedd = ProjectCubit.get(context)
                                              .changeSavedState(savedd);
                                          if (savedd == true) {
                                            ProjectCubit.get(context)
                                                .addFavorite(
                                                    productId: product.id);
                                          } else {
                                            ProjectCubit.get(context)
                                                .deleteFavorite(
                                                    productId: product.id);
                                          }
                                        },
                                        child: Icon(
                                          savedd
                                              ? Icons.favorite
                                              : Icons.favorite_outline,
                                          color: savedColor,
                                          size: 26,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        ]),
                    SizedBox(
                      height: 10,
                    ),
                    //product title
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          '${product.title}',
                          style: TextStyle(
                              color: textColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    //product price
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        '${product.price}\$',
                        style: TextStyle(
                            color: textColor,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //product info
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'About this item',
                        style: TextStyle(
                            color: textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'Type: ${product.category}',
                        style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'Brand: ${product.brand}',
                        style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'Condition: ${product.condition}',
                        style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Divider(
                        height: 1,
                        color: Colors.black38,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //product description
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'Item description',
                        style: TextStyle(
                            color: textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        '${product.body}',
                        style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Divider(
                        height: 1,
                        color: Colors.black38,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //about the saller
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'About this seller',
                        style: TextStyle(
                            color: textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                        onTap: () {
                          ProjectCubit.get(context).getProfileUser(
                              id: ProjectCubit.get(context)
                                  .profile!
                                  .data![0]
                                  .id);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileScreen()),
                          );
                        },
                        child: sellerItem(
                            ProjectCubit.get(context).followingState,
                            () {
                              ProjectCubit.get(context).changeFollowState();
                            },
                            context,
                            ProjectCubit.get(context).profile!.data![0].picture,
                            ProjectCubit.get(context).profile!.data![0].name,
                            () {
                              ProjectCubit.get(context).addFollowing(
                                  fllowingId: ProjectCubit.get(context)
                                      .profile!
                                      .data![0]
                                      .id);
                            },
                            () {
                              ProjectCubit.get(context).deleteFollowing(
                                  fllowingId: ProjectCubit.get(context)
                                      .profile!
                                      .data![0]
                                      .id);
                            },
                            ProjectCubit.get(context).profile!.data![0].email)),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Divider(
                        height: 1,
                        color: Colors.black38,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //more item to consider
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'More item to consider',
                        style: TextStyle(
                            color: textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 200,
                      child: Column(children: [
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) => Container(),
                            scrollDirection: Axis.horizontal,
                            primary: false,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: 5,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: productHome(
                                  image: "assets/images/tshirt.png",
                                  name: 'tshirt meduim',
                                  price: '100',
                                  context: context),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    //comments
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'Comments (${ProjectCubit.get(context).commentModel!.data!.length})',
                        style: TextStyle(
                            color: textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ConditionalBuilder(
                        condition:
                            ProjectCubit.get(context).commentModel == null,
                        builder: (context) => Center(
                                child: CircularProgressIndicator(
                              color: switchColors,
                            )),
                        fallback: (context) => ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => commentItem(
                                  name: ProjectCubit.get(context)
                                      .commentModel!
                                      .data![index]
                                      .author!
                                      .name,
                                  image: ProjectCubit.get(context)
                                      .commentModel!
                                      .data![index]
                                      .author!
                                      .picture,
                                  body: ProjectCubit.get(context)
                                      .commentModel!
                                      .data![index]
                                      .body,
                                  date: ProjectCubit.get(context)
                                      .commentModel!
                                      .data![index]
                                      .createdAt!
                                      .substring(0, 16)),
                              separatorBuilder: (context, index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Divider(
                                    height: 1,
                                    color: Colors.black38,
                                  ),
                                ),
                              ),
                              itemCount: ProjectCubit.get(context)
                                  .commentModel!
                                  .data!
                                  .length,
                              shrinkWrap: true,
                            )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: secondColor,
                      ),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: TextFormField(
                          controller: commentConteoller,
                          onFieldSubmitted: (value) {},
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'write your comment ….',
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.send_rounded,
                                size: 28,
                              ),
                              onPressed: () {
                                ProjectCubit.get(context).postComment(
                                    productID: product.id,
                                    body: commentConteoller.text);
                                FocusManager.instance.primaryFocus?.unfocus();
                                commentConteoller.clear();
                              },
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
