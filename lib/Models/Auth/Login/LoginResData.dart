class LoginResData {
  LoginResData({
    this.key,
    this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.type,
    this.name,
  });

  int key;
  String accessToken;
  String tokenType;
  int expiresIn;
  String type;
  String name;

  factory LoginResData.fromJson(Map<String, dynamic> json) => LoginResData(
    key:json["key"] == null ? null : json["key"],
    accessToken:json["access_token"] == null ? null : json["access_token"],
    tokenType:json["token_type"] == null ? null : json["token_type"],
    expiresIn:json["expires_in"] == null ? null : json["expires_in"],
    type:json["type"] == null ? null : json["type"],
    name:json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "key":key == null ? null : key,
    "access_token":accessToken == null ? null : accessToken,
    "token_type":tokenType == null ? null : tokenType,
    "expires_in":expiresIn == null ? null : expiresIn,
    "type":type == null ? null : type,
    "name":name == null ? null : name,
  };
}
