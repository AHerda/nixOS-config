{ user, ... }:

{
  programs.git = {
    enable = true;
    userName = user.fullName;
    userEmail = user.userEmail;
  };
}
