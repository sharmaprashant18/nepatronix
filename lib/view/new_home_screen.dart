import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nepatronix/view/digitalmarketing.dart';
import 'package:nepatronix/view/illustration_screen.dart';
import 'package:nepatronix/view/uiux.dart';
import 'package:nepatronix/view/web_development.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends ConsumerState<Homepage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    // Height categories
    final smallPhoneheight = screenHeight <= 640;

    // Width categories
    final smallPhoneWidth = screenWidth <= 360;

    // final isMediumDevice = screenWidth >= 1400 &&
    //     screenWidth < 1800 &&
    //     screenHeight >= 700 &&
    //     screenHeight <= 800;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffEDF4FE),
      body: Column(
        children: [
          Stack(children: [
            _buildHeader(smallPhoneheight, smallPhoneWidth),
            // Search bar overlay
            Positioned(
              // top: isSmallPhone ? height * 0.14 : height * 0.16,
              top: smallPhoneheight ? 150 : 210,
              left: screenWidth * 0.04,
              right: screenWidth * 0.04,
              child: _buildSearchBar(smallPhoneheight, screenWidth),
            ),
          ]),

          //  padding: EdgeInsets.symmetric(
          // horizontal: screenWidth * 0.04,
          // vertical:
          //     smallPhoneheight ? screenHeight * 0.01 : screenHeight * 0.03,

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical:
                  smallPhoneheight ? screenHeight * 0.01 : screenHeight * 0.03,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Course text
                Text(
                  'Course',
                  style: TextStyle(
                    fontSize: smallPhoneheight ? 22 : 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Options button
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_horiz,
                    size: smallPhoneheight ? 30 : 35,
                  ),
                  // padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
          // TabBar with aligned left padding to match "Course" text
          Padding(
            padding: EdgeInsets.only(
              left: screenWidth * 0.04, // Same as "Course" text padding
            ),
            child: Container(
              clipBehavior: Clip.antiAlias,
              // height: smallPhoneheight ? 50 : 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              alignment: Alignment.centerLeft,

              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
                unselectedLabelColor: Colors.black,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color(0xff10B868),
                ),
                tabs: [
                  _buildTab(
                    Icons.design_services,
                    'UI/UX Design',
                    smallPhoneheight,
                    null,
                  ),
                  _buildTab(
                    Icons.campaign_outlined,
                    'Digital Marketing',
                    smallPhoneheight,
                    Colors.purpleAccent,
                  ),
                  _buildTab(
                    Icons.web,
                    'Web Development',
                    smallPhoneheight,
                    Colors.lightBlue,
                  ),
                  _buildTab(
                    Icons.brush,
                    'Illustration',
                    smallPhoneheight,
                    Colors.orangeAccent,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
              height:
                  smallPhoneheight ? screenHeight * 0.02 : screenHeight * 0.03),

          // Tab content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: smallPhoneheight ? 20 : 40),
              child: TabBarView(
                controller: _tabController,
                children: [
                  UIUXDesignScreen(),
                  DigitalMarketingScreen(),
                  WebDevelopmentScreen(),
                  IllustrationScreen(),
                ],
              ),
            ),
          ),

          // SizedBox(
          //   height: smallPhoneheight ? 250 : 350,
          //   child: TabBarView(
          //     controller: _tabController,
          //     children: [
          //       UIUXDesignScreen(),
          //       DigitalMarketingScreen(),
          //       WebDevelopmentScreen(),
          //       IllustrationScreen(),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isSmallPhone, bool isSmallWidth) {
    return Container(
        height: isSmallWidth ? 230 : 280,
        decoration: BoxDecoration(
          color: Color(0xff5F73F3),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: isSmallPhone ? 30 : 50),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Greeting text
              Padding(
                padding: EdgeInsets.only(
                  left: isSmallWidth ? 10 : 20,
                  top: isSmallPhone ? 20 : 60,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good Morning',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isSmallPhone ? 18 : 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Elizabeth Holzer',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: isSmallPhone ? 14 : 16,
                      ),
                    ),
                  ],
                ),
              ),

              // Notification icon
              Padding(
                padding: EdgeInsets.only(
                  bottom: isSmallPhone ? 60 : 90,
                  right: isSmallWidth ? 10 : 20,
                ),
                child: _buildNotificationButton(),
              ),
            ],
          ),
        ));
  }

  // Notification button with badge
  Widget _buildNotificationButton() {
    return Stack(
      children: [
        ClipOval(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(20),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications),
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: 14,
          right: 14,
          child: Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  // Search bar widget
  Widget _buildSearchBar(bool isSmallPhone, double width) {
    return SearchBar(
      backgroundColor: WidgetStateProperty.all(Colors.white),
      elevation: WidgetStateProperty.all(2),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      hintText: 'Search Course',
      hintStyle: WidgetStateProperty.all(
        TextStyle(
          color: Colors.grey,
          fontSize: isSmallPhone ? 14 : 16,
        ),
      ),
      leading: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.search,
          color: Colors.grey,
          size: isSmallPhone ? 20 : 24,
        ),
        padding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
      ),
    );
  }

  // Individual tab with icon and text
  Widget _buildTab(
      IconData icon, String text, bool isSmallPhone, Color? iconColor) {
    return Tab(
      height: isSmallPhone ? 32 : 40,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: isSmallPhone ? 16 : 18,
            color: iconColor,
          ),
          SizedBox(width: isSmallPhone ? 4 : 8),
          Text(
            text,
            style: TextStyle(
              fontSize: isSmallPhone ? 14 : 16,
            ),
          ),
        ],
      ),
    );
  }
}
