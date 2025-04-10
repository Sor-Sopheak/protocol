class TextFieldValidator {
  static String? numberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Value field cannot be empty';
    }
    final numberRegex = RegExp(r'^\d+$');
    if (!numberRegex.hasMatch(value)) {
      return 'Please enter a valid number';
    }

    final number = int.tryParse(value);
    if (number == null || number <= 0) {
      return 'Please enter a number greater than 0';
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }
}