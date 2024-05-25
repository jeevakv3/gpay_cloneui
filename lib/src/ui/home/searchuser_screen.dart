import '../../../allpackages.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({super.key});

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  late List<String> randomCharacters;
  late List<Color> randomColors;

  @override
  void initState() {
    super.initState();
    randomCharacters = generateRandomCharacters(20);
    randomColors = generateRandomColors(20);
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: ColorConstant.appBgColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(size.height * 0.22),
          child: Padding(
            padding: EdgeInsets.only(
                left: 25.0, right: 10, top: size.height * 0.065),
            child: Row(
              children: [
                Container(
                  height: 45,
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: ColorConstant.greyColor)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: ColorConstant.greyColor,
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Expanded(
                          child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Pay by name or phone number',
                        ),
                      )),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                const Icon(
                  FontAwesome.ellipsis_vert,
                  color: ColorConstant.greyColor,
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  title: '    Peoples',
                  fontWeight: FontWeight.w600,
                  color: ColorConstant.blackColor,
                  textAlign: TextAlign.start,
                  fontSize: 22,
                ),
                SizedBox(
                  width: size.width,
                  child: ListView.builder(
                      itemCount: randomCharacters.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.to(PaymentUser(
                                color: randomColors[index],
                                title:
                                    '${randomCharacters[index].toUpperCase()}yertis',
                                firstChar:
                                    randomCharacters[index].toUpperCase()));
                          },
                          child: ListTile(
                            leading: Container(
                              width: 70.0,
                              height: 70.0,
                              decoration: BoxDecoration(
                                color: randomColors[0],
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: ColorConstant.greyColor,
                                  width: 1.0,
                                ),
                              ),
                              child: Center(
                                  child: CommonText(
                                title: randomCharacters[index].toUpperCase(),
                                color: ColorConstant.whiteColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 30,
                              )),
                            ),
                            title: CommonText(
                              title:
                                  '${randomCharacters[index].toUpperCase()}yertis',
                              maxLine: 1,
                              color: ColorConstant.blackColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            subtitle: CommonText(
                              title: '+91 9080613668',
                              maxLine: 1,
                              color: ColorConstant.greyColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ));
  }
}
