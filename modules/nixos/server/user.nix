{ pkgs, ... }:

{
  # Root user configuration for server administration
  users.users.root = {
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINZZII1621J/ZJA4p0F5DDZIMeLJ7cg/M1WZynetxpP8 mishow@misharch"
    ];
  };
}
