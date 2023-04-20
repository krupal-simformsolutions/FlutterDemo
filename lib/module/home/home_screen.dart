import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterdemo/data/model/product.dart';
import 'package:flutterdemo/data/remote/api_service.dart';
import 'package:flutterdemo/module/profile/profile_screen.dart';
import 'package:flutterdemo/values/app_colors.dart';
import 'package:flutterdemo/values/styles.dart';
import 'package:flutterdemo/values/values.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  int currentIndex = 0;
  final GlobalKey<SliderDrawerState> drawerKey = GlobalKey();

  Widget _widgetOption(int index) {
    switch (index) {
      case 0:
        return const DashboardWidget();
      case 1:
        return const Scaffold(
          body: Center(child: Text('No items in cart')),
        );
      case 2:
        return const Scaffold(
          body: Center(child: Text('No favorite items')),
        );
      case 3:
        return const ProfileScreen();
      default:
        return const Text('No Data');
    }
  }

  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        statusBarColor: AppColors.colorPrimary,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark));
    return Scaffold(
      backgroundColor: AppColors.colorPrimary,
      bottomNavigationBar: BottomNavigation(
        currentIndex: widget.currentIndex,
        callback: (index) {
          setState(() {
            widget.currentIndex = index;
          });
        },
      ),
      body: SliderDrawer(
        key: widget.drawerKey,
        splashColor: Colors.black,
        slider: const DrawerContent(),
        appBar: widget.currentIndex == 3
            ? const SizedBox()
            : SliderAppBar(
                title: const Text('Home'),
                appBarColor: AppColors.colorPrimary,
                drawerIcon: InkWell(
                  onTap: () {
                    widget.drawerKey.currentState?.openSlider();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset("assets/vectors/drawer.svg"),
                  ),
                ),
                trailing: IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: SvgPicture.asset("assets/vectors/notification.svg")),
              ),
        isCupertino: false,
        child: widget._widgetOption(widget.currentIndex),
      ),
    );
  }
}

class DrawerContent extends StatelessWidget {
  const DrawerContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Image.asset("assets/images/sample_profile.png"),
        const SizedBox(
          height: 30,
        ),
        const Text(
          'Name here',
          style: AppStyles.titleText,
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'My Favorite',
                  style: AppStyles.drawerItemStyle,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'My Profile',
                  style: AppStyles.drawerItemStyle,
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        SizedBox(
            width: 80,
            height: 80,
            child: Image.asset("assets/images/logo.png")),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({
    super.key,
  });

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  List<String> productList = [];

  @override
  void initState() {
    super.initState();
  }

  Future<List<Product>> getPosts(BuildContext context) async {
    ApiService? apiService=Provider.of<ApiService?>(context);
    if(apiService==null){
      print("provider null");
    }
    var response =
        await Provider.of<ApiService>(context, listen: false).getPosts();
    print("response waiting");
    List<dynamic> iteratable = json.decode(response.bodyString);
    List<Product> products =
        List<Product>.from(iteratable.map((e) => Product.fromJson(e)));
    return products;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Provider<ApiService>(
          create: (BuildContext context) => ApiService.create(),
          child: FutureBuilder(
            future: getPosts(context),
            builder: (context, snapshot) {
              print("snapshot loading");
              print(snapshot.data);
              return Scaffold(
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Explore ",
                          style: AppStyles.headingText,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          AppStrings.bestOutFit,
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return const FilterBottomSheet();
                                          },
                                          backgroundColor: Colors.white,
                                          elevation: 20,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight:
                                                      Radius.circular(20))));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: SvgPicture.asset(
                                          "assets/vectors/filter.svg"),
                                    ),
                                  ),
                                )),
                            label: const Text('Search'),
                            fillColor: Colors.white,
                            filled: true,
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                borderSide: BorderSide.none),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 80,
                          child: SmallClothList(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: const [
                            Text(
                              'New Arrival',
                              style: TextStyle(fontSize: 30),
                            ),
                            Spacer(),
                            Text(
                              'See all',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 250,
                          child: BigClothList(),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }
    );
  }
}

class SmallClothList extends StatelessWidget {
  const SmallClothList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      clipBehavior: Clip.hardEdge,
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: 20,
        );
      },
      itemCount: 10,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
            padding: const EdgeInsets.all(10),
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: SvgPicture.asset("assets/vectors/sampledress.svg"));
      },
    );
  }
}

class BigClothList extends StatelessWidget {
  const BigClothList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 20,
          );
        },
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('productDetail');
            },
            child: SizedBox(
              width: 160,
              height: 250,
              child: Column(
                children: [
                  Card(
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: Hero(
                        tag: 'ProductImage',
                        child: Image.asset(
                          "assets/images/shirt.png",
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: const [
                      Flexible(
                        child: Text(
                          'Long sleeve tshirt',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Text(
                        '\$300',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

class Drawer extends StatelessWidget {
  const Drawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            children: const [
              FlutterLogo(
                size: 200,
              ),
              Text("Title here")
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavigation extends StatefulWidget {
  var currentIndex = 0;

  ValueChanged<int> callback = (value) {};

  BottomNavigation(
      {super.key, required this.currentIndex, required this.callback});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 20,
        selectedItemColor: Colors.orange,
        currentIndex: widget.currentIndex,
        onTap: (index) {
          setState(() {
            widget.currentIndex = index;
            widget.callback.call(index);
          });
        },
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: SvgPicture.asset("assets/vectors/home.svg",
                color: widget.currentIndex == 0 ? Colors.orange : Colors.black),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: SvgPicture.asset(
              "assets/vectors/cart.svg",
              color: widget.currentIndex == 1 ? Colors.orange : Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: SvgPicture.asset(
              "assets/vectors/heart.svg",
              color: widget.currentIndex == 2 ? Colors.orange : Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: SvgPicture.asset(
              "assets/vectors/profile.svg",
              color: widget.currentIndex == 3 ? Colors.orange : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({
    super.key,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
        title: const Center(
          child: Text(
            "Filter",
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          SizedBox(
            width: 40,
            child: IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.close),
                )),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Divider(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Category',
              style: AppStyles.titleText,
            ),
          )
        ],
      ),
    );
  }
}
