///Program:  Palindrome Checker
///Author:  Justin Monubi Ogenche




/// Checks if the given string or number is a palindrome.
bool isPalindrome(dynamic input) {
  // Convert numeric input to string
  String s;
  if (input is String) {
    s = input;
  } else if (input is num) {
    s = input.toString();
  } else {
    throw ArgumentError('Input must be a String or a numeric value');
  }

  // Normalize the string: convert to lowercase and remove non-alphanumeric characters
  s = s.toLowerCase();
  s = s.replaceAll(RegExp(r'[^a-z0-9]'), '');

  // Check if the string is equal to its reverse
  return s == s.split('').reversed.join('');
}

void main() {
  // Test the function with different inputs
  print(isPalindrome("A man, a plan, a canal, Panama"));  // True
  print(isPalindrome("racecar"));  // True
  print(isPalindrome("hello"));    // False
  print(isPalindrome(12321));      // True
  print(isPalindrome(12345));      // False
}
