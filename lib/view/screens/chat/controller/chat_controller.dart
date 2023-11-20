import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../bases/base_controller.dart';
import '../../../../mxins/sokcit-io/socket_io_mixin.dart';
import '../../../../pagination/typedef/page_typedef.dart';
import '../models/req/get_chat_msgs_req_model.dart';
import '../models/req/send_msg_req_model.dart';
import '../models/res/msg_chat_res_model_item.dart';
import '../pagienate-use-cases/get_chat_msgs_use_case.dart';
import '../repository/chat_repo.dart';

class ChatController extends BaseController
    with SocketIoMixin
    implements GetxService {
  final ChatRepo chatRepo;

  ChatController({required this.chatRepo});

  String? orderId;

  RxnString chatId = RxnString();

  List<String> userType = ['customer', 'admin'];

  int _userTypeIndex = 0;
  bool get isOrderType => _userTypeIndex == 0;
  int get userTypeIndex => _userTypeIndex;

  void setUserTypeIndex(int index) {
    _userTypeIndex = index;
    update();
  }

  Rxn<File> pickedImageFile = Rxn();

  RxBool get canShowTextFelid => (pickedImageFile.value == null).obs;

  setChatId(String id) {
    chatId(id);
    print(" chatId ");
  }

  // FilePickerResult? _otherFile;
  // FilePickerResult? get otherFile => _otherFile;

  // File? _file;
  // PlatformFile? objFile;
  // File? get file=> _file;

  // List<MultipartBody> _selectedImageList = [];
  // List<MultipartBody> get selectedImageList => _selectedImageList;

  // final List<dynamic> _conversationList=[];
  // List<dynamic> get conversationList => _conversationList;

  // final bool _paginationLoading = true;
  // bool get paginationLoading => _paginationLoading;

  // int? _messagePageSize;
  // final int _messageOffset = 1;
  // int? get messagePageSize => _messagePageSize;
  // int? get messageOffset => _messageOffset;

  // int? _pageSize;
  // final int _offset = 1;
  final RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;
  // final String _name='';
  // String get name => _name;
  // final String _image='';
  // String get image => _image;

  // int? get pageSize => _pageSize;
  // int? get offset => _offset;

  var conversationController = TextEditingController();
  final GlobalKey<FormState> conversationKey = GlobalKey<FormState>();

  RxBool canChat = false.obs;
  PaginateChatMsgsController? paginateChatMsgsController;

  // setCanShat(bool state ,String id) async {
  //   canChat = state;
  //   await Future.delayed(const Duration(milliseconds: 300));
  //   update(['canChat-$id']);
  // }

  @override
  void onInit() async {
    super.onInit();
    await getUser;
  }

  void initChat() async {
    conversationController.text = '';
    isLoading(false);
    pickedImageFile.value = null;
    initializeSocket(
      onConnect: () {
        sendMassage(["user_id", "${user!.id}"]);
        subscribeToEvent("user-notification.${user!.id}", (data) {
          if (kDebugMode) {
            print(" received data $data  $tag ");
          }

          if (true) {
            var controller = Get.find<PaginateChatMsgsController>();
            var msg =
                MsgChatResModelItem.fromSocketMap(data['data']['message']);
            // print(" msg ::: ${msg.toString()} ");
            controller.items.insert(0, msg);
            controller.update();
          }
        });
      },
    );
    connectSocket();
    await Future.delayed(const Duration(seconds: 1));
    paginateChatMsgsController = Get.find<PaginateChatMsgsController>();
  }

  /*
  
  void initChat() async {
    conversationController.text = '';
    isLoading(false);
    pickedImageFile.value = null;
    initializeSocket(
      onConnect: () {
        sendMassage(["driver_id", "${user!.id}"]);
        subscribeToEvent("driver-notification.${user!.id}", (data) {
          if (kDebugMode) {
            print(" received data $data  $tag ");
          }

          var msg = MsgChatResModelItem.fromSocketMap(data['data']['message']);
          // print(" msg ::: ${msg.toString()} ");
          var controller = Get.find<PaginateChatMsgsController>();
          controller.items.insert(0, msg);
          controller.update();
          controller.moveScrollToMaxScrollExtent();
        });
      },
    );
    connectSocket();
    await Future.delayed(const Duration(seconds: 1));
    if (chatId != null) {
      paginateChatMsgsController = Get.find<PaginateChatMsgsController>();

      // WidgetsBinding.instance.addPostFrameCallback(
      //   (timeStamp) {
      //     paginateChatMsgsController?.moveScrollToMaxScrollExtent();
      //   },
      // );
    }
  }

   */

  // void pickMultipleImage(bool isRemove,{int? index}) async {
  //   if(isRemove) {
  //     if(index != null){
  //       pickedImageFiles!.removeAt(index);
  //       _selectedImageList.removeAt(index);
  //     }
  //   }else {
  //     pickedImageFiles = await ImagePicker().pickMultiImage(imageQuality: 40);
  //     if (pickedImageFiles != null) {
  //       for(int i =0; i< pickedImageFiles!.length; i++){
  //         _selectedImageList.add(MultipartBody('files[$i]',pickedImageFiles![i]));
  //       }
  //     }
  //   }
  //   update();
  // }

  // void pickOtherFile(bool isRemove) async {
  //   if(isRemove){
  //     _otherFile=null;
  //     _file = null;
  //   }else{
  //     _otherFile = (await FilePicker.platform.pickFiles(withReadStream: true))!;
  //     if (_otherFile != null) {
  //       objFile = _otherFile!.files.single;
  //     }
  //   }
  //   update();
  // }

  // void removeFile() async {
  //   _otherFile=null;
  //   update();
  // }

  // cleanOldData(){
  //   pickedImageFiles = [];
  //   _selectedImageList = [];
  //   _otherFile = null;
  //   _file = null;
  // }

  ScrollController scrollController = ScrollController();

  scrollToMax() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  sendMsg() async {
    final bool nesState = await actionCenter.execute(
      () async {
        isLoading.value = true;
        SendMsgReqModel req = _getReqBody().getIdForChat(
          orderId: isOrderType ? orderId : null,
          chatId: !isOrderType ? chatId.value : null,
        );
        await chatRepo.sendMsg(
          req,
        );
        isLoading.value = false;
        pickedImageFile.value = null;
        conversationController.clear();

        if (paginateChatMsgsController?.items.isEmpty ?? true) {
          paginateChatMsgsController?.onRefreshData();
        } else {
          var msg = req.toMsg(user!);
          paginateChatMsgsController?.items.insert(
            0,
            msg,
          );
        }

        paginateChatMsgsController?.update();
        pickedImageFile.value = null;
        canChat(true);
        conversationController.clear();
   
      },
      checkConnection: true,
    );
  }

  SendMsgReqModel _getReqBody() {
    SendMsgReqModel req;
    if (pickedImageFile.value != null) {
      req = SendMsgReqModel(
        msg: pickedImageFile.value,
      );
    } else {
      req = SendMsgReqModel(
        msg: conversationController.text,
      );
    }
    return req;
  }
}
