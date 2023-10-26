import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../pagination/widgets/paginations_widgets.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/text_style.dart';
import '../../../widgets/custom_image.dart';
import '../controller/chat_controller.dart';
import '../message_screen.dart';
import '../models/req/send_msg_req_model.dart';
import '../models/res/msg_chat_res_model_item.dart';

class MessageItem extends PaginationViewItem<MsgChatResModelItem> {
  final bool isOrderers;
  const MessageItem({Key? key, required this.isOrderers, required super.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => MessageScreen(
            chatId: data.id!,
          ),binding: BindingsBuilder(() {
                   // ignore: avoid_single_cascade_in_expression_statements
        Get.find<ChatController>()..initChat();
          })),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 0,
            Dimensions.paddingSizeDefault, Dimensions.paddingSizeSmall),
        child: Container(
          padding: const EdgeInsets.symmetric(
              vertical: Dimensions.paddingSizeSmall,
              horizontal: Dimensions.paddingSizeExtraSmall),
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(Dimensions.paddingSizeExtraLarge),
            border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(0.2)),
            color:
                //  isRead
                //     ?

                //     Theme.of(context).colorScheme.primary.withOpacity(.1)
                //     :
                Theme.of(context).cardColor,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: Dimensions.paddingSizeSmall,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CustomImage(
                  height: 35,
                  width: 35,
                  image: isOrderers ? data.driver!.img : data.admin?.img ?? "",
                ),
              ),
              const SizedBox(
                width: Dimensions.paddingSizeSmall,
              ),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(
                        isOrderers
                            ? "${data.driver!.firstName!} ${data.driver!.lastName!}"
                            : data.admin?.firstName ?? "",
                        style: textBold.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          color: Theme.of(context).primaryColor,
                        )),
                    const SizedBox(
                      height: Dimensions.paddingSizeExtraSmall,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            data.msgType == MsgType.text
                                ? data.lastMsg!
                                : MsgType.image.name,
                            style: textMedium.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color:
                                  // isRead
                                  //     ? Theme.of(context).textTheme.bodyLarge!.color
                                  //     :

                                  Theme.of(context).hintColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(
                          width: Dimensions.paddingSizeSmall,
                        ),
                        // TODO: time
                        Text(
                          data.createdAt.toString(),
                          textDirection: TextDirection.ltr,
                          style: textRegular.copyWith(
                            fontSize: Dimensions.fontSizeExtraSmall,
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      ],
                    )
                  ])),
              const SizedBox(
                width: Dimensions.paddingSizeSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
