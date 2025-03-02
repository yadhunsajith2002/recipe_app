import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowProgressDialog {
  /// Value to indicate if dialog is open
  bool isOpen = false;

  /// String to set the message on the dialog
  String? _message = '';

  /// StateSetter to make available the function to update message text inside an opened dialog

  /// Context to render the dialog

  /// Bool value to indicate the barrierDismisable of the dialog
  final bool? barrierDismissible;

  /// Duration for animation
  final Duration? duration;

  /// Widget indicator when custom is selected
  // Widget? _customLoadingIndicator;

  /// Color value to set the indicator color
  Color? progressIndicatorColor;

  ShowProgressDialog({this.barrierDismissible = false, this.duration = const Duration(milliseconds: 1000)});

  void show(
      {String message = "Loading",
      double height = 100,
      double width = 120,
      double radius = 5.0,
      double elevation = 5.0,
      Color backgroundColor = Colors.white,
      Color? indicatorColor,
      bool horizontal = false,
      double separation = 10.0,
      TextStyle textStyle = const TextStyle(fontSize: 14),
      bool hideText = false,
      Widget? loadingIndicator}) {
    // hide all custom snackbar
    Get.closeAllSnackbars();
    progressIndicatorColor = indicatorColor ?? Colors.blue[600];
    isOpen = true;
    _message = message;

    double height = 100;
    double width = 120;
    bool horizontal = false;
    double separation = 10.0;
    TextStyle textStyle = TextStyle(fontSize: 14);
    bool hideText = false;

    Get.dialog(
      WillPopScope(
        onWillPop: () => Future.value(barrierDismissible!),
        child: Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(0.0),
          child: StatefulBuilder(builder: (BuildContext _, StateSetter setState) {
            // _setState = setState;
            return Center(
              child: SizedBox(
                  height: height,
                  width: width,
                  /*decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius:
                            BorderRadius.all(Radius.circular(radius))),*/
                  child: /*!horizontal
                            ? */
                      Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: _getChildren(_message, horizontal, separation, textStyle, hideText),
                  ) /* : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: _getChildren(_message, horizontal,
                              separation, textStyle, hideText),
                        ),*/
                  ),
            );
          }),
        ),
      ),
      barrierDismissible: barrierDismissible!,
      useSafeArea: true,
    );
  }

  void hide() {
    if (isOpen) {
      // hide all custom snackbar
      Get.closeAllSnackbars();
      Get.back();
      isOpen = false;
    }
  }

  static List<Widget> _getChildren(
      String? message, bool horizontal, double separation, TextStyle textStyle, bool hideText) {
    return [
      // Image.asset('assets/app_logo/app_logo.png', width: 90, height: 90),
      Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          )),
      !horizontal
          ? SizedBox(
              height: separation,
            )
          : SizedBox(
              width: separation,
            ),

      /*
      if (hideText)
      Text(
        message!,
        style: textStyle,
      )*/
    ];
  }

  static Widget showProgressDialog(
      {@required String? message,
      double height = 100,
      double width = 120,
      double radius = 5.0,
      double elevation = 5.0,
      Color backgroundColor = Colors.white,
      Color? indicatorColor,
      bool horizontal = false,
      double separation = 10.0,
      TextStyle textStyle = const TextStyle(fontSize: 14),
      bool hideText = false,
      Widget? loadingIndicator}) {
    return Dialog(
      child: Center(
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.all(Radius.circular(radius))),
          child: !horizontal
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: _getChildren(message, horizontal, separation, textStyle, hideText),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: _getChildren(message, horizontal, separation, textStyle, hideText),
                ),
        ),
      ),
    );
  }
}
