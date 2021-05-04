class Product {
  final String id;
  final String title;
  final String description;
  final String price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.imageUrl,
      this.isFavorite = false});
}
