#!/bin/bash

set +x

# Das Verzeichnis, in dem das Script aufgerufen wurde in eine neue Variable speichern, um das Überschreiben von der Systemvariable $PWD zu umgehen
VERZEICHNIS="$PWD"

# Diese Schleife prüft, ob der optionale Parameter tatsächlich ein Verzeichnis ist und zeigt eine Fehlermeldung an, falls dies nicht der Fall sein sollte.
# ---------------------------------------------------------------------------------------------------------------------------------------------------------

PARAMETER=$(echo "$1" | tr "~" "$HOME") # '~' mit dem wirklichen Verzeichnis ersetzen, falls dieses benutzt wird.

if [ ! -d "$PARAMETER" ] && [ "$PARAMETER" != '' ]; then # Hier wird geprüft, ob der erste Parameter ein Verzeichnis ist und ob er überhaupt angegeben wurde.
    echo "###############################################################   #######"
    echo "# Parameter \""$PARAMETER"\" ist kein Verzeichnis."
    echo "# Bitte geben sie ein gültiges Verzeichnis an.                #     ### " # Warnmeldung, falls Parameter nicht verarbeitet werden kann.
    echo "# Lassen Sie den Parameter weg,                               #      #   "
    echo "# um Ihr derzeitiges Verzeichnis als Ausgangspunkt zu nutzen. #     ###"
    echo "###############################################################     ### "
    exit # Script schließen, falls Parameter nicht verarbeitet werden kann.
fi
# ---------------------------------------------------------------------------------------------------------------------------------------------------------

# Diese Schleife verarbeiten den optionalen Parameter, wenn er korrekt angegeben wurde.
# -----------------------------------------------------------------------------------------------------------------------------------------------------------

if [ -d "$PARAMETER" ]; then                 # Erst einmal wird geprüft, ob der Parameter ein Verzeichnis ist.
    if [[ "$PARAMETER" != /* ]]; then        # Dann wird geprüft, ob der Parameter ein absolutes oder relatives Verzeichnis ist.
        VERZEICHNIS=$(realpath "$PARAMETER") # Wenn es sich um ein relatives Verzeichnis handelt, wird dieses mit Hilfe von 'realpath' in ein absolutes umgewandelt.
    else
        VERZEICHNIS="$PARAMETER" # Wenn es sich um ein absolutes Verzeichnis handelt wird der ursprüngliche Wert von $VERZEICHNIS mit dem Parameter ersetzt.
    fi
fi
# -----------------------------------------------------------------------------------------------------------------------------------------------------------

OUTPUT=$(mktemp) # Temporäre Datei für den Output des ganzen Scripts wird erstellt.

# Diese Funktion durchsucht eventuell vorhandene Unterverzeichnisse
# -----------------------------------------------------------------------------------------------------------------------------------------------------------

subdirectory() {

    TEMP=$(mktemp) # Erstellen einer temporären Datei

    cd "$SUB"
    ls -1 "$SUB" >"$TEMP"

    for ITEM in {1..10000}; do # Die For-Schleife beginnt
        cd "$SUB"
        LINES=$(sed "${ITEM}!d" "$TEMP") # Hier wird jeweils nur die erste, die zweite etc. Zeile extrahiert, um sie weiter zu verwenden.

        if [ "$LINES" = '' ]; then # Falls der Wert von 'LINES' leer ist, bricht die Funktion ab
            break 2
        fi

        FULL2=$(realpath "$LINES") # Der gesamte Pfad von 'LINES' wird ermittelt
        echo "$FULL2"              # Dieser wird dann ausgegeben

        if [ -d "$FULL2" ]; then # Falls ein Wert von 'LINES' ein Verzeichnis ist, startet die Funktion 'subdirectory2' und durchsucht dieses
            SUB2="$FULL2"
            subdirectory2
        fi
    done
}

# Diese Funktion durchsucht die Unterverzeichnisse in den Unterverzeichnissen.
subdirectory2() {

    TEMP2=$(mktemp) # Erstellen einer temporären Datei

    cd "$SUB2"
    ls -1 "$SUB2" >"$TEMP2"

    for ITEM2 in {1..10000}; do # Die For-Schleife beginnt
        cd "$SUB2"
        LINES2=$(sed "${ITEM2}!d" "$TEMP2") # Hier wird jeweils nur die erste, die zweite etc. Zeile extrahiert, um sie weiter zu verwenden.

        if [ "$LINES2" = '' ]; then # Falls der Wert von 'LINES2' leer ist, bricht die Funktion ab
            break 2
        fi

        FULL3=$(realpath "$LINES2") # Der gesamte Pfad von 'LINES2' wird ermittelt
        echo "$FULL3"               # Der Wert wird ausgegeben

    done
}

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# Das eigentliche Script
# ------------------------------------------------------------------------------------------------------------------------------------------------------------

while :; do             # while-Loop, um allen Input in eine Datei leiten zu können
    echo "$VERZEICHNIS" # Aktuelles Verzeichnis ausgeben
    DATEIEN=$(mktemp)   # Temporäre Dateien
    TEMP2=$(mktemp)
    ls -1 "$VERZEICHNIS" >"$DATEIEN"

    for i in {1..10000}; do
        cd "$VERZEICHNIS"
        CURRENT=$(sed "${i}!d" "$DATEIEN") # Hier wird jeweils nur die erste, die zweite etc. Zeile extrahiert, um sie weiter zu verwenden.

        if [ "$CURRENT" = '' ]; then

            break 2 # Falls die Schleife alle Zeilen verarbeitet hat, bricht sie ab
        fi

        FULL=$(realpath "$CURRENT") # Der gesamte Pfad von 'CURRENT' wird ermittelt

        echo "$FULL"

        if [ -d "$FULL" ]; then # Falls ein Object ein Verzeichnis ist, wird dieses auch durchsucht, mit Hilfe von der 'subdirectory' Funktion.
            SUB="$FULL"
            subdirectory
        fi
    done
    break
done >"$OUTPUT" 2>/dev/null                        # Der Gesamte Output wird in eine Datei umgeleitet, um die Manipulation zu vereinfachen
cat "$OUTPUT" | tr / \" | sed 's/^.\{1\}//g' | cat # Mit dem 'tr' Command werden '/' mit '"' ersetzt. Der 'sed' Command löscht jeweils das erste Zeichen aus jeder Zeile.
# ------------------------------------------------------------------------------------------------------------------------------------------------------------
rm -f "$OUTPUT"
rm -f "$DATEIEN"
rm -f "$TEMP2"
rm -f "$TEMP"

