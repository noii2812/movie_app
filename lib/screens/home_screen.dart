import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/resources/movies.dart';
import 'package:movie_app/screens/movie_details/movie_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> movies = [];

  @override
  void initState() {
    movies = List.from(moviesData.map((e) => Movie.fromJson(e)));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 30, 7, 7),
        title: const Text('Home'),
        actions: const [
          Padding(
              padding: EdgeInsets.only(right: 12),
              child: CircleAvatar(
                backgroundColor: Colors.grey,
              ))
        ],
      ),
      body: CustomScaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Comming Soon",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        "",
                        style: TextStyle(color: Colors.white38),
                      ))
                ],
              ),
            ),
            SliverToBoxAdapter(
                child: SizedBox(
              width: size.width,
              height: size.height * 0.25,
              child: CarouselSlider.builder(
                  itemCount: 2,
                  itemBuilder: (_, index, pageIndex) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        width: size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                                alignment: Alignment.topCenter,
                                fit: BoxFit.cover,
                                image: NetworkImage(index == 0
                                    ? "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/846a9086-8a40-43e0-aa10-2fc7d6d73730/df616wu-64712e5f-0557-4f7d-8f2b-45541af960ae.png/v1/fill/w_1280,h_720,q_80,strp/thor_love_and_thunder__2022__textless__4_wallpaper_by_mintmovi3_df616wu-fullview.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9NzIwIiwicGF0aCI6IlwvZlwvODQ2YTkwODYtOGE0MC00M2UwLWFhMTAtMmZjN2Q2ZDczNzMwXC9kZjYxNnd1LTY0NzEyZTVmLTA1NTctNGY3ZC04ZjJiLTQ1NTQxYWY5NjBhZS5wbmciLCJ3aWR0aCI6Ijw9MTI4MCJ9XV0sImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl19.wDiliDuwOxxebY5jHVJXFCxmOZUpSZP-J_ZsPCoKlms"
                                    : "https://martinliebermandotcom.files.wordpress.com/2021/12/no-way-home-banner.jpeg"))),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    viewportFraction: 1,
                    // clipBehavior: Clip.antiAliasWithSaveLayer,
                    enlargeCenterPage: true,
                    aspectRatio: 2.5,
                    autoPlay: true,
                  )),
            )),
            const SliverToBoxAdapter(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Today Schedule",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            )),
            SliverToBoxAdapter(
              child: SizedBox(
                  height: size.height * 0.24,
                  child: ListView.builder(
                    itemCount: movies.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      Movie movie = movies[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => MovieDetailScreen(
                                        movie: movie,
                                        imageUrl: '',
                                        tag: '',
                                      ))),
                          child: Stack(
                            children: [
                              SizedBox(
                                width: size.width * 0.35,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: size.height * 0.15,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: const Color(0xff363636),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  movie.imageUrl))),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      movie.title,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: const [
                                        Icon(Icons.access_time,
                                            size: 16, color: Colors.white38),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        // Text(
                                        //   "9:30 Am",
                                        //   style: TextStyle(color: Colors.white38),
                                        // ),
                                        Text("2h 28min",
                                            style: TextStyle(
                                                color: Colors.white38))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                  top: 5,
                                  right: 5,
                                  child: Container(
                                      height: 25,
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: const Color(0xffb30000)
                                              .withOpacity(.7),
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child:
                                          const Center(child: Text("9:30 Am"))))
                            ],
                          ),
                        ),
                      );
                    },
                  )),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Now Showing",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        "See All",
                        style: TextStyle(color: Colors.white38),
                      ))
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                  height: size.height * .3,
                  child: ListView.builder(
                    itemCount: movies.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: size.width * 0.3,
                          child: Hero(
                            tag: "movie$index",
                            child: Material(
                              type: MaterialType.transparency,
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => MovieDetailScreen(
                                              movie: movies[index],
                                              imageUrl: movies[index].imageUrl,
                                              tag: "movie$index",
                                            ))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: const Color(0xff363636),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  movies[index].imageUrl))),
                                      height: size.height * 0.2,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          movies[index].title,
                                          maxLines: 1,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.access_time,
                                            size: 16, color: Colors.white38),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("2h 28min",
                                            style: TextStyle(
                                                color: Colors.white38)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomScaffold extends StatefulWidget {
  final Widget body;
  const CustomScaffold({Key? key, required this.body}) : super(key: key);

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Color.fromARGB(255, 30, 7, 7),
                  Color(0xff000000),
                ])),
          ),
          widget.body
        ],
      ),
    );
  }
}
