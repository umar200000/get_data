class ModelPosts {
  int userId;
  int id;
  String title;
  String body;

  ModelPosts(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});

  factory ModelPosts.fromJosn(Map<String, dynamic> data) {
    return ModelPosts(
        userId: data["userId"],
        id: data["id"],
        title: data["title"],
        body: data["body"]);
  }
}
