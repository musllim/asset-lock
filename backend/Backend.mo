import List "mo:base/List";
import TrieMap "mo:base/TrieMap";
import Nat "mo:base/Nat";
import Hash "mo:base/Hash";
import Iter "mo:base/Iter";
import Trie "mo:base/Trie";
import Text "mo:base/Text";
import Types "./Types";

shared (msg) actor class Backend() {
  func key(t : Text) : Types.Key<Text> { { hash = Text.hash t; key = t } };

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

  public shared (msg) func createComment(message : Text, assetId : Nat) {
    let comment : Types.Comment = {
      assetId;
      message;
      sender = msg.caller;
      likes = 0;
    };
    let foundAsset = await findAssetById(assetId);
    switch (foundAsset) {
      case (?asset) {
        let updatedComments = List.push(comment, asset.comments);
      };
      case (null) {};
    };
  };

  public shared (msg) func findAssetById(assetId : Nat) : async ?Types.TAsset {
    List.find<Types.TAsset>(assets, func(n : Types.TAsset) : Bool { n.id == assetId });
  };

  public query func getAssets() : async Types.List<Types.TAsset> {
    assets;
  };
};
