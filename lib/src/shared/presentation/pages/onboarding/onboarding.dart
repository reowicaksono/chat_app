part of '../pages.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final AppPreferences _preferences = AppPreferences();
  final PageController _pageController = PageController();
  final List<Widget> pages = [
    OnboardingPage(
      title: 'Welcome to MyApp',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      imageUrl: 'assets/lottie/book.json',
    ),
    OnboardingPage(
      title: 'Explore Features',
      description: 'Discover amazing features that make MyApp unique.',
      imageUrl: 'assets/lottie/quiz.json',
    ),
    OnboardingPage(
      title: 'Get Started',
      description: 'Sign up now and start using MyApp today!',
      imageUrl: 'assets/lottie/welcome.json',
    ),
  ];

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return pages[index];
              },
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
            ),
          ),
          SizedBox(height: 16.0),
          if (currentPage < pages.length - 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentPage > 0)
                  ElevatedButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    child: Text('Back'),
                  ),
                ElevatedButton(
                  onPressed: () {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  },
                  child: Text('Next'),
                ),
              ],
            ),
          if (currentPage == pages.length - 1)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _preferences.setOnBoardingState(true);
                });
                Navigation.navigateToPageReplacement(Approute.LOGIN_ROUTE);
              },
              child: Text('Mulai'),
            ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            imageUrl,
            height: 200,
          ),
          SizedBox(height: 16.0),
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
