class BookEntity {
  final int? id;
  final String name;
  final String author;
  final int year;
  final String description;
  final String imagePath;

  BookEntity({
    this.id,
    required this.name,
    required this.author,
    required this.year,
    required this.description,
    required this.imagePath,
  });
}