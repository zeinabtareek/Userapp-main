import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../pagination/typedef/page_typedef.dart';
import '../../../util/app_strings.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/text_style.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/pick_img_widget.dart';
import 'controller/chat_controller.dart';
import 'models/req/get_chat_msgs_req_model.dart';
import 'pagienate-use-cases/get_chat_msgs_use_case.dart';
import 'widget/message_bubble.dart';

class MessageScreen extends GetView<ChatController> {
  final String chatId;
  const MessageScreen({super.key, required this.chatId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomAppBar(title: Strings.message.tr),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: (Get.height / 5) * 3.5 -MediaQuery.of(context).viewInsets.bottom,
              child: GetBuilder<PaginateChatMsgsController>(
                  init: PaginateChatMsgsController(GetChatMsgsUseCase(
                      GetChatMsgsReqModel(1, chatId: chatId))),
                  builder: (con) {
                    return PaginateChatMsgsView(
                      scrollController: controller.scrollController,
                      listPadding:
                          const EdgeInsets.only(right: 30, left: 30),
                      child: (entity) => ConversationBubble(data: entity),
                    );
                  }),
            ),
          ),
          Obx(() => Visibility(
                visible: controller.canChat.value,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          left: Dimensions.paddingSizeDefault,
                          right: Dimensions.paddingSizeDefault,
                          // bottom: Dimensions.paddingSizeExtraLarge,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context)
                                  .hintColor
                                  .withOpacity(.25),
                              blurRadius: 2.0,
                              spreadRadius: 5,
                              offset: const Offset(5, 4),
                            ),
                          ],
                          color: Theme.of(context).cardColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                        child: Form(
                          key: controller.conversationKey,
                          child: Row(
                            children: [
                              const SizedBox(
                                  width: Dimensions.paddingSizeDefault),
                              Obx(() => Expanded(
                                    child: TextFormField(
                                      controller: controller
                                          .conversationController,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      style: textMedium.copyWith(
                                        fontSize:
                                            Dimensions.fontSizeLarge,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color!
                                            .withOpacity(0.8),
                                      ),
                                      keyboardType:
                                          TextInputType.multiline,
                                      maxLines: null,
                                      textInputAction:
                                          TextInputAction.send,
                                      enabled: controller
                                          .canShowTextFelid.isTrue,
                                      onFieldSubmitted: (value) =>
                                          controller.sendMsg(),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: Strings.typeHere.tr,
                                        hintStyle: textRegular.copyWith(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .color!
                                              .withOpacity(0.8),
                                          fontSize: 16,
                                        ),
                                      ),
                                      onChanged: (String newText) {
                                        if (newText.isNotEmpty) {
                                          controller.setPickedImg = null;
                                        }
                                      },
                                    ),
                                  )),
                              Row(
                                children: [
                                  ImagePick(
                                    width:
                                        Dimensions.identityImageWidth / 2,
                                    hight:
                                        Dimensions.identityImageHeight /
                                            2,
                                    deleteImg: () {
                                      controller.setPickedImg = null;
                                    },
                                    onSelectImg: (img) {
                                      controller.setPickedImg =
                                          XFile(img.path);
                                    },
                                  ),
          
                                  // Obx(
                                  //   () {
                                  //     return messageController.pickedImageFile.value ==
                                  //             null
                                  //         ? Padding(
                                  //             padding: const EdgeInsets.symmetric(
                                  //                 horizontal:
                                  //                     Dimensions.paddingSizeSmall),
                                  //             child: InkWell(
                                  //               child: Image.asset(Images.pickImage,
                                  //                   color: Get.isDarkMode
                                  //                       ? Colors.white
                                  //                       : Colors.black),
                                  //               onTap: () {
                                  //                 CustomPickHelper.pickImage(
                                  //                         ImageSource.camera)
                                  //                     .then((value) => {
                                  //                           if (value != null)
                                  //                             {
                                  //                               messageController
                                  //                                       .setPickedImg =
                                  //                                   XFile(value.path)
                                  //                             }
                                  //                         });
                                  //               },
                                  //             ),
                                  //           )
                                  //         : const SizedBox();
                                  //   },
                                  // ),
                                  // Obx(() {
                                  //   return messageController.pickedImageFile.value !=
                                  //           null
                                  //       ? const SizedBox()
                                  //       : const Spacer();
                                  // }),
                                  Obx(() {
                                    return controller.isLoading.value
                                        ? Container(
                                            padding: const EdgeInsets
                                                    .symmetric(
                                                horizontal: 10),
                                            height: 20,
                                            width: 40,
                                            child: Center(
                                              child:
                                                  CircularProgressIndicator(
                                                color: Theme.of(context)
                                                    .hoverColor,
                                              ),
                                            ),
                                          )
                                        : InkWell(
                                            onTap: () {
                                              if (controller
                                                      .conversationController
                                                      .text
                                                      .isNotEmpty ||
                                                  controller
                                                          .pickedImageFile
                                                          .value !=
                                                      null) {
                                                controller.sendMsg();
                                              }
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                horizontal: Dimensions
                                                    .paddingSizeSmall,
                                              ),
                                              child: Image.asset(
                                                Images.sendMessage,
                                                width: Dimensions
                                                    .iconSizeMedium,
                                                height: Dimensions
                                                    .iconSizeMedium,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                          );
                                  }),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
              )),
        ],
      ),
    );
  }
}
