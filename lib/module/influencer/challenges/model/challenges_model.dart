class ChallengesModel {
  final String name;
  final String imageUrl;
  final String mediaType;
  final String status;
final int id;
  ChallengesModel(
      {required this.mediaType,required this.name, required this.imageUrl, required this.status,required this.id});
}

// List<ChallengesModel> approvedChallengesList = [
//   ChallengesModel(imageUrl: '', status: 'Inprogress', name: 'Challenge Name'),
//   ChallengesModel(imageUrl: '', status: 'Completed', name: 'Challenge Name'),
// ];

// List<ChallengesModel> unApprovedChallengesList = [
//   ChallengesModel(imageUrl: '', status: 'Pending', name: 'Challenge Name'),
//   ChallengesModel(imageUrl: '', status: 'Rejected', name: 'Challenge Name'),
// ];
