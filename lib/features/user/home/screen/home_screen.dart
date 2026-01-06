import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import '../../../../core/themes/app_colors.dart';
import '../home searching/screen/home_searching_screen.dart';
import '../home searching/widget/searching_default_widget.dart';
import '../home_details_screen/screen/home_details_screen.dart';
import '../widget/body_widget.dart';
import '../widget/custom_slider_widget.dart';
import '../widget/home_app_bar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeAppBarWidget(
              name: "Zaid Al-Rifai",
              imageUrl: "https://i.postimg.cc/Y9gNQbDT/Image-(16).png",
            ),
            /*Obx((){
              return HomeAppBarWidget(
                name: "Zaid Al-Rifai",
                imageUrl: "https://i.postimg.cc/Y9gNQbDT/Image-(16).png",
              );
            }),*/
            const SizedBox(height: 10),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    top: 4.0,
                    right: 8.0,
                    bottom: 8.0,
                  ),
                  child: GestureDetector(
                    onTap: _searching1,
                    child: Container(
                      height: 38,
                      width: 335,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.black, width: 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            Icon(Icons.search),
                            const SizedBox(width: 20),
                            Text("Search destinations"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _searching,
                  child: SizedBox(width: 36,
                  height: 36,
                  child: Image.asset("assets/icons/Search (1).png"
                      "",fit: BoxFit.cover,),),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 109, // Adjust height as needed
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CustomSliderWidget(
                            image:
                                "https://i.postimg.cc/6pWy0YTJ/Frame-1610068086.png",
                            text: "Lebanon",
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Most popular destinations",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (){
                            Get.to(()=>HomeDetailsScreen());
                          },
                          child: UserBodyWidget(
                            initialIsLike: false, // or true, based on your requirement
                            locationImage: "https://i.postimg.cc/qMWVj71K/Rectangle-34624198.png",
                            amount: "58",
                            locationName: "Broummana, Lebanon",
                            title: "Cedar Breeze Hilltop Residence",
                            presentRating: "4.5",
                            totalRating: "100",
                          ),
                        ),

                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _searching() {
    Get.bottomSheet(
      const HomeSearchingScreen(),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }
  void _searching1() {
    Get.bottomSheet(
      const SearchingDefaultWidget(),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

}
