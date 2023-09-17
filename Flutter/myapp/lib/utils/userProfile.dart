/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
class Identity {
  String? provider;
  String? accesstoken;
  int? expiresin;
  String? userid;
  String? connection;
  bool? isSocial;

  Identity(
      {this.provider,
      this.accesstoken,
      this.expiresin,
      this.userid,
      this.connection,
      this.isSocial});

  Identity.fromJson(Map<String, dynamic> json) {
    provider = json['provider'];
    accesstoken = json['access_token'];
    expiresin = json['expires_in'];
    userid = json['user_id'];
    connection = json['connection'];
    isSocial = json['isSocial'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['provider'] = provider;
    data['access_token'] = accesstoken;
    data['expires_in'] = expiresin;
    data['user_id'] = userid;
    data['connection'] = connection;
    data['isSocial'] = isSocial;
    return data;
  }
}

class Root {
  String? email;
  bool? emailverified;
  String? name;
  String? givenname;
  String? familyname;
  String? picture;
  String? gender;
  String? locale;
  String? updatedat;
  String? userid;
  String? nickname;
  List<Identity?>? identities;
  String? createdat;
  String? lastip;
  String? lastlogin;
  int? loginscount;

  Root(
      {this.email,
      this.emailverified,
      this.name,
      this.givenname,
      this.familyname,
      this.picture,
      this.gender,
      this.locale,
      this.updatedat,
      this.userid,
      this.nickname,
      this.identities,
      this.createdat,
      this.lastip,
      this.lastlogin,
      this.loginscount});

  Root.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    emailverified = json['email_verified'];
    name = json['name'];
    givenname = json['given_name'];
    familyname = json['family_name'];
    picture = json['picture'];
    gender = json['gender'];
    locale = json['locale'];
    updatedat = json['updated_at'];
    userid = json['user_id'];
    nickname = json['nickname'];
    if (json['identities'] != null) {
      identities = <Identity>[];
      json['identities'].forEach((v) {
        identities!.add(Identity.fromJson(v));
      });
    }
    createdat = json['created_at'];
    lastip = json['last_ip'];
    lastlogin = json['last_login'];
    loginscount = json['logins_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['email'] = email;
    data['email_verified'] = emailverified;
    data['name'] = name;
    data['given_name'] = givenname;
    data['family_name'] = familyname;
    data['picture'] = picture;
    data['gender'] = gender;
    data['locale'] = locale;
    data['updated_at'] = updatedat;
    data['user_id'] = userid;
    data['nickname'] = nickname;
    data['identities'] = identities != null
        ? identities!.map((v) => v?.toJson()).toList()
        : null;
    data['created_at'] = createdat;
    data['last_ip'] = lastip;
    data['last_login'] = lastlogin;
    data['logins_count'] = loginscount;
    return data;
  }
}
