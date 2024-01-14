import Trie "mo:base/Trie";
module {
  public type TAsset = {
    name : Text;
    address : Text;
    pincode : Text;
    image : Text;
    id : Nat;
    likes : Nat;
    owner : Principal;
    comments : List<Comment>;
  };

  public type User = {
    userName : Text;
    email : Text;
    profilePic : Text;
    id : Principal;
    stars : Nat;
  };

  public type Comment = {
    assetId : Nat;
    message : Text;
    sender : Principal;
    likes : Nat;
  };

  public type Like = {
    assetId : Nat;
    sender : Principal;
  };

  public type List<T> = ?(T, List<T>);

  public type Trie<K, V> = Trie.Trie<K, V>;
  public type Key<K> = Trie.Key<K>;
};
