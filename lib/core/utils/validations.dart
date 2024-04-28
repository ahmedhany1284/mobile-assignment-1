enum ValidationType {
  none,
  email,
  text,
  password,
  confirmPassword,
  name,
  gender,
  number,


}

bool isValidBirthdate(DateTime birthdate) {
  DateTime currentDate = DateTime.now();

  DateTime minBirthdate = currentDate.subtract(const Duration(days: 365 * 100));
  DateTime maxBirthdate = currentDate;

  // Check if the birthdate is within the valid range
  return birthdate.isAfter(minBirthdate) && birthdate.isBefore(maxBirthdate);
}

bool isContainSpecialCharacters(String input) {
  for (int i = 0, len = input.length; i < len; ++i) {
    int ascii = input.codeUnitAt(i);
    // range (65 - 90) for upper letters , range(97 - 122) lower letters , 32 for space
    if ((ascii >= 65 && ascii <= 90) ||
        (ascii >= 97 && ascii <= 122) ||
        ascii == 32) continue;
    return true;
  }
  return false;
}

bool isContainNumbers(String input) {
  for (int i = 0, len = input.length; i < len; ++i) {
    int ascii = input.codeUnitAt(i);
    // range (48 - 57) for digits from 0 to 9
    if ((ascii >= 48 && ascii <= 57)) return true;
  }
  return false;
}
//
// RegExp emailRegex = RegExp(
//     r'^[0-9]+@stud\.fci-cu\.edu\.eg$',);

String? isRequired(String val, String fieldName) {
  if (val == '') {
    return 'requiredError';
  }
  return null;
}

String? checkPasswordLength(String val) {
  if (val.length < 8) {
    return 'passLenError';
  }
  return null;
}

String? checkFieldValidation(
    {required String? val,
    required String fieldName,
    required ValidationType fieldType,
    String? confirmPass}) {
  String? errorMsg;

  if (fieldType == ValidationType.text) {
    errorMsg = isRequired(val!, fieldName);
  }

  if (fieldType == ValidationType.name) {
    if (isRequired(val!, fieldName) != null) {
      errorMsg = isRequired(val, fieldName);
    } else if (isContainNumbers(val)) {
      errorMsg = 'digitText';
    } else if (isContainSpecialCharacters(val)) {
      errorMsg = 'specialText';
    }
  }


  if (fieldType == ValidationType.email) {
    if (isRequired(val!, fieldName) != null) {
      errorMsg = isRequired(val, fieldName);
    }
    // else if (!emailRegex.hasMatch(val)) {
    //   errorMsg = 'emailError';
    // }
  }

  if (fieldType == ValidationType.password) {
    if (isRequired(val!, fieldName) != null) {
      errorMsg = isRequired(val, fieldName);
    } else if (checkPasswordLength(val) != null) {
      errorMsg = checkPasswordLength(val);
    }
  }

  if (fieldType == ValidationType.confirmPassword) {
    if (isRequired(val!, fieldName) != null) {
      errorMsg = isRequired(val, fieldName);
    } else if (checkPasswordLength(val) != null) {
      errorMsg = checkPasswordLength(val);
    } else if (val != confirmPass) {
      errorMsg = 'passNotMatch';
    }
  }


  if (fieldType == ValidationType.gender) {
    if (isRequired(val!, fieldName) != null) {
      errorMsg = isRequired(val, fieldName);
    }

    else if (val != 'male' || val != 'female') {
      errorMsg = 'genderError';
    }
  }
  if (fieldType == ValidationType.number) {
    if (isRequired(val!, fieldName) != null) {
      errorMsg = isRequired(val, fieldName);
    } else if (val.length < 8) {
      errorMsg = 'Id Error';
    } else if (val.length > 8) {
      errorMsg = 'Id Error';
    }
  }

  return (errorMsg != null) ? errorMsg : null;
}
