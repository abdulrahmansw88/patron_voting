class Character{
  String? name;
  String? imageUrl;
  int? noOfVotes;

  Character({this.name, this.imageUrl, this.noOfVotes});
  toMap() {
    return {
      "name": name,
      "imageUrl": imageUrl,
      "noOfVotes": noOfVotes,
    };
  }
}