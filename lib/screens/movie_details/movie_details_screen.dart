import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:movie_app/models/movie.dart';

class MovieDetailScreen extends StatefulWidget {
  final String imageUrl;
  final String tag;
  final Movie movie;
  const MovieDetailScreen(
      {Key? key,
      required this.imageUrl,
      required this.tag,
      required this.movie})
      : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    animationController = BottomSheet.createAnimationController(this);
    animationController.duration = const Duration(milliseconds: 300);
    animationController.reverseDuration = const Duration(milliseconds: 300);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        controller: scrollController,
        slivers: [
          SliverAppBar(
            // backgroundColor: Colors.transparent,
            leading: Padding(
              padding: const EdgeInsets.all(12.0),
              child: CupertinoButton(
                padding: const EdgeInsets.all(0),
                color: Colors.white60,
                borderRadius: BorderRadius.circular(50),
                onPressed: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
            expandedHeight: size.height,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: GestureDetector(
                onTap: () {
                  scrollController.animateTo(0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                },
                child: Stack(
                  alignment: FractionalOffset.center,
                  children: [
                    Hero(
                      tag: widget.tag,
                      child: Material(
                        type: MaterialType.transparency,
                        child: Container(
                          height: size.height,
                          width: size.width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(widget.movie.imageUrl))),
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                  Colors.black.withOpacity(1),
                                  Colors.black.withOpacity(0.8),
                                  Colors.black.withOpacity(0.3),
                                  Colors.black.withOpacity(0.0),
                                ])),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: const Icon(
                              Icons.play_arrow_rounded,
                              size: 28,
                            )),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height * 0.56 + 10),
                        Text(
                          widget.movie.title,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "2021",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(" | ", style: TextStyle(color: Colors.grey)),
                            Text("Action",
                                style: TextStyle(color: Colors.grey)),
                            Text(" | ", style: TextStyle(color: Colors.grey)),
                            Text("2h 28m",
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: Text(
                            widget.movie.description,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 7,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                    Positioned(
                        bottom: size.height * 0.05,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: TextButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.resolveWith(
                                      (states) => const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 16)),
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) => Colors.red)),
                              onPressed: () {
                                // scrollController.animateTo(size.height * 0.9,
                                //     duration: const Duration(milliseconds: 500),
                                //     curve: Curves.easeInOut);
                                showModalBottomSheet(
                                    enableDrag: false,
                                    isDismissible: false,
                                    transitionAnimationController:
                                        animationController,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (_) => SelectSeatBottomSheet(
                                          size: size,
                                          movie: widget.movie,
                                        ));
                              },
                              child: const Text(
                                "Book Now",
                                style: TextStyle(color: Colors.white),
                              )),
                        )),
                  ],
                ),
              ),
            ),
          ),
          // SliverToBoxAdapter(
          //   child: SelectSeatBottomSheet(
          //     size: size,
          //   ),
          // )
        ],
      ),
    );
  }
}

class SelectSeatBottomSheet extends StatefulWidget {
  final Movie movie;
  const SelectSeatBottomSheet({
    Key? key,
    required this.size,
    required this.movie,
  }) : super(key: key);

  final Size size;

  @override
  State<SelectSeatBottomSheet> createState() => _SelectSeatBottomSheetState();
}

class _SelectSeatBottomSheetState extends State<SelectSeatBottomSheet> {
  bool isToday(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date).inDays;
    return diff == 0 && now.day == date.day;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        height: size.height,
        child: Stack(
          alignment: FractionalOffset.center,
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.black.withOpacity(.2),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CupertinoButton(
                          color: Colors.white10,
                          padding: const EdgeInsets.all(10),
                          borderRadius: BorderRadius.circular(50),
                          onPressed: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.movie.title,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        )),
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CupertinoButton(
                            color: Colors.white10,
                            padding: const EdgeInsets.all(10),
                            borderRadius: BorderRadius.circular(50),
                            onPressed: () => Navigator.pop(context),
                            child: const Icon(Icons.check),
                          ),
                        )),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (_, index) {
                        return Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              width: 90,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: index == 0
                                      ? const Color(0xffb30000)
                                      : Colors.white10),
                              child: Center(
                                  child: Text(
                                isToday(DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day + index))
                                    ? "Today"
                                    : DateFormat("EE \ndd").format(DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day + index)),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                            Positioned(
                              top: 5,
                              left: 0,
                              right: 0,
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white70),
                              ),
                            )
                          ],
                        );
                      }),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 35,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (_, index) {
                        List<String> showHours = [
                          "9:30 Am",
                          "11:30 Am",
                          "2:00 Pm",
                          "4:30 Pm",
                          "7:00 Pm"
                        ];
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: index == 0
                                  ? Colors.amber[700]
                                  : Colors.white10),
                          child: Center(
                              child: Text(showHours[index],
                                  style: const TextStyle(color: Colors.white))),
                        );
                      }),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [Text("Screen")],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: size.width * 0.5,
                      height: 5.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                            top: Radius.elliptical(size.width, 100.0)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Column(
                  children: List.generate(8, (index) {
                    List<String> rows = ["D", "E", "F", "G", "H", "I", "J", "K"]
                      ..reversed;
                    return Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        BuildSeatRow(
                          row: rows.reversed.toList()[index],
                          leftSideSeats: 10,
                          rightSideSeats: 10,
                          seatWidth: 15,
                          seatHeight: 15,
                        )
                      ],
                    );
                  }),
                ),
                Column(
                  children: List.generate(2, (index) {
                    List<String> rows = ["B", "C"];
                    return Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        BuildSeatRow(
                          row: rows.reversed.toList()[index],
                          leftSideSeats: 4,
                          rightSideSeats: 4,
                          seatWidth: 40,
                          seatHeight: 20,
                        )
                      ],
                    );
                  }),
                ),
                const SizedBox(
                  height: 10,
                ),
                const BuildSeatRow(
                  row: "A",
                  leftSideSeats: 5,
                  rightSideSeats: 5,
                  seatWidth: 32,
                  seatHeight: 20,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: size.width * 0.95,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width * .4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(4, (index) {
                            int random = Random().nextInt(5);
                            int bookRandom = Random().nextInt(10);
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              height: size.height * 0.04,
                              width: size.width * 0.35 * 1 / 4,
                              decoration: BoxDecoration(
                                color: index == random
                                    ? const Color(0xffb30000)
                                    : index == bookRandom
                                        ? Colors.amber[700]
                                        : Colors.transparent,
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(
                                  color: Colors.white60,
                                ),
                              ),
                              child: FittedBox(
                                  fit: BoxFit.none,
                                  child: Text(
                                    "Q$index",
                                    style: const TextStyle(fontSize: 12),
                                  )),
                            );
                          }),
                        ),
                      ),
                      Container(
                        width: size.width * 0.1,
                        height: size.height * 0.1,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white60,
                          ),
                        ),
                        child: const Center(child: Text("King")),
                      ),
                      SizedBox(
                        width: size.width * .4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: List.generate(4, (index) {
                            int random = Random().nextInt(10);
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              height: size.height * 0.04,
                              width: size.width * 0.35 * 1 / 4,
                              decoration: BoxDecoration(
                                color: index == random
                                    ? const Color(0xffb30000)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(
                                  color: Colors.white60,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Q${index + 5}",
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ));
  }
}

class BuildSeatRow extends StatelessWidget {
  final int leftSideSeats;
  final int rightSideSeats;
  final double seatWidth;
  final double seatHeight;
  final String row;

  const BuildSeatRow({
    Key? key,
    required this.leftSideSeats,
    required this.rightSideSeats,
    required this.seatWidth,
    required this.seatHeight,
    required this.row,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double fullWidth = size.width * 0.95;

    return SizedBox(
      width: fullWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: fullWidth * .5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(leftSideSeats, (index) {
                int random = Random().nextInt(5);
                int bookRandom = Random().nextInt(10);
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  height: (fullWidth / 2) * 0.1,
                  width: (fullWidth / 2) * 0.86 / rightSideSeats,
                  decoration: BoxDecoration(
                    color: index == random
                        ? const Color(0xffb30000)
                        : index == bookRandom
                            ? Colors.amber[700]
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(
                      color: Colors.white60,
                    ),
                  ),
                  child: size.width < 600
                      ? const Text("")
                      : Text(
                          "$row$index",
                          style: const TextStyle(fontSize: 12),
                        ),
                );
              }),
            ),
          ),
          SizedBox(
            width: fullWidth * .5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: List.generate(rightSideSeats, (index) {
                int random = Random().nextInt(10);
                return Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    height: (fullWidth / 2) * 0.1,
                    width: (fullWidth / 2) * 0.86 / rightSideSeats,
                    decoration: BoxDecoration(
                      color: index == random
                          ? const Color(0xffb30000)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(
                        color: Colors.white60,
                      ),
                    ),
                    child: size.width < 600
                        ? const Text("")
                        : Text(
                            "$row${index + 5}",
                            style: const TextStyle(fontSize: 12),
                          ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    int curveHeight = 40;
    Offset controlPoint = Offset(size.width / 2, size.height - curveHeight);
    Offset endPoint = Offset(size.width, size.height - curveHeight);

    Path path = Path()
      ..lineTo(-size.height, size.height + curveHeight)
      ..quadraticBezierTo(
          endPoint.dx, endPoint.dy, controlPoint.dx, controlPoint.dy)
      ..lineTo(size.width, size.height - curveHeight)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
