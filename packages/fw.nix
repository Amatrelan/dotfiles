{ lib, stdenv, openssl, pkg-config, fetchFromGitHub, my, rustPlatform, ... }:

rustPlatform.buildRustPackage rec {
  pname = "fw";
  version = "v2.7.0";

  src = fetchFromGitHub {
    repo = pname;
    owner = "brocode";
    rev = "07e387355835e8bdd0f061cdbddb90933a7819c7";
    sha256 = "9YoCSXleLqxsCfyAzQrLoI5KLtG8lSEEf7qI1PZ8ZlU=";

  };

  cargoSha256 = "ya2VacO9IxFgkj/vLXrzr3Xx1Dtx+u3K2mRjox9PFvs=";
  buildInputs = [ openssl ];
  nativeBuildInputs = [ pkg-config ];

  doCheck = false;

  meta = with lib; {
    description =
      "With fw you have a configuration describing your workspace. It takes care of cloning projects and can run commands across your entire workspace.";
    homepage = "https://github.com/brocode/fw";
    license = licenses.wtfpl;
    maintainers = [ "" ];
  };
}
