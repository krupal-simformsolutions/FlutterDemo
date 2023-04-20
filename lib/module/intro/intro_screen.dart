import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterdemo/data/model/intromodel.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController pageController = PageController(initialPage: 0);
  int currentPage = 1;
  static int totalPage = 3;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page!.toInt()! + 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("$currentPage/$totalPage"),
                    Spacer(),
                    GestureDetector(
                        onTap: () {
                          gotoHomePage();
                        },
                        child: const Text("Skip"))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Spacer(),
              SizedBox(
                height: 600,
                child: PageView(
                  physics: const BouncingScrollPhysics(),
                  controller: pageController,
                  children: const [
                    IntroItem(
                      introModel: IntroModel(
                          image: "assets/vectors/intro_first.svg",
                          title: "Choose product",
                          description:
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages"),
                    ),
                    IntroItem(
                      introModel: IntroModel(
                          image: "assets/vectors/intro_first.svg",
                          title: "Make payment",
                          description:
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages"),
                    ),
                    IntroItem(
                      introModel: IntroModel(
                          image: "assets/vectors/intro_second.svg",
                          title: "Get your order",
                          description:
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages"),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                color: Colors.orange,
                onPressed: () {
                  if (currentPage == totalPage) {
                    gotoHomePage();
                  } else {
                    pageController.nextPage(
                        duration: const Duration(seconds: 2),
                        curve: Curves.elasticOut);
                  }
                },
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        currentPage == totalPage ? "Get Started " : "Next",
                        style: TextStyle(color: Colors.white),
                      ),
                      Transform.rotate(
                          angle: 135,
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  void gotoHomePage() {
    Navigator.of(context).pushNamed("home");
  }
}

class IntroItem extends StatefulWidget {
  final IntroModel introModel;

  const IntroItem({Key? key, required this.introModel}) : super(key: key);

  @override
  State<IntroItem> createState() => _IntroItemState();
}

class _IntroItemState extends State<IntroItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(child: SvgPicture.asset(widget.introModel.image)),
        const SizedBox(
          height: 20,
        ),
        Text(
          widget.introModel.title,
          style: const TextStyle(fontSize: 22),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.introModel.description,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
