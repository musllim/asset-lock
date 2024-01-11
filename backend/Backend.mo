import List "mo:base/List";
import Types "./Types";

shared (msg) actor class Backend() {

  stable var users : Types.List<Types.User> = List.nil();

  public shared (msg) func createUser(_userName : Text, _email : Text) : async () {
    let user = {
      userName = _userName;
      email = _email;
      id = msg.caller;
      stars = 0;
      profilePic = "";
    };

    users := List.push(user, users);
  };

  public query func getUsers() : async Types.List<Types.User> {
    users;
  };

  let owner = msg.caller;

  stable var assets : Types.List<Types.TAsset> = List.nil();

  public func createAsset(
    _name : Text,
    _address : Text,
    _pincode : Text,
    _image : Text,
    _owner : Principal,

  ) {
    assert (owner == msg.caller);

    let asset = {
      id = List.size(assets);
      name = _name;
      address = _address;
      pincode = _pincode;
      image = _image;
      likes = 0;
      owner = _owner;
      comments = List.nil();
    };
    assets := List.push(asset, assets);
  };

  public query func getAssets() : async Types.List<Types.TAsset> {
    assets;
  };
};
