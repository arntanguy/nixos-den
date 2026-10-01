{
  perSystem.treefmt.settings.global.excludes = [
    ".claude/**"
    ".agents/**"
    ".github/*TEMPLATE*/*"
    ".github/CODEOWNERS"
    "docs/*"
    "Justfile"
    "AGENT*.md"
    "CLAUDE.md"
    "*.txt"
    "*.svg"
  ];
  perSystem.treefmt.programs.nixfmt.enable = true;
  perSystem.treefmt.programs.deadnix.enable = false;
  perSystem.treefmt.programs.nixf-diagnose.enable = false;
}
