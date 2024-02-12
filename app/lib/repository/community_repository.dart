import 'package:swipetivity_app/model/community.dart';

class CommunityRepository {
  final List<Community> communities = [
    const Community(
      id: 1,
      name: "Test Community",
      pin: "1234",
      members: [],
    ),
    const Community(
      id: 2,
      name: "Test Community 2",
      pin: "5678",
      members: [],
    ),
    const Community(
      id: 3,
      name: "Test Community 3",
      pin: "91011",
      members: [],
    ),
  ];

  Future<List<Community>> fetchCommunities() async {
    return Future.delayed(const Duration(seconds: 1), () {
      return communities;
    });
  }

  Future<Community> fetchCommunity(String pin) async {
    return Future.delayed(const Duration(seconds: 1), () {
      return communities.firstWhere((community) => community.pin == pin);
    });
  }

  Future<bool> joinCommunity(int communityId) async {
    return Future.delayed(const Duration(seconds: 1), () {
      return true;
    });
  }

  Future<bool> leaveCommunity(int communityId) async {
    return Future.delayed(const Duration(seconds: 1), () {
      return true;
    });
  }
}
