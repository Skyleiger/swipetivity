import 'package:swipetivity_app/exception/community_exceptions.dart';
import 'package:swipetivity_app/model/community.dart';
import 'package:swipetivity_app/model/community_member.dart';
import 'package:swipetivity_app/model/user.dart';
import 'package:swipetivity_app/repository/auth_repository.dart';

class CommunityRepository {
  final List<Community> communities = [
    Community(
      id: 1,
      name: "Test Community",
      pin: "4321",
      members: [
        CommunityMember(
          id: 1,
          user: baseAccount,
          joinedAt: DateTime.now(),
        ),
      ],
    ),
    Community(
      id: 2,
      name: "Test Community 2",
      pin: "5678",
      members: [
        CommunityMember(
          id: 1,
          user: baseAccount,
          joinedAt: DateTime.now(),
        ),
      ],
    ),
    Community(
      id: 3,
      name: "Test Community 3",
      pin: "91011",
      members: [
        CommunityMember(
          id: 1,
          user: baseAccount,
          joinedAt: DateTime.now(),
        ),
      ],
    ),
    const Community(
      id: 4,
      name: "Test Community 4",
      pin: "1234",
      members: [],
    ),
  ];

  late final Map<User, List<Community>> userCommunities;

  CommunityRepository() {
    userCommunities = {
      baseAccount: [
        communities[0],
        communities[1],
        communities[2],
      ],
    };
  }

  Future<List<Community>> fetchCommunities(User user) async {
    return Future.delayed(const Duration(seconds: 1), () {
      return userCommunities[user] ?? [];
    });
  }

  Future<Community> fetchCommunityByPin(String pin) {
    return Future.delayed(const Duration(seconds: 1), () {
      return communities.firstWhere((community) {
        return community.pin == pin;
      }, orElse: () {
        throw CommunityByPinNotFoundException(pin: pin);
      });
    });
  }

  Future<Community> joinCommunity(Community community, User user) async {
    return Future.delayed(const Duration(seconds: 1), () {
      if (community.hasMember(user)) {
        throw UserAlreadyInCommunityException(community: community, user: user);
      }

      return community.copyWith(
        members: [
          ...community.members,
          CommunityMember(
            id: 0,
            user: user,
            joinedAt: DateTime.now(),
          ),
        ],
      );
    });
  }

  Future<Community> leaveCommunity(Community community, User user) async {
    return Future.delayed(const Duration(seconds: 1), () {
      if (!community.hasMember(user)) {
        throw UserNotInCommunityException(community: community, user: user);
      }

      return community.copyWith(
        members:
            community.members.where((member) => member.user != user).toList(),
      );
    });
  }
}
