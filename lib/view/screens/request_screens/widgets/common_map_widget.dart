import 'package:flutter/cupertino.dart';
import 'package:flutter_animarker/widgets/animarker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';

class CommonMapWidget extends StatelessWidget {
  Future<int> mapId;
  CameraPosition initialCameraPosition;
  Function(GoogleMapController)? onMapCreated;

  CommonMapWidget({
    super.key,
    required this.mapId,
    required this.onMapCreated,
    required this.initialCameraPosition,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Animarker(
          curve: Curves.easeIn,
          rippleRadius: 0.2,
          useRotation: true,
          duration: const Duration(milliseconds: 2300),
          mapId: mapId,
          shouldAnimateCamera: false,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.radiusOverLarge),
            child: GoogleMap(
              zoomControlsEnabled: false,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              compassEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: initialCameraPosition,
              onMapCreated: onMapCreated,
            ),
          ),
        ),
        Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 100,
                child: Image.asset(Images.mapLocationIcon),
              ),
            ))
      ],
    );
  }
}
