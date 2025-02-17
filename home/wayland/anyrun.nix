{
  pkgs,
  inputs,
  default,
  ...
}: {
  programs.anyrun = {
    enable = true;

    config = {
      plugins = with inputs.anyrun.packages.${pkgs.system}; [
        applications
        rink
        shell
        translate
      ];

      width.fraction = 0.3;
      y.absolute = 15;
      hidePluginInfo = true;
      closeOnClick = true;
    };

    extraCss = ''
      * {
        transition: 200ms ease;
        font-family: Lexend;
        font-size: 1.3rem;
      }

      #window,
      #match,
      #entry,
      #plugin,
      #main { background: transparent; }

      #match.activatable {
        border-radius: 16px;
        padding: .3rem .9rem;
        margin-top: .01rem;
      }
      #match.activatable:first-child { margin-top: .7rem; }
      #match.activatable:last-child { margin-bottom: .6rem; }

      #plugin:hover #match.activatable {
        border-radius: 10px;
        padding: .3rem;
        margin-top: .01rem;
        margin-bottom: 0;
      }

      #match:selected, #match:hover, #plugin:hover {
        background: rgba(255,255,255,0.1);
      }

      #entry {
        background: rgba(255,255,255,.05);
        border: 1px solid rgba(255,255,255,0.1);
        border-radius: 16px;
        margin: .3rem;
        padding: .3rem 1rem;
      }

      list > #plugin {
        border-radius: 16px;
        margin: 0 .3rem;
      }
      list > #plugin:first-child { margin-top: .3rem; }
      list > #plugin:last-child { margin-bottom: .3rem; }
      list > #plugin:hover { padding: .6rem; }

      box#main {
        background: rgba(31,31,40,0.5);
        box-shadow: inset 0 0 0 1px rgba(255,255,255,0.1), 0 0 0 1px rgba(0,0,0,0.5);
        border-radius: 24px;
        padding: .3rem;
      }
    '';

    extraConfigFiles."applications.ron".text = ''
      Config(
        desktop_actions: false,
        max_entries: 5,
        terminal: Some("${default.terminal.name}"),
      )
    '';
  };
}
