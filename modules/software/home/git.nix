{ user, ... }:

{
  programs.git = {
    enable = true;
    userName = user.fullName;
    userEmail = user.userEmail;
    extraConfig = {
      pull.rebase = true;
      advice.setUpstreamFailure = false;
    };
    diff-so-fancy.enable = true;
  };
}
