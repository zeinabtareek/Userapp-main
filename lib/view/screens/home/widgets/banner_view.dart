import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/enum/view_state.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/view/screens/home/controller/banner_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_image.dart';

class BannerView extends StatefulWidget {
  const BannerView({super.key});

  @override
  State<BannerView> createState() => _BannerViewState();
}

class _BannerViewState extends State<BannerView> {
  @override
  Widget build(BuildContext context) {
    Get.find<BannerController>().getBannerList();
    return GetBuilder<BannerController>(
      builder: (bannerController) {
        return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 130,
            child:
            // Obx(()=>bannerController.loading.value?
            CarouselSlider.builder(
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: false,
                viewportFraction: 1,
                disableCenter: true,
                autoPlayInterval: const Duration(seconds: 7),
                onPageChanged: (index, reason) {},
              ),
              itemCount: bannerController.banners.length,
              itemBuilder: (context, index, _) {
                return ClipRRect(
                  borderRadius:
                      BorderRadius.circular(Dimensions.radiusOverLarge),
                  child:   CustomImage(
                    image: bannerController.banners[index].img??'',
                        // "https://img.freepik.com/premium-vector/luxury-car-rental-promotion-facebook-cover-banner-web-banner-template_621071-62.jpg?w=2000",
                    fit: BoxFit.cover,
                  ),
                );
              },
            )

                // :CupertinoActivityIndicator()
        // )
        );
      },
    );
  }
}
