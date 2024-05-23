import 'package:flutter/material.dart';
import 'package:smoke_free/consts/values.dart';
import 'package:smoke_free/screens/WelcomePage/models/UserData.dart';
import 'package:smoke_free/screens/WelcomePage/slides/InitialSetupPage.dart';
import 'package:smoke_free/screens/WelcomePage/slides/IntroPage.dart';
import 'package:smoke_free/screens/WelcomePage/slides/SummaryPage.dart';
import 'package:smoke_free/widgets/Indicator.dart';

void main() {
  runApp(SmokeFreeApp());
}

class SmokeFreeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmokeFree',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int _currentPage = 0;
  PageController _pageController = PageController(initialPage: 0);
  final UserData _userData = UserData();

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      buildIntroPage(_pageController),
      buildInitialSetupPage(setState, _userData, _pageController),
      buildSummaryPage(context, _userData, _pageController),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: AnimatedOpacity(
          opacity: _currentPage == 0 ? 0 : 1,
          duration: ANIMATION_DURATION_MEDIUM,
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (_currentPage > 0) {
                _pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
        ),
        title: AnimatedOpacity(
            opacity: _currentPage == 0 ? 0 : 1,
            duration: ANIMATION_DURATION_MEDIUM,
            child: Text('SmokeFree')),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
                child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: pages,
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => Indicator(isActive: index == _currentPage),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
