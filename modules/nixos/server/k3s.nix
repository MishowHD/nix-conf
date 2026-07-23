{ pkgs, ... }:

{
  # K3s service configuration
  services.k3s = {
    enable = true;
    role = "server";
  };

  # Environment variables for Kubernetes
  environment.variables = {
    KUBECONFIG = "/etc/rancher/k3s/k3s.yaml";
  };

  # Automatically create required Kubelet plugin directories
  systemd.tmpfiles.rules = [
    "d /var/lib/kubelet/plugins 0755 root root -"
    "d /var/lib/kubelet/plugins_registry 0755 root root -"
  ];

  # Kubernetes CLI tools
  environment.systemPackages = with pkgs; [
    k3s
    k9s
    kubectl
  ];
}
