part of 'book_bloc.dart';



final class BookStates {
  List<BookModel>? files;
  BookModel? file;
  String? errorMessage;
  bool isLoading;

  BookStates({
    this.files,
    this.file,
    this.errorMessage,
    this.isLoading = false,
  });

  BookStates copyWith({
    List<BookModel>? files,
    BookModel? file,
    String? errorMessage,
    bool? isLoading,
  }) {
    return BookStates(
      files: files ?? this.files,
      file: file ?? this.file,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
