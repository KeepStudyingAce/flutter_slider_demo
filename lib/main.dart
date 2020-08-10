import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_controller.dart';

final List<String> images = [
  'lib/asserts/banner1.png',
  'lib/asserts/banner2.png',
  'lib/asserts/banner3.png',
];
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Slider Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                color: Colors.lightBlue,
                width: screenWidth,
                height: 200,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return (Image.asset(
                      images[index],
                      fit: BoxFit.fill,
                    ));
                  },
                  itemCount: 3,
                  duration: 300,
                  viewportFraction:
                      (screenWidth - 60) / screenWidth, //当前item显示大小
                  scale: (screenWidth - 60) / screenWidth, //两侧Item缩放大小
                  scrollDirection: Axis.horizontal,
                  pagination: new SwiperPagination(
                      margin: EdgeInsets.only(bottom: 25),
                      builder: DotSwiperPaginationBuilder(
                        size: 6,
                        activeSize: 6,
                        color: Colors.grey,
                        activeColor: Colors.white,
                      )),
                  autoplay: true,
                )),
            Container(
              color: Colors.redAccent,
              width: screenWidth - 60,
              height: 36,
            ),
            Container(
              color: Colors.lightBlue,
              width: screenWidth,
              height: 200,
              child: CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 1,
                    aspectRatio: screenWidth / 200,
                    enableInfiniteScroll: false,
                  ),
                  items: images
                      .map((e) => Image.asset(
                            e,
                            fit: BoxFit.contain,
                            // width: screenWidth,
                            // height: 200,
                          ))
                      .toList()),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
