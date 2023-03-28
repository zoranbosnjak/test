{ gitrev ? "devel"
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
  */

  envVars = ''
    export GITREV=${gitrev}
    export timestamp=$(git show -s --format=%ct)
  '';

  drv = packages.stdenv.mkDerivation {
    name = "comet-website";
    preBuild = envVars;
    src = ./.;
    buildInputs = [
      packages.git
      packages.zip
    ];
    installPhase = ''
      mkdir -p $out
      echo $timestamp > $out/index.html
      echo $GITREV >> $out/index.html
    '';
  };

in
  drv

