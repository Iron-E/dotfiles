{ ... }:
{
  imports = [ ];

  programs.git.aliases = {
    graph = "log --graph --pretty=format:'%C(#ffb7b7)%h%C(reset bold) %an%C(reset) %s %C(#ff4090)(%cr)%C(bold #ffa6ff)%d%C(reset)' --abbrev-commit --date=relative";
    main = "symbolic-ref refs/remotes/origin/HEAD --short";
  };
}
