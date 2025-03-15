// To parse this JSON data, do
//
//     final mainMessageModel = mainMessageModelFromJson(jsonString);

import 'dart:convert';

MainMessageModel mainMessageModelFromJson(String str) =>
    MainMessageModel.fromJson(json.decode(str));

String mainMessageModelToJson(MainMessageModel data) =>
    json.encode(data.toJson());

class MainMessageModel {
  String? status;
  MainMessageModelData? data;

  MainMessageModel({
    this.status,
    this.data,
  });

  factory MainMessageModel.fromJson(Map<String, dynamic> json) =>
      MainMessageModel(
        status: json["status"],
        data: json["data"] == null
            ? null
            : MainMessageModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class MainMessageModelData {
  String? threadCode;
  ThreadDetails? threadDetails;
  List<Message>? messages;

  MainMessageModelData({
    this.threadCode,
    this.threadDetails,
    this.messages,
  });

  factory MainMessageModelData.fromJson(Map<String, dynamic> json) =>
      MainMessageModelData(
        threadCode: json["thread_code"],
        threadDetails: json["thread_details"] == null
            ? null
            : ThreadDetails.fromJson(json["thread_details"]),
        messages: json["messages"] == null
            ? []
            : List<Message>.from(
                json["messages"]!.map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "thread_code": threadCode,
        "thread_details": threadDetails?.toJson(),
        "messages": messages == null
            ? []
            : List<dynamic>.from(messages!.map((x) => x.toJson())),
      };
}

class Message {
  int? id;
  int? threadId;
  int? senderId;
  int? receiverId;
  String? message;
  int? read;
  DateTime? createdAt;
  DateTime? updatedAt;

  Message({
    this.id,
    this.threadId,
    this.senderId,
    this.receiverId,
    this.message,
    this.read,
    this.createdAt,
    this.updatedAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
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

class ThreadDetails {
  int? id;
  String? code;
  int? contactOne;
  int? contactTwo;
  DateTime? createdAt;
  DateTime? updatedAt;

  ThreadDetails({
    this.id,
    this.code,
    this.contactOne,
    this.contactTwo,
    this.createdAt,
    this.updatedAt,
  });

  factory ThreadDetails.fromJson(Map<String, dynamic> json) => ThreadDetails(
        id: json["id"],
        code: json["code"],
        contactOne: json["contact_one"],
        contactTwo: json["contact_two"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "contact_one": contactOne,
        "contact_two": contactTwo,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
