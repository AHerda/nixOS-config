{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    font-awesome
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "FiraMono"
        "JetBrainsMono"
        "NerdFontsSymbolsOnly"
      ];
    })
  ];
}
