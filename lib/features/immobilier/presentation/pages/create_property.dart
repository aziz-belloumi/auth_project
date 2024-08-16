import 'package:convergeimmob/constants/app_colors.dart';
import 'package:convergeimmob/constants/app_styles.dart';
import 'package:convergeimmob/features/immobilier/domain/entities/property.dart';
import 'package:convergeimmob/features/immobilier/presentation/bloc/property_bloc.dart';
import 'package:convergeimmob/features/immobilier/presentation/bloc/property_event.dart';
import 'package:convergeimmob/features/immobilier/presentation/bloc/property_state.dart';
import 'package:convergeimmob/shared/app_button.dart';
import 'package:convergeimmob/shared/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class CreatePropertyScreen extends StatelessWidget {
  CreatePropertyScreen({super.key});

  List describePropertyList = [
    {"icon": Icons.home, "title": "House"},
    {"icon": Icons.apartment, "title": "Apartment"},
    {"icon": Icons.villa, "title": "Villa"},
    {"icon": Icons.house_sharp, "title": "Townhouse"},
    {"icon": Icons.scatter_plot, "title": "Residential Plot"},
    {"icon": Icons.house_siding, "title": "Residential Building"},
    {"icon": Icons.maps_home_work_outlined, "title": "Office"},
    {"icon": Icons.shop, "title": "Shop"},
    {"icon": Icons.holiday_village, "title": "Commercial Villa"},
    {"icon": Icons.shower_outlined, "title": "Showroom"},
    {"icon": Icons.map, "title": "Commercial Plot"},
    {"icon": Icons.apartment_sharp, "title": "Commercial Building"},
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Add New Property",
      //       style: AppStyles.smallTitle(
      //         fontSize: 20,
      //         fontWeight: FontWeight.w700,
      //       )),
      // ),
      body: BlocListener<PropertyBloc, PropertyState>(
        listener: (context, state) {
          if (state is PropertyLoaded) {
            Get.snackbar('Success', 'Property added successfully!');
          } else if (state is PropertyError) {
            Get.snackbar('Error', state.message);
          }
        },
        child:
            BlocBuilder<PropertyBloc, PropertyState>(builder: (context, state) {
          int selectedIndex = -1;
          if (state is PropertyTypeSelected) {
            selectedIndex = state.selectedIndex;
          }

          return Container(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 64,
              bottom: 64,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Which of the following best describes your property?",
                    textAlign: TextAlign.center,
                    style: AppStyles.smallTitle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    )),
                Expanded(
                  child: GridView.builder(
                    itemCount: describePropertyList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            (orientation == Orientation.portrait) ? 3 : 3),
                    // padding: EdgeInsets.all(10),
                    itemBuilder: (BuildContext context, int index) {
                      return new GestureDetector(
                        onTap: () {
                          // print(describePropertyList[index]["title"]);
                          // print(index);
                          context.read<PropertyBloc>().add(SelectPropertyType(index));

                          // print(state.selectedIndex);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.01,
                            vertical: size.width * 0.01,
                          ),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border: Border.all(
                                  width: 2,
                                  color: selectedIndex == index
                                      ? AppColors.bluebgNavItem
                                      : AppColors.greyDescribePropertyItem),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.01,
                              vertical: size.width * 0.01,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  describePropertyList[index]['icon'],
                                  color: selectedIndex == index
                                      ? AppColors.bluebgNavItem
                                      : AppColors.greyDescribePropertyItem,
                                ),
                                Text(
                                  describePropertyList[index]['title']
                                      .toString(),
                                  style: AppStyles.smallTitle(
                                      color:
                                      selectedIndex == index
                                          ? AppColors.bluebgNavItem
                                          : AppColors.greyDescribePropertyItem),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                SizedBox(
                  width: size.width,
                  height: size.height * 0.08,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text('Back')),
                      AppButton(
                        onPressed: () {
                          // context.read<PropertyBloc>().add(AddProperty(property));
                        },
                        width: size.width * 0.3,
                        child: Text('Continue'),
                      ),
                    ],
                  ),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     // Property property = Property(name: nameController.text);
                //     // final name = nameController.text;
                //     // final description = descriptionController.text;
                //
                //     // context.read<PropertyBloc>().add(AddProperty(property));
                //   },
                //   child: Text('Continue'),
                // ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
