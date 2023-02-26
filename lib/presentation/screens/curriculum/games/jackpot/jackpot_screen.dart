import 'package:esjourney/presentation/screens/curriculum/games/jackpot/jackpot_logic.dart';
import 'package:esjourney/presentation/widgets/curriculum/games/jackpot/spinner_widget.dart';
import 'package:esjourney/utils/screen_size.dart';
import 'package:flutter/material.dart';

class JackpotScreen extends StatefulWidget {
  const JackpotScreen({super.key});

  @override
  State<JackpotScreen> createState() => JackpotScreenState();
}

class JackpotScreenState extends State<JackpotScreen>
    with TickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  );

  late final AnimationController spinnercontroller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  );

  var gameserivce = JackpotLogic();

  @override
  void initState() {
    super.initState();
    controller.forward();
    spinnercontroller.forward();
  }

  @override
  Widget build(BuildContext context) {
    double height = ScreenSize.height(context);
    double width = ScreenSize.width(context);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffDD009F), Color(0xff5C0051)]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          padding: const EdgeInsets.only(left: 15, right: 15),
          children: [
            SizedBox(
              height: height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                Image.asset(
                  'assets/images/curriculum/games/jackpot/Graphics/gfx-slot-machine.png',
                  width: width * 0.6,
                ),
                //TODO : watch add to get coins
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.info_outline,
                    color: Colors.white,
                    size: 40,
                  ),
                )
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.25),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'YOUR\nCOINS',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        gameserivce.yourcoins.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Column(
              children: [
                SpinnerWidgetBox(
                  spinnerImage: gameserivce.items[gameserivce.reels[0]],
                  isSpin: false,
                  controller: spinnercontroller,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SpinnerWidgetBox(
                      spinnerImage: gameserivce.items[gameserivce.reels[1]],
                      isSpin: false,
                      controller: spinnercontroller,
                    ),
                    SpinnerWidgetBox(
                      spinnerImage: gameserivce.items[gameserivce.reels[2]],
                      isSpin: false,
                      controller: spinnercontroller,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    spinnercontroller.forward(from: 0);
                    var spin = gameserivce.spin();
                    if (spin == "GAME END") {
                      showPopup('GAME END');
                    }
                    if (spin == "WIN") {
                      showPopup('WIN');
                    }
                    setState(() {});
                  },
                  child: SpinnerWidgetBox(
                    spinnerImage: 'gfx-spin.png',
                    isSpin: true,
                    controller: spinnercontroller,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  showPopup(type) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: SizedBox(
            height: height * 0.35,
            width: width * 0.9,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Material(
                child: Column(
                  children: [
                    Container(
                      width: width * 0.9,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.centerRight,
                              colors: [Color(0xffDD009F), Color(0xff5C0051)])),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                          child: Text(
                            type == "GAME END" ? "GAME OVER" : "YOU WIN",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Image.asset(
                      'assets/images/curriculum/games/jackpot/Graphics/gfx-seven-reel.png',
                      width: 100,
                    ),
                    const Spacer(),
                    Text(
                      type == "GAME END"
                          ? "Bad Luck! You lost all of the coins.\nTry again tomorrow"
                          : "Hurray! You win the spin.\nLet's play again",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 17),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        if (type == "GAME END") {
                          Navigator.pop(context);
                          setState(() {
                            gameserivce.reset();
                          });
                          Navigator.pop(context);
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.only(
                                left: 20, right: 20, top: 5, bottom: 5)),
                        foregroundColor:
                            MaterialStateProperty.all(const Color(0xffDD009F)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: const BorderSide(
                                color: Color(0xffDD009F), width: 3),
                          ),
                        ),
                      ),
                      child: Text(
                        type == "GAME END" ? "GAME OVER" : "CONTINUE",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
