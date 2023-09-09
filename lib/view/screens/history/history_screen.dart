import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/history/controller/activity_controller.dart';
import 'package:ride_sharing_user_app/view/screens/history/widgets/activity_item_view.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_body.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_calender.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_drop_down.dart';

import '../../../util/app_strings.dart';
import '../../../util/app_style.dart';

class HistoryScreen extends StatelessWidget {
  final String fromPage;
  HistoryScreen({Key? key, required this.fromPage}) : super(key: key);

  String initialSelectItem = Get.find<ActivityController>().filterList.first;
  final controller = Get.put(ActivityController() );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBody(
        appBar: CustomAppBar(title: Strings.checkYourAllTrip.tr,showBackButton:  true),
        body: Padding(
          padding: K.fixedPadding0,
          child: GetBuilder<ActivityController>(builder: (activityController){
            return Column(children: [
              TextButton(onPressed: ()async{
                await  controller.activityRepo.getAllHistoryTrips();
              }, child: Text('click')),

              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(Strings.yourTrips.tr,
                  style: textSemiBold.copyWith(
                    fontSize: Dimensions.fontSizeExtraLarge,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                activityController.showCustomDate?
                InkWell(
                  onTap: ()=> activityController.updateShowCustomDateState(false),
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(Dimensions.radiusOverLarge),
                      border: Border.all(
                        width: 1,
                        color: Theme.of(context).primaryColor.withOpacity(0.2),
                      ),
                    ),
                    padding: K.fixedPadding0,

                    child:  Center(child:  Text("${activityController.filterStartDate} - ${activityController.filterEndDate}",
                        style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.5)),
                      ),
                    )
                  ),
                ) : Container(
                  width: 120,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(Dimensions.radiusOverLarge),
                    border: Border.all(
                      width: 1,
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                    ),
                  ),
                  // padding:  K.fixedPadding0,
                  child: Center(
                    child: CustomDropDown(
                      icon: Icon(Icons.expand_more, color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.5),),
                      maxListHeight: 200,
                      items: activityController.filterList.map((item) =>
                          CustomDropdownMenuItem<String>(
                            value: item,
                            child: Text(item.tr,style: textRegular.copyWith(color:
                            item!=initialSelectItem? Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.5)
                                :Theme.of(context).primaryColor
                            ),),
                          )
                      ).toList(),
                      hintText: Strings.select.tr,
                      borderRadius: 5,
                      onChanged: (selectedItem) {
                      initialSelectItem = selectedItem ?? Strings.all;
                      if(initialSelectItem==Strings.custom){
                        showDialog(context: context, builder: (_)=> CustomCalender(
                          onChanged: (value){
                            Get.back();
                          },
                        ));
                      }
                      activityController.update();
                    },
                    ),
                  ),
                ),
              ]),

              Divider(color: Theme.of(context).primaryColor.withOpacity(0.2),),
              Flexible(
                child: ListView.builder(itemBuilder: (context,index){
                  return ActivityItemView(activityItemModel: activityController.activityItemList[index],isDetailsScreen: false,);
                },
                  itemCount: activityController.activityItemList.length,
                  padding: EdgeInsets.zero,
                ))
              ],
            );
          }),
        ),
      ),
    );
  }
}