class MainStoryAndSliderModel {
  bool? status;
  String? message;
  List<Slider>? sliders;
  List<Story>? stories;

  MainStoryAndSliderModel({
    this.status,
    this.message,
    this.sliders,
    this.stories,
  });

  factory MainStoryAndSliderModel.fromJson(Map<String, dynamic> json) =>
      MainStoryAndSliderModel(
        status: json["status"],
        message: json["message"],
        sliders: json["sliders"] == null
            ? []
            : List<Slider>.from(
                json["sliders"]!.map((x) => Slider.fromJson(x))),
        stories: json["stories"] == null
            ? []
            : List<Story>.from(json["stories"]!.map((x) => Story.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "sliders": sliders == null
            ? []
            : List<dynamic>.from(sliders!.map((x) => x.toJson())),
        "stories": stories == null
            ? []
            : List<dynamic>.from(stories!.map((x) => x.toJson())),
      };
}

class Slider {
  int? id;
  String? image;
  dynamic link;

  Slider({
    this.id,
    this.image,
    this.link,
  });

  factory Slider.fromJson(Map<String, dynamic> json) => Slider(
        id: json["id"],
        image: json["image"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "link": link,
      };
}

class Story {
  int? id;
  String? image;
  DateTime? endTime;
  int? userId;
  String? by;

  Story({
    this.id,
    this.image,
    this.endTime,
    this.userId,
    this.by,
  });

  factory Story.fromJson(Map<String, dynamic> json) => Story(
        id: json["id"],
        image: json["image"],
        endTime:
            json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
        userId: json["user_id"],
        by: json["by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "end_time": endTime?.toIso8601String(),
        "user_id": userId,
        "by": by,
      };
}
