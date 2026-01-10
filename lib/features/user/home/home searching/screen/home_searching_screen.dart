import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/themes/app_colors.dart';
import '../widget/body_container_widget.dart';
import '../widget/calender_widget/calender_dialog_box_widget.dart';

class HomeSearchingScreen extends StatefulWidget {
  const HomeSearchingScreen({super.key});

  @override
  State<HomeSearchingScreen> createState() => _HomeSearchingScreenState();
}

class _HomeSearchingScreenState extends State<HomeSearchingScreen> {
  List<Map<String, String>> countries = [
    {
      "countryName": "I'm flexible",
      "worldMapImage": "https://i.postimg.cc/3JYSHSBW/Image-(19).png",
    },
    {
      "countryName": "Lebanon",
      "worldMapImage":
      "https://i.postimg.cc/W4yNBJc5/Screenshot-2025-12-21-203118.jpg",
    },
    {
      "countryName": "Jordan",
      "worldMapImage":
      "https://i.postimg.cc/9Q4Nx4bt/Screenshot-2025-12-21-203456.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(width: 44, child: const Divider()),

              /*  Row(
                  children: [
                    Text("Filter"),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("Cancel"),
                    ),
                  ],
                ),*/
                /*const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),*/
                Container(
                  height: 346,
                  width: 327,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Where to?",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                       /* const SizedBox(height: 20),
                        Container(
                          height: 38,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.black,
                              width: 1,
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                Icon(Icons.search),
                                SizedBox(width: 10),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "Search destinations",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),*/
                      /*  Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: countries.length,
                            itemBuilder: (context, index) {
                              return UserMapWidget(
                                selectCountry: false,
                                countryName: countries[index]['countryName'],
                                worldMapImage:
                                countries[index]['worldMapImage'],
                              );
                            },
                          ),
                        ),*/
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                BodyContainerWidget(
                  title: "Where",
                  subtitle: "Add guests",
                  callBackTap: () => _showCalenderDialog(context), // Fixed here
                ),
                const SizedBox(height: 10),
                BodyContainerWidget(
                  title: "When",
                  subtitle: "Any week",
                  callBackTap: () {
                    Get.bottomSheet(
                      const HomeSearchingScreen(),
                      isScrollControlled: true,
                    );
                  },
                ),
                const SizedBox(height: 10),

                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryColors,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Reset",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Spacer(),
                      ElevatedButton.icon(
                        icon: Icon(Icons.search, color: Colors.white),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.infoSecondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () {},
                        label: Text(
                          "Search",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCalenderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CalenderDialogBoxWidget();
      },
    );
  }
}
