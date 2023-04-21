import 'package:equatable/equatable.dart';
import 'package:geniuspay/models/user_profile.dart';

class User extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String name;
  final bool houseAccount;
  final String avatar;
  final String dateJoined;
  final UserProfile userProfile;
  final bool isActive;
  final String? username;
  final String helloMessage;
  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.name,
    required this.houseAccount,
    required this.avatar,
    required this.dateJoined,
    required this.userProfile,
    required this.isActive,
    required this.username,
    required this.helloMessage,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      houseAccount: map['house_account'] ?? false,
      avatar: map['avatar'] ?? 'https://i.ibb.co/Zg5JKGJ/lion-1f981.png',
      isActive: map['is_active'],
      dateJoined: map['date_joined'] ?? '',
      userProfile: UserProfile.fromMap(map['profile']),
      username: map['username'] ?? '',
      helloMessage: map['hello']['message'] ?? '',
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      firstName,
      lastName,
      email,
      name,
      houseAccount,
      dateJoined,
      userProfile,
    ];
  }

  @override
  String toString() {
    return 'User(id: $id, firstName: $firstName, lastName: $lastName,username: $username, email: $email, name: $name, houseAccount: $houseAccount, avatar: $avatar, dateJoined: $dateJoined, userProfile: $userProfile)';
  }
}
