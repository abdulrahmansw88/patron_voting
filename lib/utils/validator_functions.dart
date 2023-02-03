validateRequiredField(value,field){
  if(value.isEmpty){
    return "Invalid $field";
  }
}

validateEmail(String? value) {
  bool validMail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!);
  if(!validMail){
    return false;
  }else{
    return true;
  }
}