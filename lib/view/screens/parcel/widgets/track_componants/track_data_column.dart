import 'package:flutter/cupertino.dart';
import 'package:ride_sharing_user_app/view/screens/parcel/widgets/track_componants/track_data_list_tile.dart';

trackDataColumn({required List x}) {
// trackDataColumn({statusTitle,statusDate}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: List.generate(
      x.length,
      (index) => trackDataListTile(
        title: x[index]['title'],
        subTitle: x[index]['subTitle'],
      ),
    ),
  );
}
