import 'package:get/get.dart';
import 'package:ride_sharing_user_app/bases/base_controller.dart';
import 'package:ride_sharing_user_app/data/api_checker.dart';
import 'package:ride_sharing_user_app/enum/view_state.dart';
import 'package:ride_sharing_user_app/view/screens/home/model/banner_model.dart';
import 'package:ride_sharing_user_app/view/screens/home/repository/banner_repo.dart';

class BannerController extends BaseController implements GetxService {
  final BannerRepo bannerRepo;

  BannerController({required this.bannerRepo});

  final banners = <BannerData>[].obs;
  // List<BannerData> banners =<BannerData> [];

  int? _currentIndex = 0;

  int? get currentIndex => _currentIndex;

  final loading = false.obs;
  onInit() async {
    super.onInit();

    await getBannerList();
  }

  RxnNum unReedCount = RxnNum();
  Future<void> getBannerList() async {
    try {
      loading.value = true;
      var res = await bannerRepo.getSlider();
      BannerModel response = res.$1;
      unReedCount.value = res.$2;
      banners.value = [];
      banners.value.addAll(response.data as Iterable<BannerData>);
      loading.value = false;
    } catch (e) {
      print(e);
    }
    update();
  }

  void setCurrentIndex(int index, bool notify) {
    _currentIndex = index;
    if (notify) {
      update();
    }
  }
}
