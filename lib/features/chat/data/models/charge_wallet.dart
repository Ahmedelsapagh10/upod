class MainChargeWalletModel {
  bool? status;
  String? message;

  MainChargeWalletModel({
    this.status,
    this.message,
  });

  factory MainChargeWalletModel.fromJson(Map<String, dynamic> json) =>
      MainChargeWalletModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
