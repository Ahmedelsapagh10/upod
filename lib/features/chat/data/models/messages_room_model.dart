class MainMessagesRoomModel {
  String? status;
  List<MainMessagesRoomModelData>? data;

  MainMessagesRoomModel({
    this.status,
    this.data,
  });

  factory MainMessagesRoomModel.fromJson(Map<String, dynamic> json) =>
      MainMessagesRoomModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<MainMessagesRoomModelData>.from(json["data"]!
                .map((x) => MainMessagesRoomModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MainMessagesRoomModelData {
  int? id;
  String? code;
  Contact? contactOne;
  Contact? contactTwo;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? unreadMessagesCount;
  LastMessage? lastMessage;

  MainMessagesRoomModelData({
    this.id,
    this.code,
    this.contactOne,
    this.contactTwo,
    this.createdAt,
    this.updatedAt,
    this.unreadMessagesCount,
    this.lastMessage,
  });

  factory MainMessagesRoomModelData.fromJson(Map<String, dynamic> json) =>
      MainMessagesRoomModelData(
        id: json["id"],
        code: json["code"],
        contactOne: json["contact_one"] == null
            ? null
            : Contact.fromJson(json["contact_one"]),
        contactTwo: json["contact_two"] == null
            ? null
            : Contact.fromJson(json["contact_two"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        unreadMessagesCount: json["unread_messages_count"],
        lastMessage: json["last_message"] == null
            ? null
            : LastMessage.fromJson(json["last_message"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "contact_one": contactOne?.toJson(),
        "contact_two": contactTwo?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "unread_messages_count": unreadMessagesCount,
        "last_message": lastMessage?.toJson(),
      };
}

class Contact {
  int? id;
  String? role;
  String? email;
  int? status;
  String? name;
  String? phone;
  dynamic website;
  String? skills;
  int? points;
  int? wallet;
  String? facebook;
  String? twitter;
  String? linkedin;
  String? address;
  dynamic about;
  String? biography;
  dynamic educations;
  String? photo;
  DateTime? emailVerifiedAt;
  dynamic paymentkeys;
  dynamic videoUrl;
  DateTime? createdAt;
  DateTime? updatedAt;

  Contact({
    this.id,
    this.role,
    this.email,
    this.status,
    this.name,
    this.phone,
    this.website,
    this.skills,
    this.points,
    this.wallet,
    this.facebook,
    this.twitter,
    this.linkedin,
    this.address,
    this.about,
    this.biography,
    this.educations,
    this.photo,
    this.emailVerifiedAt,
    this.paymentkeys,
    this.videoUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json["id"],
        role: json["role"],
        email: json["email"],
        status: json["status"],
        name: json["name"],
        phone: json["phone"],
        website: json["website"],
        skills: json["skills"],
        points: json["points"],
        wallet: json["wallet"],
        facebook: json["facebook"],
        twitter: json["twitter"],
        linkedin: json["linkedin"],
        address: json["address"],
        about: json["about"],
        biography: json["biography"],
        educations: json["educations"],
        photo: json["photo"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        paymentkeys: json["paymentkeys"],
        videoUrl: json["video_url"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role": role,
        "email": email,
        "status": status,
        "name": name,
        "phone": phone,
        "website": website,
        "skills": skills,
        "points": points,
        "wallet": wallet,
        "facebook": facebook,
        "twitter": twitter,
        "linkedin": linkedin,
        "address": address,
        "about": about,
        "biography": biography,
        "educations": educations,
        "photo": photo,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "paymentkeys": paymentkeys,
        "video_url": videoUrl,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class LastMessage {
  int? id;
  int? threadId;
  int? senderId;
  int? receiverId;
  String? message;
  int? read;
  DateTime? createdAt;
  DateTime? updatedAt;

  LastMessage({
    this.id,
    this.threadId,
    this.senderId,
    this.receiverId,
    this.message,
    this.read,
    this.createdAt,
    this.updatedAt,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
        id: json["id"],
        threadId: json["thread_id"],
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        message: json["message"],
        read: json["read"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "thread_id": threadId,
        "sender_id": senderId,
        "receiver_id": receiverId,
        "message": message,
        "read": read,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
