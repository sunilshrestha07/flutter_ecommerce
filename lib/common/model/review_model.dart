class reviewmodel {
  String? sId;
  String? userName;
  String? comment;
  int? rating;
  String? postId;
  String? userId;
  String? userImage;
  String? createdAt;
  String? updatedAt;

  reviewmodel({
    this.sId,
    this.userName,
    this.comment,
    this.rating,
    this.postId,
    this.userId,
    this.userImage,
    this.createdAt,
    this.updatedAt,
  });

  reviewmodel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    comment = json['comment'];
    rating = json['rating'];
    postId = json['postId'];
    userId = json['userId'];
    userImage = json['userImage'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userName'] = this.userName;
    data['comment'] = this.comment;
    data['rating'] = this.rating;
    data['postId'] = this.postId;
    data['userId'] = this.userId;
    data['userImage'] = this.userImage;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
