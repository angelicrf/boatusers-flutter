class Post {
  int id = 0;
  String userId = '';
  String title = '';
  String body = '';

  Post.fromJson(Map<String, dynamic> json) {
    // ignore: unnecessary_null_comparison
    if (json == null) return;
    id = json['id'];
    json['userId'];
    title = json['title'];
    body = json['body'];
  }

/*   Post.toJson(Map<String, dynamic> json) {
    json['id'] = id;
    json['userId'] = userId;
    json['title'] = title;
    json['body'] = body;
  } */
  Map<String, dynamic> toJson() =>
      {"id": id, "userId": userId, "title": title, "body": body};
  static List<Post> listofObjects(List<dynamic> thisObject) {
    List<Post> thisValue =
        thisObject.map((value) => Post.fromJson(value)).toList();
    // ignore: unnecessary_null_comparison
    return thisObject == null ? <Post>[] as List<Post> : thisValue;
  }
}
