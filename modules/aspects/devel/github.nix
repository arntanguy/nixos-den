# Development Tools Split
{ den, inputs, ... }:
{
  # User-specific terminal interfaces, CLIs, and GUIs
  den.aspects.devel.github = {
    includes = [
      (den.batteries.unfree [
        "github-copilot-cli"
      ])
    ];
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          # GitHub & CI/CD User Workflow
          gh # GitHub CLI
          gh-f # GitHub CLI fzf extension
          github-copilot-cli # Agentic CLI
          act # Run GitHub Actions locally in Docker
          act3 # Glance at recent GitHub Actions runs
        ];
      };
  };
}
