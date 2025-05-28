// To parse this JSON data, do
//
//     final signInModel = signInModelFromJson(jsonString);

import 'dart:convert';

SignInModel signInModelFromJson(String str) => SignInModel.fromJson(json.decode(str));

String signInModelToJson(SignInModel data) => json.encode(data.toJson());

class SignInModel {
  final int? status;
  final String? message;
  final Data? data;

  SignInModel({
    this.status,
    this.message,
    this.data,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? countryCode;
  final String? mobile;
  final String? email;
  final String? profileImage;
  final HideAlbum? notification;
  final HideAlbum? isLike;
  final HideAlbum? isComment;
  final HideAlbum? isDownload;
  final HideAlbum? isUpload;
  final bool? isPendingUpdate;
  final int? relationshipToChild;
  final int? totalTags;
  final int? preminumTagLimit;
  final HideAlbum? isHigh;
  final String? lang;
  final String? supportEmail;
  final HideAlbum? hideAlbum;
  final String? totalPaidCredit;
  final String? totalFreeCredit;
  final String? totalAvailableCredit;
  final bool? isTourComplete;
  final bool? isSubscribeByAdmin;
  final String? adminSubscribeEndDate;
  final String? referalCode;
  final bool? aiReadDot;
  final List<Album>? albums;
  final String? token;
  final bool? isSubscribe;
  final dynamic subscription;
  final int? remainingDays;

  Data({
    this.id,
    this.firstName,
    this.lastName,
    this.countryCode,
    this.mobile,
    this.email,
    this.profileImage,
    this.notification,
    this.isLike,
    this.isComment,
    this.isDownload,
    this.isUpload,
    this.isPendingUpdate,
    this.relationshipToChild,
    this.totalTags,
    this.preminumTagLimit,
    this.isHigh,
    this.lang,
    this.supportEmail,
    this.hideAlbum,
    this.totalPaidCredit,
    this.totalFreeCredit,
    this.totalAvailableCredit,
    this.isTourComplete,
    this.isSubscribeByAdmin,
    this.adminSubscribeEndDate,
    this.referalCode,
    this.aiReadDot,
    this.albums,
    this.token,
    this.isSubscribe,
    this.subscription,
    this.remainingDays,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    countryCode: json["country_code"],
    mobile: json["mobile"],
    email: json["email"],
    profileImage: json["profile_image"],
    notification: hideAlbumValues.map[json["notification"]]!,
    isLike: hideAlbumValues.map[json["is_like"]]!,
    isComment: hideAlbumValues.map[json["is_comment"]]!,
    isDownload: hideAlbumValues.map[json["is_download"]]!,
    isUpload: hideAlbumValues.map[json["is_upload"]]!,
    isPendingUpdate: json["is_pending_update"],
    relationshipToChild: json["relationship_to_child"],
    totalTags: json["total_tags"],
    preminumTagLimit: json["preminum_tag_limit"],
    isHigh: hideAlbumValues.map[json["is_high"]]!,
    lang: json["lang"],
    supportEmail: json["support_email"],
    hideAlbum: hideAlbumValues.map[json["hide_album"]]!,
    totalPaidCredit: json["total_paid_credit"],
    totalFreeCredit: json["total_free_credit"],
    totalAvailableCredit: json["total_available_credit"],
    isTourComplete: json["is_tour_complete"],
    isSubscribeByAdmin: json["is_subscribe_by_admin"],
    adminSubscribeEndDate: json["admin_subscribe_end_date"],
    referalCode: json["referal_code"],
    aiReadDot: json["ai_read_dot"],
    albums: json["albums"] == null ? [] : List<Album>.from(json["albums"]!.map((x) => Album.fromJson(x))),
    token: json["token"],
    isSubscribe: json["is_subscribe"],
    subscription: json["subscription"],
    remainingDays: json["remaining_days"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "country_code": countryCode,
    "mobile": mobile,
    "email": email,
    "profile_image": profileImage,
    "notification": hideAlbumValues.reverse[notification],
    "is_like": hideAlbumValues.reverse[isLike],
    "is_comment": hideAlbumValues.reverse[isComment],
    "is_download": hideAlbumValues.reverse[isDownload],
    "is_upload": hideAlbumValues.reverse[isUpload],
    "is_pending_update": isPendingUpdate,
    "relationship_to_child": relationshipToChild,
    "total_tags": totalTags,
    "preminum_tag_limit": preminumTagLimit,
    "is_high": hideAlbumValues.reverse[isHigh],
    "lang": lang,
    "support_email": supportEmail,
    "hide_album": hideAlbumValues.reverse[hideAlbum],
    "total_paid_credit": totalPaidCredit,
    "total_free_credit": totalFreeCredit,
    "total_available_credit": totalAvailableCredit,
    "is_tour_complete": isTourComplete,
    "is_subscribe_by_admin": isSubscribeByAdmin,
    "admin_subscribe_end_date": adminSubscribeEndDate,
    "referal_code": referalCode,
    "ai_read_dot": aiReadDot,
    "albums": albums == null ? [] : List<dynamic>.from(albums!.map((x) => x.toJson())),
    "token": token,
    "is_subscribe": isSubscribe,
    "subscription": subscription,
    "remaining_days": remainingDays,
  };
}

class Album {
  final int? id;
  final String? name;
  final String? profileImage;
  final String? userRole;
  final String? isChanged;
  final String? isHighlight;
  final String? isInviteChanged;
  final DateTime? createdAt;
  final bool? isAlbumHavePhoto;
  final int? aiAlbumId;
  final List<Child>? children;
  final List<Member>? members;

  Album({
    this.id,
    this.name,
    this.profileImage,
    this.userRole,
    this.isChanged,
    this.isHighlight,
    this.isInviteChanged,
    this.createdAt,
    this.isAlbumHavePhoto,
    this.aiAlbumId,
    this.children,
    this.members,
  });

  factory Album.fromJson(Map<String, dynamic> json) => Album(
    id: json["id"],
    name: json["name"],
    profileImage: json["profile_image"],
    userRole: json["user_role"],
    isChanged: json["is_changed"],
    isHighlight: json["is_highlight"],
    isInviteChanged: json["is_invite_changed"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    isAlbumHavePhoto: json["is_album_have_photo"],
    aiAlbumId: json["ai_album_id"],
    children: json["children"] == null ? [] : List<Child>.from(json["children"]!.map((x) => Child.fromJson(x))),
    members: json["members"] == null ? [] : List<Member>.from(json["members"]!.map((x) => Member.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "profile_image": profileImage,
    "user_role": userRole,
    "is_changed": isChanged,
    "is_highlight": isHighlight,
    "is_invite_changed": isInviteChanged,
    "created_at": createdAt?.toIso8601String(),
    "is_album_have_photo": isAlbumHavePhoto,
    "ai_album_id": aiAlbumId,
    "children": children == null ? [] : List<dynamic>.from(children!.map((x) => x.toJson())),
    "members": members == null ? [] : List<dynamic>.from(members!.map((x) => x.toJson())),
  };
}

class Child {
  final int? id;
  final String? name;
  final String? gender;
  final String? birthDate;

  Child({
    this.id,
    this.name,
    this.gender,
    this.birthDate,
  });

  factory Child.fromJson(Map<String, dynamic> json) => Child(
    id: json["id"],
    name: json["name"],
    gender: json["gender"],
    birthDate: json["birth_date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "gender": gender,
    "birth_date": birthDate,
  };
}

class Member {
  final int? id;
  final String? name;
  final String? profileImage;
  final String? email;
  final int? relationId;
  final String? relation;
  final Role? role;
  final HideAlbum? isLike;
  final HideAlbum? isComment;
  final HideAlbum? isDownload;
  final HideAlbum? isUpload;

  Member({
    this.id,
    this.name,
    this.profileImage,
    this.email,
    this.relationId,
    this.relation,
    this.role,
    this.isLike,
    this.isComment,
    this.isDownload,
    this.isUpload,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    id: json["id"],
    name: json["name"],
    profileImage: json["profile_image"],
    email: json["email"],
    relationId: json["relation_id"],
    relation: json["relation"],
    role: roleValues.map[json["role"]]!,
    isLike: hideAlbumValues.map[json["is_like"]]!,
    isComment: hideAlbumValues.map[json["is_comment"]]!,
    isDownload: hideAlbumValues.map[json["is_download"]]!,
    isUpload: hideAlbumValues.map[json["is_upload"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "profile_image": profileImage,
    "email": email,
    "relation_id": relationId,
    "relation": relation,
    "role": roleValues.reverse[role],
    "is_like": hideAlbumValues.reverse[isLike],
    "is_comment": hideAlbumValues.reverse[isComment],
    "is_download": hideAlbumValues.reverse[isDownload],
    "is_upload": hideAlbumValues.reverse[isUpload],
  };
}

enum HideAlbum {
  NO,
  YES
}

final hideAlbumValues = EnumValues({
  "no": HideAlbum.NO,
  "yes": HideAlbum.YES
});

enum Role {
  ADMIN,
  MEMBER
}

final roleValues = EnumValues({
  "admin": Role.ADMIN,
  "member": Role.MEMBER
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
