import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../util/app_strings.dart';
import '../../../../util/app_style.dart';
import '../../../widgets/custom_button.dart';
import '../controller/choose_from_map_controller.dart';

class SearchBottom extends StatelessWidget {
  const SearchBottom({super.key});

  // final controller = Get.put(ChooseFromMapController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChooseFromMapController>(
      init: ChooseFromMapController(),
      builder: (controller) => Container(
        margin: K.fixedPadding0,
        padding: K.fixedPadding0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 12,
              )
            ]),
        child: Material(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                Strings.selectDestination.tr,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Theme.of(context).primaryColor),
              ),
              K.sizedBoxH0,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                        () => controller.isDataLoading.value
                        ? Text(Strings.searchingAddress.tr,style:
                    K.hintSmallTextStyle,)
                        : Text(controller.address.value.tr),
                  ),
                   GestureDetector(child: Text(Strings.search.tr,style: K.primaryMediumTextStyle,),
                   onTap: (){
                     controller.toggleContainerVisibility();
                   },)
                ],
              ),

              K.sizedBoxH0,
              Obx(
                () => Row(
                  children: [
                    Expanded(
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        height: controller.isContainerVisible.value ? 50 : 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          // height: 50.0,
                          decoration: getBoxShadow(),
                          child: Center(
                            child: TextFormField(

                                textCapitalization: TextCapitalization.words,
                                decoration: getInoutDecoration(
                                  controller.isContainerVisible.value
                                      ? Strings.pickUpLocation.tr
                                      : null,
                                  controller.isContainerVisible.value
                                      ? Icon(Icons.location_on)
                                      : null,
                                ),
                                onChanged: (value) {
                                  print(value);
                                }),
                          ),
                        ),
                      ),
                    ),


                  ],
                ),
              ),
              K.sizedBoxH0,
              CustomButton(
                buttonText: Strings.seTDestination.tr,
                radius: 25,
                onPressed: () {

                  // Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  getInoutDecoration(hint, icon) {
    return InputDecoration(
      icon: Container(
        margin: const EdgeInsets.only(
          left: 20,
        ),
        width: 10,
        height: 10,
        child: icon,
      ),
      hintText: hint,
      border: InputBorder.none,
      contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
    );
  }

  getBoxShadow() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(.4),
              offset: Offset(.50, 1.0),
              blurRadius: 1,
              spreadRadius: 1)
        ]);
  }

  searchTo() {
    return GetBuilder<ChooseFromMapController>(
      init: ChooseFromMapController(),
      builder: (controller) => Material(
        child: Container(
          margin: EdgeInsets.all(10),
          height: 60.0,
          width: double.infinity,
          decoration: getBoxShadow(),
          child: TextField(
              keyboardType: TextInputType.text,
              controller: controller.searchDesTextEditing,
              cursorColor: Colors.black,
              // textInputAction: TextInputAction.go,
              decoration: getInoutDecoration(
                "destination?",
                const Icon(
                  Icons.local_taxi,
                  color: Colors.black,
                ),
              ),
              onChanged: (value) {
                // mapController
                //     .searchPlacesfrom(value);
                print(value);
              }
              // onChanged: (value) {}
              // mapController.searchPlacesTo(value)
              ),
        ),
      ),
    );
  }
}
