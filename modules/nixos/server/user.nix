{ pkgs, ... }:

{
  # Root user configuration for server administration
  users.users.root = {
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      # Paste your public SSH key here (e.g. cat ~/.ssh/id_ed25519.pub)
      # "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI..."
    ];
  };
}
