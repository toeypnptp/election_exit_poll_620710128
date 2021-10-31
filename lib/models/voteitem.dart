class VoteItem {
  final int number;
  final String title;
  final String firstName;
  final String lastName;
  VoteItem({
    required this.number,
    required this.title,
    required this.firstName,
    required this.lastName,
  });

  factory VoteItem.fromJson(Map<String, dynamic> json) {
    return VoteItem(
      number: json['number'],
      title: json['title'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }

}