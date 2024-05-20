// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

//models
import '../models/topic.dart';

class TopicCard extends StatelessWidget {
  final height;
  final width;
  final Topic topic;

  const TopicCard({super.key, this.height, this.width, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(topic.routeName, arguments: topic.id);
        },
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: Hero(
                tag: topic.bgHeroTagName,
                child: Container(
                  width: width,
                  height: height,
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: width,
                height: height,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Hero(
                        tag: topic.imageHeroTagName,
                        child: Image.asset(
                          topic.imageSrc,
                          width: height * 0.75,
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            topic.topicName,
                            style: const TextStyle(
                                fontSize: 28, color: Colors.white),
                          ),
                          Text(
                            topic.subTopic,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
