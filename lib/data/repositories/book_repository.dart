import 'package:flutter_application/data/models/book_model.dart';

class BookRepository {
  List<BookModel> books = [
    BookModel(
      title: "Harry Potter 1",
      bookUrl:
          "https://docenti.unimc.it/antonella.pascali/teaching/2018/19055/files/ultima-lezione/harry-potter-and-the-philosophers-stone",
      coverageUrl:
          "https://musicart.xboxlive.com/7/92e05000-0000-0000-0000-000000000002/504/image.jpg?w=1920&h=1080",
      savePath: "",
      progress: 0,
      isLoading: false,
      isDownloaded: false,
    ),
    BookModel(
      title: "Harry Potter 2",
      bookUrl:
          "https://www.hasanboy.uz/wp-content/uploads/2018/04/Harry-Potter-and-the-Chamber-of-Secrets.pdf",
      coverageUrl:
          "https://avatars.mds.yandex.net/get-kinopoisk-image/4774061/1ef65bfb-b16b-42aa-a54a-758395253290/600x900",
      savePath: "",
      progress: 0,
      isLoading: false,
      isDownloaded: false,
    ),
    BookModel(
      title: "Harry Potter 3",
      bookUrl:
          "https://vidyaprabodhinicollege.edu.in/VPCCECM/ebooks/ENGLISH%20LITERATURE/Harry%20potter/(Book%203)%20Harry%20Potter%20And%20The%20Prisoner%20Of%20Azkaban_001.pdf",
      coverageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1w9Sug7kJoGENfm75E2KsC86LgtA9rwxTpg&s",
      savePath: "",
      progress: 0,
      isLoading: false,
      isDownloaded: false,
    ),

     BookModel(
      title: "Harry Potter 4",
      bookUrl:
          "https://ebookpresssite.wordpress.com/wp-content/uploads/2017/10/4_harry_potter_and_the_goblet_of_fire.pdf",
      coverageUrl:
          "https://upload.wikimedia.org/wikipedia/ru/4/45/Harry_Potter_and_the_Goblet_of_Fire_%E2%80%94_movie.jpg",
      savePath: "",
      progress: 0,
      isLoading: false,
      isDownloaded: false,
    ),

    BookModel(
      title: "Harry Potter 5",
      bookUrl:
          "https://www.hasanboy.uz/wp-content/uploads/2018/04/Harry-Potter-and-the-Order-of-Phoenix.pdf",
      coverageUrl:
          "https://upload.wikimedia.org/wikipedia/ru/6/60/Harry_Potter_and_the_Order_of_the_Phoenix_%E2%80%94_movie.jpg",
      savePath: "",
      progress: 0,
      isLoading: false,
      isDownloaded: false,
    ),
    
  ];
}
