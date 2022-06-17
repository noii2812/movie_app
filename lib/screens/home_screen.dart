import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/screens/movie_details/movie_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: const [
          Padding(
              padding: EdgeInsets.only(right: 12),
              child: CircleAvatar(
                backgroundColor: Colors.grey,
              ))
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: Container(
            width: size.width,
            child: CarouselSlider.builder(
                itemCount: 2,
                itemBuilder: (_, index, pageIndex) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "https://www.themoviedb.org/t/p/original/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg"))),
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
          // SliverToBoxAdapter(
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(horizontal: 12),
          //     height: 55,
          //     child: TextFormField(
          //       decoration: InputDecoration(
          //         prefixIcon: const Icon(Icons.search),
          //         enabledBorder: OutlineInputBorder(
          //             borderSide: const BorderSide(color: Colors.grey),
          //             borderRadius: BorderRadius.circular(50)),
          //         hintText: 'Search Movie',
          //       ),
          //     ),
          //   ),
          // ),
          // const SliverToBoxAdapter(child: SizedBox(height: 20)),
          // SliverToBoxAdapter(
          // child: SizedBox(
          //     height: 45,
          //     child: ListView.builder(
          //         itemCount: 5,
          //         scrollDirection: Axis.horizontal,
          //         itemBuilder: (_, index) {
          //           return Padding(
          //             padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //             child: Container(
          //               padding: const EdgeInsets.symmetric(horizontal: 4),
          //               decoration: BoxDecoration(
          //                   color: const Color(0xff363636),
          //                   borderRadius: BorderRadius.circular(8)),
          //               height: 50,
          //               child: Center(
          //                 child: Text(
          //                   'Genre $index',
          //                   style: const TextStyle(fontSize: 20),
          //                 ),
          //               ),
          //             ),
          //           );
          //         })),
          // ),
          // const SliverToBoxAdapter(child: SizedBox(height: 20)),
          // const SliverToBoxAdapter(
          //     child: Padding(
          //   padding: EdgeInsets.all(8.0),
          //   child: Text(
          //     "Upcoming",
          //     style: TextStyle(
          //         fontSize: 16,
          //         fontWeight: FontWeight.bold,
          //         color: Colors.white),
          //   ),
          // )),
          // SliverToBoxAdapter(
          //   child: SizedBox(
          //       height: 255,
          //       child: ListView.builder(
          //         itemCount: 5,
          //         scrollDirection: Axis.horizontal,
          //         itemBuilder: (_, index) {
          //           return Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: SizedBox(
          //               width: 150,
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Container(
          //                     height: 185,
          //                     decoration: BoxDecoration(
          //                         borderRadius: BorderRadius.circular(12),
          //                         color: const Color(0xff363636),
          //                         image: const DecorationImage(
          //                             fit: BoxFit.cover,
          //                             image: NetworkImage(
          //                                 "https://www.themoviedb.org/t/p/original/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg"))),
          //                   ),
          //                   const SizedBox(
          //                     height: 5,
          //                   ),
          //                   const Text(
          //                     "Spider-Man No Way Home",
          //                     style: TextStyle(
          //                         fontSize: 12,
          //                         color: Colors.white,
          //                         fontWeight: FontWeight.bold),
          //                   ),
          //                   const SizedBox(
          //                     height: 5,
          //                   ),
          //                   Row(
          //                     children: const [
          //                       Icon(Icons.access_time,
          //                           size: 16, color: Colors.white38),
          //                       SizedBox(
          //                         width: 5,
          //                       ),
          //                       Text("2h 28min",
          //                           style: TextStyle(color: Colors.white38)),
          //                     ],
          //                   )
          //                 ],
          //               ),
          //             ),
          //           );
          //         },
          //       )),
          // ),
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
                height: 300,
                child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Hero(
                        tag: "movie$index",
                        child: Material(
                          type: MaterialType.transparency,
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => MovieDetailScreen(
                                          imageUrl:
                                              "https://www.themoviedb.org/t/p/original/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg",
                                          tag: "movie$index",
                                        ))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: const Color(0xff363636),
                                      image: const DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              "https://www.themoviedb.org/t/p/original/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg"))),
                                  height: 220,
                                  width: 150,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Spider-Man No Way Home",
                                  style: TextStyle(
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
                                      width: 5,
                                    ),
                                    Text("2h 28min",
                                        style:
                                            TextStyle(color: Colors.white38)),
                                  ],
                                )
                              ],
                            ),
                          ),
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
                    "Today Schedule",
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
        ],
      ),
    );
  }
}
