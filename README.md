# verzeichnis-script
- **Dieses Script durchsucht das Verzeichnis, in dem man sich befindet und gibt dessen Inhalte (getrennt mit '"') aus.**
- Dieses Script war eine Hausaufgabe bei der FV.
- Es ist sehr rudimentär aber sollte halbwegs in jedem beliebigen Verzeichnis funktionieren.

# Installation
1. Das Script `2averzeichnis` und den Link `2averzeichnissimple` in `~/bin` ablegen.
2. `nano ~/.bashrc` 
3. `export PATH="$PATH:$HOME/bin"` in die Datei schreiben.
4. (Optional) `alias avb="~/bin/2averzeichnis"`

# Verwendung
- Falls der 4. optionale Schritt durchgeführt wurde, einfach `avb` in einem beliebigen Verzeichnis tippen.
- Sonst mit `2averzeichnis` aufrufen.

# Parameter
- Das Script akzeptiert ein Verzeichnis als optionalen Parameter.

# Beispiele
- `avb ~`
- `avb /`
- `avb /var`
- `avb ~/bin`
- `2averzeichnis`
- `2averzeichnis --help`
- `avb --help`
- `2averzeichnissimple`
