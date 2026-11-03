# VSCode base configuration
# Highly opinionated
{ den, ... }:
{
  # User-specific terminal interfaces, CLIs, and GUIs
  den.aspects.devel.vscode = {
    includes = [
      (den.batteries.unfree [
        "copilot-language-server"
        "vscode"
        "vscode-extension-ms-vscode-remote-remote-containers"
      ])
    ];
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [ clang-tools ];
        programs = {
          vscode = {
            # or vscodium for opensource
            enable = true;
            #package = pkgs.vscodium;
            package =
              let
                # This contain coreutils and a 'id' binary not configured for LDAP,
                # so at LAAS, vscode 'id -u -n' fails
                id-link = pkgs.runCommand "id-link" { } ''
                  mkdir -p $out/bin
                  ln -s /usr/bin/id $out/bin/id
                '';
              in
              pkgs.vscode.overrideAttrs (super: {
                autoPatchelfIgnoreMissingDeps = (super.autoPatchelfIgnoreMissingDeps or [ ]) ++ [
                  "libxkbfile.so.1"
                ];
                buildInputs = (super.buildInputs or [ ]) ++ [ pkgs.libxkbfile ];
                preFixup = super.preFixup + ''
                  gappsWrapperArgs+=(
                    --prefix PATH : ${id-link}/bin
                    --add-flags --no-sandbox
                  )
                '';
              });

            profiles.default.extensions = with pkgs.vscode-extensions; [
              mkhl.direnv
              ms-vscode.cmake-tools
              llvm-vs-code-extensions.vscode-clangd # Replaces ms-vscode.cpptools
              ms-vscode-remote.remote-containers
              ms-python.python
              github.vscode-github-actions
              redhat.vscode-yaml
            ];
          };
        };
      };
  };
}
