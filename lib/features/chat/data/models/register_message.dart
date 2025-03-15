class MainMessagesRegisterModel {
  String? status;
  String? message;
  String? threadCode;

  MainMessagesRegisterModel({
    this.status,
    this.message,
    this.threadCode,
  });

  factory MainMessagesRegisterModel.fromJson(Map<String, dynamic> json) =>
      MainMessagesRegisterModel(
        status: json["status"],
        message: json["message"],
        threadCode: json["thread_code"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "thread_code": threadCode,
      };
}
