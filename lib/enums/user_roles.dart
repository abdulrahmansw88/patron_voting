enum UserRoles {
  character,
  admin,
  user,
}


returnUserRole(int index){
  switch(index){
    case 0 : UserRoles.character;
    return "Character";
    case 1 : UserRoles.admin;
    return "Admin";
    case 2 : UserRoles.user;
    return "User";
    break;
  }
}