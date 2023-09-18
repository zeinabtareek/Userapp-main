import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/view/screens/home/widgets/banner_view.dart';
import 'package:ride_sharing_user_app/view/screens/map/map_screen.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/status_package_screen.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/custom_parcel_body.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/dotted_border_card.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/parcel_category_screen.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_text_field.dart';

import '../../../authenticate/presentation/widgets/test_field_title.dart';
import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';
import '../../../util/images.dart';
import '../../widgets/animated_widget.dart';
import '../../widgets/custom_category_card.dart';
import '../../widgets/custom_float_action_btn.dart';
import 'controller/parcel_controller.dart';

// class ParcelScreen extends StatelessWidget {
//   const ParcelScreen({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomBody(
//         appBar: const CustomAppBar(title: 'parcel_screen',showBackButton: true,),
//         body: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
//           child: Column(children:  [
//
//             const Expanded(child: Column(children: [
//               BannerView(),
//               DottedBorderCard(),
//               ParcelCategoryView()
//             ])
//             ),
//
//             CustomButton(
//               buttonText: 'add_parcel'.tr,
//               onPressed: ()=>Get.to(()=>const MapScreen(fromScreen: 'parcel')),
//             )],
//           ),
//         ),
//       ),
//     );
//   }
// }

class ParcelHomeScreen extends StatelessWidget {
  const ParcelHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(  SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark, // dark text for status bar
        statusBarColor: Theme.of(context).primaryColor),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {},
          ),
        ),
      body:
          SafeArea(
            child:   CustomParcelBody(
              firstPartBody: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      K.sizedBoxW0,
                      CustomOvel(
                        Image.asset(Images.profileOutline),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            Strings.yourLocation.tr,
                            style: TextStyle(color: Colors.white.withOpacity(.7)),
                          ),
                          const Text(
                            'New York, NY, 10016, USA',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimensions.iconSizeSmall),
                          )
                        ],
                      ),
                      CustomOvel(
                        Image.asset(Images.notificationOutline),
                      ),
                      K.sizedBoxW0,
                    ],
                  ),
                  K.sizedBoxH2,
                  Image.asset(
                    Images.package,
                    height: 200,
                    fit: BoxFit.cover,
                    width: 350,
                  ),
                  K.sizedBoxH2,
                  Text(Strings.trackYourPackage.tr,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimensions.radiusExtraLarge,
                          fontWeight: FontWeight.bold)),
                  K.sizedBoxH2,
                  Text(Strings.pleaseEnterYourTrackingNumber.tr,
                      style: TextStyle(
                          color: Colors.white.withOpacity(.7),
                          fontSize: Dimensions.iconSizeSmall)),
                  K.sizedBoxH0,
                  K.sizedBoxH2,
                  Row(
                    children: [
                      K.sizedBoxW0,
                      K.sizedBoxW0,
                      const Expanded(
                        child: CustomTextField(
                          hintText: '',
                          inputType: TextInputType.name,
                          suffixIcon: Images.close,
                          prefixIcon: Images.search,
                          fillColor: Colors.white,
                          inputAction: TextInputAction.next,
                        ),
                      ),
                      K.sizedBoxW0,
                      CustomOvel(Image.asset(Images.scanner), color: Colors.white),
                      K.sizedBoxW0,
                      K.sizedBoxW0,
                    ],
                  ),
                  K.sizedBoxH0,
                ],
              ),
              body: GetBuilder<ParcelController>(builder: (controller) {
                return Container(
                  color: Colors.white,
                  padding: K.fixedPadding0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      animatedWidget(
                          widget: SizedBox(),
                          list: controller.optionsList,
                          limit: controller.optionsList.length),
                      K.sizedBoxH0,
                      Text(
                        Strings.specialOffers.tr,
                        style: K.semiBoldBlackTextStyle,
                      ),
                      K.sizedBoxH0,
                      Image.asset(
                        Images.banner,
                        height: 200,
                        width: Get.width,
                      ),
                      K.sizedBoxH0,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Strings.specialOffers.tr,
                            style: K.semiBoldBlackTextStyle,
                          ),
                          Text(
                            Strings.viewAll.tr,
                            style: K.semiBoldBlackTextStyle,
                          ),
                        ],
                      ),
                      K.sizedBoxH0,
                      trackHistoryList([2,2,2,3]),


                    ],
                  ),
                );
              }),
            ),
          ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: customFloatActionButton(image:Images.doc,onPressed: (){
          Get.to(StatusPackageScreen());
        })


    );
  }
}

Widget CustomOvel(image, {Color? color}) {
  return ClipOval(
    child: Material(
      color: color ?? Color(0xff3b9a8b).withOpacity(.5), // button color
      child: InkWell(
        // splashColor: Colors.red, // inkwell color
        child: SizedBox(
          width: 46,
          height: 46,
          child: Padding(padding: K.fixedPadding1, child: image),
        ),
        onTap: () {},
      ),
    ),
  );
}
Widget trackHistoryList(List list){
  return ListView.builder(
    shrinkWrap: true,
      itemCount: list.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context,index){
    return animatedWidget(widget: itemTrackHistory() ,limit: list.length);
  });
}
Widget itemTrackHistory ({ Icon ?icon ,double? elevated}){

  return Card(
      color: Colors.white,
      elevation: elevated ?? 1,
      shadowColor: Colors.white10,

      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
  ),
  child: ListTile(
    trailing:  IconButton(
      icon: icon??Icon( Icons.arrow_forward_ios_sharp,size: 15,color: Colors.grey.withOpacity(.7),), onPressed: () {  },
    ),
    title: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'New York, NY, 10016, USA',
          style: TextStyle(
              color: Colors.black,
              fontSize: Dimensions.iconSizeSmall),
        ),
        Text('Order ID: JB390299191242',
          style: TextStyle(color: Colors.grey,fontSize: Dimensions.fontSizeSmall),
        ),

      ],
    ),
    leading:   CustomOvel(
        Image.asset(Images.package2),
        color: Colors.grey.withOpacity(.3)
    ),
    ),
  );
}