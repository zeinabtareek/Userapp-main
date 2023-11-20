import '../../../../genral-models/vehicle_type.dart';

class CategoryModel {
  String? id;
  String? categoryImage;
  String? categoryTitle;
  String? discountType;
  List<CategoryModel>? sub;
  bool? isActive;
  bool? hasChild;
  bool? isParcel;
  CategoryModel({
    this.categoryImage,
    this.categoryTitle,
    this.discountType,
    this.id,
    this.sub,
    this.isActive,
    this.hasChild,
    this.isParcel,
  });

  factory CategoryModel.fromVehicleType(VehicleType vehicleType) {
    return CategoryModel(
      id: vehicleType.id,
      hasChild: vehicleType.hasChild,
      isActive: vehicleType.isActive,
      categoryImage: vehicleType.img,
      categoryTitle: vehicleType.name,
      isParcel: vehicleType.isParcel,
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
