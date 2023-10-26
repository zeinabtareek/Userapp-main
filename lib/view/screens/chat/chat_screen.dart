import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../pagination/typedef/page_typedef.dart';
import '../../../pagination/widgets/paginations_widgets.dart';
import '../../../util/app_strings.dart';
import '../../../util/dimensions.dart';
import '../../widgets/custom_app_bar.dart';
import 'controller/chat_controller.dart';
import 'pagienate-use-cases/get_chats_list_usecase.dart';
import 'repository/chat_repo.dart';
import 'widget/message_item.dart';
import 'widget/user_type_button_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int vindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<ChatController>(
        init: ChatController(chatRepo: ChatRepo()),
        builder: (chatController) {
          return Column(
            children: [
              CustomAppBar(
                title: Strings.message.tr,
              ),

              Container(
                transform: Matrix4.translationValues(0, -15, 0),
                child: SizedBox(
                  height: Dimensions.headerCardHeight,
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: chatController.userType.length,
                      itemBuilder: (context, index) {
                        return UserTypeButtonWidget(
                          userType: chatController.userType[index],
                          isSelected: index == vindex,
                          onTap: () {
                            print(" index $index ");
                            setState(() {
                              vindex = index;
                            });
                          },
                        );
                      }),
                ),
              ),
              Visibility(
                visible: vindex == 0,
                child: Expanded(
                  child: GetBuilder<PaginateChatListOrdersController>(
                      init: PaginateChatListOrdersController(
                        GetChatsListOrdersUseCase(),
                      ),
                      builder: (con) {
                        return PaginateChatListOrdersView(
                          listPadding:
                              const EdgeInsets.only(top: 0, bottom: 90),
                          child: (entity) => MessageItem(
                            data: entity,
                            isOrderers: true,
                          ),
                          paginatedLst: (list) => SmartRefresherApp(
                            controller: con,
                            list: list,
                          ),
                        );
                      }),
                ),
              ),
              // if (vindex == 1) ...{
              Visibility(
                visible: vindex == 1,
                child: Expanded(
                  child: GetBuilder<PaginateChatListAdminController>(
                      init: PaginateChatListAdminController(
                        GetChatsListAdminUseCase(),
                      ),
                      builder: (con) {
                        return SmartRefresherApp(
                          controller: con,
                          list: PaginateChatListAdminView(
                            listPadding:
                                const EdgeInsets.only(top: 0, bottom: 90),
                            child: (entity) => MessageItem(
                              data: entity,
                              isOrderers: false,
                            ),
                            paginatedLst: (list) => list,
                          ),
                        );
                      }),
                ),
              )
              // }
            ],
          );
        },
      ),
    );
  }
}
