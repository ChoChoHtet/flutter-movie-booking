import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movies_booking/data/vos/card_vo.dart';
import 'package:movies_booking/persistence/hive_constants.dart';

part 'user_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_USER_ID,adapterName: "UserVOAdapter")
class UserVO {
  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "name")
  @HiveField(1)
  String? name;

  @JsonKey(name: "email")
  @HiveField(2)
  String? email;

  @JsonKey(name: "phone")
  @HiveField(3)
  String? phone;

  @JsonKey(name: "total_expense")
  @HiveField(4)
  int? totalExpense;

  @JsonKey(name: "profile_image")
  @HiveField(5)
  String? profileImage;

  @HiveField(6)
  String? token;

  @JsonKey(name: "cards")
  @HiveField(7)
  List<CardVO>? cards;

  String getToken() {
    return token != null ? "Bearer "+token! : "no token" ;
  }


  @override
  String toString() {
    return 'UserVO{id: $id, name: $name, email: $email, phone: $phone, totalExpense: $totalExpense, profileImage: $profileImage, token: $token, cards: $cards}';
  }


  UserVO(this.id, this.name, this.email, this.phone, this.totalExpense,
      this.profileImage, this.token, this.cards);

  factory UserVO.fromJson(Map<String,dynamic>json) => _$UserVOFromJson(json);
  Map<String,dynamic> toJson() => _$UserVOToJson(this);
}
