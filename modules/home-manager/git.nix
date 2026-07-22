{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Giacomo Di Clerico";
        email = "giacomodiclerico@gmail.com";
      };
      init = {
        defaultBranch = "main";
      };
    };
  };
}
