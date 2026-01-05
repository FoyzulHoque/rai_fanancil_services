import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/widgets/custom_background_widget.dart';
import '../widget/body_widget_1.dart';
import '../widget/custom_app_bar_details_widget.dart';
import '../widget/custom_container_widget.dart';
import '../widget/details_slider_widget.dart';
import 'package:get/get.dart';

import '../widget/map_body_widget.dart';
import '../widget/popular_facilities_widget.dart';

class HomeDetailsScreen extends StatefulWidget {
  const HomeDetailsScreen({super.key});

  @override
  State<HomeDetailsScreen> createState() => _HomeDetailsScreenState();
}

class _HomeDetailsScreenState extends State<HomeDetailsScreen> {
  bool _isExpanded = false;
  final List<String> imagesList = [
    "https://i.postimg.cc/qMWVj71K/Rectangle-34624198.png",
    "https://i.postimg.cc/pXkBbz4L/Mask-group-(1).png",
    "https://i.postimg.cc/CLvb6Yn0/Mask-group-(2).png",
    "https://i.postimg.cc/Xv6qsDLy/Mask-group-(3).png",
    "https://i.postimg.cc/pdBWqVyY/Mask-group-(4).png",
    "https://i.postimg.cc/yx3z47Yg/Mask-group-(5).png",
    "https://i.postimg.cc/NFcZVmVd/Mask-group-(7).png",
    "https://i.postimg.cc/qMWVj71K/Rectangle-34624198.png",
    "https://i.postimg.cc/qMWVj71K/Rectangle-34624198.png",
    "https://i.postimg.cc/qMWVj71K/Rectangle-34624198.png",
  ];
  final List<Map<String, dynamic>> popularFacilities = [
    {
      "title": "Swimming pool",
      "image": "assets/icons/mingcute_swimming-pool-line1.png",
    },
    {"title": "WiFi", "image": "assets/icons/ic_round-wifi2.png"},
    {"title": "AC", "image": "assets/icons/ic_round-ac-unit4.png"},
    {"title": "Parking", "image": "assets/icons/mdi_car-outline.png"},
    {"title": "Smoking area", "image": "assets/icons/tabler_smoking6.png"},
    {"title": "Television", "image": "assets/icons/tabler_device-tv-old.png"},
    {
      "title": "Shower",
      "image": "assets/icons/material-symbols_shower-outline-rounded.png",
    },
    {
      "title": "Refrigerator",
      "image": "assets/icons/mdi_refrigerator-outline.png",
    },
  ];

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: CustomBackgroundWidget(
        containerHeight: 1856,
        //containerWidth: 375,
        image: "assets/images/Home(details).png",
        topLeft: 16,
        topRight: 16,
        bottomLeft: 0,
        bottomRight: 0,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  // Slider Widget
                  DetailsSliderWidget(images: imagesList, selectImage: false),

                  // Custom App Bar (Back button + Like)
                  Positioned(
                    top:
                        MediaQuery.of(context).padding.top +
                        10, // Status bar safe
                    left: 16,
                    right: 16,
                    child: CustomAppBarDetailsWidget(
                      arrowBack: () {
                        Get.back();
                      },
                      initialIsLike: true,
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cedar Breeze Hilltop Residence",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      BodyWidget1(
                        starCount: 3,
                        buttonCallBack: () {},
                        buttonText: "Immersive Experience",
                        description:
                            '''We were only sad not to stay longer. We hope to be back to explore Nantes some more and would love to stay at Golwen’s place again, if they’ll have us! .We were only sad not to stay longer. We hope to be back to explore Nantes some more and would love to stay at Golwen’s place again, if they’ll have us! .We were only sad not to stay longer. We hope to be back to explore Nantes some more and would love to stay at Golwen’s place again, if they’ll have us! .We were only sad not to stay longer. We hope to be back to explore Nantes some more and would love to stay at Golwen’s place again, if they’ll have us! ''',
                        ratingPercentage: '4.6',
                        totalRating: '462',
                      ),
                      const SizedBox(height: 10),
                      MapBodyWidget(
                        locationName: "Beirut, Lebanon",
                        latitude: 33.888630,
                        longitude: 35.495480,
                        zoom: 15,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Facilities",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10),

                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 159.5 / 72, // ✅ এটা যোগ করো — height ঠিক হয়ে যাবে
                        ),
                        itemCount: _isExpanded ? popularFacilities.length : 6,
                        itemBuilder: (context, index) {
                          final facility = popularFacilities[index];
                          return PopularFacilitiesWidget(
                            title: facility['title'],
                            image: facility['image'],
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondaryColors,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(
                            _isExpanded ? "View less" : "View more",
                            style: const TextStyle(color: AppColors.black, fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      CustomContainerWidget(
                        text: "Doctor",
                        onTabAction: (){},
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
