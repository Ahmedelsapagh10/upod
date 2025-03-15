class MainRoomModel {
  String? status;
  List<MainRoomModelData>? data;

  MainRoomModel({
    this.status,
    this.data,
  });

  factory MainRoomModel.fromJson(Map<String, dynamic> json) => MainRoomModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<MainRoomModelData>.from(
                json["data"]!.map((x) => MainRoomModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MainRoomModelData {
  int? id;
  String? role;
  String? email;
  int? status;
  String? name;
  String? phone;
  dynamic website;
  String? skills;
  int? points;
  dynamic facebook;
  dynamic twitter;
  dynamic linkedin;
  String? address;
  dynamic about;
  dynamic biography;
  dynamic educations;
  dynamic photo;
  DateTime? emailVerifiedAt;
  dynamic paymentkeys;
  dynamic videoUrl;
  DateTime? createdAt;
  dynamic updatedAt;

  MainRoomModelData({
    this.id,
    this.role,
    this.email,
    this.status,
    this.name,
    this.phone,
    this.website,
    this.skills,
    this.points,
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

  factory MainRoomModelData.fromJson(Map<String, dynamic> json) =>
      MainRoomModelData(
        id: json["id"],
        role: json["role"],
        email: json["email"],
        status: json["status"],
        name: json["name"],
        phone: json["phone"],
        website: json["website"],
        skills: json["skills"],
        points: json["points"],
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
        updatedAt: json["updated_at"],
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
        "updated_at": updatedAt,
      };
}
