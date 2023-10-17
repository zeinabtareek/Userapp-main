import '../../../../genral-models/vehicle_type.dart';

class CategoryModel {
  String? id;
  String? categoryImage;
  String? categoryTitle;
  String? discountType;
  List<CategoryModel>? sub;

  CategoryModel({
    this.categoryImage,
    this.categoryTitle,
    this.discountType,
    this.id,
    this.sub,
  });

  factory CategoryModel.fromVehicleType(VehicleType vehicleType) {
    return CategoryModel(
      id: vehicleType.id,
      categoryImage: vehicleType.img,
      categoryTitle: vehicleType.name,
      sub: vehicleType.types
          ?.map((e) => CategoryModel.fromVehicleType(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': categoryImage,
      "type": categoryTitle,
    };
  }
}
