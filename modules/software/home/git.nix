{ user, ... }:

{
  programs = {
    git = {
      enable = true;
      # diff-so-fancy.enable = true;

      settings = {
        user = {
          name = user.fullName;
          email = user.userEmail;
        };

        pull.rebase = true;
        advice.setUpstreamFailure = false;
      };
    };
    difftastic = {
      enable = true;
      git.diffToolMode = true;
    };
  };
}
