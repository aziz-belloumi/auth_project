import 'package:convergeimmob/authServices/bloc/log_out_cubit.dart';
import 'package:convergeimmob/authServices/global_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:imageview360/imageview360.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:panorama_viewer/panorama_viewer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_360/video_360.dart';
import 'package:convergeimmob/constants/app_colors.dart';
import 'package:convergeimmob/constants/app_styles.dart';
import 'package:convergeimmob/shared/app_textfield.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  String? profilePicture;
  String? email ;
  String? firstName ;

  @override
  void initState(){
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null && JwtDecoder.isExpired(token) == false) {
      final decodedToken = JwtDecoder.decode(token);
      setState(() {
        profilePicture = decodedToken['profilePicture'];
        email = decodedToken["email"] ;
        firstName = decodedToken["firstName"];
      });
    }
  }

  Flutter3DController controller = Flutter3DController();

  Video360Controller? video360Controller;

  String durationText = '';

  String totalText = '';


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<LogOutCubit,AuthState>(
        listener: (context,state){
          if (state is AuthLoading) {
            showDialog(
              context: context,
              builder: (context) => const Center(child: CircularProgressIndicator()),
            );
          }
          else if (state is AuthInitial) {
            Get.offAllNamed('/login');
          }
          else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
          },
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.04,
                      vertical: size.width * 0.02,
                    ),
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
                            Container(
                              height: size.height * 0.06,
                              width: size.height * 0.06,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                border: Border.all(
                                  color: AppColors.black.withOpacity(0.5),
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                Icons.filter_alt_outlined,
                                color: AppColors.black.withOpacity(0.5),
                              ),
                            )
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
                                padding: const EdgeInsets.all(8.0),
                                child: const Center(
                                  child: Text("ok"),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: size.width,
                          height: size.height * 0.45,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 12,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed('detail_property');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.5,
                                        height: size.height * 0.3,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.asset(
                                            "assets/images/appart.jpg",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Property Name",
                                            style: AppStyles.title(),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.bed,
                                            size: 16,
                                            color: AppColors.grey,
                                          ),
                                          Text("3",
                                              style: AppStyles.smallTitle()),
                                          const Icon(
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
                                          const Icon(
                                            Icons.location_on,
                                            size: 16,
                                            color: AppColors.grey,
                                          ),
                                          Text("Place",
                                              style: AppStyles.smallTitle()),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "\$200",
                                            style: AppStyles.title(),
                                          ),
                                        ],
                                      ),
                                      Text("Per month",
                                          style: AppStyles.smallTitle()),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                            width: size.width * 0.9,
                            height: size.height * 0.05,
                            child: Text(
                              "Best Matches For You",
                              style: AppStyles.title(fontSize: 24),
                            )),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: size.width * 0.9,
                              height: size.height * 0.3,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  "assets/images/appart.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.9,
                              child: Row(
                                children: [
                                  Text(
                                    "Property Name",
                                    style: AppStyles.title(),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.9,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.bed,
                                    size: 16,
                                    color: AppColors.grey,
                                  ),
                                  Text("3", style: AppStyles.smallTitle()),
                                  const Icon(
                                    Icons.bathtub_outlined,
                                    size: 16,
                                    color: AppColors.grey,
                                  ),
                                  Text(
                                    "4",
                                    style: AppStyles.smallTitle(),
                                  ),
                                  Text("hb", style: AppStyles.smallTitle()),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.9,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: AppColors.grey,
                                  ),
                                  Text("Place", style: AppStyles.smallTitle()),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.9,
                              child: Row(
                                children: [
                                  Text(
                                    "\$200",
                                    style: AppStyles.title(),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                width: size.width * 0.9,
                                child: Text("Per month",
                                    style: AppStyles.smallTitle())),
                          ],
                        ),
                      );
                    },
                    childCount: 12, // Number of items in the list
                  ),
                ),
              ],
            ),
            Positioned(
                bottom: 0,
                left: size.width * 0.3,
                right: size.width * 0.3,
                child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed("map_screen");
                    },
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            AppColors.bluePrimaryHigher)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(
                          Icons.map_outlined,
                          color: AppColors.white,
                        ),
                        Text(
                          "Map View",
                          style: AppStyles.smallTitleWhite(
                              fontSize: size.width * 0.038),
                        ),
                      ],
                    )))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed("create_property");
        },
        backgroundColor: AppColors.bluePrimaryHigher,
        child: const Icon(Icons.add, color: AppColors.white),
      ),
      drawer: Drawer(
          backgroundColor: AppColors.bluebgNavItem,
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 64),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(size.width*0.006),
                      decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(100), 
                          color: Colors.white
                      ),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: profilePicture != null && profilePicture!.isNotEmpty
                            ? NetworkImage(profilePicture!)
                            : const NetworkImage("https://i.pinimg.com/736x/09/21/fc/0921fc87aa989330b8d403014bf4f340.jpg"),
                      ),
                    ),
                    SizedBox(width: size.width * 0.04,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start ,
                      children: [
                        Text(
                          "$firstName",
                        style: const TextStyle(color: AppColors.white,fontSize:16 , fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "$email",
                          style: const TextStyle(color: AppColors.white , fontSize:13),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height : size.height * 0.03,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.home_outlined,
                      color: AppColors.white,
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    TextButton(
                      child: Text(
                        "Home",
                        style: AppStyles.smallTitle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white),
                      ),
                      onPressed: (){},
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.favorite_border,
                      color: AppColors.white,
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    TextButton(
                      child: Text(
                        "Favorites",
                        style: AppStyles.smallTitle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white),
                      ),
                      onPressed: (){},
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.message_sharp,
                      color: AppColors.white,
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    TextButton(
                      child: Text(
                        "Messages",
                        style: AppStyles.smallTitle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white),
                      ),
                      onPressed: (){},
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.notifications_none_rounded,
                      color: AppColors.white,
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    TextButton(
                      child: Text(
                        "Notifications",
                        style: AppStyles.smallTitle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white),
                      ),
                      onPressed: (){},
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.manage_search,
                      color: AppColors.white,
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    TextButton(
                      child: Text(
                        "Manage Listings",
                        style: AppStyles.smallTitle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white),
                      ),
                      onPressed: (){},
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add_home_outlined,
                      color: AppColors.white,
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    TextButton(
                      child: Text(
                        "Add New Property",
                        style: AppStyles.smallTitle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white),
                      ),
                      onPressed: (){},
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.settings,
                      color: AppColors.white,
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    TextButton(
                      child: Text(
                        "Account Settings",
                        style: AppStyles.smallTitle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white),
                      ),
                      onPressed: (){
                        Get.offAllNamed("/profile" );
                      },
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.contact_support_rounded,
                      color: AppColors.white,
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    TextButton(
                      child: Text(
                        "Support",
                        style: AppStyles.smallTitle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white),
                      ),
                      onPressed: (){},

                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.privacy_tip_outlined,
                      color: AppColors.white,
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    TextButton(
                      child: Text(
                        "Terms and Privacy",
                        style: AppStyles.smallTitle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white),
                      ),
                      onPressed: (){},
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.attach_money,
                      color: AppColors.white,
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    TextButton(
                      child: Text(
                        "Rent Affordability Calculator",
                        style: AppStyles.smallTitle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white),
                      ),
                      onPressed: (){},
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.star_rate_outlined,
                      color: AppColors.white,
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    TextButton(
                      child: Text(
                        "Rate the App",
                        style: AppStyles.smallTitle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white),
                      ),
                      onPressed: (){},
                    ),
                  ],
                ),
                SizedBox(height : size.height * 0.04,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.logout,
                      color: AppColors.white,
                    ),
                    TextButton(
                      child: Text("Log out",
                        style: AppStyles.smallTitle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white),
                      ),
                      onPressed: () {
                        context.read<LogOutCubit>().logOut();
                      },
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
