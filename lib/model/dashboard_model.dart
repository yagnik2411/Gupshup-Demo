List<DashboardModel> dashboardList = <DashboardModel>[] ;

class DashboardModel {
  late String fromUser;
  late String postedTime;
  late String spostedTime;
  late String text;
  late String imageUrl;
  late String id;
  late int fromuserid;
  late String profileUrl;
  late String groupname;
  late String groupUrl;
  late String type;
  late int groupid;
  late int isrestricted;
  late int isSaved;
  late String next;

  DashboardModel(
      {required this.fromUser,
      required this.postedTime,
      required this.spostedTime,
      required this.text,
      required this.imageUrl,
      required this.id,
      required this.fromuserid,
      required this.profileUrl,
      required this.groupname,
      required this.groupUrl,
      required this.type,
      required this.groupid,
      required this.isrestricted,
      required this.isSaved,
      required this.next});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    fromUser = json['fromUser'];
    postedTime = json['postedTime'];
    spostedTime = json['spostedTime'];
    text = json['text'];
    imageUrl = json['imageUrl'];
    id = json['id'];
    fromuserid = json['fromuserid'];
    profileUrl = json['profileUrl'];
    groupname = json['groupname'];
    groupUrl = json['groupUrl'];
    type = json['type'];
    groupid = json['groupid'];
    isrestricted = json['isrestricted'];
    isSaved = json['isSaved'];
    next = json['next'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fromUser'] = fromUser;
    data['postedTime'] = postedTime;
    data['spostedTime'] = spostedTime;
    data['text'] = text;
    data['imageUrl'] = imageUrl;
    data['id'] = id;
    data['fromuserid'] = fromuserid;
    data['profileUrl'] = profileUrl;
    data['groupname'] = groupname;
    data['groupUrl'] = groupUrl;
    data['type'] = type;
    data['groupid'] = groupid;
    data['isrestricted'] = isrestricted;
    data['isSaved'] = isSaved;
    data['next'] = next;
    return data;
  }
}
