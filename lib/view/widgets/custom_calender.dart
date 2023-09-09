import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/text_style.dart';
import 'package:ride_sharing_user_app/view/screens/history/controller/activity_controller.dart';
import 'package:ride_sharing_user_app/view/widgets/custom_button.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../util/app_strings.dart';

class CustomCalender extends StatefulWidget {
  final Function(Object? text) onChanged;
  final Function()? onPress;
  const CustomCalender({Key? key, required this.onChanged, this.onPress}) : super(key: key);

  @override
  State<CustomCalender> createState() => _CustomCalenderState();
}

class _CustomCalenderState extends State<CustomCalender> {
  String _range = '';

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('yyyy-MM-d').format(args.value.startDate)}/'

            '${DateFormat('yyyy-MM-d').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
      } else if (args.value is List<DateTime>) {
      } else {
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    List<String> rng = _range.split('/');
    final DateRangePickerController controller = DateRangePickerController();
    DateTime? selectedDate;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeDefault, vertical: 30),
      child: Container(decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraLarge),
        color: Theme.of(context).canvasColor,
      ),
        padding:  const EdgeInsets.all(Dimensions.paddingSizeDefault),

        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeLarge),
                  child: Card(elevation: 0,
                      color: Colors.transparent,
                      child: Text(Strings.selectYourDate.tr,
                        style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge),)),
                ),
                Expanded(
                  child: SfDateRangePicker(
                    confirmText: Strings.apply.tr,
                    showActionButtons: false,
                    cancelText: '',
                    onCancel: ()=> Navigator.pop(context),
                    onSubmit: widget.onChanged,
                    todayHighlightColor: Theme.of(context).primaryColor,
                    selectionMode: DateRangePickerSelectionMode.range,
                    rangeSelectionColor: Theme.of(context).primaryColor.withOpacity(.25),
                    view: DateRangePickerView.month,
                    enableMultiView: true,
                    navigationDirection: DateRangePickerNavigationDirection.vertical,
                    startRangeSelectionColor: Theme.of(context).primaryColor,
                    endRangeSelectionColor: Theme.of(context).colorScheme.onTertiaryContainer,
                    // initialSelectedRange: PickerDateRange(
                    //     DateTime.now().subtract(const Duration(days: 2)),
                    //     DateTime.now().add(const Duration(days: 2))),
                    onSelectionChanged: _onSelectionChanged,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Card(color: Colors.transparent,
                    elevation: 0,
                    child: Container(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
                      decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(100)
                    ),
                      child: Row(mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: Dimensions.iconSizeSmall,child: Image.asset(Images.calenderIcon)),

                        const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                         Text(rng.length>1? rng[0]:Strings.select, style: textRegular.copyWith(color: Colors.white),),
                      ],
                    ),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Card(color: Colors.transparent,
                    elevation: 0,
                    child: Container(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onTertiaryContainer,
                          borderRadius: BorderRadius.circular(100)
                      ),
                      child: Row(mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: Dimensions.iconSizeSmall,child: Image.asset(Images.calenderIcon)),
                          const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                          Text(rng.length>1? rng[1] :Strings.select, style: textRegular.copyWith(color: Colors.white),),
                        ],
                      ),),
                  ),
                ),

                const SizedBox(height: 40,),
                CustomButton(
                  radius: Dimensions.paddingSizeExtraLarge,
                  onPressed:(){
                    selectedDate = controller.selectedDate;
                    if (kDebugMode) {
                      print(selectedDate);
                    }

                    Get.find<ActivityController>().updateShowCustomDateState(true);
                    Get.find<ActivityController>().setFilterDateRangeValue(start: rng[0],end: rng[1]);
                    Get.back();
                  },
                  buttonText: Strings.apply.tr,

                ),
              ],
            ),
            Positioned(child: Align(
              alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: ()=> Get.back(),
                    child: Icon(Icons.clear,size: Dimensions.iconSizeMedium,color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(.5),))))
          ],
        ),),
    );
  }
}
