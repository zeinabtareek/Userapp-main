
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_app_bar.dart';

class CustomParcelBody extends StatelessWidget {
  final Widget firstPartBody;
  final Widget body;
  // final CustomAppBar appBar;
  const CustomParcelBody({Key? key, required this.firstPartBody,  required this.body, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(
        children: [

          Stack(
            children: [
              Container(
   height: MediaQuery.of(context).size.height/1.9,
  width: context.width,
                decoration:  BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(Dimensions.paddingSizeSignUp),
                      bottomRight:  Radius.circular(Dimensions.paddingSizeSignUp),
                    ),
                    color: Theme.of(context).primaryColor
                ),child: firstPartBody
),

            ],
          ),

          // Expanded(
          //   child: SingleChildScrollView(
          //     child:
              body,
            // ),
          // ),
        ],
      ),
    );
  }
}