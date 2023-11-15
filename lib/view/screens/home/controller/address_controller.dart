import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../authenticate/data/models/base_model.dart';
import '../../../../bases/base_controller.dart';
import '../../../../enum/view_state.dart';
import '../../../../util/images.dart';
import '../../../../util/ui/overlay_helper.dart';
import '../../choose_from_map/choose_from_map_screen.dart';
import '../../ride/model/address_model.dart';
import '../../where_to_go/repository/search_service.dart';
import '../repository/address_repo.dart';

class AddressController extends BaseController implements GetxService {
  final AddressRepo? addressRepo;

  AddressController({this.addressRepo});

  List<AddressData> addressList = [];

  AddressRepo addressRepo1 = AddressRepo();

  int? _currentIndex = 0;

  int? get currentIndex => _currentIndex;

  AddressModel addressModel = AddressModel();
  AddressModel suggestionAddressModel = AddressModel();

  @override
  onInit() async {
    super.onInit();

    await getAddressList();
    await getSuggestedAddressList();
  }

  static List<String> staticAddressNames = [
    "home",
    "office",
    "journey",
    "mall"
  ];

  static List<String> staticAddressIcons = [
    Images.homeHome,
    Images.homeWork,
    Images.homeCar,
    Images.homeLock,
  ];

  TextEditingController addressCompleteController = TextEditingController();
  RxnString selectedAddressName = RxnString();
  Rxn<LatLng> selectedAddressLocation = Rxn();
  initAddOrEditScreen(AddressData data) {
    addressCompleteController = TextEditingController();
    selectedAddressName.value = data.name;
    isUpdateData(false);

    if (data.isHaveData) {
      addressCompleteController.text = data.location!;
      selectedAddressName.value = data.name;

      selectedAddressLocation.value = LatLng(
        double.parse(data.lat!),
        double.parse(data.lng!),
      );
    } else {
      addressCompleteController.text = "";
      selectedAddressLocation.value = null;
    }
  }

  void naiveteToSelectAddress() {
    Get.to(() => ChooseFromMapScreen(
              selectedAddressLocation.value != null
                  ? [selectedAddressLocation.value!]
                  : [],
            ))!
        .then((point) async {
      if (point != null) {
        if (point != selectedAddressLocation.value) {
          isUpdateData(true);
        }
        selectedAddressLocation.value = point;
        addressCompleteController.text = await getPlaceNameFromLatLng(point);
      }
    });
  }

  RxBool isUpdateData = false.obs;
  void changAddressName(String newAddress, {AddressData? address}) {
    if (selectedAddressName.value == newAddress) {
    } else {
      selectedAddressName.value = newAddress;
      isUpdateData.value = true;
    }
    if (address != null) {
      if (address.name == newAddress) {
        isUpdateData.value = false;
      } else {
        isUpdateData.value = true;
      }
    }
  }

  disposeAddOrEditScreen() {
    addressCompleteController.dispose();
    selectedAddressLocation.value = null;
  }

  RxBool isLoading = false.obs;
  postAddress({AddressData? address}) {
    actionCenter.execute(
      () async {
        try {
          isLoading(true);

          final req = AddressData(
            lat: selectedAddressLocation.value?.latitude.toString(),
            lng: selectedAddressLocation.value?.longitude.toString(),
            location: addressCompleteController.text,
            name: selectedAddressName.value,
            id: address?.id,
          );

          isLoading(true);
          await addressRepo1.postAddress(req);
          isLoading(false);
          OverlayHelper.showSuccessToast(Get.overlayContext!, "Sucses");
          await getAddressList();
          Get.back();
        } on Exception {
          isLoading(false);
          OverlayHelper.showErrorToast(Get.overlayContext!, "Error");
        }
      },
      checkConnection: true,
    );
  }

  deleteAddress({required AddressData address}) {
    actionCenter.execute(
      () async {
        try {
          isLoading(true);

          isLoading(true);
          await addressRepo1.deleteAddress(address);
          isLoading(false);
          OverlayHelper.showSuccessToast(Get.overlayContext!, "Sucses");
          await getAddressList();
          Get.back();
        } on Exception {
          isLoading(false);
          OverlayHelper.showErrorToast(Get.overlayContext!, "Error");
        }
      },
      checkConnection: true,
    );
  }

  @override
  Future<String> getPlaceNameFromLatLng(LatLng latlng) async {
    return SearchServices().getPlaceNameFromLatLng(latlng);
  }

  static String getAddressIconByName(String name) {
    int index = staticAddressNames.indexWhere((element) => element == name);

    if (index == -1) {
      return Images.location;
    } else {
      return staticAddressIcons[index];
    }
  }

  Future<void> getAddressList() async {
    if (addressModel.data==null) {
  setState(ViewState.busy);
  
  try {
    addressModel = await addressRepo1.getAddressList();
    for (var item in staticAddressNames) {
      int? index =
          addressModel.data?.indexWhere((element) => element.name == item);
      if (index != null) {
        if (index == -1) {
          addressModel.data?.add(AddressData.createEmpty(item));
        }
      }
    }
  
    if (kDebugMode) {
      print('addressList ${addressModel.data?.length}');
    }
    // }
  } on MsgModel {
    // TODO
  }
  setState(ViewState.idle);
  
  update();
}
  }

  Future<void> getSuggestedAddressList() async {
    if (suggestionAddressModel.data == null) {
      setState(ViewState.busy);

      try {
        suggestionAddressModel = await addressRepo1.getSuggestedAddressList();

        print('suggestionAddressModel ${suggestionAddressModel.data?.length}');
        // }
      } on MsgModel {
        // TODO
      }
      setState(ViewState.idle);
      update();
    }

    
  }

  void setCurrentIndex(int index, bool notify) {
    _currentIndex = index;
    if (notify) {
      update();
    }
  }
}
