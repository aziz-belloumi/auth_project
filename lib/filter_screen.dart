import 'package:convergeimmob/constants/app_colors.dart';
import 'package:convergeimmob/constants/app_styles.dart';
import 'package:convergeimmob/shared/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrolling_buttons_bar/scrolling_buttons_bar.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  RangeValues _currentRangeValues = const RangeValues(0, 1000);
  int selectedItemIndex = -1;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double childHeight = MediaQuery.of(context).size.height / 20;
    double childWidth = MediaQuery.of(context).size.width / 5;
    double iconSize = childHeight * 0.8;
    var toolbarItems = [
      Center(
        child: Text(
          "Properties",
          style: AppStyles.smallTitle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: selectedItemIndex == 0 ? AppColors.white : AppColors.grey),
        ),
      ),
      Center(
        child: Text(
          "New Projects",
          style: AppStyles.smallTitle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: selectedItemIndex == 1 ? AppColors.white : AppColors.grey),
        ),
      ),
    ];
    return Scaffold(
        appBar: AppBar(actions: [
          Container(
            width: size.width,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    "Cancel",
                    style: AppStyles.smallTitle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: size.width * 0.2,
                  child: Center(
                    child: Text(
                      "Filters",
                      style: AppStyles.smallTitle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  "Reset",
                  style: AppStyles.smallTitle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          )
        ], automaticallyImplyLeading: false),
        body: Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.only(left: 16, right: 16, top: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(99)),
                        border: Border.all(width: 1, color: AppColors.grey)),
                    padding: EdgeInsets.all(1),
                    child: ScrollingButtonBar(
                      selectedItemIndex: selectedItemIndex,
                      scrollController: _scrollController,
                      childWidth: childWidth,
                      childHeight: childHeight,
                      foregroundColor: AppColors.bluePrimaryHigher,
                      radius: 99,
                      animationDuration: const Duration(milliseconds: 333),
                      children: [
                        for (int i = 0; i < toolbarItems.length; i++)
                          buildSingleItemInToolbar(i, toolbarItems)
                      ],
                    )),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: size.width * 0.42,
                      height: size.height * 0.06,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          border: Border.all(
                            width: 1,
                          )),
                      child: Text(
                        "Rent",
                        style: AppStyles.smallTitle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      width: size.width * 0.42,
                      height: size.height * 0.06,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          border: Border.all(
                            width: 1,
                          )),
                      child: Text(
                        "Buy",
                        style: AppStyles.smallTitle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: size.width,
                  child: Text(
                    "Location",
                    style: AppStyles.smallTitle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                AppTextField(
                  obscureText: false,
                  text: "Search for locality, area or city",
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: size.width,
                  child: Text(
                    "Property Type",
                    style: AppStyles.smallTitle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: size.width * 0.42,
                      height: size.height * 0.06,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          border: Border.all(
                            width: 1,
                          )),
                      child: Text(
                        "Residential",
                        style: AppStyles.smallTitle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      width: size.width * 0.42,
                      height: size.height * 0.06,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          border: Border.all(
                            width: 1,
                          )),
                      child: Text(
                        "Commercial",
                        style: AppStyles.smallTitle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: size.width,
                  height: size.height * 0.04,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 12,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text("ok"),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: size.width,
                  child: Text(
                    "Budget",
                    style: AppStyles.smallTitle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$ ${_currentRangeValues.start.round().toString()}",
                      style: AppStyles.smallTitle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "\$ ${_currentRangeValues.end.round().toString()}",
                      style: AppStyles.smallTitle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.04,
                  child: RangeSlider(
                    values: _currentRangeValues,
                    min: 0,
                    max: 1000,
                    divisions: 1000,
                    activeColor: AppColors.bluebgNavItem,
                    labels: RangeLabels(
                      _currentRangeValues.start.round().toString(),
                      _currentRangeValues.end.round().toString(),
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        _currentRangeValues = values;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: size.width,
                  child: Text(
                    "Bedrooms",
                    style: AppStyles.smallTitle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.04,
                          vertical: size.height * 0.003),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: AppColors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Text(
                        'Any',
                        style: AppStyles.smallTitle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.04,
                          vertical: size.height * 0.003),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: AppColors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Text(
                        '1',
                        style: AppStyles.smallTitle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.04,
                          vertical: size.height * 0.003),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: AppColors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Text(
                        '2',
                        style: AppStyles.smallTitle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.04,
                          vertical: size.height * 0.003),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: AppColors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Text(
                        '3',
                        style: AppStyles.smallTitle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.04,
                          vertical: size.height * 0.003),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: AppColors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Text(
                        '4',
                        style: AppStyles.smallTitle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.04,
                          vertical: size.height * 0.003),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: AppColors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Text(
                        '5',
                        style: AppStyles.smallTitle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.04,
                          vertical: size.height * 0.003),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: AppColors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Text(
                        '5+',
                        style: AppStyles.smallTitle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: size.width,
                  child: Text(
                    "Beds",
                    style: AppStyles.smallTitle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.04,
                          vertical: size.height * 0.003),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: AppColors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Text(
                        'Any',
                        style: AppStyles.smallTitle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.04,
                          vertical: size.height * 0.003),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: AppColors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Text(
                        '1',
                        style: AppStyles.smallTitle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.04,
                          vertical: size.height * 0.003),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: AppColors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Text(
                        '2',
                        style: AppStyles.smallTitle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.04,
                          vertical: size.height * 0.003),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: AppColors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Text(
                        '3',
                        style: AppStyles.smallTitle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.04,
                          vertical: size.height * 0.003),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: AppColors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Text(
                        '4',
                        style: AppStyles.smallTitle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.04,
                          vertical: size.height * 0.003),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: AppColors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Text(
                        '5',
                        style: AppStyles.smallTitle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.04,
                          vertical: size.height * 0.003),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: AppColors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Text(
                        '5+',
                        style: AppStyles.smallTitle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: size.width,
                  child: Text(
                    "Built Up Area",
                    style: AppStyles.smallTitle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      " ${_currentRangeValues.start.round().toString()} m",
                      style: AppStyles.smallTitle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "\$ ${_currentRangeValues.end.round().toString()} m",
                      style: AppStyles.smallTitle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.04,
                  child: RangeSlider(
                    values: _currentRangeValues,
                    min: 0,
                    max: 1000,
                    divisions: 1000,
                    activeColor: AppColors.bluebgNavItem,
                    labels: RangeLabels(
                      _currentRangeValues.start.round().toString(),
                      _currentRangeValues.end.round().toString(),
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        _currentRangeValues = values;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: size.width,
                  child: Text(
                    "Rental Frequency",
                    style: AppStyles.smallTitle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.02,
                          vertical: size.height * 0.003),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: AppColors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Text(
                        'Any',
                        style: AppStyles.smallTitle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.02,
                          vertical: size.height * 0.003),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: AppColors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Text(
                        'Yearly',
                        style: AppStyles.smallTitle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.02,
                          vertical: size.height * 0.003),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: AppColors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Text(
                        'Monthly',
                        style: AppStyles.smallTitle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.02,
                          vertical: size.height * 0.003),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: AppColors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Text(
                        'Weekly',
                        style: AppStyles.smallTitle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.02,
                          vertical: size.height * 0.003),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: AppColors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Text(
                        'Daily',
                        style: AppStyles.smallTitle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: size.width,
                  child: Text(
                    "Keywords",
                    style: AppStyles.smallTitle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                AppTextField(
                  obscureText: false,
                  text: "Enter a keyword",
                ),
                SizedBox(
                  width: size.width,
                  child: Text(
                    "Agent or Agency",
                    style: AppStyles.smallTitle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                AppTextField(
                  obscureText: false,
                  text: "Select agents or agencies",
                ),
                SizedBox(
                  width: size.width,
                  child: Text(
                    "Amenities",
                    style: AppStyles.smallTitle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.06,
                  child: Row(
                    children: [
                      Icon(
                        Icons.wifi,
                        size: 20,
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Text(
                        "Wifi",
                        style: AppStyles.smallTitle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      Spacer(
                        flex: 17,
                      ),
                      Checkbox(value: false, onChanged: (value) {})
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                  child: Row(
                    children: [
                      Icon(
                        Icons.tv,
                        size: 20,
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Text(
                        "TV",
                        style: AppStyles.smallTitle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      Spacer(
                        flex: 17,
                      ),
                      Checkbox(value: false, onChanged: (value) {})
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                  child: Row(
                    children: [
                      Icon(
                        Icons.hot_tub,
                        size: 20,
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Text(
                        "Hot Tub",
                        style: AppStyles.smallTitle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      Spacer(
                        flex: 17,
                      ),
                      Checkbox(value: false, onChanged: (value) {})
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                  child: Row(
                    children: [
                      Icon(
                        Icons.mode_fan_off_outlined,
                        size: 20,
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Text(
                        "Air Conditioning",
                        style: AppStyles.smallTitle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      Spacer(
                        flex: 17,
                      ),
                      Checkbox(value: false, onChanged: (value) {})
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                  child: Row(
                    children: [
                      Icon(
                        Icons.local_laundry_service_rounded,
                        size: 20,
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Text(
                        "Laundry Facilities",
                        style: AppStyles.smallTitle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      Spacer(
                        flex: 17,
                      ),
                      Checkbox(value: false, onChanged: (value) {})
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                  child: Row(
                    children: [
                      Icon(
                        Icons.kitchen,
                        size: 20,
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Text(
                        "Kitchen",
                        style: AppStyles.smallTitle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      Spacer(
                        flex: 17,
                      ),
                      Checkbox(value: false, onChanged: (value) {})
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                  child: Row(
                    children: [
                      Icon(
                        Icons.security,
                        size: 20,
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Text(
                        "Security Features",
                        style: AppStyles.smallTitle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      Spacer(
                        flex: 17,
                      ),
                      Checkbox(value: false, onChanged: (value) {})
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                  child: Row(
                    children: [
                      Icon(
                        Icons.local_parking,
                        size: 20,
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Text(
                        "Parking",
                        style: AppStyles.smallTitle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      Spacer(
                        flex: 17,
                      ),
                      Checkbox(value: false, onChanged: (value) {})
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                  child: Row(
                    children: [
                      Icon(
                        Icons.mode_fan_off_sharp,
                        size: 20,
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Text(
                        "Pet-Friendly",
                        style: AppStyles.smallTitle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      Spacer(
                        flex: 17,
                      ),
                      Checkbox(value: false, onChanged: (value) {})
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                  child: Row(
                    children: [
                      Icon(
                        Icons.sports_gymnastics,
                        size: 20,
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Text(
                        "Gym",
                        style: AppStyles.smallTitle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      Spacer(
                        flex: 17,
                      ),
                      Checkbox(value: false, onChanged: (value) {})
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                  child: Row(
                    children: [
                      Icon(
                        Icons.pool,
                        size: 20,
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Text(
                        "Pool",
                        style: AppStyles.smallTitle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      Spacer(
                        flex: 17,
                      ),
                      Checkbox(value: false, onChanged: (value) {})
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                  child: Row(
                    children: [
                      Icon(
                        Icons.grass,
                        size: 20,
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Text(
                        "Outdoor Space",
                        style: AppStyles.smallTitle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      Spacer(
                        flex: 17,
                      ),
                      Checkbox(value: false, onChanged: (value) {})
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                  child: Row(
                    children: [
                      Icon(
                        Icons.elevator,
                        size: 20,
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Text(
                        "Elevator",
                        style: AppStyles.smallTitle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      Spacer(
                        flex: 17,
                      ),
                      Checkbox(value: false, onChanged: (value) {})
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.02)
              ],
            ),
          ),
        ));
  }

  buildSingleItemInToolbar(i, toolbarItems) {
    return ButtonsItem(
        child: toolbarItems[i],
        onTap: () {
          setState(() {
            selectedItemIndex = i;
          });
        });
  }
}
