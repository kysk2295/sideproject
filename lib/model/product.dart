class Product {
  final String title;
  final String desc;
  final String link;
  final String price;
  final String category;
  final List<String> tags;

  Product({required this.title, required this.desc, required this.link, required this.price,
  required this.category, required this.tags});

  Map<String, dynamic> toJson(){
    return {
      'title':title,
      'desc':desc,
      'link':link,
      'price':price,
      'category':category,
      'tags':tags,

    };

  }


}