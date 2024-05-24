# Class definitions:

L'organizzazione dei dati è suddivisa in tre categorie principali:

## Informazioni Principali:

### Dati Storici:

- Numero Medio di Sigarette al Giorno negli Ultimi 15 Giorni
- Numero Attuale di Sigarette Massime che l'utente può fumare 

### Supporto:
- Supporto Sociale Disponibile (sì/no) -> se si: 
    - (sottocampo) selezionare tipo di supporto (numero di telefono di una persona cara o terapeuta, etc) -> salvare dato

### Tempistica

- Tempo Desiderato per Smettere di Fumare

### Fattori di Influenza:

- Trigger del Desiderio di Fumare (stress, noia, ansia, ecc.) [elenco]

## Obiettivi:

- Obiettivi Giornalieri/Settimanali -> (sottocampo) Risultati degli Obiettivi (null, raggiunto/non raggiunto)

## Preferenze:

- Preferenze di Notifica (abilitato/disabilitato) -> se abilitato:
    - Frequenza di Notifica (7gg/15gg/30gg)

## Tracciamento Progressi:

### Daily:

- Data (giorno/mese/anno)
- Stato Giornaliero (fumato/non fumato)
- Desiderio di fumare (si/no) -> se si:
    - Scala di Desiderio (da verde a rosso)
    - Attività Svolte per Distrarsi (testo libero)
- Note Personali (testo libero per ogni giorno)
