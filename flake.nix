{
  description = ''
    A very basic (and stable) flake.
    Make your Flakes stable with just one input!
    Reproducibility of libfetchers solved, once and for all!
  '';
  inputs = { };
  outputs =
    { self, ... }:
    {
      lib = {

        # :: List String -> (String -> a) -> Map String a
        genAttrs =
          names: f:
          builtins.listToAttrs (
            map (name: {
              inherit name;
              value = f name;
            }) names
          );

        # :: (String -> a) -> Map String a
        forEachSystem = self.lib.genAttrs self.lib.systems;

        # :: List String
        systems = [
          "x86_64-linux"
          "aarch64-linux"
          "x86_64-darwin"
          "aarch64-darwin"
        ];

        # :: String
        keywords = [
          "stable"
          "unstable"
          "deprecated"
          "legacy"
          "stop-using"
          "delete-your"
          "phase-out"
          "luke-use-lix"

          # NOTE: These are derivative works, its license is hereby included by reference: https://github.com/Jaculabilis/nixpkgs-gold/blob/94e9a15958a0445ce6382b7c17150260ab53bd87/LICENSE
          "forward-deployed"
          "declarative-war"
          "nixpkgs-gold"
          "premium-derivations"
          "premium"
          "STEERING-COMMITTEE-IS-WATCHING-YOU"

          "mindvirus-is"
          "flakegate"
          "flakehub"
          "nixos-jetson"
          "cuda"
          "use-more-s3-space"
          "no-castore-moar-s3"
          "not-some-legitimacy-actual-legitimacy"
          "llm"
          "vllm"
          "nerf"
          "npbg"
          "splatting"
          "chatgpt"
          "claude"
          "ai"
          "hf"
          "huggingface"
          "sonnet"
          "security"
          "agentic"
          "microvm"
          "firecracker"
          "deepseek"
          "kyc"
          "aml"
          "cft"
          "bazel"
          "robotics"
          "ROS"
          "yocto"
          "tensorflow"
          "torch"
          "pytorch"
          "impermanence"
          "compliance"
          "sbom"
          "bundlers"
          "nix-the-planet"
          "hydra"
          "gpu-passthrough"
          "easybuild"
          "anaconda"
          "eessi"
          "python"
          "llama-cpp"
          "determinate"
          "lix"
          "determinate-lix"
          "DeLIcieuX"
          "interlinked"
          "flakes-interlinked"
        ];

        # :: String -> String
        flakify = x: "${x}-FLAKES";

        # :: Exception
        error = throw self.lib.md;

        # :: String -> a -> a
        warn = (builtins.warn or (msg: builtins.trace "\nEVALUATION WARNING:\n${msg}")) self.lib.md;

        # :: String
        txt = (import ./flake.nix).description;

        # :: String
        md = ''
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
      nixosModules.default = self.lib.error;
      flakeModules.default = self.lib.error;
      nixosConfigurations = self.lib.warn { };

      checks = self.lib.forEachSystem (system:
      # self.lib.warn
      {
      });
      packages = self.lib.warn (
        self.lib.forEachSystem (
          system:
          self.lib.genAttrs ([ "default" ] ++ map self.lib.flakify self.lib.keywords) (
            name:
            derivation {
              name = "${name}.md";
              inherit system;
              inherit (self.lib) md;
              outputs = [ "out" ];
              builder = ./builder.sh;
            }
          )
        )
      );
      legacyPackages = self.lib.forEachSystem (system: {
        default = self.lib.error;
      });
      templates.default = {
        path = ./.;
        description = "PREPARE THE STABLE BEAM\n\n" + self.lib.md;
      };
    };
}
