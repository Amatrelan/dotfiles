{ lib, stdenv, openssl, pkg-config, fetchFromGitHub, my, rustPlatform, ... }:

stdenv.mkDerivation {
  pname = "bsp-layout";
  version = "0.0.9";

  src = fetchFromGitHub {
    repo = "bsp-layout";
    owner = "phenax";
    rev = "87e387355835e8bdd0f061cdbddb90933a7819c7";
    sha256 = "8YoCSXleLqxsCfyAzQrLoI5KLtG8lSEEf7qI1PZ8ZlU=";

  };

  phases = "installPhase";

  installPhase = ''
    mkdir -p $out/bin


  '';

  meta = with lib; {
    description =
      "With fw you have a configuration describing your workspace. It takes care of cloning projects and can run commands across your entire workspace.";
    homepage = "https://github.com/brocode/fw";
    license = licenses.wtfpl;
    maintainers = [ "" ];
  };
}
