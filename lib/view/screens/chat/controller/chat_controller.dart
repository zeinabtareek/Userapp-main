import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ride_sharing_user_app/mxins/sokcit-io/socket_io_mixin.dart';

import '../../../../bases/base_controller.dart';
import '../../../../pagination/typedef/page_typedef.dart';
import '../models/req/send_msg_req_model.dart';
import '../repository/chat_repo.dart';

class ChatController extends BaseController
    with SocketIoMixin
    implements GetxService {
  final ChatRepo chatRepo;

  ChatController({required this.chatRepo});

  String? chatId;

  List<String> userType = ['customer', 'admin'];

  int _userTypeIndex = 0;
  int get userTypeIndex => _userTypeIndex;

  void setUserTypeIndex(int index) {
    _userTypeIndex = index;
    update();
  }

  final Rxn<XFile> _pickedImageFile = Rxn(null);
  Rxn<XFile> get pickedImageFile => _pickedImageFile;
  set setPickedImg(XFile? file) => _pickedImageFile(file);
  RxBool get canShowTextFelid => (pickedImageFile.value == null).obs;

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

  void initChat() {
    conversationController.text = '';
    isLoading(false);
    _pickedImageFile.value = null;
    initializeSocket(
      onConnect: () {
        sendMassage(["user_id", "${user!.id}"]);
        subscribeToEvent("user-notification.${user!.id}", (data) {
         if (kDebugMode) {
           print(" received data $data  $tag ");
         }

          var controller = Get.find<PaginateChatMsgsController>();
          controller.onRefreshData(
              // onLoadSucses: () => controller.scrollController.jumpTo(
              //     controller.scrollController.position.maxScrollExtent)

              );
        });
      },
    );
    connectSocket();
  }

  // void pickMultipleImage(bool isRemove,{int? index}) async {
  //   if(isRemove) {
  //     if(index != null){
  //       _pickedImageFiles!.removeAt(index);
  //       _selectedImageList.removeAt(index);
  //     }
  //   }else {
  //     _pickedImageFiles = await ImagePicker().pickMultiImage(imageQuality: 40);
  //     if (_pickedImageFiles != null) {
  //       for(int i =0; i< _pickedImageFiles!.length; i++){
  //         _selectedImageList.add(MultipartBody('files[$i]',_pickedImageFiles![i]));
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
  //   _pickedImageFiles = [];
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
        await chatRepo.sendMsg(
          _getReqBody().getIdForChat(
            orderId: _userTypeIndex == 0 ? chatId : null,
          ),
        );
        isLoading.value = false;
        _pickedImageFile.value = null;
        conversationController.clear();
        // Get.find<PaginateChatMsgsController>().onRefreshData();
        // scrollToMax();

        await Future.delayed(const Duration(milliseconds: 300));
        scrollToMax();
      },
      checkConnection: true,
    );
  }

  SendMsgReqModel _getReqBody() {
    SendMsgReqModel req;
    if (_pickedImageFile.value != null) {
      req = SendMsgReqModel(
        msg: _pickedImageFile.value,
      );
    } else {
      req = SendMsgReqModel(
        msg: conversationController.text,
      );
    }
    return req;
  }
}
