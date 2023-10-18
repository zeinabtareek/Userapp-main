import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/view/screens/where_to_go/widget/input_field_for_set_route.dart';

import '../../../util/app_strings.dart';
import '../home/controller/address_controller.dart';
import 'controller/where_to_go_controller.dart';

class TestWhereToGo extends StatelessWidget {
  String ?address;
    TestWhereToGo({super.key,   this. address});
  final toRoutNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<WhereToGoController>(
        init: WhereToGoController(),
    builder: (setMapController) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: TextEditingController(text: address),
              decoration: InputDecoration(
                hintText: 'first '
              ),
            ),

            FocusScope(
              child: Focus(
                onFocusChange: (focus) {
                  if (focus) {
                    setMapController
                        .searchController
                        .value =
                        setMapController
                            .toRouteController;
                  }
                },
                child: InputField(
                    controller:setMapController.searchController.value.text!='' &&
      setMapController.searchController.value.text!=null?
                    setMapController.searchController.value:

                        TextEditingController(text: address),
                    hint: Strings
                        .enterDestinationRoute
                        .tr,
                    node:  toRoutNode,
                    onTap: () {},
                    // async =>
                    // await setMapController
                    //     .checkPermissionBeforeNavigation(
                    //     context),
                    onChange: (v) {
                      // setMapController
                      //     .searchPlacesFrom(
                      //     v);
                      // print(v);
                    }),
              ),
            ),


            TextField(
              decoration: InputDecoration(
                hintText: 'first '
              ),
            ),

            FocusScope(
              child: Focus(

                onFocusChange: (focus) {
                  if (!focus) {
                    if (setMapController
                        .searchController
                        .value !=
                        null) {
                      // Check if the text field is empty
                      if (setMapController
                          .fromRouteController
                          .text
                          .isEmpty) {
                        setMapController
                            .searchController
                            .value =
                            TextEditingController();
                      } else {
                        setMapController
                            .searchController
                            .value =
                            setMapController
                                .fromRouteController;
                      }
                    } else if (setMapController
                        .selectedSuggestedAddress
                        .value !=
                        '') {
                      setMapController
                          .selectedSuggestedAddress
                          .value = '';
                    } else {
                      setMapController
                          .fromRouteController
                          .text =
                      ''; // Clear the address
                    }
                  }
                },
                child:
                // GetBuilder<AddressController>(
                //   builder: (addressController) =>
                      InputField(
                        controller:

                        address != null
                            ? TextEditingController(
                            text:
                            address.toString())
                            : setMapController
                            .fromRouteController,
                        // setMapController.searchController.value.text!='' &&
                        //     setMapController.searchController.value.text!=null?
                        // setMapController.searchController.value:

                        // TextEditingController(text: address),


                        node: setMapController.fromNode,
                        hint: Strings
                            .enterCurrentLocationRoute
                            .tr,
                        onTap: () async {
                          await setMapController
                              .checkPermissionBeforeNavigation(
                              context);
                        },
                        onChange: (v) {
                          if(address ==null){
                            setMapController
                                .searchPlacesFrom(v);
                          }
                          //
                          print(v);
                        },
                      ),
                ),
              // ),
            ),


          ],
        ),
      );}
      ),
    );
  }
}
