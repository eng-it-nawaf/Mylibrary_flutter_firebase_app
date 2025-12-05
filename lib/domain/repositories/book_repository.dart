import '../entities/book_entity.dart';

abstract class BookRepository {
  Future<List<BookEntity>> getBooks();
  Future<int> addBook(BookEntity book);
  Future<void> deleteBook(int id);
}