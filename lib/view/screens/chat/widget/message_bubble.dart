import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ride_sharing_user_app/authenticate/domain/use-cases/auth_cases.dart';

import '../../../../initialize_dependencies.dart';
import '../../../../pagination/widgets/paginations_widgets.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/text_style.dart';
import '../../../widgets/custom_image.dart';
import '../models/req/send_msg_req_model.dart';
import '../models/res/msg_chat_res_model_item.dart';

class ConversationBubble extends PaginationViewItem<MsgChatResModelItem> {
  const ConversationBubble({super.key, required super.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      // constraints: const BoxConstraints(maxHeight: 100),
      child: Column(
        crossAxisAlignment:
            data.isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: data.isMe!
                ? const EdgeInsets.fromLTRB(20, 5, 5, 5)
                : const EdgeInsets.fromLTRB(5, 5, 20, 5),
            child: Column(
              crossAxisAlignment: data.isMe!
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: data.isMe!
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    Text(
                      data.senderType!,
                      style: textRegular.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.fontSizeExtraSmall),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: data.isMe!
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    data.isMe!
                        ? const SizedBox()
                        : Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: CustomImage(
                                  height: 30,
                                  width: 30,
                                  image: data.user?.img ?? "",
                                ),
                              ),
                            ],
                          ),
                    const SizedBox(
                      width: Dimensions.paddingSizeSmall,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: data.isMe!
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Container(
                              decoration: BoxDecoration(
                                color: data.isMe!
                                    ? Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer
                                    : Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    Dimensions.paddingSizeDefault),
                                child: data.msgType == MsgType.text
                                    ? Text(data.msg ?? "")
                                    : data.msg is String &&
                                            data.msgType == MsgType.image
                                        ? CustomImage(
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.contain,
                                            image: data.msg ?? "",

                                            // frameBuilder: (BuildContext context,
                                            //     Widget child,
                                            //     int? frame,
                                            //     bool? wasSynchronouslyLoaded) {
                                            //   if (wasSynchronouslyLoaded==true) {
                                            //     // Image was loaded synchronously
                                            //     onImageLoaded();
                                            //   } else {
                                            //     // Image was loaded asynchronously
                                            //     return child;
                                            //   }
                                            // },                                          headers: {
                                            //   "Authorization":
                                            //       "Bearer ${sl<AuthCases>().getUserData()}"
                                            // },
                                          )
                                        : Image.file(
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.contain,
                                            File((data.msg as File).path),
                                          ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    data.isMe!
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: CustomImage(
                              height: 30,
                              width: 30,
                              image: data.user?.img ?? "",
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: data.isMe!
                ? const EdgeInsets.fromLTRB(5, 0, 50, 5)
                : const EdgeInsets.fromLTRB(50, 0, 5, 5),
            child: Text(
              data.createdAt.toString(),
              textDirection: TextDirection.ltr,
              style: textRegular.copyWith(
                fontSize: Dimensions.fontSizeExtraSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
