# CPU Usage Investigation

## Scenario

Il server è molto lento. Gli utenti segnalano che le applicazioni rispondono lentamente. Il sospetto è un utilizzo elevato della CPU.

## Investigation

### 1. Monitoraggio della CPU

È stato utilizzato `top` per monitorare in tempo reale l'utilizzo della CPU e individuare eventuali processi anomali.

Inizialmente il sistema non mostrava problemi di CPU.

Per simulare un problema di utilizzo elevato della CPU è stato avviato un processo `yes`:

    yes > /dev/null &

Successivamente, tramite `top`, è stato individuato il processo responsabile dell'elevato utilizzo della CPU:

- PID: 1583
- User: luca
- Command: yes
- CPU usage: circa 92%

### 2. Verifica del processo

Il processo è stato analizzato con:

    ps -fp 1583

Output:

    UID          PID    PPID  C STIME TTY          TIME CMD
    luca        1583    1141 92 12:25 pts/0    00:01:42 yes

Il processo `yes` risultava responsabile dell'elevato utilizzo della CPU.

### 3. Terminazione del processo

Il processo è stato terminato con:

    kill 1583

La terminazione è stata verificata con:

    ps -p 1583

Il processo non risultava più attivo.

### 4. Verifica dell'utilizzo della CPU

È stato nuovamente utilizzato:

    top

Dopo la terminazione del processo sono stati osservati i seguenti valori:

- CPU idle: 99.9%
- CPU user: 0.1%
- CPU system: 0.0%
- Nessun processo con utilizzo anomalo della CPU
- Load average: 0.33, 0.33, 0.20

La CPU risultava quindi praticamente completamente libera.

### 5. Analisi con ps

È stato utilizzato:

    ps aux --sort=-%cpu | head

Questo comando ordina i processi in base all'utilizzo della CPU e mostra i processi che stanno utilizzando maggiormente la CPU.

Il processo `ps` stesso è comparso temporaneamente al primo posto con un utilizzo del 50% perché era il comando appena eseguito. Non rappresentava quindi un problema reale di CPU.

Gli altri processi mostravano un utilizzo molto basso della CPU.

### 6. Analisi con vmstat

È stato utilizzato:

    vmstat 1 5

Il comando ha permesso di osservare per cinque intervalli consecutivi l'utilizzo di CPU, memoria, swap e I/O.

I principali valori osservati sono stati:

- `r = 0` → nessun processo in attesa della CPU
- `b = 0` → nessun processo bloccato
- `swpd = 0` → nessuna memoria swap utilizzata
- `si = 0` → nessun dato trasferito dalla swap alla RAM
- `so = 0` → nessun dato trasferito dalla RAM alla swap
- `us = 0` → utilizzo minimo della CPU da parte dei processi utente
- `sy = 0-1` → utilizzo minimo della CPU da parte del kernel
- `id = 99-100` → CPU praticamente completamente libera
- `wa = 0` → nessuna attesa significativa per I/O

L'output di `vmstat` ha quindi confermato che, dopo la terminazione del processo `yes`, il sistema non presentava più un problema di utilizzo elevato della CPU.

## Conclusion

Il problema era causato da un processo `yes` che consumava una quantità elevata di CPU.

Il processo è stato:

1. individuato tramite `top`
2. verificato tramite `ps`
3. terminato tramite `kill`
4. verificato nuovamente tramite `top`
5. analizzato con `ps aux --sort=-%cpu`
6. verificato con `vmstat`

Dopo la terminazione del processo, l'utilizzo della CPU è tornato alla normalità.

Questo laboratorio ha permesso di esercitarsi nell'identificazione, analisi e risoluzione di un problema di elevato utilizzo della CPU in ambiente Linux.
