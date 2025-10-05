`stable-flakes`
===============

Usage
-----

```nix
{
    inputs.stable-flakes.url = "github:SomeoneSerge/stable-flakes";
    outputs = { stable-flakes, nixpkgs, ... }:
    {
        inherit (stable-flakes) checks nixosModules;
        legacyPackages = stable-flakes.lib.warn nixpkgs.legacyPackages;
        flakeModules.foobar = stable-flakes.lib.error;
    };
}
```
