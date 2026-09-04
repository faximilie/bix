{ ... }:
{
  xdg.desktopEntries.emacsclient = {
    name = "Emacs (Client)";
    genericName = "Text Editor";
    comment = "Edit text";
    mimeType = [
      "text/english" "text/plain" "text/x-makefile" "text/x-c++hdr"
      "text/x-c++src" "text/x-chdr" "text/x-csrc" "text/x-java"
      "text/x-moc" "text/x-pascal" "text/x-tcl" "text/x-tex"
      "application/x-shellscript" "text/x-c" "text/x-c++"
    ];
    exec = "emacsclient -n -c %F";
    icon = "emacs";
    terminal = false;
    type = "Application";
    categories = [ "Development" "TextEditor" ];
  };

  services.emacs.enable = true;
  programs.doom-emacs.enable = true;
}
