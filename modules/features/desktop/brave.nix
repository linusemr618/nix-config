{
  flake.homeModules.desktop = {
    programs.brave = {
      enable = true;
      #defaultSearchProviderEnabled = true;
      #defaultSearchProviderSearchURL = "https://duckduckgo.com/?q={searchTerms}&t=brave";
      #defaultSearchProviderSuggestURL = "https://ac.duckduckgo.com/ac/?q={searchTerms}&type=list";
      extensions = [
        "ghmbeldphafepmbegfdlkpapadhbakde" # Proton Pass
        "lmjnegcaeklhafolokijcfjliaokphfk" # Video DownloadHelper
      ];
    };
  };
}
