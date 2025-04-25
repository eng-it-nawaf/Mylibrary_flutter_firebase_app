// import 'package:onboarding_app/domain/repositories/book_repository.dart';
// import 'package:onboarding_app/data/models/book_model.dart';
//
// class GetBooksUseCase {
//   final BookRepository repository;
//
//   GetBooksUseCase(this.repository);
//
//   Future<List<BookModel>> execute() async {
//     return await repository.getBooks();
//   }
// }

import '../../entities/book_entity.dart';
import '../../repositories/book_repository.dart';

class GetBooksUseCase {
  final BookRepository repository;

  GetBooksUseCase(this.repository);

  Future<List<BookEntity>> execute() {
    return repository.getBooks();
  }
}