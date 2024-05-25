import '../../../allpackages.dart';

class PaymentUser extends StatefulWidget {
  Color? color;
  String? title;
  String? firstChar;
  PaymentUser({super.key, this.color, this.title, this.firstChar});

  @override
  State<PaymentUser> createState() => _PaymentUserState();
}

class _PaymentUserState extends State<PaymentUser> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.22),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: ColorConstant.greyColor,
                size: 30,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            title: ListTile(
              leading: Container(
                width: 50.0,
                height: 48.0,
                decoration: BoxDecoration(
                  color: widget.color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ColorConstant.greyColor,
                    width: 1.0,
                  ),
                ),
                child: Center(
                    child: CommonText(
                  title: widget.firstChar,
                  color: ColorConstant.whiteColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 30,
                )),
              ),
              title: CommonText(
                title: widget.title,
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
            actions: const [
              Icon(
                Icons.local_phone,
                color: ColorConstant.blackColor,
              ),
              SizedBox(
                width: 15,
              ),
              Icon(
                FontAwesome.ellipsis_vert,
                color: ColorConstant.blackColor,
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 85.0,
                    height: 85.0,
                    decoration: BoxDecoration(
                      color: widget.color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: ColorConstant.greyColor,
                        width: 1.0,
                      ),
                    ),
                    child: Center(
                        child: CommonText(
                      title: widget.firstChar,
                      color: ColorConstant.whiteColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 30,
                    )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Center(
                    child: CommonText(
                      title: widget.title,
                      maxLine: 1,
                      color: ColorConstant.blackColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Center(
                  child: CommonText(
                    title: '+91 9080613668',
                    maxLine: 1,
                    color: ColorConstant.greyColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 1,
                    width: size.width,
                    decoration: const BoxDecoration(
                        color: ColorConstant.greyColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 18.0),
            child: isExpanded
                ? Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        child: const Icon(
                          MfgLabs.right_open,
                          color: ColorConstant.greyColor,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                            color: ColorConstant.appBgColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 12.0, left: 8.0),
                              child: TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Send a message....',
                                    suffixIcon: InkWell(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.send,
                                        color: ColorConstant.darkBlue,
                                        size: 25,
                                      ),
                                    )),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: ColorConstant.liteBlue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: CommonText(
                              title: '   Pay   ',
                              color: ColorConstant.whiteColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: ColorConstant.liteBlue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: CommonText(
                              title: '   Request   ',
                              color: ColorConstant.whiteColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: ColorConstant.appBgColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonText(
                                    title: ' Message....',
                                    color: ColorConstant.greyColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.send,
                                      color: ColorConstant.darkBlue,
                                      size: 25,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
