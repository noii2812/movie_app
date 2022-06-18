import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/screens/home_screen.dart';

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

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
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
          const Center(
            child: Icon(
              Icons.play_circle_filled,
              size: 70,
              color: Colors.white60,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.55,
              ),
              Text(
                widget.movie.title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                  Text("Action", style: TextStyle(color: Colors.grey)),
                  Text(" | ", style: TextStyle(color: Colors.grey)),
                  Text("2h 28m", style: TextStyle(color: Colors.grey)),
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
                  style: const TextStyle(color: Colors.grey),
                ),
              )
            ],
          ),
          Positioned(
            top: 20,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: CupertinoButton(
                padding: const EdgeInsets.all(10),
                color: Colors.white60,
                borderRadius: BorderRadius.circular(50),
                onPressed: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: TextButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.resolveWith((states) =>
                            const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 16)),
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.red)),
                    onPressed: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (_) => StatefulBuilder(
                              builder: ((context, setState) =>
                                  SelectSeatBottomSheet(size: size))));
                    },
                    child: const Text(
                      "Book Now",
                      style: TextStyle(color: Colors.white),
                    )),
              )),
        ],
      ),
    );
  }
}

class SelectSeatBottomSheet extends StatefulWidget {
  const SelectSeatBottomSheet({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<SelectSeatBottomSheet> createState() => _SelectSeatBottomSheetState();
}

class _SelectSeatBottomSheetState extends State<SelectSeatBottomSheet> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: widget.size.height * 0.75,
      child: CustomScaffold(
          body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Text("Screen")],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size.width * 0.25,
                height: 3,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      blurRadius: 50,
                      spreadRadius: 5,
                      color: Colors.white.withOpacity(0.8),
                      offset: Offset(0, 15))
                ]),
              ),
            ],
          ),
          Column(
            children: List.generate(8, (index) {
              List<String> rows = ["D", "E", "F", "G", "H", "I", "J", "K"];
              return Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  BuildSeatRow(
                    row: rows[index],
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
                    row: rows[index],
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
                              ? Color(0xffb30000)
                              : index == bookRandom
                                  ? Colors.amber[700]
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                            color: Colors.white60,
                          ),
                        ),
                        // child: FittedBox(child: Text("Q$index")),
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
                              ? Color(0xffb30000)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                            color: Colors.white60,
                          ),
                        ),
                        // child: FittedBox(child: Text("Q${index + 5}")),
                      );
                    }),
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
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
                        ? Color(0xffb30000)
                        : index == bookRandom
                            ? Colors.amber[700]
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(
                      color: Colors.white60,
                    ),
                  ),
                  // child: FittedBox(child: Text("$row$index")),
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
                          ? Color(0xffb30000)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(
                        color: Colors.white60,
                      ),
                    ),
                    // child: FittedBox(child: Text("$row${index + 5}")),
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
