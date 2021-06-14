class StringService {
  RegExp _numeric = RegExp(r'^-?[0-9]+$');

  formatString(int length, String input) {
    if (input.length <= length) {
      return input;
    } else {
      return input.substring(0, length - 2) + '..';
    }
  }

  formatPrice(String money) {
    String result = '';
    int convertMoney = int.parse(money);
    money = convertMoney.toString();
    int count = 0;
    for (int i = money.length - 1; i >= 0; i--) {
      if (count == 3) {
        count = 1;
        result += ',';
      } else {
        count++;
      }
      result += money[i];
    }
    String need = '';
    for (int i = result.length - 1; i >= 0; i--) {
      need += result[i];
    }
    return need;
  }

  formatPhoneString(String phone) {
    return phone[0] == '0' ? phone : '0' + phone;
  }

  isNumeric(String input) {
    return _numeric.hasMatch(input);
  }
}
