{ pkgs, ...}:

let
  luaVer = pkgs.luajit;
  luaPkgs = (pkgs.callPackage ./lua.nix {inherit luaVer;});
in let
  luaWithPackages = (luaVer.withPackages(ps: with ps // luaPkgs; [
    luasocket
    luafilesystem
    lpeg
    penlight
    ])).override(args: { ignoreCollisions = true; });
in
with pkgs;
mkShell {
  nativeBuildInputs = [
  ];

  buildInputs = with pkgs; [
    luaWithPackages
    stylua # Lua formatter
    selene # Lua linter written in rust
    lua-language-server # Lua LSP
    luajitPackages.luarocks-nix
  ];

  shellHook = ''
    # ...
  '';
}
