{ ... }:
{
  imports = [ ];

  programs.git.aliases = {
    main = "symbolic-ref refs/remotes/origin/HEAD --short";
  };
}
