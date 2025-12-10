import 'dart:math';

// Username Generator
String generateUsername(String name, int id) {
  return "${name[0].toLowerCase()}$id";
}

// Password Generator
String generateTempPassword() {
  const chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  Random rand = Random();
  return List.generate(10, (index) => chars[rand.nextInt(chars.length)]).join();
}
