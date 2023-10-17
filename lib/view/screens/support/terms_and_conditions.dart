import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/view/screens/support/controller/support_controller.dart';
//
// class TermsAndConditions extends StatelessWidget {
//   const TermsAndConditions({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     String data = "terms_and_condition".tr;
//     return Column(
//       children: [
//         const SizedBox(height: Dimensions.paddingSizeDefault,),
//         Html(
//           data: data,
//           style: {
//             "p": Style(
//               fontSize: FontSize.medium,
//             ),
//           },
//         ),
//       ],
//     );
//   }
// }
class HtmlViewerScreen extends StatelessWidget {
  final bool isPolicy;
  const HtmlViewerScreen({Key? key, this.isPolicy = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      physics: const BouncingScrollPhysics(),
      child: GetBuilder<SupportController>(
        builder: (helpAndSupportController) {
          return HtmlWidget(isPolicy
              ?(helpAndSupportController.model.data?.terms?.value=='') ?
          'No Data'  :

          helpAndSupportController.model.data?.terms?.value ?? ''
              : (helpAndSupportController.model.data?.policy?.value==''||helpAndSupportController.model.data!.policy!.value!.isEmpty) ?
          'No Data'  :helpAndSupportController.model.data?.policy?.value ?? '');
        },
      ),
    );
  }
}