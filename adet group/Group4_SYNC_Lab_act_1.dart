import 'dart:io';

void main() {
  // Inputs
  stdout.write("Enter Student Name: ");
  String name = stdin.readLineSync() ?? "";

  //Input Validation
  int studentNumber = 0;
  while (true) {
    stdout.write("Enter Student Number: ");
    String? input = stdin.readLineSync();

    int? number = int.tryParse(input ?? "");

    if (number != null && number > 0) {
      studentNumber = number;
      break;
    } else {
      print("Invalid input. Please enter a positive whole number.");
    }
  }
  stdout.write("Enter Course (e.g., BSIT in Networking): ");
  String course = stdin.readLineSync() ?? "";

  //Input Validation
  int yearLevel = 0;
  while (true) {
    stdout.write("Enter Year Level (1-4): ");
    String? levelInput = stdin.readLineSync();

    int? level = int.tryParse(levelInput ?? "");
    if (level != null && level >= 1 && level <= 4) {
      yearLevel = level;
      break;
    } else {
      print("Invalid year level. Please enter a number from 1 to 4.");
    }
  }

  // Course code and units input
  List<String> courses = [];
  Map<String, int> units = {};

  print("\nEnter enrolled courses one by one.");
  print('Type "done" when you are finished.\n');

  while (true) {
    stdout.write("Enter course code (or 'done' to finish): ");
    String? courseInput = stdin.readLineSync();
    
    // Clean input
    if (courseInput == null) continue;

    courseInput = courseInput.trim().toUpperCase();

    if (courseInput?.toLowerCase() == 'done') {
      printSummary(courses, units, name, studentNumber, yearLevel, course);
      break;
    }

    if (courseInput == null || courseInput.isEmpty) {
      print("Invalid input. Please enter a course code.");
      continue;
    }

    //Check for duplicate course code
    if (courses.contains(courseInput)) {
      print("Course code already exists. Please enter a different course.");
      continue;
    }
    // Course code format validation 
    
    //(must start with a number and contain letters)
    RegExp coursePattern = RegExp(r'^[0-9][A-Za-z0-9]*$');
    if (!coursePattern.hasMatch(courseInput)) {
      print("Invalid course code format. Must start with a number and contain letters/numbers only.");
      continue;
    }
    // No spaces allowed
    if (courseInput.contains(' ')) {
      print("Invalid input. Course code cannot contain spaces.");
      continue;
      }

    // Input validation for units
    int courseUnits = 0;
    while (true) {
      stdout.write("Enter number of units for $courseInput: ");
      String? unitsInput = stdin.readLineSync();

      int? parsedUnits = int.tryParse(unitsInput ?? "");

      if (parsedUnits != null && parsedUnits > 0) {
        courseUnits = parsedUnits;
        break;
      } else {
        print("Invalid input. Please enter a positive whole number.");
      }
    }
    courses.add(courseInput);
    units[courseInput] = courseUnits;
    print("Added: $courseInput ($courseUnits units)");
  }
}

// Print summary 
void printSummary(List<String> courses, Map<String, int> units, String name, int studentNumber, int yearLevel, String course) {
  // Sorting courses alphabetically
  courses.sort();
  // Compute totals
  int totalSubjects = courses.length;
  int totalUnits = units.values.fold(0, (sum, val) => sum + val);

  // Convert year level to readable format
  String yearText;
  switch (yearLevel) {
    case 1:
      yearText = "1st Year";
      break;
    case 2:
      yearText = "2nd Year";
      break;
    case 3:
      yearText = "3rd Year";
      break;
    case 4:
      yearText = "4th Year";
      break;
    default:
      yearText = "$yearLevel Year";
    }
    print("\n========== SUMMARY ==========");
    print("Name: $name");
    print("Student number: $studentNumber");
    print("Course: $course");
    print("Year Level: $yearText\n");

    print("Enrolled Courses:");
    for (var c in courses) {
      print("- $c (${units[c]} units)");
    }

    print("\nTotal Subjects: $totalSubjects");
    print("Total Units: $totalUnits");
    print("=============================");
  }
