// import 'package:onboarding_app/data/models/book_model.dart';
//
// abstract class BookRepository {
//   Future<List<BookModel>> getBooks();
//   Future<void> addBook(BookModel book);
// }

import '../entities/book_entity.dart';

abstract class BookRepository {
  Future<List<BookEntity>> getBooks();
  Future<int> addBook(BookEntity book);
  Future<void> deleteBook(int id);
}