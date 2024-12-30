{ inputs, ... }:
{
  xdg.configFile = {
    "vesktop/themes/tokyonight-moon.theme.css".source =
      "${inputs.tokyonight-nvim}/extras/discord/tokyonight_moon.css";
    "eza/theme.yml".source = "${inputs.tokyonight-nvim}/extras/eza/tokyonight.yml";
    "lazygit/config.yml".source = "${inputs.tokyonight-nvim}/extras/lazygit/tokyonight_moon.yml";
  };
}
