import '../../../allpackages.dart';

// ignore: must_be_immutable
class CommonText extends StatelessWidget {
  String? title;
  Color? color;
  double? fontSize;
  FontWeight? fontWeight;
  TextAlign? textAlign;
  int? maxLine;
  CommonText(
      {super.key,
      this.title,
      this.color,
      this.fontSize,
      this.fontWeight,
      this.textAlign,
      this.maxLine});

  @override
  Widget build(BuildContext context) {
    return Text(
      title!,
      textAlign: textAlign,
      maxLines: maxLine,
      style:
          TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
