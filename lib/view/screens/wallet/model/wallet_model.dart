class WalletModel {
  WalletModel({
      this.data,
      this.links,
      this.meta,
      this.status,
      this.message,
      this.wallet,
  });

  final List<WalletData>? data;
  final Links? links;
  final Meta? meta;
  final String? status;
  final dynamic message;
  final int? wallet;

  factory WalletModel.fromJson(Map<String, dynamic> json){
    return WalletModel(
      data: json["data"] == null ? [] : List<WalletData>.from(json["data"]!.map((x) => WalletData.fromJson(x))),
      links: json["links"] == null ? null : Links.fromJson(json["links"]),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      status: json["status"],
      message: json["message"],
      wallet: json["wallet"],
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data?.map((x) => x.toJson()).toList(),
    "links": links?.toJson(),
    "meta": meta?.toJson(),
    "status": status,
    "message": message,
    "wallet": wallet,
  };

}

class WalletData {
  WalletData({
    required this.id,
    required this.order,
    required this.amount,
    required this.walletBefore,
    required this.walletAfter,
    required this.transactionType,
    required this.createdAt,
  });

  final String? id;
  final Order? order;
  final int? amount;
  final int? walletBefore;
  final int? walletAfter;
  final String? transactionType;
  final String? createdAt;

  factory WalletData.fromJson(Map<String, dynamic> json){
    return WalletData(
      id: json["id"],
      order: json["order"] == null ? null : Order.fromJson(json["order"]),
      amount: json["amount"],
      walletBefore: json["wallet_before"],
      walletAfter: json["wallet_after"],
      transactionType: json["transaction_type"],
      createdAt: json["created_at"],
      // createdAt: DateTime.tryParse(json["created_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "order": order?.toJson(),
    "amount": amount,
    "wallet_before": walletBefore,
    "wallet_after": walletAfter,
    "transaction_type": transactionType,
    "created_at": createdAt,
  };

}

class Order {
  Order({
    required this.id,
    required this.status,
    required this.transactionId,
  });

  final int? id;
  final String? status;
  final dynamic transactionId;

  factory Order.fromJson(Map<String, dynamic> json){
    return Order(
      id: json["id"],
      status: json["status"],
      transactionId: json["transaction_id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "transaction_id": transactionId,
  };

}

class Links {
  Links({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

  final String? first;
  final String? last;
  final dynamic prev;
  final dynamic next;

  factory Links.fromJson(Map<String, dynamic> json){
    return Links(
      first: json["first"],
      last: json["last"],
      prev: json["prev"],
      next: json["next"],
    );
  }

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };

}

class Meta {
  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  final int? currentPage;
  final int? from;
  final int? lastPage;
  final List<Link> links;
  final String? path;
  final int? perPage;
  final int? to;
  final int? total;

  factory Meta.fromJson(Map<String, dynamic> json){
    return Meta(
      currentPage: json["current_page"],
      from: json["from"],
      lastPage: json["last_page"],
      links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
      path: json["path"],
      perPage: json["per_page"],
      to: json["to"],
      total: json["total"],
    );
  }

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": links.map((x) => x?.toJson()).toList(),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };

}

class Link {
  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  final String? url;
  final String? label;
  final bool? active;

  factory Link.fromJson(Map<String, dynamic> json){
    return Link(
      url: json["url"],
      label: json["label"],
      active: json["active"],
    );
  }

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };

}
