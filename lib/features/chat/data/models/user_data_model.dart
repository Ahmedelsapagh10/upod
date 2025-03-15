class MainUserDataModel {
  bool? status;
  String? message;
  MainUserDataModelData? data;

  MainUserDataModel({
    this.status,
    this.message,
    this.data,
  });

  factory MainUserDataModel.fromJson(Map<String, dynamic> json) =>
      MainUserDataModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : MainUserDataModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class MainUserDataModelData {
  int? id;
  String? role;
  String? email;
  int? status;
  String? name;
  dynamic phone;
  dynamic website;
  dynamic skills;
  dynamic points;
  dynamic wallet;
  String? facebook;
  String? twitter;
  String? linkedin;
  dynamic address;
  dynamic about;
  String? biography;
  dynamic educations;
  String? photo;
  dynamic emailVerifiedAt;
  dynamic paymentkeys;
  dynamic videoUrl;
  DateTime? createdAt;
  DateTime? updatedAt;

  MainUserDataModelData({
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

  factory MainUserDataModelData.fromJson(Map<String, dynamic> json) =>
      MainUserDataModelData(
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
        emailVerifiedAt: json["email_verified_at"],
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
        "email_verified_at": emailVerifiedAt,
        "paymentkeys": paymentkeys,
        "video_url": videoUrl,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
