class Users {
  List<dynamic> completedLevels = [];
  late int currentLevel;
  late String? email;
  late String uid;
  List<dynamic> friends = [];
  List<dynamic> fav_puzzles = [];
  late String firstName;
  late String lastName;
  int total_score = 0;
  late bool isAdmin;
  late String avatarUrl = "";
  Users(
      {this.currentLevel = 0,
      this.firstName = "guest",
      this.lastName = "guest",
      this.total_score = 0,
      this.isAdmin = false,
      this.uid = "",
      this.avatarUrl = ""});

  Map<String, dynamic> toMap(Users user) {
    var data = Map<String, dynamic>();

    data["uid"] = user.uid;
    data["firstname"] = user.firstName;
    data['lastName'] = user.lastName;
    data["email"] = user.email;
    data['currentLevel'] = 0;
    data['completedLevels'] = [];

    data['total_score'] = 0;
    data['isAdmin'] = user.isAdmin;

    data['friends'] = [];
    data['fav_puzzles'] = [];

    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Current Level: $currentLevel, firstName: $firstName, lastName: $lastName, ";
  }
}
