# verzeichnis-script
- Dieses Script war eine Hausaufgabe bei der FV.
- Es ist sehr rudimentär aber sollte halbwegs in jedem beliebigen Verzeichnis funktionieren.

# Installation
1. Das Script `averzeichnis.sh` in `~/bin` ablegen.
2. `nano ~/.bashrc` 
3. `export PATH="$PATH:$HOME/bin"` in die Datei schreiben.
4. (Optional) `alias avb="~/bin/averzeichnis.sh"`

# Verwendung
- Falls der 4. optionale Schritt durchgeführt wurde, einfach `avb` in einem beliebigen Verzeichnis tippen.
- Sonst mit `averzeichnis.sh` aufrufen.

# Parameter
- Das Script akzeptiert ein Verzeichnis als optionalen Parameter.

# Beispiele
- `avb ~`
- `avb /`
- `avb /var`
- `avb ~/bin`
- `averzeichnis.sh`
