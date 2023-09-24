import 'package:flutter/cupertino.dart';

import '../../../../util/app_style.dart';
import '../../../../util/images.dart';
import '../../../widgets/custom_image.dart';

class PageViewBody extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;

  PageViewBody({
    super.key,
    required this.image,
    required this.subTitle,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Image(
        //   image: AssetImage(image),
        //   // image: AssetImage(image),
        //   // key: Key('${Random().nextInt(999999999)}'),
        //   fit: BoxFit.contain,
        //   alignment: Alignment.topCenter,
        // ),
        CustomImage(
          svg: image,
          // height: 86,
          // width: 86,
          placeholder: Images.personPlaceholder,
        ),
        K.sizedBoxH1,
        Text(title, style: K.boldBlackTextStyle),
        K.sizedBoxH3,

        SizedBox(
            width: MediaQuery.of(context).size.width / 1.4,
            child: Text(
              subTitle,
              style: K.hintLargeTextStyle,
              textAlign: TextAlign.center,
            )),
      ],
    );
  }
}
