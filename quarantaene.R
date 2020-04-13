library(plyr)
library(formattable)
quarantaene <- read.delim("./quarantaene.csv")
ergebnis = data.frame()
for (bundesland in unique(quarantaene$Aufwachsen)) {
  quarantaene.bundesland <- quarantaene[quarantaene$Aufwachsen==bundesland,]
  df <- count(quarantaene.bundesland, vars = "Aussprache")
  df$gesamt <- sum(df$freq)
  df$prozent <- percent(df$freq/df$gesamt)
  df$Bundesland <- bundesland
  ergebnis <- rbind(ergebnis,df)
}
# Nur die Bundesländer mit mind. 5 Antworten nehmen
ergebnis <- ergebnis[ergebnis$gesamt > 5,]
# Nur die Varianten mit n>1 übernehmen
ergebnis <- ergebnis[ergebnis$freq>1,]
