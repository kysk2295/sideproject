class Post{
  final String artistName;
  final String productName;
  final String thumbnailUrl;
  final String imgUrl;

  Post({required this.artistName, required this.productName, required this.thumbnailUrl,
  required this.imgUrl});

  factory Post.fromJson(Map<String,dynamic> json){
    return Post(
      artistName:json['artistName'],
      productName:json['productName'],
      thumbnailUrl:json['thumbnailUrl'],
      imgUrl:json['imgUrl'],
    );
  }
}