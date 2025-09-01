// enum UserRole {
//   user,
//   student,
//   scholarStudent,
//   applicants,
// }
//
// extension UserRoleExtension on UserRole {
//   String get name {
//     switch (this) {
//       case UserRole.user:
//         return 'User';
//       case UserRole.student:
//         return 'Student';
//       case UserRole.scholarStudent:
//         return 'Scholar Student';
//       case UserRole.applicants:
//         return 'Applicants';
//       default:
//         return '';
//     }
//   }
//
//   // Helper method to convert enum to lowercase for case-insensitive comparison
//   static UserRole? fromString(String role) {
//     switch (role.toLowerCase()) {
//       case 'user':
//         return UserRole.user;
//       case 'student':
//         return UserRole.student;
//       case 'scholar student':
//         return UserRole.scholarStudent;
//       case 'applicants':
//         return UserRole.applicants;
//       default:
//         return UserRole.user; // Default role if no match is found
//     }
//   }
// }
//
// // Function to get Role based on the list of roles
// UserRole getRoleFromList(List<String> roles) {
//   for (var role in roles) {
//     // Normalize the role string by converting it to lowercase
//     var normalizedRole = role.trim().toLowerCase();
//
//     // Use the `fromString` helper function to match the normalized role
//     UserRole? userRole = UserRoleExtension.fromString(normalizedRole);
//     if (userRole != UserRole.user) {
//       return userRole!; // Return the first matching role (if not "User")
//     }
//   }
//   return UserRole.user; // Default to "User" if no match is found
// }
//

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
    }
  }

  // Convert string to UserRole
  static UserRole fromString(String role) {
    switch (role.trim().toLowerCase()) {
      case 'scholar student':
        return UserRole.scholarStudent;
      case 'student':
        return UserRole.student;
      case 'applicants':
        return UserRole.applicants;
      case 'user':
      default:
        return UserRole.user;
    }
  }
}

// Function to get role based on priority
UserRole getRoleFromList(List<String> roles) {
  // Define priority (higher index → lower priority)
  final priority = [
    UserRole.scholarStudent,
    UserRole.applicants,
    UserRole.student,
    UserRole.user
  ];

  // Convert all roles to enum
  final userRoles = roles.map((r) => UserRoleExtension.fromString(r)).toSet();

  // Find the highest priority role present
  for (var role in priority) {
    if (userRoles.contains(role)) {
      return role;
    }
  }

  return UserRole.user; // Default
}
