import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/ride/controller/ride_controller.dart';
import 'package:ride_sharing_user_app/view/screens/set_map/controller/set_map_controller.dart';
import 'package:ride_sharing_user_app/view/screens/set_map/widget/input_field_for_set_route.dart';
import 'package:ride_sharing_user_app/view/screens/set_map/widget/suggested_route_screen.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_divider.dart';

import '../choose_from_map/choose_from_map_screen.dart';

class SetDestinationScreen extends StatefulWidget {
  final String? address;
  const SetDestinationScreen({Key? key, this.address}) : super(key: key);

  @override
  State<SetDestinationScreen> createState() => _SetDestinationScreenState();
}

class _SetDestinationScreenState extends State<SetDestinationScreen> {
  TextEditingController fromRouteController = TextEditingController();
  TextEditingController toRouteController = TextEditingController();
  TextEditingController extraRouteController = TextEditingController();
  TextEditingController entranceController = TextEditingController();
  FocusNode fromNode = FocusNode();
  FocusNode toNode = FocusNode();
  FocusNode entranceNode = FocusNode();
  FocusNode extraNode = FocusNode();
  @override
  void initState() {
    super.initState();
    fromRouteController.text = widget.address??"";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(backgroundColor: Theme.of(context).cardColor,
        iconTheme: IconThemeData(color: Theme.of(context).textTheme.bodyMedium!.color),),

      body: GetBuilder<SetMapController>(
        builder: (setMapController) {
          return SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault,Dimensions.paddingSizeDefault,Dimensions.paddingSizeSmall),
                child: Container(decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)

                ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.end,children: [
                    Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Padding(
                        padding:  const EdgeInsets.fromLTRB( Dimensions.paddingSizeSmall,Dimensions.paddingSizeLarge, Dimensions.paddingSizeSmall,0),
                        child: Column(
                          children: [
                            SizedBox(width: Dimensions.iconSizeLarge, child: Image.asset(Images.currentLocation,
                              color: Theme.of(context).colorScheme.onSecondary.withOpacity(.75),)),

                            SizedBox(height:70 ,width: 10,child: CustomDivider(height: 5,dashWidth: .75,axis: Axis.vertical,color: Theme.of(context).colorScheme.onSecondary,)),

                            SizedBox(width: Dimensions.iconSizeLarge, child: Image.asset(Images.activityDirection,
                              color: Theme.of(context).colorScheme.onSecondary.withOpacity(.75),)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InputField(controller: fromRouteController,node: fromNode,
                                hint: "Enter Current Location Route",
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                                child: Text('to'.tr,style: textRegular.copyWith(color: Colors.white)),
                              ),
                              ListView.builder(
                                  itemCount: setMapController.currentExtraRoute,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index){
                                    return  Padding(
                                      padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                                      child: InputField(controller: extraRouteController,node: extraNode, hint: "Enter Extra Route",),
                                    );
                                  }),
                              Row(
                                children: [
                                  Expanded(
                                    child: InputField(controller: toRouteController,node: toNode, hint: 'Enter Destination Route',),
                                  ),
                                  const SizedBox(width: Dimensions.paddingSizeSmall,),
                                  GestureDetector(
                                    onTap: ()=> setMapController.setExtraRoute(),
                                    child: Container(height: 40,width: 40,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColorDark.withOpacity(.35),
                                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                                      ),child: const Icon(Icons.add, color: Colors.white)),
                                  )
                                ],
                              ),
                              const SizedBox(height: Dimensions.paddingSizeDefault),
                              setMapController.addEntrance
                                  ?SizedBox(width: 200,child: InputField(controller: entranceController,node: entranceNode, hint: 'Enter Entrance',)) :
                              GestureDetector(
                                onTap: ()=> setMapController.setAddEntrance(),
                                child: Row(crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(height: 25, child: Image.asset(Images.curvedArrow)),
                                    const SizedBox(width: Dimensions.paddingSizeSmall),
                                    Container(transform: Matrix4.translationValues(0, 10, 0),
                                      child: Row(children: [
                                        const Icon(Icons.add, color: Colors.white),
                                        Text('add_entrance'.tr, style: textMedium.copyWith(color: Colors.white.withOpacity(.75),fontSize: Dimensions.fontSizeLarge),)
                                      ],),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeExtraLarge, Dimensions.paddingSizeSmall, Dimensions.paddingSizeExtraLarge,Dimensions.paddingSizeExtraLarge),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('you_can_add_multiple_route_to'.tr,style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                              color: Colors.white.withOpacity(.75)),),
                          GestureDetector(
                            onTap: (){
                              Get.to(()=> const SuggestedRouteScreen());
                              Get.find<RideController>().updateRideCurrentState(RideState.initial);
                              },
                            child: Text('done'.tr,style: textRegular.copyWith(fontSize: Dimensions.fontSizeExtraLarge,
                                color: Theme.of(context).colorScheme.onSecondary.withOpacity(.75)),),
                          ),
                        ],
                      ),
                    )
                  ],),),
              ),


              Padding(
                padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 0, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault),
                child: Container(decoration: BoxDecoration(
                    border:Border.all(color:  Theme.of(context).primaryColor,width: 1),
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)

                ),child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children:   [

                    SavedAndRecentItem(title: 'saved', icon: Images.homeOutline, subTitle: '1 Willich St Singapore',isSeeMore: true,),
                    SavedAndRecentItem(title: 'saved', icon: Images.editProfileLocation, subTitle: 'Bidadari Park Dive Singapore',isSeeMore: true,),
                    GestureDetector(onTap: (){
                      Get.to(ChooseFromMapScreen());
                    },
                        child: SavedAndRecentItem(title: 'set_from_map', icon: Images.setFromMap, subTitle: 'choose_from_map')),

                  ],),),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 0, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault),
                child: Container(decoration: BoxDecoration(
                    border:Border.all(color:  Theme.of(context).primaryColor,width: 1),
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)

                ),child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                      child: Text('suggestions'.tr, style: textMedium.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeLarge),),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: 6,
                          itemBuilder: (context, index){
                            return Padding(
                              padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
                              child: Row(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).hintColor.withOpacity(.08),
                                          borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)
                                      ), child: Icon(Icons.place_outlined, color: Theme.of(context).primaryColor.withOpacity(.5),)),
                                  const SizedBox(width: Dimensions.paddingSizeSmall,),

                                  const Text('Uttara, Sector 12'),
                                ],
                              ),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                      child: Text('set_from_map'.tr, style: textMedium.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge),),
                    ),

                    GestureDetector(
                      onTap: (){
                        Get.back();
                        //Get.find<RiderMapController>().setStayOnlineTypeIndex(9);
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 0, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault),
                        child: Row(children: [
                          Container(padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                            decoration: BoxDecoration(
                                color: Theme.of(context).hintColor.withOpacity(.08),
                                borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)
                            ),
                            child: SizedBox(width: Dimensions.iconSizeMedium,
                                child: Image.asset(Images.setFromMap)),
                          ),
                          const SizedBox(width: Dimensions.paddingSizeSmall,),
                          Text('choose_from_map'.tr, style: textRegular.copyWith(color: Theme.of(context).primaryColor),)
                        ],),
                      ),
                    )


                  ],),),
              ),
            ],),
          );
        }
      ),
    );
  }
}


class SavedAndRecentItem extends StatelessWidget {
  final String title;
  final String icon;
  final String subTitle;
  final bool isSeeMore;
  final Function()? onTap;
  const SavedAndRecentItem({Key? key, required this.title, required this.icon, required this.subTitle, this.isSeeMore = false, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Text(title.tr, style: textMedium.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge),),
      ),

      GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 0, Dimensions.paddingSizeDefault, Dimensions.paddingSizeExtraSmall),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
            Container(padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
              decoration: BoxDecoration(
                  color: Theme.of(context).hintColor.withOpacity(.08),
                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)
              ),
              child: SizedBox(width: Dimensions.iconSizeMedium,
                  child: Image.asset(icon, color: Theme.of(context).primaryColor,)),
            ),
            const SizedBox(width: Dimensions.paddingSizeSmall,),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subTitle.tr, style: textRegular.copyWith(color: Theme.of(context).primaryColor),),
                isSeeMore?
                    Padding(
                      padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                      child: Container(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
                        decoration: BoxDecoration(
                          color: Theme.of(context).hintColor.withOpacity(.125),
                          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSeven)

                        ),
                        child: Text('see_more'.tr, style: textRegular.copyWith(color: Theme.of(context).hintColor),),
                      ),
                    ):const SizedBox(),
              ],
            )
          ],),
        ),
      )
    ],);
  }
}
