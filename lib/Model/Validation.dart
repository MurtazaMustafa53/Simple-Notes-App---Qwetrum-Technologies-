class Validation {
  List<String> errors = [];

  String? emailValidation(String? value) {
    if (value!.isEmpty) {
      String error = "Email is required";
      errors.add(error);
      return error;
    }
    if (!value.contains("@") || !value.contains(".")) {
      String error = "Enter a valid Email Address";
      errors.add(error);
      return error;
    }
    return null;
  }

  String? passwordValidation(String? value) {
    if (value!.isEmpty) {
      String error = "Password is Required";
      errors.add(error);
      return error;
    }
    if (value.length < 8) {
      String error = "Password must be bigger than 8 charectors";
      errors.add(error);
      return error;
    }
    return null;
  }

  String? nameValidation(String? value) {
    if (value!.isEmpty) {
      String error = "Name is Required";
      errors.add(error);
      return error;
    }

    return null;
  }

  String? confirmPasswordValidation(String? value, String? password) {
    if (value!.isEmpty) {
      String error = "Please confirm your Password";
      errors.add(error);
      return error;
    }
    if (value != password) {
      String error = "Passwords do not Match";
      errors.add(error);
      return error;
    }
    return null;
  }
}
