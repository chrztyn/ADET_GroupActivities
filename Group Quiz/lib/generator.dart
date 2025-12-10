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

// Confirmation
// Student
print("\nWelcome ${s.name}");
print("You registered $email as your username");
print("Your student number: $studnum");
print("Your temporary password is: $tempPass\n");

// Employee
print("\nWelcome ${e.name}");
print("You registered $email as your username");
print("Your employee number: $empnum");
print("Your temporary password is: $tempPass\n");
