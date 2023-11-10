# APP Developement Final Project
> Maximilian Kraft - MatNr. 51850099

> Data Source: https://www.data.gv.at/katalog/dataset/wiener-linien-echtzeitdaten-via-datendrehscheibe-wien

Base URL:

https://www.wienerlinien.at/ogd_realtime/monitor?activateTrafficInfo=stoerunglang&rbl=4438

## Hinweise zur App

Die App ladet etwas lange, während sie damit beschäftigt ist die CSV-Dateien zu parsen.
Würde man das in eine Art Localstorage (Core Data o.ä) geben würde das die Performanz bestimmt erhöhen. 

Man könnte auch noch eine Funktionalität einbauen dass alle Linien mit unterschiedlichen Farben angzeigt werden, oder dass die Abfahrten besser ins UI integriert werden. 



## Angabe

Erstellen Sie eine App zur Darstellung von POIs (basierend auf Open Government Data Vienna) auf einer Karte. Wählen Sie selber aus, welche Daten Sie anzeigen möchten (z.B. Öffi-Haltestellen, Taxistände, Elektroladestationen, etc.) und sprechen Sie sich mit Ihren KollegInnen ab, damit Sie alle unterschiedliche Daten verwenden. Die App sollte mit einer Liste der jeweils abgefragten Daten starten. Ein Klick auf einen Listeneintrag öffnet eine Karte, die den ausgewählten Punkt anzeigt.

Laden Sie das gesamte Projekt als Zip-File hoch.

Hinweise/Anmerkungen:

- Die abgefragten Daten müssen als JSON-File formatiert sein

- Es reicht jeweils die Darstellung einer Koordinate (auch wenn mehrere Koordinaten bzw. ganze Flächen im JSON verfügbar wären).

- Die Struktur des JSON-Files ist anders als beim Beispiel im Unterricht. Daher muss sowohl das Auslesen, als auch das Abspeichern (Model) entsprechend angepasst werden.

- Die Daten sollen automatisch beim Start geholt werden und ein “Refresh” soll mittels Button möglich sein

- Ein Klick auf eine Annotation soll Zusatzinformationen anzeigen.

- Es soll eine Möglichkeit geben, abgefragte Einträge bzw. deren Inhalt persistent (in einer Art Favoritenliste) zu speichern. Diese Liste soll über einen eigenen Tab erreichbar sein.

Punktezusammensetzung:

- Basisfunktionalität (25 Punkte)

- Anzeige von Zusatzinformationen in der Bubble über der Annotation (eigene Annotation Klasse) (5 Punkte)

- Unterschiedliche Farben der Annotations, abhängig z.B. von der Anzahl der Stellplätze, Verfügbarkeit, etc. (5 Punkte)

- Persistente Speicherung ausgewählter Einträge in einer Favoritenliste, welche über einen eigenen Tab erreichbar sein soll. (15 Punkte)

- Löschen von einzelnen Einträgen der Favoritenliste (5 Punkte)

- Keine Errors, Crashes, etc. (5 Punkte)
