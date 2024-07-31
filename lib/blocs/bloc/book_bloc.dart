import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_application/data/models/book_model.dart';
import 'package:flutter_application/data/repositories/book_repository.dart';
import 'package:flutter_application/services/permission_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

part 'book_events.dart';
part 'book_states.dart';

class BookBloc extends Bloc<BookEvents, BookStates> {
  BookBloc({required this.bookRepository}) : super(BookStates()) {
    on<GetBooks>(_onGetFiles);
    on<DownloadFile>(_onDownload);
    on<OpenFile>(_onOpen);
    on<SearchBookEvent>(_onSearch);
    // on<UploadFile>(_onUpload);
  }

  final BookRepository bookRepository;

  void _onGetFiles(GetBooks event, Emitter<BookStates> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      for (var book in bookRepository.books) {
        final fullPath = await _getSavePath(book);
        if (_checkFileExists(fullPath)) {
          book = book
            ..savePath = fullPath
            ..isDownloaded = true;
        }

        emit(
          state.copyWith(
            files: bookRepository.books,
            isLoading: false,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  void _onDownload(DownloadFile event, Emitter<BookStates> emit) async {
    final file = event.book;

    file.isLoading = true;
    emit(state.copyWith(file: file));

    final dio = Dio();

    if (await PermissionService.requestStoragePermission()) {
      try {
        final fullPath = await _getSavePath(file);
        if (_checkFileExists(fullPath)) {
          add(OpenFile(path: fullPath));
          emit(
            state.copyWith(
              file: file
                ..savePath = fullPath
                ..isDownloaded = true
                ..isLoading = false,
            ),
          );
        } else {
          final response = await dio.download(file.bookUrl, fullPath,
              onReceiveProgress: (count, total) {
            emit(state.copyWith(
              file: state.file!..progress = count / total,
            ));
          });

          emit(
            state.copyWith(
              file: state.file!
                ..savePath = fullPath
                ..isLoading = false
                ..isDownloaded = true,
            ),
          );
        }
      } on DioException catch (e) {
        emit(
          state.copyWith(
              file: state.file!..isLoading = false,
              errorMessage: e.response?.data),
        );
      } catch (e) {
        emit(state.copyWith(
            errorMessage: e.toString(), file: state.file!..isLoading = false));
      }
    }
  }

  void _onSearch(SearchBookEvent event, Emitter<BookStates> emit) {
    try {
      emit(state.copyWith(
          files: bookRepository.books
              .where(
                (element) => element.title
                    .toLowerCase()
                    .contains(event.query.toLowerCase()),
              )
              .toList()));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void _onOpen(OpenFile event, Emitter<BookStates> emit) async {
    await OpenFilex.open(event.path);
  }

  Future<String> _getSavePath(BookModel file) async {
    final savePath = await getApplicationDocumentsDirectory();
    final fileExtension = file.bookUrl.split('.').last;
    final fileName = "${file.title}.$fileExtension";
    final fullPath = "${savePath.path}/$fileName";

    return fullPath;
  }

  bool _checkFileExists(String bookPath) {
    final file = File(bookPath);
    return file.existsSync();
  }
}
