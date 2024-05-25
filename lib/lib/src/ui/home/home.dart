import '../../../allpackages.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  var iconData = [
    Icons.qr_code,
    Icons.phone,
    Icons.phonelink_ring,
    FontAwesome.bank,
    Icons.open_in_new,
    Icons.person,
    Icons.speaker_group,
    Icons.phonelink_setup
  ];
  var iconText = [
    'Scan any\nQR code',
    'Pay\ncontacts',
    'Pay phone\nnumber',
    'Bank\ntransfer',
    'Pay UPI ID\nor number',
    'Self\ntransfer',
    'Pay\nbills',
    'Mobile\nrecharge'
  ];

  late List<String> randomCharacters;
  late List<Color> randomColors;

  int chatLength = 0;

  bool isMore = false;

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  bool _showFirstString = true;

  @override
  void initState() {
    super.initState();
    randomCharacters = generateRandomCharacters(10);
    randomColors = generateRandomColors(10);
    isExpanded();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _showFirstString = !_showFirstString;
            _controller.reverse();
          });
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.0),
      end: const Offset(0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  List<String> generateRandomCharacters(int length) {
    const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    Random random = Random();

    return List<String>.generate(
        length, (index) => chars[random.nextInt(chars.length)]);
  }

  List<Color> generateRandomColors(int length) {
    Random random = Random();

    return List<Color>.generate(length, (index) {
      int red, green, blue;
      do {
        red = random.nextInt(256);
        green = random.nextInt(256);
        blue = random.nextInt(256);
      } while ((red == 255 && green == 255 && blue == 255) ||
          (red == 0 && green == 0 && blue == 0));

      return Color.fromARGB(255, red, green, blue);
    });
  }

  isExpanded() {
    if (randomCharacters.length > 9) {
      chatLength = 8;
    } else {
      chatLength = randomCharacters.length;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isGranted) {
      if (await Permission.camera.request().isGranted) {
        Get.to(const QrCodeScanner());
      } else {
        Get.snackbar('', 'Please give the permmison');
      }
    } else {
      if (await Permission.camera.request().isGranted) {
        Get.to(const QrCodeScanner());
      } else {
        Get.snackbar('', 'Please give the permmison');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorConstant.appBgColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.065),
                  child: InkWell(
                    onTap: () {
                      Get.to(const SearchUser());
                    },
                    child: Card(
                      elevation: 4,
                      color: ColorConstant.whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Container(
                          height: 50,
                          width: size.width * 0.75,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: ColorConstant.whiteColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.search,
                                  color: ColorConstant.blackColor,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Center(
                                  child: SlideTransition(
                                    position: _slideAnimation,
                                    child: CommonText(
                                      title: _showFirstString
                                          ? 'Pay friends and merchants'
                                          : 'Pay by name or Phone number',
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ),
                                // Center(
                                //   child : AnimatedTextKit(animatedTexts: [
                                //     RotateAnimatedText(
                                //       duration : const Duration(milliseconds: 5000),
                                //       'Pay friends and merchants', textStyle: TextStyle(color: Colors.grey.shade500)),
                                //      RotateAnimatedText(
                                //        duration : const Duration(milliseconds: 5000),
                                //       'Pay by name or Phone number',  textStyle: TextStyle(color: Colors.grey.shade500)),
                                //   ],)
                             
                                // )
                              ],
                            ),
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 6),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: ColorConstant.orangeColor,
                      child: Center(
                        child: CommonText(
                          title: 'J',
                          color: ColorConstant.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: size.height * 0.22,
              width: size.width,
              decoration: const BoxDecoration(
                  color: ColorConstant.whiteColor,
                  image: DecorationImage(
                      image: AssetImage('assets/hometopbg.jpeg'),
                      fit: BoxFit.fill)),
            ),
            Container(
              width: size.width,
              color: ColorConstant.whiteColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.26,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 6.0, // Spacing between columns
                        mainAxisSpacing: 6.0, // Spacing between rows
                        childAspectRatio: 0.9, // Aspect ratio of each item
                      ),
                      itemCount: iconData.length, // Number of items
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            if (index == 0) {
                              requestCameraPermission();
                            } else {
                              Get.to(const SearchUser());
                            }
                          },
                          child: Column(
                            children: [
                              Icon(
                                iconData[index],
                                color: Colors.blue.shade700,
                                size: 35,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CommonText(
                                  title: iconText[index],
                                  maxLine: 2,
                                  color: ColorConstant.blackColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      padding: const EdgeInsets.only(
                          left: 20.0,
                          top: 20.0,
                          right: 10), // Padding around the grid
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Container(
                        height: 25,
                        width: size.width * 0.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: ColorConstant.appBgColor),
                        child: CommonText(
                          title: 'UPI ID : jeevasg21@oksbi',
                          color: ColorConstant.greyColor,
                          textAlign: TextAlign.center,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: CommonText(
                      title: 'People',
                      color: ColorConstant.blackColor,
                      textAlign: TextAlign.start,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: chatLength,
                    itemBuilder: (BuildContext context, int index) {
                      print('index-----$index');
                      return Column(
                        children: [
                          randomCharacters.length > 9 &&
                                  ((isMore == false && index < 7) ||
                                      (isMore && index < chatLength - 1))
                              ? InkWell(
                                  onTap: () {
                                    Get.to(PaymentUser(
                                      color: randomColors[index],
                                      title:
                                          '${randomCharacters[index].toUpperCase()}yertis',
                                      firstChar:
                                          randomCharacters[index].toUpperCase(),
                                    ));
                                  },
                                  child: Container(
                                    width: 80.0,
                                    height: 80.0,
                                    decoration: BoxDecoration(
                                      color: randomColors[index],
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: ColorConstant.greyColor,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Center(
                                        child: CommonText(
                                      title:
                                          randomCharacters[index].toUpperCase(),
                                      color: ColorConstant.whiteColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 30,
                                    )),
                                  ),
                                )
                              : Container(),
                          randomCharacters.length > 9 &&
                                  ((isMore == false && index < 7) ||
                                      (isMore && index < chatLength - 1))
                              ? CommonText(
                                  title:
                                      '${randomCharacters[index].toUpperCase()}yertis',
                                  maxLine: 1,
                                  color: ColorConstant.blackColor,
                                  fontSize: 13,
                                )
                              : Container(),
                          randomCharacters.length > 9 &&
                                  ((isMore == false && index == 7) ||
                                      (isMore && index == chatLength - 1))
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isMore = !isMore;
                                        if (isMore == true) {
                                          chatLength = randomCharacters.length;
                                        } else {
                                          chatLength = 8;
                                        }
                                      });
                                    },
                                    child: Container(
                                      width: 80.0,
                                      height: 80.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: ColorConstant.greyColor,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Center(
                                          child: Icon(
                                        isMore == false
                                            ? Icons.keyboard_arrow_down
                                            : Icons.keyboard_arrow_up,
                                        color: Colors.blue,
                                        size: 30,
                                      )),
                                    ),
                                  ),
                                )
                              : const SizedBox(
                                  height: 0,
                                  width: 0,
                                ),
                        ],
                      );
                    },
                    padding:
                        const EdgeInsets.only(left: 20.0, top: 8.0, right: 10),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, left: 15, bottom: 2),
                    child: CommonText(
                      title: 'Bills & recharges',
                      color: ColorConstant.blackColor,
                      textAlign: TextAlign.start,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 10),
                    child: CommonText(
                      title: 'No bills due. Try adding these!',
                      color: Colors.grey.shade900,
                      textAlign: TextAlign.start,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 65,
                              width: 65,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(255, 168, 209, 245)),
                              child: const Center(
                                child: Icon(
                                  Icons.phonelink_ring,
                                  color: ColorConstant.blackColor,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, top: 8.0),
                              child: CommonText(
                                title: ' Mobile\nrecharges',
                                color: Colors.grey.shade900,
                                textAlign: TextAlign.start,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              height: 65,
                              width: 65,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(255, 168, 209, 245)),
                              child: const Center(
                                child: Icon(
                                  Icons.tv,
                                  color: ColorConstant.blackColor,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, top: 8.0),
                              child: CommonText(
                                title: ' DTH / Cable\nrecharges',
                                maxLine: 2,
                                color: Colors.grey.shade900,
                                textAlign: TextAlign.start,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              height: 65,
                              width: 65,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(255, 168, 209, 245)),
                              child: const Center(
                                child: Icon(
                                  Icons.lightbulb_outline,
                                  color: ColorConstant.blackColor,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, top: 8.0),
                              child: CommonText(
                                title: 'Electricity',
                                color: Colors.grey.shade900,
                                textAlign: TextAlign.start,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              height: 65,
                              width: 65,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(255, 168, 209, 245)),
                              child: const Center(
                                child: Icon(
                                  Icons.local_car_wash,
                                  color: ColorConstant.blackColor,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, top: 8.0),
                              child: CommonText(
                                title: ' FASTag\nrecharge',
                                color: Colors.grey.shade900,
                                textAlign: TextAlign.start,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Container(
                      height: 35,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: ColorConstant.greyColor)),
                      child: Center(
                        child: CommonText(
                          title: 'See all',
                          color: Colors.blue,
                          textAlign: TextAlign.start,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, left: 15, bottom: 2),
                    child: CommonText(
                      title: 'Offers & rewards',
                      color: ColorConstant.blackColor,
                      textAlign: TextAlign.start,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 65,
                              width: 65,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: ColorConstant.greyColor),
                                  color:
                                      const Color.fromARGB(255, 234, 167, 68)),
                              child: Center(
                                child: Icon(
                                  FontAwesome.award,
                                  color: ColorConstant.whiteColor,
                                  size: size.height * 0.04,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, top: 8.0),
                              child: CommonText(
                                title: 'Rewards',
                                color: Colors.grey.shade900,
                                textAlign: TextAlign.start,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: size.width * 0.06,
                        ),
                        Column(
                          children: [
                            Container(
                              height: 65,
                              width: 65,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: ColorConstant.greyColor),
                                  color:
                                      const Color.fromARGB(255, 242, 77, 93)),
                              child: Center(
                                child: Icon(
                                  FontAwesome.tags,
                                  color: ColorConstant.whiteColor,
                                  size: size.height * 0.04,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, top: 8.0),
                              child: CommonText(
                                title: 'Offers',
                                color: Colors.grey.shade900,
                                textAlign: TextAlign.start,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: size.width * 0.06,
                        ),
                        Column(
                          children: [
                            Container(
                              height: 65,
                              width: 65,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorConstant.greyColor),
                                  shape: BoxShape.circle,
                                  color:
                                      const Color.fromARGB(255, 40, 148, 242)),
                              child: Center(
                                child: Icon(
                                  Icons.local_florist,
                                  color: ColorConstant.whiteColor,
                                  size: size.height * 0.04,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, top: 8.0),
                              child: CommonText(
                                title: 'Referrals',
                                color: Colors.grey.shade900,
                                textAlign: TextAlign.start,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, left: 15, bottom: 2),
                    child: CommonText(
                      title: 'Manage your money',
                      color: ColorConstant.blackColor,
                      textAlign: TextAlign.start,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15, top: 6.0, bottom: 4),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: ColorConstant.greyColor)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 10, right: 10, bottom: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Entypo.megaphone,
                                  color: Colors.green,
                                  size: size.height * 0.05,
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: CommonText(
                                    title:
                                        'Get loans of up to ₹8 lakhs with no waiting or paperwork',
                                    color: ColorConstant.blackColor,
                                    textAlign: TextAlign.start,
                                    fontSize: 15,
                                    maxLine: 4,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: size.width * 0.12, top: 10),
                              child: CommonText(
                                title: 'Apply now >',
                                color: Colors.blue,
                                textAlign: TextAlign.start,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 10, top: 6.0, bottom: 4),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: ColorConstant.greyColor),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Entypo.credit_card,
                                    color: ColorConstant.darkBlue,
                                  ),
                                  Flexible(
                                    child: CommonText(
                                      title: ' Get a credit card ',
                                      color: ColorConstant.blackColor,
                                      textAlign: TextAlign.start,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      maxLine: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.04,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: ColorConstant.greyColor),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  FontAwesome.money,
                                  color: ColorConstant.darkBlue,
                                ),
                                CommonText(
                                  title: '  Loans ',
                                  color: ColorConstant.blackColor,
                                  textAlign: TextAlign.start,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.04,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: ColorConstant.greyColor),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  FontAwesome5.coins,
                                  color: ColorConstant.darkBlue,
                                ),
                                CommonText(
                                  title: '  Gold ',
                                  color: ColorConstant.blackColor,
                                  textAlign: TextAlign.start,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 15.0,
                        right: 15,
                        top: size.height * 0.04,
                        bottom: 15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Entypo.gauge,
                              color: ColorConstant.darkBlue,
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: size.width * 0.04),
                                child: CommonText(
                                  title: 'Check your CIBIL score for free',
                                  color: ColorConstant.blackColor,
                                  textAlign: TextAlign.start,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: ColorConstant.darkBlue,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        Row(
                          children: [
                            Icon(
                              Entypo.back_in_time,
                              color: ColorConstant.darkBlue,
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: size.width * 0.04),
                                child: CommonText(
                                  title: 'See transaction history',
                                  color: ColorConstant.blackColor,
                                  textAlign: TextAlign.start,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: ColorConstant.darkBlue,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        Row(
                          children: [
                            Icon(
                              FontAwesome.bank,
                              color: ColorConstant.darkBlue,
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: size.width * 0.04),
                                child: CommonText(
                                  title: 'Check your balance',
                                  color: ColorConstant.blackColor,
                                  textAlign: TextAlign.start,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: ColorConstant.darkBlue,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Container(
                    width: size.width,
                    height: size.height * 0.25,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/hometopbg.jpeg'),
                            fit: BoxFit.fill)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            title: 'Invite friends to get ₹201',
                            color: ColorConstant.blackColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          CommonText(
                            title:
                                'Invite friends to Google Pay and get ₹201 when your friends sends their first payment. They get ₹21!',
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            children: [
                              CommonText(
                                title: 'Copy your code  ',
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                              CommonText(
                                title: 'z1gl9g  ',
                                color: ColorConstant.blackColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                              InkWell(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.copy,
                                    color: ColorConstant.blackColor,
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
