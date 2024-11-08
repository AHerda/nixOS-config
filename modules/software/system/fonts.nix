{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    font-awesome
    fira-code
    fira-code-symbols
    nerdfonts
    # (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];
}
