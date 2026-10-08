# Memory Usage Investigation

## Scenario

Il server sta diventando lento e gli utenti segnalano che le applicazioni rispondono lentamente. Il sospetto è un problema di memoria RAM.

## Investigation

### 1. Analisi della memoria con free

È stato utilizzato `free -h` per controllare rapidamente l'utilizzo della memoria RAM e della swap.

I valori iniziali erano:

- RAM totale: 1.8 GiB
- RAM utilizzata: 364 MiB
- RAM libera: 1.4 GiB
- RAM disponibile: 1.4 GiB
- Swap totale: 1.0 GiB
- Swap utilizzata: 0 B
- Swap libera: 1.0 GiB

I valori non indicavano una situazione di memoria insufficiente.

### 2. Analisi dei processi

È stato utilizzato:

    ps aux --sort=-%mem | head

Il comando permette di ordinare i processi in base alla percentuale di memoria utilizzata.

Il processo che utilizzava più memoria era `systemd-journald`, con circa l'1.2% della RAM.

Gli altri processi mostravano valori contenuti e non è stato individuato alcun processo con un consumo anomalo di memoria.

### 3. Analisi con vmstat

È stato utilizzato:

    vmstat -s

I principali valori osservati sono stati:

- Memoria totale: circa 1.89 GB
- Memoria utilizzata: circa 377 MB
- Memoria libera: circa 1.43 GB
- Swap totale: 1 GB
- Swap utilizzata: 0 KB
- Swap libera: 1 GB
- Pagine scambiate in ingresso: 0
- Pagine scambiate in uscita: 0

L'assenza di pagine scambiate e l'elevata quantità di memoria libera confermano che non era presente pressione sulla memoria.

### 4. Verifica finale

È stato nuovamente utilizzato:

    free -h

I valori finali erano:

- RAM totale: 1.8 GiB
- RAM utilizzata: 368 MiB
- RAM libera: 1.4 GiB
- RAM disponibile: 1.4 GiB
- Swap utilizzata: 0 B
- Swap libera: 1.0 GiB

I valori sono rimasti stabili e hanno confermato che il sistema disponeva di memoria sufficiente.

## Conclusion

L'analisi non ha evidenziato un problema di memoria RAM.

La memoria disponibile era elevata, nessun processo utilizzava una quantità anomala di RAM e la swap non veniva utilizzata.

Il problema di lentezza non era quindi riconducibile a una saturazione della memoria.

Il troubleshooting ha permesso di esercitarsi nell'analisi della memoria Linux utilizzando:

1. `free`
2. `ps`
3. `vmstat`

La verifica finale con `free` ha confermato che la situazione della memoria era normale.
