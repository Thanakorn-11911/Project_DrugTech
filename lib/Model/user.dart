class UsersM {
  String id, email, username, image;
  UsersM({this.id, this.email, this.username, this.image});
  static UsersM current;
  factory UsersM.fromJson(Map<String, dynamic> j, {String id}) => UsersM(
      email: j['email'],
      id: j['id'],
      username: j['username'],
      image: j['image']);
  Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "username": username,
        "image": image,
      };
}
