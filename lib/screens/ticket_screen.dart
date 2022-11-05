import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/models/movie.dart';

class TicketScreen extends StatefulWidget {
  final Movie movie;
  const TicketScreen({Key? key, required this.movie}) : super(key: key);

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      // backgroundColor: Colors.white,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipPath(
            clipper: TicketClipper(),
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              width: size.width * 0.8,
              height: size.height * 0.8,
              padding: const EdgeInsets.all(1),
              margin: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                        image: NetworkImage(widget.movie.imageUrl),
                        fit: BoxFit.cover)),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: size.height * 0.2,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.white,
                                  Colors.white.withOpacity(1),
                                ])),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 18),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ticketDetails(
                                    const Icon(Icons.access_time),
                                    "Price",
                                    "7.50 \$",
                                  ),
                                  ticketDetails(const Icon(Icons.access_time),
                                      "ROW", "D"),
                                  ticketDetails(const Icon(Icons.access_time),
                                      "Seats", "10-12"),
                                ],
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     ticketDetails(const Icon(Icons.access_time),
                              //         "${widget.movie.durations}", "Min"),
                              //     ticketDetails(const Icon(Icons.access_time),
                              //         "${widget.movie.durations}", "Min"),
                              //     ticketDetails(const Icon(Icons.access_time),
                              //         "${widget.movie.durations}", "Min"),
                              //   ],
                              // ),
                              // FittedBox(
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: List.generate(
                              //         20,
                              //         (index) => Container(
                              //               margin: const EdgeInsets.symmetric(
                              //                   horizontal: 2),
                              //               width: 10,
                              //               height: 1,
                              //               color: Colors.black54,
                              //             )),
                              //   ),
                              // ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ticketDetails(
                                    const Icon(Icons.access_time),
                                    "Date",
                                    DateFormat("MMM dd").format(DateTime.now()),
                                  ),
                                  ticketDetails(const Icon(Icons.access_time),
                                      "Time", "2:00 pm"),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    "https://firebasestorage.googleapis.com/v0/b/interview-cbf86.appspot.com/o/qrcode_23921758_.png?alt=media&token=e577fbd3-72cd-440a-a49e-dd1de5d8392a"))),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
                                        "Scan Here",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 9),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ticketDetails(icon, title, subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black26,
          ),
        ),
        Text(subtitle,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              // fontWeight: FontWeight.bold,
            )),
      ],
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    path.addOval(
        Rect.fromCircle(center: Offset(0.0, size.height * 0), radius: 8.0));
    path.addOval(Rect.fromCircle(
        center: Offset(size.width, size.height * 0), radius: 8.0));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
