// import 'package:onboarding_app/domain/repositories/book_repository.dart';
// import 'package:onboarding_app/data/models/book_model.dart';
//
// class AddBookUseCase {
//   final BookRepository repository;
//
//   AddBookUseCase(this.repository);
//
//   Future<void> execute(BookModel book) async {
//     await repository.addBook(book);
//   }
// }

import '../../entities/book_entity.dart';
import '../../repositories/book_repository.dart';

class AddBookUseCase {
  final BookRepository repository;

  AddBookUseCase(this.repository);

  Future<int> execute(BookEntity book) {
    return repository.addBook(book);
  }
}