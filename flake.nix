{
  description = "A very basic (and stable) flake";
  inputs = { };
  outputs =
    { self }:
    {
      lib = {

        # :: Exception
        error = throw self.lib.announcement;

        # :: String -> a -> a
        warn = (builtins.warn or (msg: builtins.trace "EVALUATION WARNING:\n${msg}")) self.lib.announcement;

        # :: String
        announcement = ''
          Flakes are now Stable!
          ======================

          With the recent Feature Freeze announcement[^1] and with Robert H
          stepping away from the NixOS/Nix Team, Flakes are, after an almost
          decade-long stalement, finally recognized as Stable by virtuall all
          vested parties. This means we can finally move on, and begin to isolate
          and remove the hacks and the vast mass of technical debt that has been
          supporting the legacy interface, preventing progress, and spoiling the
          UX. This is the end of Drama. We may now start addressing the
          long-standing usability issues, such as the support for Dependency
          Injection, proper Versioning, and easier composition of Out-of-Tree
          Projects. The first step, of course, is to delete your `flake.nix` and
          switch to a proper lockfile management solution[^2][^3].
          Do not forget the prior art on the subject![^4][^5][^6][^7]


          [^1]: https://wiki.lix.systems/books/lix-contributors/page/flakes-feature-freeze
          [^2]: https://github.com/nikstur/lon
          [^3]: https://github.com/andir/npins
          [^4]: https://jade.fyi/blog/flakes-arent-real
          [^5]: https://github.com/infinisil/sanix
          [^6]: https://piegames.de/dumps/pinning-nixos-with-npins-revisited
          [^7]: https://piegames.de/dumps/nixpkgs-global-overlays
        '';

      };

      checks.x86_64-linux = self.lib.warn { };
      packages.x86_64-linux = self.lib.warn { };
      legacyPackages.x86_64-linux.default = self.lib.error;
      nixosModules.default = self.lib.error;
      flakeModules.default = self.lib.error;
      nixosConfigurations = self.lib.warn { };
    };
}
