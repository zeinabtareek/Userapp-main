import 'package:get/get.dart';
import 'package:ride_sharing_user_app/bases/base_controller.dart';
import 'package:ride_sharing_user_app/data/api_checker.dart';
import 'package:ride_sharing_user_app/enum/view_state.dart';
import 'package:ride_sharing_user_app/view/screens/home/model/banner_model.dart';
import 'package:ride_sharing_user_app/view/screens/home/repository/banner_repo.dart';

class BannerController extends BaseController implements GetxService {
  final BannerRepo bannerRepo;

  BannerController({required this.bannerRepo});

  List<BannerData> banners =<BannerData> [];

  int? _currentIndex = 0;

  int? get currentIndex => _currentIndex;

  onInit()async{
    super.onInit();

   await getBannerList();


  }
  final loading=false.obs;


  Future<void> getBannerList() async {
    // loading.value=true;

    try{
     BannerModel response = await bannerRepo.getSlider();
       banners = [];
      banners.addAll(response.data as Iterable<BannerData>);

  }catch(e){
      print(e);
    }
    // loading.value=false;
    update();

  }

  void setCurrentIndex(int index, bool notify) {
    _currentIndex = index;
    if (notify) {
      update();
    }
  }
}
