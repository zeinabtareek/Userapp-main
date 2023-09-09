class ActivityItemModel{
  final String image;
  final String vachelType;
  final String? title;
  final String? date;
  final String? orderStatus;
  final double? orderAmount;
  final RiderDetails? riderDetails;
  final TripDetails? tripDetails;

  ActivityItemModel(
    {
      required this.image,
      required this.vachelType,
      this.title,
      this.date,
      this.orderAmount,
      this.orderStatus,
      this.riderDetails,
      this.tripDetails
    });
}

class RiderDetails{
  final String? name;
  final String? image;
  final double? rating;
  final String? vehicleType;
  final String? vehicleName;
  final String? vehicleNumber;

  RiderDetails(
    {
      this.name,
      this.image,
      this.rating,
      this.vehicleType,
      this.vehicleName,
      this.vehicleNumber
    });
}

class TripDetails{
  final String? pickLocation;
  final String? destination;
  final double? totalDistance;
  final double? farePrice;
  final String? paymentMethod;

  TripDetails(
    {
      this.pickLocation,
      this.destination,
      this.totalDistance,
      this.farePrice,
      this.paymentMethod,
  });
}

