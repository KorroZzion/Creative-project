{ pkgs ? import <nixpkgs> { } }:

let
  #TODO temporary values
  #Should I even have DataIn? We could exchange data over 80 just as fine
  portDataIn = "7777";
  portServer = "8000";

  checkin = pkgs.callPackage ./checkin { inherit pkgs; };

  pythonEnv = pkgs.python39.withPackages (ps: with ps; [ django gunicorn ]);

  #TODO write nginx configuration
  nginxConf = pkgs.writeText "nginx.conf" ''
    user nobody nobody;
    worker_processes 5;
    error_log /log/nginx/error.log;
    pid /log/nginx/nginx.pid;
  '';

  #In my nix-repl, runtimeShell is bash, so I assume it is bash here too
  #Should look this up
  script = pkgs.writeScriptBin "entry.sh" ''
    #!${pkgs.runtimeShell}
    mkdir -p /log/{nginx,gunicorn,django}
    gunicorn checkin.wsgi:application --bind 0.0.0.0:${portServer}
  '';

in {
  container = pkgs.dockerTools.buildLayeredImage {
    name = "checkin";
    tag = "latest";
    #created = "now";
    contents = [ pythonEnv checkin script pkgs.nginx pkgs.coreutils ];
    config = {
      #Django will store DBs here
      #It also needs to store its own data
      #TODO decide on olume layout
      Volumes = {
        "/data" = { };
        "/log" = { };
      };
      Cmd = [ "entry.sh" ];
      WorkingDir = "/checkin";
      ExposedPorts = { "${portServer}/tcp" = { }; };
      Env = [
        #required for Django
        "PYTHONDONTWRITEBYTECODE=1"
        "PYTHONUNBUFFERED=1"
      ];
    };
  };

  shell = pkgs.mkShell {
    name = "checkin-env";
    buildInputs = [ pkgs.nixfmt pythonEnv pkgs.nginx ];
    inherit portDataIn;
    inherit portServer;
  };
}
