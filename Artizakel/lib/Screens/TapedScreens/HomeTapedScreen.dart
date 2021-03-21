import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeTapedScreen extends StatefulWidget {
  @override
  _HomeTapedScreenState createState() => _HomeTapedScreenState();
}

class _HomeTapedScreenState extends State<HomeTapedScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        topSliderImages(),
        Text("THIS IS PRODUCT ARIA "),
      ],
    );
  }

  Widget topSliderImages() {
    List topAd = [3];
    return Container(
      width: double.infinity,
      child: CarouselSlider(
        options: CarouselOptions(
          height: 200.0,
          autoPlay: true,
        ),
        items: topAd.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 100,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: FittedBox(
                    child: Image(
                  image: NetworkImage(
                      "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80"),
                  fit: BoxFit.cover,
                )),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
