class StringService {
  formatString(int length, String input) {
    if (input.length <= length) {
      return input;
    } else {
      return input.substring(0, length - 2) + '..';
    }
  }
}
