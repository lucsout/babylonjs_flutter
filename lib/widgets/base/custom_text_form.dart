import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:sporty/customs/custom_applications.dart';

class CustomTextFormField extends StatefulWidget {
  TextEditingController? controller;
  final String? text;
  final String? hintText;
  final bool? isPwd;
  final bool? isRequired;
  final void Function(String)? onchanged;
  final String? value;
  final int? maxChar;
  final int? minChar;
  final int? maxLines;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? isInt;
  final bool? isEuro;
  final bool? isDateValidate;
  final Color? fontColor;
  final double? fontSize;
  final FocusNode? fNode;
  bool? enabled;
  bool? editingMode;
  final bool? validateEmail;
  final Color? borderColor;
  final Color? backgroundColor;

  CustomTextFormField(
      {this.text,
      this.hintText,
      this.controller,
      this.isPwd,
      this.borderColor,
      this.validateEmail,
      this.maxLines,
      this.isRequired,
      this.onchanged,
      this.editingMode,
      this.suffixIcon,
      this.prefixIcon,
      this.maxChar,
      this.fNode,
      this.minChar,
      this.enabled,
      this.value,
      this.isInt,
      this.backgroundColor,
      this.isDateValidate,
      this.isEuro,
      this.fontColor,
      this.fontSize}) {
    if (this.controller != null) this.controller!.text = this.value ?? '';
  }

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  TextEditingController controller = new TextEditingController();
  String value = "";

  @override
  void initState() {
    if (widget.controller == null) {
      if (widget.value != null) controller.text = widget.value!;
    } else {
      controller = widget.controller!;
    }

    if (widget.enabled == null) widget.enabled = true;

    super.initState();
  }

  InputDecoration getDecoration() {
    return InputDecoration(
      focusColor: CustomApplication.accentColor,
      labelText: widget.text,
      hintText: widget.hintText,
      suffixIcon: widget.suffixIcon ?? null,
      prefixIcon: widget.prefixIcon ?? null,
      errorMaxLines: 2,
      labelStyle: TextStyle(color: CustomApplication.textColor),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        borderSide: BorderSide(
            color: widget.borderColor ?? Colors.white.withOpacity(0.90),
            width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        borderSide: BorderSide(color: CustomApplication.accentColor, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (this.widget.editingMode == null) this.widget.editingMode = true;

    return IgnorePointer(
      ignoring: !widget.editingMode!,
      child: Padding(
        padding: EdgeInsets.zero,
        child: TextFormField(
          onChanged: (string) {
            var stringEdit = string;
            if (widget.maxChar != null) {
              if (string.length > widget.maxChar!) {
                stringEdit = string.substring(0, widget.maxChar);

                setState(() {
                  widget.controller!.text = stringEdit;
                  widget.controller!.selection = TextSelection.collapsed(
                      offset: widget.controller!.text.length);
                });
              }
            }
            if (widget.isInt != null) {
              final stringEdit = string.replaceAll(new RegExp(r"(\D+)"), "");

              setState(() {
                widget.controller!.text = stringEdit;
                widget.controller!.selection = TextSelection.collapsed(
                    offset: widget.controller!.text.length);
              });
            }
            if (widget.isEuro != null) {
              final stringEdit = string.replaceAll(new RegExp(r"[a-zA-Z]"), "");

              setState(() {
                if (widget.controller!.text.contains("€")) {
                  widget.controller!.text = stringEdit;
                } else
                  widget.controller!.text = "€ " + stringEdit;

                widget.controller!.selection = TextSelection.collapsed(
                    offset: widget.controller!.text.length);
              });
            }

            if (widget.onchanged != null) widget.onchanged!(stringEdit);
          },
          enabled: widget.enabled,
          maxLines: widget.maxLines ?? 1,
          controller: controller,
          initialValue: null,
          textAlign: TextAlign.start,
          style: TextStyle(
              color: widget.fontColor ?? Colors.black,
              fontSize: widget.fontSize ?? 14),
          cursorColor: CustomApplication.accentColor,
          obscureText: widget.isPwd == null ? false : widget.isPwd!,
          decoration: getDecoration(),
          validator: (value) {
            if ((widget.validateEmail ?? false) && value!.isNotEmpty) {
              var res = EmailValidator.validate(value);
              if (res)
                return null;
              else
                return "Email non corretta";
            }

            if (widget.isRequired == null && widget.isDateValidate == null)
              return null;
            else if (widget.isRequired ?? false) {
              if (widget.minChar != null) {
                if (value!.length <= widget.minChar!) {
                  return "Il campo " +
                      widget.text! +
                      " deve essere di almeno " +
                      widget.minChar.toString() +
                      " caratteri";
                }
              }
              if (value!.isEmpty) {
                return 'Inserire ' + widget.text!;
              }
            } else if (widget.isDateValidate ?? false) {
              var checkData = false;

              if (value!.isEmpty && (widget.isRequired ?? false))
                checkData = true;

              if (value.isEmpty && !(widget.isRequired ?? false))
                checkData = false;

              if (value.isNotEmpty) checkData = true;

              if (checkData) {
                if (value.length < 10) return "Data non valida";
                if (value.length >= 5 && int.parse(value.substring(3, 5)) > 12)
                  return "Mese non valido";
                if (value.length >= 2 && int.parse(value.substring(0, 2)) > 31)
                  return "Giorno non valido";
                if (value.length == 10 &&
                    (int.parse(value.substring(6, 10)) < 1900 ||
                        int.parse(value.substring(6, 10)) >
                            DateTime.now().year)) return "Anno non valido";
              }
            }

            return null;
          },
        ),
      ),
    );
  }
}
