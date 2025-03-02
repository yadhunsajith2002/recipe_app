import 'package:get/get.dart';

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isSameMonth(DateTime other) {
    return year == other.year && month == other.month;
  }
}

String? validateEmail(value) {
  if (value != null && GetUtils.isEmail(value)) {
    return null;
  }
  return "Please enter a valid email id";
}

validateIfscCode(value, {bool isNotRequired = true}) {
  if (isNotRequired && value != null && value.toString().isNotEmpty && !validateIFSC(value)) {
    return "please_enter_ifsc_code".tr;
  }
  return null;
}

String? emptyNotAllow({dynamic value,String errorMessage = "Empty not allowed", bool isRequired = true}) {
  if (isRequired && value != null && value.toString().isNotEmpty && validateText(value)) {
    return null;
  }
  return errorMessage;
}



validatePanNumber(value, {bool isNotRequired = true}) {
  if (isNotRequired && value != null && value.toString().isNotEmpty && !validatePAN(value)) {
    return "please_enter_pan_number".tr;
  }
  return null;
}

validateTinNumber(value, {bool isNotRequired = true}) {
  if (isNotRequired && value != null && value.toString().isNotEmpty && value.trim().length == 11) {
    return "please_enter_tin_number".tr;
  }
  return null;
}

validateCstNumber(value, {bool isNotRequired = true}) {
  if (isNotRequired && value != null && value.toString().isNotEmpty && value.trim().length == 11) {
    return "please_enter_cst_number".tr;
  }
  return null;
}

validateGstNumber(value, {bool isNotRequired = true}) {
  if (isNotRequired && value != null && value.toString().isNotEmpty && value.trim().length == 15) {
    return "please_enter_gst_number".tr;
  }
  return null;
}

validatePhoneNumber(value, {bool isNotRequired = true}) {
  if (isNotRequired && value != null && value.toString().isNotEmpty && value.trim().length == 10) {
    return "please_enter_phone_number".tr;
  }
  return null;
}

String? validatePassword(value) {
  if (value != null && value.trim().length > 7) {
    return null;
  } else {
    return "Please enter Password of at least Eight character";
  }
}
validateCountryName(value) {
  if (value != null && value.toString().isNotEmpty) {
    return null;
  } else {
    return "Please select country";
  }
}

String? matchPassword(value, String oldPassword) {
  if (value != null && value.trim().length > 7 && oldPassword.trim() == value.trim()) {
    return null;
  } else {
    return "Password not match.";
  }
}

String? validateMobileNumber(value, {bool isNotRequired = true}) {
  if (isNotRequired && (value == null || value.trim().length < 10 || value.trim().length > 15)) {
    return "Please enter valid Mobile Number";
  } else {
    return null;
  }
}

requiredValidateTextFormField(value, String text, {bool isNotRequired = true}) {
  if (isNotRequired && (value == null || value.trim().isEmpty)) {
    return text;
  }
  return null;
}

bool validateIFSC(String ifsc) {
  // Regular expression to match the IFSC format
  RegExp regex = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$');
  return regex.hasMatch(ifsc);
}

bool validateText(String text) {
  // Regular expression to match the IFSC format
  RegExp regex = RegExp(r'^[a-zA-Z]+$');
  return regex.hasMatch(text);
}

bool validateName(String name) {
  // Regular expression to match the IFSC format
  RegExp regex = RegExp(r'[A-Za-z]+');
  return regex.hasMatch(name);
}

bool validatePAN(String pan) {
  // Regular expression for PAN validation
  RegExp panRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$');
  return panRegex.hasMatch(pan);
}