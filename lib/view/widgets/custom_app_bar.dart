import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/app_strings.dart';
import '../../util/app_style.dart';
import '../../util/dimensions.dart';
import '../../util/images.dart';
import '../../util/text_style.dart';
import '../screens/map/map_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final bool showActionButton;
  final Function()? onBackPressed;
  final bool centerTitle;
  final bool isHome;
  final double? height;
  final String? address;
  final PreferredSizeWidget? bottom;
  final Widget? actionWidget;
  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.onBackPressed,
    this.height,
    this.bottom,
    this.centerTitle = false,
    this.showActionButton = true,
    this.isHome = false,
    this.address,
    this.actionWidget,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(150.0),
      child: AppBar(
        toolbarHeight: height ?? MediaQuery.of(context).size.height / 12,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.tr,
              style: textRegular.copyWith(
                fontSize: isHome
                    ? Dimensions.fontSizeExtraLarge
                    : Dimensions.fontSizeLarge,
                color: Colors.white,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
            isHome
                ? GestureDetector(
                    onTap:null,
                        // Get.to(() => MapScreen(fromScreen: Strings.location)),home
                    child: Row(
                      children: [
                        const Icon(
                          Icons.place_outlined,
                          color: Colors.white,
                        ),
                        K.sizedBoxH0,
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Text(
                              address != null
                                  ? address!
                                  : 'no_address'.tr,
                              style: textRegular.copyWith(
                                color: Colors.white,
                                fontSize: Dimensions.fontSizeSmall,
                              ),
                              maxLines: 3,
                            ))
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),

        // flexibleSpace: isHome?GestureDetector(
        //   onTap: ()=> Get.to(()=>   MapScreen(fromScreen: Strings.location)),
        //   child:     Row(children:  [
        //       Icon(Icons.place_outlined,color: Colors.white,),
        //       SizedBox(width: Dimensions.paddingSizeSmall),
        // Text('15 Changi Business Park Cres, shihainaki \nSingapore', style: textRegular.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeSmall))
        // ],),
        //
        // ) : const SizedBox.shrink(),
        centerTitle: true,
        // centerTitle: centerTitle,
        excludeHeaderSemantics: true,
        leading: showBackButton
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () => onBackPressed != null
                    ? onBackPressed!()
                    : Navigator.pop(context),
              )
            : SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Image.asset(
                    Images.logo,
                    color: Colors.white,
                  ),
                ),
              ),
        actions: [
          if (true) ...{
            SizedBox(
              height: 10,
              width: 15,
              child: ChuckerFlutter.chuckerButton,
            ),
          },
          if (actionWidget != null) ...{actionWidget!}

          // showActionButton?
          // InkWell(
          //   onTap: (){
          //     showGeneralDialog(
          //       context: context,
          //       barrierDismissible: true,
          //       transitionDuration: const Duration(milliseconds: 500),
          //       barrierLabel: MaterialLocalizations.of(context).dialogLabel,
          //       barrierColor: Colors.black.withOpacity(0.5),
          //       pageBuilder: (context, _, __) {
          //         return const WeatherAssistant();
          //       },
          //       transitionBuilder: (context, animation, secondaryAnimation, child) {
          //         return SlideTransition(
          //           position: CurvedAnimation(
          //             parent: animation,
          //             curve: Curves.easeOut,
          //           ).drive(Tween<Offset>(
          //             begin: const Offset(0, -1.0),
          //             end: Offset.zero,
          //           )),
          //           child: child,
          //         );
          //       },
          //     );
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.fromLTRB(15,0, 15, 0),
          //     child: Image.asset(Images.cloud,width: 20,height: 20,),
          //   ),
          // ):const SizedBox()
        ],
        elevation: 0,
        bottom: bottom,
      ),
    );
  }

  @override
  Size get preferredSize => const Size(Dimensions.webMaxWidth, 150);
}
