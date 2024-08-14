class User {
  final String id;
  final String name;
  final String role; // 'motorcyclist' or 'passenger'
  final String bio;
  final String profilePictureUrl;

  User({
    required this.id,
    required this.name,
    required this.role,
    required this.bio,
    required this.profilePictureUrl,
  });
}
