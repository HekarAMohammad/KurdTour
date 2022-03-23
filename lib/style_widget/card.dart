import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Widget generalcard(
    {String? image, String? titledoc, String? discription, double? ratingnew}) {
  return Container(
    margin: const EdgeInsets.only(top: 10, bottom: 5),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.yellow),
        borderRadius: BorderRadius.circular(12),
        color: Color.fromARGB(255, 248, 248, 247)),
    width: 320,
    height: 145,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 200,
          height: 140,
          padding: const EdgeInsets.only(left: 7, right: 7, bottom: 5, top: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              image!,
              fit: BoxFit.fill,
              width: 200,
            ),
          ),
        ),
        SizedBox(
          width: 150,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 7, bottom: 7),
                child: Text(
                  titledoc!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.amber,
                    decorationStyle: TextDecorationStyle.wavy,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 5, left: 5),
                height: 67,
                margin: const EdgeInsets.only(bottom: 7),
                child: Text(
                  discription ?? 'description',
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.justify,
                ),
              ),
              RatingBarIndicator(
                rating: ratingnew ?? 3.5,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 26,
                direction: Axis.horizontal,
              ),
            ],
          ),
        )
      ],
    ),
  );
}
