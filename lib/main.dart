import 'package:flutter/material.dart';
import 'package:flutter_application/blocs/bloc/book_bloc.dart';
import 'package:flutter_application/data/repositories/book_repository.dart';
import 'package:flutter_application/ui/screens/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => BookRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (ctx) => BookBloc(
              bookRepository: RepositoryProvider.of<BookRepository>(ctx),
            ),
          ),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        ),
      ),
    );
  }
}
