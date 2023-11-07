import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ride_sharing_user_app/bases/base_controller.dart';
import 'package:ride_sharing_user_app/enum/view_state.dart';

import '../../../../authenticate/presentation/widgets/test_field_title.dart';
import '../../../../util/app_strings.dart';
import '../../../../util/app_style.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/text_style.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_drop_down.dart';
import '../../../widgets/notes_text_field.dart';
import '../controller/support_controller.dart';
import '../model/complain_res_model.dart';

class ComplainsPage extends GetView<SupportController> {
  const ComplainsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFieldTitle(
          title: Strings.complains.tr,
        ),
        K.sizedBoxH0,
        Container(
          width: MediaQuery.of(context).size.width / 1,
          height: Dimensions.iconSizeDoubleExtraLarge,
          padding: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.06),
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
            border: Border.all(
              width: 1,
              color: Theme.of(context).primaryColor.withOpacity(0.2),
            ),
          ),
          // padding:  K.fixedPadding0,
          child: BaseStateWidget<SupportController>(
            onPressedRetryButton: controller.getComplains,
            successWidget: Obx(() => Center(
                  child: CustomDropDown(
                    icon: Icon(
                      Icons.expand_more,
                      color: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .color!
                          .withOpacity(0.5),
                    ),
                    maxListHeight: 300.h,
                    items: controller.complains
                        .map((item) => CustomDropdownMenuItem<ComplainResModel>(
                              value: item,
                              child: Text(
                                '\t${item.title.tr}',
                                style: textRegular.copyWith(
                                    color: item !=
                                            controller.initialSelectItem.value
                                        ? Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .color!
                                            .withOpacity(0.5)
                                        : Theme.of(context).primaryColor),
                              ),
                            ))
                        .toList(),
                    hintText: Strings.select.tr,
                    borderRadius: 5,
                    onChanged: (selectedItem) {
                      controller.initialSelectItem(selectedItem);
                    },
                  ),
                )),
          ),
        ),
        K.sizedBoxH0,
        K.sizedBoxH0,
        NotesTextField(
            textEditingController: controller.feedBackController,
            hint: Strings.yourFeedBack.tr),
        const Spacer(),
        Obx(
          () => CustomButton(
            buttonText: Strings.submit.tr,
            radius: 25,
            isLoading: controller.state == ViewState.busy ? true : false,
            onPressed: controller.submitComplain
            // Get.offAll(DashboardScreen());
            // Get.back();
            ,
          ),
        ),
        K.sizedBoxH0,
      ],
    );
  }
}
