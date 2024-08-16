import 'package:convergeimmob/constants/app_colors.dart';
import 'package:convergeimmob/constants/app_styles.dart';
import 'package:convergeimmob/shared/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart' as latLng;

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
                center: latLng.LatLng(
                  36.47,
                  10.09,
                ),
                zoom: 10.0,
                minZoom: 3.0),
            children: [
              TileLayer(
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/houssemeddinembarek/cly8k5ish00hd01pgda7iajio/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiaG91c3NlbWVkZGluZW1iYXJlayIsImEiOiJjbGpzbjZkdWMwYzZsM2ZuMGxtNDN6dTMzIn0.jpXIKj6gqtJZNtr9BaiyNw',
                additionalOptions: {
                  'accessToken':
                      'pk.eyJ1IjoiaG91c3NlbWVkZGluZW1iYXJlayIsImEiOiJjbGpzbjZkdWMwYzZsM2ZuMGxtNDN6dTMzIn0.jpXIKj6gqtJZNtr9BaiyNw',
                  'id': 'mapbox.light'
                },
              ),
              // MarkerLayer(
              //   markers: markers,
              // ),
            ],
          ),
          Container(
            height: size.height * 0.2,
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04,
              vertical: size.width * 0.02,
            ),
            decoration: BoxDecoration(color: AppColors.white),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextField(
                      obscureText: false,
                      width: size.width * 0.75,
                      icon: Icons.search,
                      iconColor: AppColors.black.withOpacity(0.5),
                      text: "Search",
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/filter_screen');
                      },
                      child: Container(
                        height: size.height * 0.06,
                        width: size.height * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                            color: AppColors.black.withOpacity(0.5),
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.filter_alt_outlined,
                          color: AppColors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: size.width,
                  height: size.height * 0.1,
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
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.1,
            minChildSize: 0.1,
            maxChildSize: 0.9,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.whiteBgScrolledlist,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      width: 41,
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppColors.black,
                        borderRadius: BorderRadius.all(
                          Radius.circular(24),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        controller: scrollController,
                        itemCount: 12,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed('detail_property');
                            },
                            child: Container(
                                width: size.width * 0.6,
                                height: 96,
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(color:  AppColors.whiteBgScrolledlist,),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Spacer(
                                      flex: 2,
                                    ),
                                    SizedBox(
                                      width: size.width * 0.2,
                                      height: size.width * 0.2,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          "assets/images/appart.jpg",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Spacer(
                                      flex: 1,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          width: size.width*0.5,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Property Name",
                                                style: AppStyles.title(),
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: size.width*0.01,vertical: size.height*0.001),
                                                decoration: BoxDecoration(color: AppColors.gNavBgColor,borderRadius: BorderRadius.all(Radius.circular(99)),),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.star,color: AppColors.yellow,size: size.width*0.03,),
                                                    SizedBox(width:size.width*0.01),
                                                    Text("4.6",style: AppStyles.smallTitle(fontSize: 10,fontWeight: FontWeight.w400),)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.bed,
                                              size: 16,
                                              color: AppColors.grey,
                                            ),
                                            Text("3",
                                                style: AppStyles.smallTitle()),
                                            Icon(
                                              Icons.bathtub_outlined,
                                              size: 16,
                                              color: AppColors.grey,
                                            ),
                                            Text(
                                              "4",
                                              style: AppStyles.smallTitle(),
                                            ),
                                            // Icon(Icons.),
                                            Text("hb",
                                                style: AppStyles.smallTitle()),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 16,
                                              color: AppColors.grey,
                                            ),
                                            Text("Place",
                                                style: AppStyles.smallTitle()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Spacer(
                                      flex: 2,
                                    )
                                  ],
                                )),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
