# structure credits: github.com/novafacing
# basic generation: luarocks nix ...
{pkgs, lib, stdenv, fetchurl, fetchgit, fetchzip, luaVer, ... }:
let
  luaVerPkgs = luaVer.pkgs;
in let
  inherit (luaVerPkgs) luaOlder luaAtLeast buildLuarocksPackage;
  lua = luaVer;
in {
  penlight = buildLuarocksPackage {
    pname = "penlight";
    version = "1.13.1-1";
    knownRockspec = (fetchurl {
      url    = "mirror://luarocks/penlight-1.13.1-1.rockspec";
      sha256 = "1hn8kcmzb8g5329c13k0ak0mzjm8vn3v07rmnfw621cmpzk30hs4";
    }).outPath;
    src = fetchgit ( removeAttrs (builtins.fromJSON ''{
      "url": "https://github.com/lunarmodules/penlight.git",
      "rev": "3bf03267b2571ba3cfa676a10528dd7b9a0db404",
      "date": "2023-04-30T11:35:23+02:00",
      "path": "/nix/store/j55vz6c2w9s57hfch6r2vr5b4x0lf4x0-penlight",
      "sha256": "0fkhdnjv72ik67pjw994kibp205x6hx809hpq6805bn9jpivk963",
      "fetchLFS": false,
      "fetchSubmodules": true,
      "deepClone": false,
      "leaveDotGit": false
       }
     '') ["date" "path"]) ;

    propagatedBuildInputs = with luaVerPkgs ; [ luafilesystem ];

    meta = {
      homepage = "https://lunarmodules.github.io/penlight";
      description = "Lua utility libraries loosely based on the Python standard libraries";
      license.fullName = "MIT/X11";
    };
  };

}
