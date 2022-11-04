class postDetails {

  String? description;
  String? title;
  String? dateTime;
  String? imageURL;

  postDetails();

  void setURL(u){
    imageURL = u;
  }
  
  void setDescription(d){
    description = d;
  }

  void setTitle(t){
    title = t;
  }

  void setDateTime(d){
    dateTime = d;
  }

}