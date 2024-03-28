// public string FirstName { get; set; } = "";
// public string LastName { get; set; } = "";
// public string Email { get; set; } = "";
// public string Username { get; set; } = "";

class ActiveDirectoryDto {
  final String firstName;
  final String lastName;
  final String email;
  final String username;

  ActiveDirectoryDto({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.username = ''
  });

  factory ActiveDirectoryDto.fromJson(Map<String, dynamic> json) => ActiveDirectoryDto(
    firstName: json['firstName'] as String? ?? '',
    lastName: json['lastName'] as String? ?? '',
    email: json['email'] as String? ?? '',
    username: json['username'] as String? ?? ''
  );

  Map<String, dynamic> toJson() => {
    if (firstName.isNotEmpty) 'firstName': firstName,
    if (lastName.isNotEmpty) 'lastName': lastName,
    if (email.isNotEmpty) 'email': email,
    if (username.isNotEmpty) 'username': username
  };
}