import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:movie_app/components/movie_bottomsheet.dart';
import 'package:movie_app/models/movie.dart';
import 'package:rxdart/rxdart.dart';

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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        color: Colors.white.withOpacity(.1),
                        width: 60,
                        height: 60,
                        child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
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

class BuildSeatRow extends StatelessWidget {
  final int leftSideSeats;
  final int rightSideSeats;
  final double seatWidth;
  final double seatHeight;
  final String row;

  BuildSeatRow({
    Key? key,
    required this.leftSideSeats,
    required this.rightSideSeats,
    required this.seatWidth,
    required this.seatHeight,
    required this.row,
  }) : super(key: key);

  BehaviorSubject<List<int>> subjectSelectedLeftSeats =
      BehaviorSubject<List<int>>()..value = [];
  BehaviorSubject<List<int>> subjectSelectedRightSeats =
      BehaviorSubject<List<int>>()..value = [];
  List<int> selectedLeftRow = <int>[];
  List<int> selectedRightRow = <int>[];

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
                // int random = Random().nextInt(5);
                int bookRandom = Random().nextInt(10);
                return InkWell(
                  onTap: () {
                    if (selectedLeftRow.contains(index)) {
                      selectedLeftRow.remove(index);
                      subjectSelectedLeftSeats.add(selectedLeftRow);
                    } else {
                      selectedLeftRow.add(index);
                      subjectSelectedLeftSeats.add(selectedLeftRow);
                      // print(subjectSelectedLeftSeats.value.contains(index));
                    }
                  },
                  child: StreamBuilder(
                      stream: subjectSelectedLeftSeats,
                      builder: (context, snapshot) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          height: (fullWidth / 2) * 0.1,
                          width: (fullWidth / 2) * 0.86 / rightSideSeats,
                          decoration: BoxDecoration(
                            color:
                                subjectSelectedLeftSeats.value.contains(index)
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
                );
              }),
            ),
          ),
          SizedBox(
            width: fullWidth * .5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: List.generate(rightSideSeats, (index) {
                // int random = Random().nextInt(10);
                return Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: InkWell(
                    onTap: () {
                      if (selectedRightRow.contains(index)) {
                        selectedRightRow.remove(index);
                        subjectSelectedRightSeats.add(selectedRightRow);
                      } else {
                        selectedRightRow.add(index);
                        subjectSelectedRightSeats.add(selectedRightRow);
                      }
                    },
                    child: StreamBuilder(
                        initialData: const [],
                        stream: subjectSelectedRightSeats,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) return Container();
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 1),
                            height: (fullWidth / 2) * 0.1,
                            width: (fullWidth / 2) * 0.86 / rightSideSeats,
                            decoration: BoxDecoration(
                              color: snapshot.data.contains(index)
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
                          );
                        }),
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
