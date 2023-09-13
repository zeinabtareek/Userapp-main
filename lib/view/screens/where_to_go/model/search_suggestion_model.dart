

import 'geometry_model.dart';

// class Suggestion {
//    final String  placeId;
//    String ? description;
//    String ? main_text;
//
//   Suggestion({required this.placeId, this.description, this.main_text});
//   factory Suggestion.fromJson(Map<String,dynamic>json){
//     return Suggestion(
//       placeId:json['place_id'],
//       description:json['description'],
//       main_text:json['main_text'],
//
//     );
//   }
//
//
// }
class Suggestion {
  List<Predictions>? predictions;
  String? status;

  Suggestion({this.predictions, this.status});

  Suggestion.fromJson(Map<String, dynamic> json) {
    if (json['predictions'] != null) {
      predictions = <Predictions>[];
      json['predictions'].forEach((v) {
        predictions!.add(new Predictions.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.predictions != null) {
      data['predictions'] = this.predictions!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Predictions {
  String? description;
  List<MatchedSubstrings>? matchedSubstrings;
  String? placeId;
  String? reference;
  StructuredFormatting? structuredFormatting;
  List<Terms>? terms;
  List<String>? types;

  Predictions(
      {this.description,
        this.matchedSubstrings,
        this.placeId,
        this.reference,
        this.structuredFormatting,
        this.terms,
        this.types});

  Predictions.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    if (json['matched_substrings'] != null) {
      matchedSubstrings = <MatchedSubstrings>[];
      json['matched_substrings'].forEach((v) {
        matchedSubstrings!.add(new MatchedSubstrings.fromJson(v));
      });
    }
    placeId = json['place_id'];
    reference = json['reference'];
    structuredFormatting = json['structured_formatting'] != null
        ? new StructuredFormatting.fromJson(json['structured_formatting'])
        : null;
    if (json['terms'] != null) {
      terms = <Terms>[];
      json['terms'].forEach((v) {
        terms!.add(new Terms.fromJson(v));
      });
    }
    types = json['types'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    if (this.matchedSubstrings != null) {
      data['matched_substrings'] =
          this.matchedSubstrings!.map((v) => v.toJson()).toList();
    }
    data['place_id'] = this.placeId;
    data['reference'] = this.reference;
    if (this.structuredFormatting != null) {
      data['structured_formatting'] = this.structuredFormatting!.toJson();
    }
    if (this.terms != null) {
      data['terms'] = this.terms!.map((v) => v.toJson()).toList();
    }
    data['types'] = this.types;
    return data;
  }
}

class MatchedSubstrings {
  int? length;
  int? offset;

  MatchedSubstrings({this.length, this.offset});

  MatchedSubstrings.fromJson(Map<String, dynamic> json) {
    length = json['length'];
    offset = json['offset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['length'] = this.length;
    data['offset'] = this.offset;
    return data;
  }
}

class StructuredFormatting {
  String? mainText;
  List<MatchedSubstrings>? mainTextMatchedSubstrings;
  String? secondaryText;

  StructuredFormatting(
      {this.mainText, this.mainTextMatchedSubstrings, this.secondaryText});

  StructuredFormatting.fromJson(Map<String, dynamic> json) {
    mainText = json['main_text'];
    if (json['main_text_matched_substrings'] != null) {
      mainTextMatchedSubstrings = <MatchedSubstrings>[];
      json['main_text_matched_substrings'].forEach((v) {
        mainTextMatchedSubstrings!
            .add(new MatchedSubstrings.fromJson(v));
      });
    }
    secondaryText = json['secondary_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['main_text'] = this.mainText;
    if (this.mainTextMatchedSubstrings != null) {
      data['main_text_matched_substrings'] =
          this.mainTextMatchedSubstrings!.map((v) => v.toJson()).toList();
    }
    data['secondary_text'] = this.secondaryText;
    return data;
  }
}

class Terms {
  int? offset;
  String? value;

  Terms({this.offset, this.value});

  Terms.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offset'] = this.offset;
    data['value'] = this.value;
    return data;
  }
}





















class PlaceDetail {
  final Geometry ?geometry;
  String? address;
  double? latitude;
  double? longitude;
  String? name;

  PlaceDetail({
    this.geometry,
    this.address,
    this.latitude,
    this.longitude,
    this.name,
  });

  factory PlaceDetail.fromJson(Map<String,dynamic>json){
    return PlaceDetail(
      geometry: Geometry.fromJson(json['geometry']),
      address:json['address'],
      latitude:json['latitude'],
      longitude:json['longitude'],
      name:json['name'],

    );
}
}

