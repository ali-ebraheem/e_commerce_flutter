import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:project_collage/Cubit/cubit.dart';
import 'package:project_collage/Cubit/states.dart';
import 'package:project_collage/Shared/components/components.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController discriptionController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController brandController = TextEditingController();
    List<String> items = [
      'Category :',
      'Electronics',
      'Vehicles',
      'Fashion',
      'Food',
      'Jobs',
      'Books',
      'Cell Phones',
    ];
    List<String> condition = [
      'Condition :',
      'new',
      'used',
    ];

    int categoryIndex = 0;
    return BlocConsumer<ProjectCubit, ProjectStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var dashboardCubit = ProjectCubit.get(context);
          return Scaffold(
            bottomSheet: InkWell(
              onTap: () {
                print(priceController.text);
                categoryIndex =
                    findIndexWhere(items, dashboardCubit.categoryDropdownvalue);
                if (priceController.text.isNotEmpty &&
                    nameController.text.isNotEmpty &&
                    discriptionController.text.isNotEmpty &&
                    dashboardCubit.imagesDashboard.isNotEmpty) {
                  dashboardCubit.postProduct(
                    price: priceController.text,
                    image: dashboardCubit.images,
                    title: nameController.text,
                    body: discriptionController.text,
                    categoryId: categoryIndex == 0 ? 11 : categoryIndex,
                    brand: brandController.text,
                    condition:
                        dashboardCubit.conditionDropdownvalue == 'Condition :'
                            ? 'not set'
                            : dashboardCubit.conditionDropdownvalue,
                  );
                  Fluttertoast.showToast(
                      msg: "Your product has been posted",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  Navigator.pop(context);
                } else {
                  Fluttertoast.showToast(
                      msg: "Please fill in all fields",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
              child: Container(
                height: 50,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'save and post',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                color: switchColors,
              ),
            ),
            appBar: AppBar(
              leading: Builder(
                builder: (context) => IconButton(
                  onPressed: () {
                    categoryIndex = findIndexWhere(
                        items, dashboardCubit.categoryDropdownvalue);
                    if (priceController.text.isNotEmpty &&
                        nameController.text.isNotEmpty &&
                        discriptionController.text.isNotEmpty &&
                        dashboardCubit.imagesDashboard.isNotEmpty) {
                      dashboardCubit.postProduct(
                        price: priceController.text,
                        image: dashboardCubit.images,
                        title: nameController.text,
                        body: discriptionController.text,
                        categoryId: categoryIndex == 0 ? 11 : categoryIndex,
                        brand: brandController.text,
                        condition: dashboardCubit.conditionDropdownvalue ==
                                'Condition :'
                            ? 'not set'
                            : dashboardCubit.conditionDropdownvalue,
                      );
                      Fluttertoast.showToast(
                          msg: "Your product has been posted",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      Navigator.pop(context);
                    } else {
                      Fluttertoast.showToast(
                          msg: "Please fill in all fields",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
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
                'Dashboard',
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
                        //get image from gallery
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  ProjectCubit.get(context).pickImage();
                                },
                                child: Container(
                                  width: 95,
                                  height: 90,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: switchColors),
                                  child: Icon(
                                    Icons.add_a_photo_rounded,
                                    size: 70,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 90,
                                width: 245,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: ListView.separated(
                                          separatorBuilder: (context, index) =>
                                              Container(),
                                          scrollDirection: Axis.horizontal,
                                          primary: false,
                                          shrinkWrap: true,
                                          physics: BouncingScrollPhysics(),
                                          itemCount: ProjectCubit.get(context)
                                              .imagesDashboard
                                              .length,
                                          itemBuilder: (context, index) =>
                                              Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: ProjectCubit.get(context)
                                                    .imagesDashboard
                                                    .isEmpty
                                                ? Container()
                                                : imageItem(
                                                    image: ProjectCubit.get(
                                                            context)
                                                        .imagesDashboard[index],
                                                    removeItem: () {
                                                      ProjectCubit.get(context)
                                                          .removeImage(
                                                              index: index);
                                                    }),
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                            ]),
                        SizedBox(
                          height: 30,
                        ),
                        //select category
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Container(
                              height: 55,
                              width: double.infinity,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    style: TextStyle(
                                        color: textColor, fontSize: 18),
                                    isExpanded: true,
                                    value: ProjectCubit.get(context)
                                        .categoryDropdownvalue,
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    items: items.map((String items) {
                                      return DropdownMenuItem(
                                          value: items, child: Text(items));
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      ProjectCubit.get(context)
                                          .changeCategoryDropdownvalue(
                                              dropdownvaluee: newValue);
                                    },
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 1,
                                      spreadRadius: 0.0,
                                      offset: Offset(
                                        0.0,
                                        1.0,
                                      ), // shadow direction: bottom right
                                    )
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: Colors.white, width: 1))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //prouduct name
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: Container(
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 2,
                                      spreadRadius: 0.0,
                                      offset: Offset(
                                        0.0,
                                        1.0,
                                      ), // shadow direction: bottom right
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: TextFormField(
                                      controller: nameController,
                                      style: TextStyle(fontSize: 18),
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Product name...',
                                        hintStyle: TextStyle(fontSize: 18),
                                      ),
                                    )))),
                        SizedBox(
                          height: 20,
                        ),
                        // condition and brand
                        Row(
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                child: Container(
                                    height: 55,
                                    width: 150,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          style: TextStyle(
                                              color: textColor, fontSize: 18),
                                          isExpanded: true,
                                          value: ProjectCubit.get(context)
                                              .conditionDropdownvalue,
                                          icon: Icon(Icons.keyboard_arrow_down),
                                          items: condition.map((String items) {
                                            return DropdownMenuItem(
                                                value: items,
                                                child: Text(items));
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            ProjectCubit.get(context)
                                                .changeConditionDropdownvalue(
                                                    dropdownvalue: newValue);
                                          },
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black,
                                            blurRadius: 2,
                                            spreadRadius: 0.0,
                                            offset: Offset(
                                              0.0,
                                              1.0,
                                            ), // shadow direction: bottom right
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.white, width: 1)))),
                            SizedBox(
                              width: 40,
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                child: Container(
                                    height: 55,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 2,
                                          spreadRadius: 0.0,
                                          offset: Offset(
                                            0.0,
                                            1.0,
                                          ), // shadow direction: bottom right
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: TextFormField(
                                          controller: brandController,
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
                                            border: InputBorder.none,
                                            hintText: 'Brand...',
                                            hintStyle: TextStyle(fontSize: 18),
                                          ),
                                        ))),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // description
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 2,
                                  spreadRadius: 0.0,
                                  offset: Offset(
                                    0.0,
                                    1.0,
                                  ), // shadow direction: bottom right
                                )
                              ],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                controller: discriptionController,
                                style: TextStyle(fontSize: 18),
                                maxLines: 6,
                                keyboardType: TextInputType.multiline,
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Description...',
                                  hintStyle: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //price
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: Container(
                                height: 55,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 2,
                                      spreadRadius: 0.0,
                                      offset: Offset(
                                        0.0,
                                        1.0,
                                      ), // shadow direction: bottom right
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: TextFormField(
                                      controller: priceController,
                                      style: TextStyle(fontSize: 20),
                                      keyboardType: TextInputType.number,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.red),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        border: InputBorder.none,
                                        hintText: 'Price...',
                                        hintStyle: TextStyle(fontSize: 18),
                                      ),
                                    )))),
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
