import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class MovieDetailScreen extends StatefulWidget {
  final String imageUrl;
  final String tag;
  const MovieDetailScreen({Key? key, required this.imageUrl, required this.tag})
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
                        image: NetworkImage(widget.imageUrl))),
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
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: ClipRRect(
          //     // borderRadius: BorderRadius.circular(50
          //     //     // topRight: Radius.circular(15),
          //     //     // topLeft: Radius.circular(15),
          //     //     ),
          //     child: BackdropFilter(
          //       filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          //       child: Container(
          //         height: 220,
          //         padding: const EdgeInsets.only(
          //             top: 10), //use margin instead of padding,
          //         // clipBehavior: Clip.antiAlias,
          //         decoration: BoxDecoration(
          //             // gradient: LinearGradient(
          //             //     begin: Alignment.bottomCenter,
          //             //     end: Alignment.topCenter,
          //             //     colors: [
          //             //       Colors.black.withOpacity(.8),
          //             //       Colors.black.withOpacity(.1),
          //             //       Colors.white.withOpacity(.0),
          //             //       Colors.white.withOpacity(.0),
          //             //     ]),
          //             // color: Colors.black.withOpacity(.2),
          //             borderRadius: BorderRadius.circular(0)),
          //       ),
          //     ),
          //   ),
          //s ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.55,
              ),
              const Text(
                "Spider-Man No Way Home",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
              const Padding(
                padding: EdgeInsets.all(28.0),
                child: Text(
                  '''
With Spider-Man's identity now revealed, Peter asks Doctor Strange for help. When a spell goes wrong, dangerous foes from other worlds start to appear, forcing Peter to discover what it truly means to be Spider-Man.''',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
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
                            EdgeInsets.symmetric(horizontal: 30, vertical: 16)),
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.red)),
                    onPressed: () {},
                    child: Text(
                      "Book Now",
                      style: TextStyle(color: Colors.white),
                    )),
              )),
        ],
      ),
    );
  }
}
