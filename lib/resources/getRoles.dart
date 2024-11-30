enum UserRole {
  user,
  student,
  scholarStudent,
  applicants,
}

extension UserRoleExtension on UserRole {
  String get name {
    switch (this) {
      case UserRole.user:
        return 'User';
      case UserRole.student:
        return 'Student';
      case UserRole.scholarStudent:
        return 'Scholar Student';
      case UserRole.applicants:
        return 'Applicants';
      default:
        return '';
    }
  }

  // Helper method to convert enum to lowercase for case-insensitive comparison
  static UserRole? fromString(String role) {
    switch (role.toLowerCase()) {
      case 'user':
        return UserRole.user;
      case 'student':
        return UserRole.student;
      case 'scholar student':
        return UserRole.scholarStudent;
      case 'applicants':
        return UserRole.applicants;
      default:
        return UserRole.user; // Default role if no match is found
    }
  }
}

// Function to get Role based on the list of roles
UserRole getRoleFromList(List<String> roles) {
  for (var role in roles) {
    // Normalize the role string by converting it to lowercase
    var normalizedRole = role.trim().toLowerCase();

    // Use the `fromString` helper function to match the normalized role
    UserRole? userRole = UserRoleExtension.fromString(normalizedRole);
    if (userRole != UserRole.user) {
      return userRole!; // Return the first matching role (if not "User")
    }
  }
  return UserRole.user; // Default to "User" if no match is found
}

