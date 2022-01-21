//..lib/main.dart

import 'package:flutter/material.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Onboarding Screen Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({required this.title});
  @override
  MyHomePageState createState() {
    return new MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  int _slideIndex = 0;

  final List<String> images = [
    "assets/slide_1.png",
    "assets/slide_2.png",
    "assets/slide_3.png",
    "assets/slide_4.png"
  ];

  final List<String> text0 = [
    "Welcome to our app",
    "Enjoy texting...",
    "Showcase your Writing skills",
    "Friendship is great"
  ];

  final List<String> text1 = [
    "App for sending messages to friends and lovers",
    "Find best deals in your area, simply",
    "Have fun while texting your relatives and more",
    "Meet new friends from all over the world"
  ];

  final IndexController controller = IndexController();

  @override
  Widget build(BuildContext context) {

    TransformerPageView transformerPageView = TransformerPageView(
        pageSnapping: true,
        onPageChanged: (index) {
          setState(() {
            this._slideIndex = index;
          });
        },
        loop: false,
        controller: controller,
        transformer: new PageTransformerBuilder(
            builder: (Widget child, TransformInfo info) {
              return new Material(
                color: Colors.white,
                elevation: 8.0,
                textStyle: new TextStyle(color: Colors.white),
                borderRadius: new BorderRadius.circular(12.0),
                child: new Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new ParallaxContainer(
                          child: new Text(
                            text0[info.index],
                            style: new TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 34.0,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.bold),
                          ),
                          position: info.position,
                          opacityFactor: .8,
                          translationFactor: 400.0,
                        ),
                        SizedBox(
                          height: 45.0,
                        ),
                        new ParallaxContainer(
                          child: new Image.asset(
                            images[info.index],
                            fit: BoxFit.contain,
                            height: 350,
                          ),
                          position: info.position,
                          translationFactor: 400.0,
                        ),
                        SizedBox(
                          height: 45.0,
                        ),
                        new ParallaxContainer(
                          child: new Text(
                            text1[info.index],
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 28.0,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.bold),
                          ),
                          position: info.position,
                          translationFactor: 300.0,
                        ),
                        SizedBox(
                          height: 55.0,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
        itemCount: 4);

    return Scaffold(
      backgroundColor: Colors.white,
      body: transformerPageView,
    );

  }
}

class Dots extends StatelessWidget {
  final IndexController controller;
  final int slideIndex;
  final int numberOfDots;

  Dots({required this.controller, required this.slideIndex, required this.numberOfDots});

  Widget _activeSlide(int index) {
    return GestureDetector(
      onTap: () {
        print('Tapped');
        // controller.move(index);
      },
      child: new Container(
        child: Padding(
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          child: Container(
            width: 20.0,
            height: 20.0,
            decoration: BoxDecoration(
              color: Colors.orangeAccent.withOpacity(.3),
              borderRadius: BorderRadius.circular(50.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget _inactiveSlide(int index) {
    return GestureDetector(
      onTap: () {
        controller.move(index);
      },
      child: new Container(
        child: Padding(
          padding: EdgeInsets.only(left: 5.0, right: 5.0),
          child: Container(
            width: 14.0,
            height: 14.0,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.7),
                borderRadius: BorderRadius.circular(50.0)),
          ),
        ),
      ),
    );
  }

  List<Widget> _generateDots() {
    List<Widget> dots = [];
    for (int i = 0; i < numberOfDots; i++) {
      dots.add(i == slideIndex ? _activeSlide(i) : _inactiveSlide(i));
    }
    return dots;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _generateDots(),
        ));
  }
}