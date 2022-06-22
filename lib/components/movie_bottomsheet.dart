import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/screens/movie_details_screen.dart';
import 'package:movie_app/screens/ticket_screen.dart';

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

  List<DateTime> showDates = [];
  DateTime selectedDate = DateTime.now();

  List<Map<String, dynamic>> shows = [];

  @override
  void initState() {
    for (int i = 0; i < 5; i++) {
      showDates.add(DateTime.now().add(Duration(days: i)));
    }

    super.initState();
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
                buildMovieDetailsAppBar(context),
                const SizedBox(height: 20),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: showDates.length,
                      itemBuilder: (_, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedDate = showDates[index];
                            });
                          },
                          child: Stack(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                width: 90,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: selectedDate == showDates[index]
                                        ? const Color(0xffb30000)
                                        : Colors.white10),
                                child: Center(
                                    child: Text(
                                  isToday(DateTime.now()
                                          .add(Duration(days: index)))
                                      ? "Today"
                                      : DateFormat("EE \ndd").format(
                                          DateTime.now()
                                              .add(Duration(days: index))),
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
                          ),
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
                  height: 20,
                ),
                InteractiveViewer(
                  // scaleEnabled: false,
                  panEnabled: true, // Set it to false to prevent panning.
                  boundaryMargin: const EdgeInsets.all(0),
                  minScale: 1,
                  maxScale: 4,
                  child: Column(
                    children: [
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
                          List<String> rows = [
                            "D",
                            "E",
                            "F",
                            "G",
                            "H",
                            "I",
                            "J",
                            "K"
                          ]..reversed;
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
                      BuildSeatRow(
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
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 2),
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
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 2),
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
                )
              ],
            ),
          ],
        ));
  }

  Row buildMovieDetailsAppBar(BuildContext context) {
    return Row(
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
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => TicketScreen(movie: widget.movie))),
                child: const Icon(Icons.check),
              ),
            )),
      ],
    );
  }
}
