import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconTextField extends StatefulWidget {
  const IconTextField({
    Key? key,
    required this.hint,
    required this.controller,
    required this.whiteBackground,
    this.icon,
    this.focusNode,
    this.suffixIcon,
    this.label,
    this.formatters,
    this.textColor = Colors.white,
    this.textInputType = TextInputType.text,
    this.isPassword = false,
    this.isMultiLine = false,
    this.isEnabled = true,
  }) : super(key: key);

  final String? icon;
  final String? suffixIcon;
  final String hint;
  final String? label;
  final TextEditingController controller;
  final List<TextInputFormatter>? formatters;
  final bool isPassword;
  final bool isMultiLine;
  final bool isEnabled;
  final Color textColor;
  final TextInputType textInputType;
  final bool whiteBackground;
  final FocusNode? focusNode;

  @override
  State<IconTextField> createState() => _IconTextFieldState();
}

class _IconTextFieldState extends State<IconTextField> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Text(widget.label!, style: TextStyle(color: widget.textColor)),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: widget.whiteBackground ? Color(0xFFF5F5F5) : Colors.white10,
          ),
          height: widget.isMultiLine ? 100 : 50,
          child: Row(
            crossAxisAlignment:
                widget.isMultiLine
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              if (widget.icon != null)
                Row(
                  children: [
                    Container(
                      width: 45,
                      padding: EdgeInsets.only(
                        top: widget.isMultiLine ? 20 : 0,
                      ),
                      child: Image.asset(
                        widget.icon!,
                        height: 14,
                        width: 14,
                        color:
                            widget.whiteBackground
                                ? Color(0x61000000)
                                : Colors.white,
                      ),
                    ),
                    Container(
                      width: 1,
                      height: double.infinity,
                      color: Colors.white54,
                    ),
                  ],
                ),
              Expanded(
                child:
                    widget.isMultiLine
                        ? TextFormField(
                      focusNode: widget.focusNode,
                          enabled: widget.isEnabled,
                          cursorColor:
                              widget.whiteBackground
                                  ? Color(0x61000000)
                                  : Colors.white,
                          style: TextStyle(
                            color:
                                widget.whiteBackground
                                    ? Color(0x61000000)
                                    : Colors.white54,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          controller: widget.controller,
                          keyboardType: widget.textInputType,
                          inputFormatters: widget.formatters,
                          minLines: 1,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: widget.hint,
                            hintStyle: TextStyle(
                              color:
                                  widget.whiteBackground
                                      ? Color(0x61000000)
                                      : Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            border: InputBorder.none,
                          ),
                        )
                        : TextFormField(
                      focusNode: widget.focusNode,
                      enabled: widget.isEnabled,
                          cursorColor:
                              widget.whiteBackground
                                  ? Color(0x61000000)
                                  : Colors.white,
                          style: TextStyle(
                            color:
                                widget.whiteBackground
                                    ? Color(0x61000000)
                                    : Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          controller: widget.controller,
                          obscureText: widget.isPassword ? !isVisible : false,
                          keyboardType: widget.textInputType,
                          inputFormatters: widget.formatters,
                          decoration: InputDecoration(
                            hintText: widget.hint,
                            hintStyle: TextStyle(
                              color:
                                  widget.whiteBackground
                                      ? Color(0x61000000)
                                      : Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
              ),
              if (widget.suffixIcon != null)
                Container(
                  width: 45,
                  padding: EdgeInsets.only(top: widget.isMultiLine ? 20 : 0),
                  child: Image.asset(
                    widget.suffixIcon!,
                    height: 14,
                    width: 14,
                    color:
                        widget.whiteBackground
                            ? Color(0x61000000)
                            : Colors.white,
                  ),
                ),
              Visibility(
                visible: widget.isPassword,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  child: SizedBox(
                    width: 40,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(
                          isVisible
                              ? 'assets/icons/eye.svg'
                              : 'assets/icons/eye_slash.svg',
                          fit: BoxFit.scaleDown,
                          color:
                              widget.whiteBackground
                                  ? Color(0x61000000)
                                  : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
