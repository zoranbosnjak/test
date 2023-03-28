{ gitrev ? null
}:

let
  sources = import ./nix/sources.nix;
  packages = import sources.nixpkgs {};

  /*
  shortGitrev = builtins.substring 0 7 gitrev;
  haskellPackages = packages.haskellPackages;

  codeGenerator = import ./code-generator/default.nix { inShell = false; };

  aspecsRef = builtins.fromJSON (builtins.readFile ./nix/aspecs.json);
  aspecsDir = packages.fetchgit {
    url = aspecsRef.url;
    rev = aspecsRef.rev;
    sha256 = aspecsRef.sha256;
  };

  site = haskellPackages.callCabal2nix "website" ./. { };

  env = packages.stdenv.mkDerivation rec {
    name = "website-devel-environment";
    buildInputs = site.env.nativeBuildInputs ++ [
    ];
    shellHook = envVars;
  };

  libPython = import ../support/Language/Python/lib.nix { reference = "todo"; };

  envVars = ''
    export SHORT_GITREV=${shortGitrev}
  '';
  */

  envVars = ''
  '';

  drv = packages.stdenv.mkDerivation {
    name = "comet-website";
    preBuild = envVars;
    src = ./.;
    buildInputs = [
      packages.zip
    ];
    installPhase = ''
      mkdir -p $out
      echo "Hello World..." > $out/index.html
    '';
  };

in
  drv

