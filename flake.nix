{
  #description = "";

  inputs.nixpkgs.url = "github:nixOS/nixpkgs";
  inputs.fu.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, fu }:
    fu.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        #container must be called defaultPackage to be noticed
        defaultPackage = (import ./. { inherit pkgs; }).container;
        #shell must be called devShell to be noticed
        devShell = (import ./. { inherit pkgs; }).shell;
        #It seems that defaultPackage and devShell remove the need for calling an attribute. "nix develop" and "nix build" understand their targets.
        #TODO understand flakes
      });
}
