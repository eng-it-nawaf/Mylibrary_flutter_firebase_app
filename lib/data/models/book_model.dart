import 'package:onboarding_app/domain/entities/book_entity.dart';

class BookModel {
  final int? id;
  final String name;
  final String author;
  final int year;
  final String description;
  final String imagePath;

  BookModel({
    this.id,
    required this.name,
    required this.author,
    required this.year,
    required this.description,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'author': author,
      'year': year,
      'description': description,
      'image': imagePath,
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      id: map['id'],
      name: map['name'],
      author: map['author'],
      year: map['year'],
      description: map['description'],
      imagePath: map['image'],
    );
  }

  BookEntity toEntity() {
    return BookEntity(
      id: id,
      name: name,
      author: author,
      year: year,
      description: description,
      imagePath: imagePath,
    );
  }

  factory BookModel.fromEntity(BookEntity entity) {
    return BookModel(
      id: entity.id,
      name: entity.name,
      author: entity.author,
      year: entity.year,
      description: entity.description,
      imagePath: entity.imagePath ?? '',
    );
  }
}