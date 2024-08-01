import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/blocs/bloc/book_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Junction'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.bell),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  prefixIcon: const Icon(CupertinoIcons.search),
                  labelText: 'Search for books',
                ),
                onChanged: (value) {
                  context.read<BookBloc>().add(SearchBookEvent(query: value));
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: BlocBuilder<BookBloc, BookStates>(
              bloc: context.read<BookBloc>()..add(GetBooks()),
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state.errorMessage != null) {
                  return Center(
                    child: Text(state.errorMessage.toString()),
                  );
                }
                if (state.files == null || state.files!.isEmpty) {
                  return const Center(
                    child: Text("No files available"),
                  );
                }

                final books = state.files;

                return GridView.builder(
                  itemCount: books!.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    final file = books[index];
                    return GestureDetector(
                      onTap: () {
                        context.read<BookBloc>().add(DownloadFile(book: file));
                      },
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEFEFE),
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.network(
                                file.coverageUrl,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) =>
                                        const Center(
                                  child: Icon(Icons.error),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                color: Colors.black54,
                                child: Column(
                                  children: [
                                    Text(
                                      file.title,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    LinearProgressIndicator(
                                      backgroundColor: Colors.white,
                                      color: file.progress != 0
                                          ? Colors.blue
                                          : Colors.white,
                                      value: file.progress != 0
                                          ? file.progress.toDouble()
                                          : 1,
                                    ),
                                    file.isLoading
                                        ? const SizedBox(
                                            height: 40,
                                            child:
                                                CircularProgressIndicator(),
                                          )
                                        : IconButton(
                                            onPressed: () {
                                              if (file.isDownloaded) {
                                                context.read<BookBloc>().add(
                                                    OpenFile(
                                                        path: file.savePath));
                                              } else {
                                                context.read<BookBloc>().add(
                                                    DownloadFile(book: file));
                                              }
                                            },
                                            icon: Icon(
                                              file.isDownloaded
                                                  ? Icons.check
                                                  : Icons.download,
                                              color: Colors.blue,
                                              size: 40,
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
