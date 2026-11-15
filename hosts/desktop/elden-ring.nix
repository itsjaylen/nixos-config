{ username, ... }:
{
  programs.elden-ring-convergence = {
    enable = true;
    user = username;
    installDirectory = "/home/${username}/Games/ConvergenceER";
  };
}