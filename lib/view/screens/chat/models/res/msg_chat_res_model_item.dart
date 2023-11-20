// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ride_sharing_user_app/authenticate/data/models/res-models/user_model.dart';
import 'package:ride_sharing_user_app/view/screens/chat/models/req/send_msg_req_model.dart';
import 'package:ride_sharing_user_app/view/screens/where_to_go/model/order_create.dart';

import '../../constants/chat_constant.dart';

Map _item = {
  "data": [
    {
      "id": "11555f14-4b31-4bf8-a5c4-a8fd1f130768",
      "chat_type": "order",
      "order": {
        "id": "c5763dca-8a84-4483-bee0-b1bef9a02a52",
        "status": "driver_accept",
        "distance": 10,
        "time": 10,
        "payment_type": "cash",
        "from": {"lat": "21.23443", "lng": "23.32323", "location": "Nasr City"},
        "to": {"lat": "21.23443", "lng": "23.32323", "location": "Nasr City"},
        "is_parcel": false,
        "created_at": "2023-09-28 14:56:16"
      },
      "user": {
        "id": "f82eb02c-c8b5-4c14-a0a4-6ba4423e8777",
        "phone_code": "+966",
        "phone": "1020187099",
        "email": "abeerelghool@gmail.com",
        "img":
            "http://127.0.0.1:8000/storage/files/uploads/user/img/1683564049335319742download_hood_1696327801_@2023.png",
        "first_name": "abeer",
        "last_name": "elghool",
        "username": "abeerd97e0"
      },
      "driver": {
        "id": "b4dd80b3-73b6-497a-93c1-3e1bfaf9739e",
        "phone_code": "+966",
        "phone": "123456781",
        "email": "omar@gmail.com",
        "img":
            "http://127.0.0.1:8000/storage/files/uploads/driver/img/1679554542217114369depositphotos_119659092-stock-illustration-male-avatar-profile-picture-vector_hood_1696326991_@2023.jpg",
        "first_name": "Omar",
        "last_name": "Mohamed",
        "vehicle": null
      },
      "admin": null,
      "last_msg": "Hi User !",
      "msg_type": "text",
      "read_at": "2023-10-03 10:56:31",
      "sender_type": "driver",
      "created_at": "2023-10-02 06:07:21"
    }
  ],
  "links": {
    "first": "http://127.0.0.1:8000/api/driver/chats?page=1",
    "last": "http://127.0.0.1:8000/api/driver/chats?page=1",
    "prev": null,
    "next": null
  },
  "meta": {
    "current_page": 1,
    "from": 1,
    "last_page": 1,
    "links": [
      {"url": null, "label": "&laquo; Previous", "active": false},
      {
        "url": "http://127.0.0.1:8000/api/driver/chats?page=1",
        "label": "1",
        "active": true
      },
      {"url": null, "label": "Next &raquo;", "active": false}
    ],
    "path": "http://127.0.0.1:8000/api/driver/chats",
    "per_page": 10,
    "to": 1,
    "total": 1
  },
  "status": 200,
  "message": null
};

class MsgChatResModelItem {
  String? id;
  String? chatType;
  Order? order;
  Driver? user;
  Driver? driver;
  Driver? admin;
  String? lastMsg;
  MsgType? msgType;
  DateTime? readAt;
  String? senderType;
  DateTime? createdAt;
  dynamic msg;

  // TODO:  msgStuts
  bool? isMe;
  MsgChatResModelItem({
    this.id,
    this.chatType,
    this.order,
    this.user,
    this.driver,
    this.admin,
    this.lastMsg,
    this.msgType,
    this.readAt,
    this.senderType,
    this.createdAt,
    this.isMe,
    this.msg,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'chatType': chatType,
      'order': order?.toMap(),
      'user': user?.toMap(),
      'driver': driver?.toMap(),
      'admin': admin,
      'lastMsg': lastMsg,
      'msgType': msgType,
      'readAt': readAt?.millisecondsSinceEpoch,
      'senderType': senderType,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory MsgChatResModelItem.fromMap(Map<String, dynamic> map) {
    try {
      return MsgChatResModelItem(
        isMe: map['sender_type'] == ChatConstant.who,
        msg: map['msg'],
        id: map['id'] != null ? map['id'] as String : null,
        chatType: map['chat_type'] != null ? map['chat_type'] as String : null,
        order: map['order'] != null
            ? Order.fromMap(map['order'] as Map<String, dynamic>)
            : null,
        user: map['user'] != null
            ? Driver.fromMap(map['user'] as Map<String, dynamic>)
            : null,
        driver: map['driver'] != null
            ? Driver.fromMap(map['driver'] as Map<String, dynamic>)
            : null,
        admin: map['admin'] != null
            ? Driver.fromMap(map['admin'] as Map<String, dynamic>)
            : null,
        lastMsg: map['last_msg'] != null ? map['last_msg'] as String : null,
        msgType: map['msg_type'] != null
            ? MsgType.values.firstWhere(
                (element) => element.name == map['msg_type'] as String)
            : null,
        readAt: map['read_at'] != null
            ? DateTime.parse(map['read_at'] as String)
            : null,
        senderType:
            map['sender_type'] != null ? map['sender_type'] as String : null,
        createdAt: map['created_at'] != null
            ? DateTime.parse(map['created_at'] as String)
            : null,
      );
    } on Exception {
      print(" e :: e ");
      rethrow;
    }
  }

  factory MsgChatResModelItem.fromSingleMsg(
      Map<String, dynamic> mapElement, Map<String, dynamic> map) {
    try {
      return MsgChatResModelItem(
        isMe: mapElement['sender_type'] == ChatConstant.who,
        msg: mapElement['msg'],
        id: mapElement['id'] != null ? mapElement['id'] as String : null,
        chatType: map['chat_type'] != null ? map['chat_type'] as String : null,
        order: map['order'] != null
            ? Order.fromMap(map['order'] as Map<String, dynamic>)
            : null,
        user: map['user'] != null
            ? Driver.fromMap(map['user'] as Map<String, dynamic>)
            : null,
        driver: map['driver'] != null
            ? Driver.fromMap(map['driver'] as Map<String, dynamic>)
            : null,
        admin: map['admin'] != null
            ? Driver.fromMap(map['admin'] as Map<String, dynamic>)
            : null,
        lastMsg: map['last_msg'] != null ? map['last_msg'] as String : null,
        msgType: mapElement['msg_type'] != null
            ? MsgType.values.firstWhere(
                (element) => element.name == mapElement['msg_type'] as String)
            : null,
        readAt: mapElement['read_at'] != null
            ? DateTime.parse(mapElement['read_at'] as String)
            : null,
        senderType: mapElement['sender_type'] != null
            ? mapElement['sender_type'] as String
            : null,
        createdAt: mapElement['created_at'] != null
            ? DateTime.parse(mapElement['created_at'] as String)
            : null,
      );
    } on Exception {
      print(" e :: e ");
      rethrow;
    }
  }

  factory MsgChatResModelItem.fromSocketMap(Map<String, dynamic> map) {
    /*
 message: {id: 909a7d1e-ceb9-43bb-b4ca-08e4f5161d35,
  msg: V,
   msg_type: text, 
   sender_type: user,
    read_at: null,
     created_at: 2023-10-28 23:00:41,} 
   */
    return MsgChatResModelItem(
      id: map['id'],
      msg: map['msg'],
      isMe: false,
      msgType: MsgType.values
          .firstWhere((element) => element.name == map["msg_type"]),
      senderType:
          map['sender_type'] != null ? map['sender_type'] as String : null,
      readAt: map['read_at'] != null ? DateTime.parse(map['read_at']) : null,
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
    );
  }
  String toJson() => json.encode(toMap());

  factory MsgChatResModelItem.fromJson(String source) =>
      MsgChatResModelItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MsgChatResModelItem(id: $id, chatType: $chatType, order: $order, user: $user, driver: $driver, admin: $admin, lastMsg: $lastMsg, msgType: $msgType, readAt: $readAt, senderType: $senderType, createdAt: $createdAt, msg: $msg, isMe: $isMe)';
  }
}

class Driver {
  String? id;
  String? phoneCode;
  String? phone;
  String? email;
  String? img;
  String? firstName;
  String? lastName;
  dynamic vehicle;
  String? username;
  int? rate;
  Driver({
    this.id,
    this.rate,
    this.phoneCode,
    this.phone,
    this.email,
    this.img,
    this.firstName,
    this.lastName,
    this.vehicle,
    this.username,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'phoneCode': phoneCode,
      'phone': phone,
      'email': email,
      'img': img,
      'firstName': firstName,
      'lastName': lastName,
      'vehicle': vehicle,
      'username': username,
    };
  }

  factory Driver.fromMap(Map<String, dynamic> map) {
    return Driver(
      id: map['id'] != null ? map['id'] as String : null,
      phoneCode: map['phone_code'] != null ? map['phone_code'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      img: map['img'] != null ? map['img'] as String : null,
      firstName:
          (map['first_name'] != null ? map['first_name'] as String : null) ??
              (map['name'] != null ? map['name'] as String : null),
      lastName: map['last_name'] != null ? map['last_name'] as String : null,
      vehicle: map['vehicle'] != null ? Vehicle.fromJson(map['vehicle']) : null,
      username: map['user_name'] != null ? map['user_name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Driver.fromJson(String source) =>
      Driver.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Driver. fromUser(UserAuthModel user) {
    return Driver(
        email: user.email,
        firstName: user.firstName,
        lastName: user.lastName,
        id: user.id,
        img: user.img,
        phone: user.phone,
        phoneCode: user.phoneCode,
        rate: user.rating,
        username: user.username,
        vehicle: null);
  }
}

class Order {
  String id;
  String status;
  int distance;
  int time;
  String paymentType;
  From from;
  From to;
  bool isParcel;
  DateTime createdAt;

  Order({
    required this.id,
    required this.status,
    required this.distance,
    required this.time,
    required this.paymentType,
    required this.from,
    required this.to,
    required this.isParcel,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status,
      'distance': distance,
      'time': time,
      'paymentType': paymentType,
      'from': from.toMap(),
      'to': to.toMap(),
      'isParcel': isParcel,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] as String,
      status: map['status'] as String,
      distance: map['distance'] as int,
      time: map['time'] as int,
      paymentType: map['payment_type'] as String,
      from: From.fromMap(map['from'] as Map<String, dynamic>),
      to: From.fromMap(map['to'] as Map<String, dynamic>),
      isParcel: map['is_parcel'] as bool,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);

// TODO: get canceled word
  bool get canChatInOrder {
    bool chatStatus = status != "finished" && status != "canceled";
    print(" chatStatus $chatStatus $status ");
    return chatStatus;
  }
}

class From {
  String lat;
  String lng;
  String location;

  From({
    required this.lat,
    required this.lng,
    required this.location,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'lng': lng,
      'location': location,
    };
  }

  factory From.fromMap(Map<String, dynamic> map) {
    return From(
      lat: map['lat'] as String,
      lng: map['lng'] as String,
      location: map['location'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory From.fromJson(String source) =>
      From.fromMap(json.decode(source) as Map<String, dynamic>);
}
