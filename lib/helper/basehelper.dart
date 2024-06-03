import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';





import '../model/user_model.dart';
import '../utils/constant/colors.dart';

class BaseHelper {
  static const String termsAndConditions="""Benvenuti nei nostri Termini e condizioni d’uso.
Questa è una parte importante che riguarda i diritti legali degli utenti, pertanto si prega di leggere attentamente questa Sezione e la nostra Informativa sulla privacy www.wannaplys.fun.


1 – INTRODUZIONE


Il Servizio WANNA PLAYS comprende funzionalità social ed interattive.


L’accordo tra WANNA PLAYS e gli utenti comprende questi Termini e condizioni d’uso (i “Termini”) e la nostra Informativa sulla privacy.


L’utente riconosce di aver letto, compreso e accettato gli Accordi, e di accettare di esservi vincolato. Qualora non si accettino (o non sia possibile rispettare) gli Accordi, l’utente non deve utilizzare il Servizio WANNA PLAYS né i suoi Contenuti.


Si prega di leggere gli Accordi con attenzione. 


Gli Accordi contengono informazioni su future variazioni agli Accordi, rinnovi automatici, limitazioni della responsabilità, informazioni sulla privacy, una rinuncia al diritto di class action e la soluzione di controversie mediante arbitrato invece che in un tribunale, foro obbligatorio in caso di giudizio.


Eventuali informazioni fornite dagli utenti durante la sottoscrizione dell’abbonamento possono essere corrette tornando alle schermate precedenti e modificando le informazioni errate, oppure modificando il profilo utente all’interno dell’applicazione.


2 – REGISTRAZIONE E REQUISITI UTENTE


Al fine di utilizzare l’Applicazione ed accedere ai Contenuti, è necessario creare un Account personale ed univoco, non è consentito agli utenti di avere due profili.


L’utente promette inoltre di fornire a WANNA PLAYS informazioni di registrazione vere, accurate e complete, e accetta di mantenerle sempre in tale stato, consapevole delle violazioni penali in cui incorrerebbe in contrario.


La registrazione avviene mediante l’inserimento del numero di cellulare oppure dell’indirizzo email, del  nome, cognome e della propria password, così da garantire l’unicità e la corrispondenza dei dati di registrazione ad un soggetto realmente esistente, successivamente sarà possibile verificare l’indirizzo email tramite la conferma di ricezione. Successivamente all’interno dell’applicazione potrà essere completata e successivamente anche corretta, la scheda del Profilo Utente, contenente tutti i dati necessari ad identificare l’utente/giocatore, con recapiti, codice fiscale e partita iva e codice univoco per la fatturazione.


3 – SERVIZIO


Descrizione del Servizio e dell’Applicazione WANNA PLAYS.


3 - I nostri Servizi


WANNA PLAYS ha il fine di permettere ai giocatori di tennis di cercare e trovare in breve tempo un avversario da sfidare, presso tutti i circoli Tennis, oppure svolgere altre mansioni comunque collegate e connesse all’attività sportiva del tennis.


Sarà possibile creare una Chat di gruppo con altri utenti/giocatori per giocare con loro;
Sarà possibile richiedere una lezione ai coach;
Sarà possibile organizzare partite i Paddle con altri giocatori;
Sarà possibile prenotare i campi nei circoli iscritti;
Sarà possibile prenotare visite da fisioterapisti iscritti;
Sarà possibile scambiarsi tramite l’app messaggi istantanei all’interno di una Chat appositamente creata;
Sarà possibile invitare un amico a partecipare a WANNA PLAYS tramite l’apposito spazio riservato e l’invio di un codice promozionale;
Sarà possibile tramite l’utilizzo dei codici personali invitare amici a scaricare l’applicazione WANNA PLAYS, tramite il servizio “INVITA UN AMICO” ed ottenere così dei crediti che potranno essere utilizzati esclusivamente all’interno dell’app WANNA PLAYS per ricevere in cambio dei servizi erogati direttamente da WANNA PLAYS;
A discrezione potranno essere aggiunti e/o modificati e/o eliminati alcuni servizi sopra elencati senza che ciò comporti alcuna modificazione del diritto dell’utilizzatore e senza che possa in alcun modo mantenere il diritto di utilizzazione del medesimo servizio.


WANNA PLAYS potrà in qualunque momento sospendere l’erogazione del servizio prestato.


4 – Garanzia e esclusione di responsabilità


WANNA PLAYS TENTA DI FORNIRE IL MIGLIORE SERVIZIO POSSIBILE, MA L’UTENTE COMPRENDE E ACCETTA CHE IL SERVIZIO WANNA PLAYS È FORNITO “COSÌ COME È” E “COME DISPONIBILE”, SENZA ALCUNA GARANZIA O CONDIZIONE ESPLICITA O IMPLICITA DI ALCUN GENERE. L’UTENTE UTILIZZA IL SERVIZIO WANNA PLAYS A PROPRIO RISCHIO.
NEI LIMITI MASSIMI PREVISTI DALLA LEGGE VIGENTE, WANNA PLAYS NON FORNISCE ALCUNA ASSICURAZIONE E NEGA QUALSIASI GARANZIA IN MERITO AL SERVIZIO RESO ED ALL’ESECUZIONE DELLE PRESTAZIONI RICHIESTE AGLI ALTRI UTENTI.


WANNA PLAYS E I PROPRIETARI DI ALTRI SOFTWARE NON GARANTISCONO IN ALCUN MODO CHE IL SERVIZIO SIA PRIVO DI MALWARE O ALTRI COMPONENTI NOCIVI.


INOLTRE, WANNA PLAYS NON FORNISCE ALCUNA ASSICURAZIONE E NON GARANTISCE, AFFERMA O SI ASSUME LA RESPONSABILITÀ DI QUALSIASI APPLICAZIONE DI TERZE PARTI (O DEL RELATIVO CONTENUTO), CONTENUTO UTENTE O ALTRI PRODOTTI O SERVIZI PUBBLICIZZATI O OFFERTI DA TERZE PARTI SU O TRAMITE IL SERVIZIO O UN SITO WEB COLLEGATO TRAMITE COLLEGAMENTO IPERTESTUALE O PRESENTATO IN UN BANNER O ALTRA PUBBLICITÀ.


L’UTENTE COMPRENDE E ACCETTA CHE WANNA PLAYS NON È RESPONSABILE DI QUALSIASI TRANSAZIONE TRA UTENTE E FORNITORI TERZE PARTI DI APPLICAZIONI O PRODOTTI DI TERZE PARTI O DI SERVIZI PUBBLICIZZATI SU O TRAMITE IL SERVIZIO  


COME PER OGNI ACQUISTO DI PRODOTTI O SERVIZI TRAMITE QUALSIASI MEZZO O IN QUALSIASI AMBIENTE, L’UTENTE DEVE UTILIZZARE IL PROPRIO GIUDIZIO E PRESTARE CAUTELA OVE APPROPRIATO. A QUESTO PROPOSITO, NESSUN CONSIGLIO O INFORMAZIONE FORNITI IN FORMA ORALE O SCRITTA DALL’UTENTE A WANNA PLAYS COSTITUIRANNO UNA QUALSIASI FORMA DI GARANZIA PER CONTO DI WANNA PLAYS.
SE VIETATO DALLA LEGGE VIGENTE, ALCUNI ASPETTI DI QUESTA SEZIONE POSSONO NON VALERE IN TALUNE GIURISDIZIONI. CIÒ NON HA EFFETTI SUI DIRITTI STATUTARI DELL’UTENTE COME CONSUMATORE.


5 – Limitazioni


L’UTENTE ACCETTA CHE, NEI LIMITI PREVISTI DALLA LEGGE VIGENTE, IL SOLO E UNICO RIMEDIO PER EVENTUALI PROBLEMI O INSODDISFAZIONI CON IL SERVIZIO WANNA PLAYS CONSISTE NEL DISINSTALLARE IL SOFTWARE WANNA PLAYS E SMETTERE DI UTILIZZARE IL SERVIZIO OFFERTO.
ANCHE SE WANNA PLAYS NON SI ASSUME ALCUNA RESPONSABILITÀ PER APPLICAZIONI DI TERZE PARTI O LORO CONTENUTI, E ANCHE SE IL RAPPORTO CON TALI APPLICAZIONI DI TERZE PARTI PUÒ ESSERE REGOLATO DA ACCORDI SEPARATI CON TALI TERZE PARTI, NEI LIMITI PREVISTI DALLA LEGGE VIGENTE IL SOLO E UNICO RIMEDIO OFFERTO DA WANNA PLAYS PER EVENTUALI PROBLEMI O INSODDISFAZIONI CON LE APPLICAZIONI DI TERZE PARTI O I LORO CONTENUTI CONSISTE NEL DISINSTALLARE E/O SMETTERE DI UTILIZZARE TALI APPLICAZIONI DI TERZE PARTI.
NEI LIMITI MASSIMI PREVISTI DALLA LEGGE, IN NESSUN CASO WANNA PLAYS E I SUOI FUNZIONARI, AZIONISTI, DIPENDENTI, AGENTI, DIRETTORI, CONSOCIATE, FILIALI, SUCCESSORI, ASSEGNATARI, FORNITORI O LICENZIANTI POTRANNO ESSERE CONSIDERATI RESPONSABILI DI
(1) EVENTUALI DANNI INDIRETTI, SPECIALI, INCIDENTALI, PUNITIVI, ESEMPLARI O CONSEGUENTI;
(2) EVENTUALI PERDITE DI USO, DATI, AFFARI O UTILI (SIA DIRETTE CHE INDIRETTE), IN OGNI CASO DERIVANTI DALL’USO O DALL’INCAPACITÀ DI UTILIZZARE IL SERVIZIO, APPLICAZIONI DI TERZE PARTI O IL CONTENUTO DI APPLICAZIONI DI TERZE PARTI, INDIPENDENTEMENTE DA QUALSIASI TEORIA LEGALE E DAL FATTO CHE WANNA PLAYS SIA STATA AVVERTITA DELLA POSSIBILITÀ DI TALI DANNI, E ANCHE LADDOVE UN RIMEDIO NON OTTENGA IL RISULTATO PREVISTO;
(3) QUALSIASI RESPONSABILITÀ AGGREGATA PER TUTTE LE RICHIESTE RELATIVE A SERVIZIO WANNA PLAYS, APPLICAZIONI DI TERZE PARTI O CONTENUTO DI APPLICAZIONI DI TERZE PARTI DI VALORE SUPERIORE AGLI IMPORTI PAGATI DALL’UTENTE A WANNA PLAYS DURANTE I PRECEDENTI DODICI MESI IN QUESTIONE, NEI LIMITI MASSIMI CONSENTITI DALLA LEGGE VIGENTE.


5 -LIMITAZIONE DI RESPONSABILITA’ PER IL SERVIZIO BACHECA E CHAT?


L’utente riconosce che le opinioni espresse all’interno del servizio Chat oppure all’interno della Bacheca  sono esclusivamente quelle degli autori di tale contenuto dei messaggi e non corrispondono alle opinioni o alle politiche di WANNA PLAYS o di qualsiasi suo funzionario, azionista, dipendente, agente, direttore, consociata, filiale, fornitore o licenziante.


Eventuali contenuti inappropriati saranno immediatamente cancellati dietro segnalazione degli utenti e comunque non potranno in alcun modo comportare la responsabilità diretta, indiretta oppure in qualsiasi modo collegata o dipendente di WANNA PLAYS, per eventuali danni, di qualunque natura, cagionati a terzi.




5.1 Esclusione di responsabilità per la prestazioni erogate dagli utenti.


In nessun caso WANNA PLAYS potrà essere ritenuta responsabile per i contratti conclusi all’interno dell’Applicazione WANNA PLAYS e per il loro esatto adempimento e/o pagamento.


WANNA PLAYS eroga un Servizio limitato alla messa in contatto dei giocatori, non risponde di qualsiasi comportamento tenuto dai singoli utenti nell’esecuzione delle prestazioni promesse, e/o per la mancata esecuzione  delle stesse, oppure  per il loro mancato pagamento.


Nessun tipo di responsabilità diretta, indiretta oppure in qualsiasi modo collegata o dipendente dalle prestazioni altrui potrà essere addebitata a WANNA PLAYS, per eventuali danni cagionati a terzi, di qualsiasi natura essi siano.


Gli accordi raggiunti all’interno dell’Applicazione dagli utenti riguardano l’esecuzione di prestazioni  in favore di utenti/giocatori ed in quanto tali saranno gli stessi a dover tenere indenne l’altra parte contrattuale da eventuali danni, nessun addebito, per nessuna ragione e/o motivo potrà essere mosso nei confronti di WANNA PLAYS.


 


6 – Servizio Gratuito e Abbonamenti a pagamento


Alcuni Servizi WANNA PLAYS sono forniti a titolo gratuito.
Altri Servizi WANNA PLAYS richiedono di effettuare il pagamento prima di poterli utilizzare.
Attualmente i Servizi cui è possibile accedere dopo il pagamento sono indicati come “Servizi illimitati”. Attualmente i Servizi che non richiedono alcun pagamento sono indicati con il termine “Servizi gratuiti” oppure “ Basic”. Per saperne di più sui nostri servizi, visitare LINK.


In caso di annullamento o interruzione di un abbonamento ai Servizi illimitati (ad esempio per una variazione dei dati di pagamento), è possibile non essere in grado di attivare nuovamente l’abbonamento in questione.


Gli abbonamenti a pagamento possono essere disdetti in qualsiasi momento, almeno il giorno lavorativo precedente il loro rinnovo, o direttamente dall’APP oppure tramite invio di una email all’indirizzo MAIL.






7 – Servizio Crediti


Mediante l’utilizzo della sezione INVITA UN AMICO gli utenti potranno invitare degli amici a scaricare e registrarsi all’applicazione WANNA PLAYS, utilizzando il loro codice personale che sarà inviato all’amico.


In questo modo entrambi i soggetti riceveranno uno o più crediti, secondo come pubblicato sul sito e nell’applicazione Web e Mobile in quel momento, che saranno accumulati e potranno essere utilizzati dall’utente ESCLUSIVAMENTE all’interno dell’applicazione WANNA PLAYS per l’erogazione di servizi diretti.
In nessun caso i crediti potranno avere un valore economico o potranno essere venduti o riscattati agli utenti, oppure utilizzati al di fuori dell’applicazione WANNA PLAYS e per l’acquisto di prodotti e/o servizi diversi da quelli presenti all’interno delle Applicazioni Web e Mobile nella sezione “INVITA UN AMICO”.


Nella suddetta sezione sarà presente un elenco di servizi che potranno essere utilizzati al raggiungimento di una certo numero di crediti e l’utilizzo del servizio comporterà l’utilizzo e la perdita del numero di crediti corrispondenti.




8 – Periodi di prova


Dopo la fase di registrazione, WANNA PLAYS può offrire periodi di prova di Abbonamenti a servizi illimitati per uno specifico periodo a titolo gratuito o con una tariffa ridotta (“Periodo di prova” “Promozione”).
WANNA PLAYS si riserva il diritto di stabilire, a propria assoluta discrezione, l’idoneità di un utente ad un Periodo di prova e, ai sensi delle leggi vigenti, di ritirare o modificare in qualsiasi momento un Periodo di prova senza alcuna precedente comunicazione e senza responsabilità, nei limiti massimi consentiti dalla legge.


Per alcuni Periodi di prova, WANNA PLAYS a potrebbe richiede di fornire i dati di pagamento per darvi inizio.


AL TERMINE DI TALI PERIODI DI PROVA, POSSIAMO DARE AUTOMATICAMENTE INIZIO ALL’ADDEBITO DELL’ABBONAMENTO A PAGAMENTO APPLICABILE A PARTIRE DAL PRIMO GIORNO DOPO LA FINE DEL PERIODO DI PROVA, CON ADDEBITO RIPETUTO OGNI MESE O QUANTITÀ SUPERIORE. FORNENDO I PROPRI ESTREMI DI PAGAMENTO ALL’INIZIO DEL PERIODO DI PROVA, L’UTENTE ACCETTA QUESTO ADDEBITO TRAMITE QUESTI ESTREMI DI PAGAMENTO. QUALORA L’UTENTE NON DESIDERI ACCETTARE L’ADDEBITO, EGLI DEVE ANNULLARE L’ABBONAMENTO A PAGAMENTO APPLICABILE TRAMITE LA PAGINA DI ABBONAMENTO DEL PROPRIO ACCOUNT WANNA PLAYS, OPPURE TERMINARE IL PROPRIO ACCOUNT WANNA PLAYS PRIMA DELLA FINE DEL PERIODO DI PROVA. QUALORA NON DESIDERI CONTINUARE A RICEVERE ADDEBITI MENSILI REGOLARI, L’UTENTE DEVE ANNULLARE L’ABBONAMENTO A PAGAMENTO APPLICABILE TRAMITE LA PAGINA DI ABBONAMENTO DEL PROPRIO ACCOUNT WANNA PALY
, OPPURE TERMINARE IL PROPRIO ACCOUNT WANNA PLAYS PRIMA DELLA FINE DEL PERIODO MENSILE IN CORSO, ED ALMENO 24 ORE PRIMA. GLI ABBONAMENTI A PAGAMENTO NON POSSONO ESSERE TERMINATI PRIMA DELLA FINE DEL PERIODO GIÀ PAGATO E, TRANNE OVE ESPRESSAMENTE PREVISTO IN QUESTI TERMINI, WANNA PLAYS NON RIMBORSERÀ ALCUN COSTO ANTICIPATO. LA SEZIONE LIMITAZIONI DEFINISCE I TERMINI AGGIUNTIVI RELATIVI ALL’ANNULLAMENTO DI UN ABBONAMENTO A PAGAMENTO.


 


9 – Diritti riconosciuti da WANNA PLAYS agli utenti


Il Servizio WANNA PLAYS è di proprietà di WANNA PLAYS o dei suoi licenzianti. WANNA PLAYS concede agli utenti una licenza limitata, non esclusiva e revocabile per l’utilizzo del Servizio  e una licenza limitata, non esclusiva e revocabile per l’utilizzo personale, non commerciale  (la “Licenza”). Questa Licenza rimane in vigore fino alla sua scadenza e tranne se terminata dall’utente o da WANNA PLAYS. L’utente promette e accetta di utilizzare WANNA PLAYS solo per uso personale, non commerciale e per scopi professionali, e che non ridistribuirà né trasferirà il Servizio WANNA PLAYS a terze parti, né lo utilizzerà per conto di altri soggetti.


Le applicazioni software di WANNA PLAYS e suoi servizi ulteriori sono concessi all’utente su licenza, non venduti, e WANNA PLAYS e i suoi licenzianti conservano la proprietà di tutte le copie di Applicazioni software WANNA PLAYS, anche dopo l’installazione su personal computer, dispositivi palmari, tablet, cellulari e/o altri dispositivi simili dell’utente (“Dispositivi”).


Tutti i marchi, siano essi registrati, i marchi di servizio, i nomi depositati, i loghi, i nomi di dominio e qualsiasi altra funzionalità del marchio WANNA PLAYS sono proprietà esclusiva di WANNA PLAYS dei suoi licenzianti. Gli Accordi non concedono all’utente il diritto di utilizzare alcuna Caratteristica del marchio WANNA PLAYS per usi commerciali o non commerciali.


L’utente accetta di rispettare e di non utilizzare il Servizio WANNA PLAYS in alcun modo non espressamente consentito dagli Accordi. Tranne per i diritti espressamente concessi all’utente ai sensi di questi Accordi, WANNA PLAYS non concede all’utente alcun diritto, titolo o interesse sul Servizio o i suoi Contenuti.


I software di terze parti ( per es…..) compresi nel Servizio WANNA PLAYS sono concessi su licenza all’utente ai sensi degli Accordi o dei termini di licenza del software della terza parte pertinente, come pubblicati nella guida o nella sezione Impostazioni del nostro software per computer desktop e client mobili e/o sul nostro sito Web.


10 – Applicazioni di terze parti


Il Servizio WANNA PLAYS è integrato con applicazioni di terze parti, siti Web e servizi (“Applicazioni di terze parti”) per rendere disponibili contenuti, prodotti e/o servizi agli utenti. Queste Applicazioni di terze parti possono disporre di propri Termini e condizioni d’uso e Informative sulla privacy, e il loro uso da parte dell’utente sarà regolato da e soggetto a tali Termini e condizioni e Informative sulla privacy. L’utente comprende e accetta che WANNA PLAYS non promuove e non è responsabile di comportamento, funzionalità o contenuto di qualsiasi Applicazione di terze parti o di qualsiasi transazione che è possibile sottoscrivere con il fornitore di tali Applicazioni di terze parti.


11 – Contenuti generati dagli utenti


Gli utenti di WANNA PLAYS possono pubblicare, caricare e/o contribuire con contenuti al Servizio, ivi compresi ad esempio immagini, testo, messaggi.
In relazione ai servizi all’utente pubblicati su WANNA PLAYS, l’utente WANNA PLAYSP(1) avere il diritto di pubblicare tale contenuti utente
(2) i contenuti utente, o il loro uso da parte di WANNA PLAYS come contemplato negli Accordi, non viola Accordi, leggi vigenti o proprietà intellettuali (ivi inclusi e senza limitazione i copyright) pubblicamente o personalmente, o altri diritti di altre persone, né comporta alcuna iscrizione a o sponsorizzazione dell’utente o del suo Contenuto utente da parte di WANNA PLAYS o di qualsiasi entità o persona fisica senza previo consenso scritto di tale persona fisica o entità.


WANNA PLAYS può, ma senza alcun obbligo in tal senso, monitorare, rivedere o modificare il Contenuto utente. In ogni caso, WANNA PLAYS si riserva il diritto di rimuovere o disattivare l’accesso a qualsiasi Contenuto utente, con o senza motivo, compresi in forma non limitativa i Contenuti utente che, a esclusiva discrezione di WANNA PLAYS, violano gli Accordi.  WANNA PLAYS può intraprendere queste azioni senza previa comunicazione a utenti o terze parti. La rimozione o la disattivazione dell’accesso ai Contenuti utente deve avvenire a esclusiva discrezione di WANNA PLAYS, e non promettiamo di rimuovere o disattivare l’accesso ad alcuno specifico Contenuto utente.


L’utente è l’unico responsabile di ogni Contenuto utente da lui pubblicato. WANNA PLAYS non è responsabile dei Contenuti utente, né promuove alcuna opinione contenuta in qualsiasi Contenuto utente. QUALORA QUALCUNO PRESENTI UN RECLAMO CONTRO WANNA PLAYS IN RELAZIONE A UN CONTENUTO UTENTE PUBBLICATO, L’UTENTE ACCETTA, NEI LIMITI CONSENTITI DALLA LEGGE LOCALE, DI INDENNIZZARE E RITENERE WANNA PLAYS IMMUNE DA E IN RELAZIONE A TUTTI I DANNI, LE PERDITE E LE SPESE DI QUALSIASI GENERE (IVI INCLUSI RAGIONEVOLI ONORARI E SPESE LEGALI) DERIVANTI DA TALE RECLAMO.


12 – Diritti riconosciuti dagli utenti a WANNA PLAYS


In considerazione dei diritti concessi ai sensi degli Accordi, l’utente concede a WANNA PLAYS il diritto di
(1) utilizzare la sua posizione GPS per il funzionamento di alcune funzioni dell’applicazione,
(2) fornire pubblicità e altre informazioni all’utente su prodotti venduti direttamente da WANNA PLAYS  
(3) permettere ai partner commerciali di fare lo stesso
(4) il diritto di cedere a terzi le informazioni raccolte
(5) il diritto di elaborare con intelligenza artificiale i dati raccolti e potere sulla base degli stessi profilare gli utenti ed offrire loro servizi evoluti.


Se fornisce a WANNA PLAYS feedback, idee o suggerimenti in relazione al Servizio, l’utente riconosce che tale Feedback non è riservato e autorizza WANNA PLAYS a utilizzarlo senza alcuna limitazione né alcun pagamento a favore dell’utente in questione. Il Feedback è considerato un tipo di Contenuto utente. Ove applicabile e consentito dalla legge vigente, l’utente accetta anche di WANNA PLAYS a essere identificato come autore di qualsiasi Contenuto utente, tra cui Feedback e diritto di opporsi a trattamento derogatorio di tale Contenuto utente.


13 – Linee guida per gli utenti


WANNA PLAYS rispetta i diritti di proprietà intellettuale e si aspetta che gli utenti facciano lo stesso. WANNA PLAYS ha stabilito alcune regole base che gli utenti devono seguire quando utilizzano il Servizio per assicurarsi che WANNA PLAYS rimanga un prodotto usufruibile da parte di tutti. Si prega di seguire queste regole e di incoraggiare gli altri utenti a comportarsi allo stesso modo.


Non è permesso per alcun motivo:
copiare, ridistribuire, riprodurre, “estrarre”, registrare, trasferire, eseguire o mostrare in pubblico, trasmettere o rendere disponibile al pubblico una parte qualsiasi del Servizio o in alternativa fare qualsiasi uso del Servizio o del suo contenuto che non sia espressamente permesso ai sensi degli Accordi o della legge vigente, o che altrimenti violi i diritti di proprietà intellettuale (come il copyright) di WANNA PLAYS o di qualsiasi loro parte;
utilizzare WANNA PLAYS per importare o copiare file locali per cui non si dispone dei diritti legali necessari per farlo in questo modo;
trasferire copie di Contenuti presenti nella cache da un Dispositivo autorizzato a qualsiasi altro Dispositivo tramite qualsiasi mezzo;
eseguire l’ingegnerizzazione inversa, decompilare, disassemblare, modificare o creare lavori derivati basati sul servizio WANNA PLAYS o qualsiasi sua parte, tranne ove permesso dalla legge vigente;
aggirare qualsiasi tecnologia usata da WANNA PLAYS, i suoi licenzianti o altre terze parti al fine di proteggere i contenuti o i servizi;
vendere, noleggiare, subappaltare o concedere in leasing qualsiasi parte del Servizio WANNA PLAYS;
aggirare eventuali restrizioni territoriali applicate da WANNA PLAYS o dai suoi licenzianti;
aumentare in modo artificiale il conteggio delle accettazioni di incarichi, o manipolare i servizi in qualsiasi altro modo mediante script o altri processi automatizzati;
rimuovere o modificare copyright, marchi registrati o altre indicazioni di proprietà intellettuale contenuti in o forniti tramite il Servizio WANNA PLAYS (compreso al fine di occultare o modificare eventuali indicazioni di proprietà o provenienza di qualsiasi contenuto);
fornire la propria password ad altre persone, o utilizzare nome utente e password di altre persone;
eseguire il “crawling” all’interno di WANNA PLAYS, o usare altri mezzi automatizzati (compresi bot, scraper e spider) per raccogliere informazioni da ; WANNA PLAYS


Si prega di rispettare WANNA PLAYS , i proprietari del servizio e altri utenti del Servizio WANNA PLAYS, di non impegnarsi in attività illegali, pubblicare i contenuti utente o registrare e/o utilizzare un nome utente che sia o comprenda materiale: offensivo, denigratorio, diffamatorio, pornografico, minaccioso o osceno; illegale o concepito per promuovere o commettere atti illegali di qualsiasi genere, compresa in forma non limitativa la violazione di diritti di proprietà intellettuale, diritti alla privacy o diritti esclusivi di WANNA PLAYS o terze parti; volutamente contenente la propria password, la password di un altro utente o dati personali di terze parti, o concepito per sollecitare la concessione di tali dati personali; maligno come malware, cavalli di Troia o virus, o altrimenti in grado di interferire con l’accesso degli utenti al Servizio; concepito o in grado di causare disturbo o molestie ad altri utenti; in grado di fingere o travisare la propria affiliazione con altri utenti, persone o entità, o altrimenti fraudolento, falso, ingannevole o fuorviante; che fa uso di mezzi automatizzati per promuovere artificialmente un contenuto;
che comporti la trasmissione di messaggi di massa non richiesti o altre forme di spam (“spam”), posta indesiderata, catene di messaggi o simili, ivi incluso attraverso la casella in entrata di WANNA PLAYS;
che comporti attività commerciali o di vendita, come pubblicità, promozioni, concorsi, lotterie o schemi a piramide, che non siano espressamente autorizzate da WANNA PLAYS; che colleghi, faccia riferimento o altrimenti promuova prodotti o servizi commerciali, tranne ove espressamente autorizzato da WANNA PLAYS; in grado di interferire con o interrompere in qualsiasi modo il Servizio, manomettere, violare o tentare di sondare, esaminare o sottoporre a prove di vulnerabilità il Servizio o i sistemi di computer o la rete di WANNA PLAYS, le regole di utilizzo o qualsiasi altro componente di sicurezza, misura di autenticazione o altra misura di protezione di WANNA PLAYS applicabile a Servizio o qualsiasi sua parte; o che causi conflitti con gli Accordi, come stabilito da WANNA PLAYS.
L’utente comprende e accetta che la pubblicazione di tale Contenuto utente può comportare la chiusura o la sospensione immediata del suo account WANNA PLAYS. L’utente accetta anche che WANNA PLAYS possa richiamare il suo nome utente per qualsiasi motivo.


Si invita a fare attenzione al modo in cui viene usato il Servizio WANNA PLAYS e a ciò che si condivide. Il Servizio WANNA PLAYS comprende funzionalità sociali e interattive, tra cui la capacità di pubblicare Contenuto utente, condividere contenuti e rendere pubbliche alcune informazioni personali. Si prega di ricordare che le informazioni condivise o pubblicamente disponibili possono essere utilizzate o ricondivise da altri utenti su WANNA PLAYS o altrove nel Web, pertanto si prega di usare WANNA PLAYS con cautela e di fare attenzione alle impostazioni del proprio account.
WANNA PLAYS non ha alcuna responsabilità in merito alla decisione dell’utente di pubblicare materiali sul Servizio.


La password protegge l’account utente, e l’utente è l’unico responsabile della sua conservazione in modo riservato e sicuro. L’utente comprende di essere responsabile di ogni uso del proprio nome utente e della propria password all’interno del Servizio. In caso di furto o smarrimento di nome utente o password, o se si ritiene che vi siano stati accessi non autorizzati al proprio account da parte di terze parti, si prega di comunicarlo immediatamente e di modificare la propria password il più presto possibile.


14 – Violazione e segnalazione di contenuti utente


WANNA PLAYS rispetta i diritti dei propri utenti e dei proprietari di proprietà intellettuali. Se si ritiene che un Contenuto violi i propri diritti di proprietà intellettuale o altri diritti, avvisaci con una email all’indirizzo XXXXX Qualora venga informata da un titolare di copyright della violazione di un copyright da parte di un Contenuto, WANNA PLAYS potrà intervenire a propria assoluta discrezione senza previa comunicazione al fornitore di tale Contenuto.


Se si ritiene che un Contenuto non rispetti le Linee guida per gli utenti, si invita ad effettuare una comunicazione playswanna@gmail.com.


15 – Limitazioni e variazioni del Servizi


In caso di difficoltà tecniche o operazioni di manutenzione che possono causare interruzioni temporanee, nei limiti previsti dalla legge vigente, WANNA PLAYS si riserva il diritto di modificare o interrompere, periodicamente e in qualsiasi momento, e in modo temporaneo o permanente, funzioni e funzionalità del WANNA PLAYS, con o senza preavviso e senza alcuna responsabilità nei confronti degli utenti, tranne ove proibito dalla legge, per eventuali interruzioni, modifiche o cessazioni del Servizio WANNA PLAYS o di altre funzioni o funzionalità correlate.


 


16 – VARIAZIONE DEGLI ACCORDI


WANNA PLAYS può apportare modifiche agli Accordi. In caso di modifiche materiali agli Accordi, WANNA PLAYS informerà gli utenti come appropriato in base alle circostanze, ad esempio visualizzando i comunicati importanti all’interno del Servizio o inviando un’e-mail. In alcuni casi WANNA PLAYS informerà gli utenti anticipatamente, e il protrarsi dell’uso del Servizio dopo l’esecuzione delle modifiche costituirà l’accettazione delle modifiche da parte degli utenti in questione. Si prega pertanto di assicurarsi di leggere attentamente eventuali comunicazioni di questo tipo. Laddove non si desideri continuare a utilizzare il Servizio, in conformità con la nuova versione degli Accordi, sarà possibile terminare il contratto e recedere dallo stesso smettendo di utilizzare l’Applicazione e chiedendo di essere eliminati dal database all’indirizzo on line playswanna@gmail.com


17 – Assistenza clienti


Per ottenere l’assistenza clienti su domande riguardanti account e pagamenti, si prega di inviare una nota all’indirizzo playswanna@gmail.comWANNA PLAYS farà ogni tentativo ragionevole per rispondere a tutte le Richieste inviate entro un lasso di tempo ragionevole, ma non garantisce in alcun modo che le Richieste all’Assistenza clienti possano ricevere una risposta in un particolare lasso di tempo e/o che sia possibile rispondervi in maniera soddisfacente.


19 – Pagamenti, cancellazioni e ripensamenti


Gli Abbonamenti a pagamento possono essere acquistati (1) pagando un canone di abbonamento mensile o maggiore; o (2) mediante pagamento di un canone annuale o maggiore; (3) o mediante pagamento anticipato per avere accesso al Servizio WANNA PLAYS per uno specifico periodo di tempo (“Periodo anticipato”) o (4) mediante altre tipologie di pagamenti che di volta in volta saranno pubblicati sul sito internet LINK oppure in altra maniera.


Tranne ove l’Abbonamento a pagamento sia stato acquistato come Periodo anticipato, il pagamento effettuato a WANNA PLAYS  sarà rinnovato automaticamente al termine del periodo di abbonamento, tranne ove l’utente annulli l’Abbonamento a pagamento mediante l’apposita pagina prima della fine del periodo di abbonamento in corso, oppure chieda espressamente a WANNA PLAYS di annullarlo all’indirizzo MAIL. L’annullamento avrà valore a partire dal giorno successivo all’ultimo giorno del periodo di abbonamento in corso, e l’utente sarà riportato al livello di Servizio gratuito. Tuttavia, WANNA PLAYS non rimborserà alcun canone di abbonamento già pagato laddove l’utente annulli il proprio pagamento o Abbonamento a pagamento prima della scadenza del termine pattuito.


In caso di abbonamenti prepagati di più mesi, acquistati con uno sconto, l’utente potrà chiedere l’annullamento dell’abbonamento anche prima della scadenza, tuttavia non potrà più usufruire dello sconto ricevuto, che sarà revocato; l’annullamento dell’abbonamento avrà effetto dal periodo mensile successivo a quello della richiesta, e l’operazione di annullamento del contratto, calcolo ed emissione di nota di credito ed annullamento potrà avere un costo di € 5,00 che sarà addebitato a discrezione di WANNA PLAYS.


WANNA PLAYS può modificare il prezzo di Abbonamenti a pagamento, e comunicherà in anticipo eventuali variazioni di prezzo e, se pertinente, come accettare tali variazioni. Le variazioni di prezzo per gli Abbonamenti a pagamento avranno efficacia a partire dal periodo di abbonamento successivo alla data della modifica. Ove consentito dalla legge locale, continuando a utilizzare il servizio  dopo l’entrata in vigore della variazione di prezzo, l’utente accetta il nuovo prezzo. Qualora decida di non accettare la variazione di prezzo, l’utente ha il diritto di rifiutarla annullando la propria sottoscrizione all’indirizzo MAIL o altro a pagamento, prima che tale variazione entri in vigore. Qualora i servizi a pagamento dovessero divenire gratuiti, nessun rimborso sarà previsto per gli utenti che abbiano ancora in corso i precedenti abbonamenti; in tale caso WANNA PLAYS si riserva il diritto di mettere a disposizione dell’utente ulteriori servizi a pagamento, senza costi aggiuntivi per l’utente stesso, fino alla totale compensazione della porzione di abbonamento ancora non usufruito. Si prega pertanto di assicurarsi di leggere attentamente eventuali comunicazioni relative alle variazioni di prezzo.


20 – Termine e annullamento


Gli Accordi rimarranno in vigore fino a quando non saranno terminati dall’utente o da WANNA PLAYS.
Tuttavia, l’utente comprende e accetta che la licenza perpetua concessa in relazione al Contenuto utente, incluso il Feedback, è irrevocabile e continuerà pertanto anche dopo la scadenza o il termine per qualsiasi motivo degli Accordi.
WANNA PLAYS può terminare gli Accordi o sospendere l’accesso al Servizio da parte dell’utente in qualsiasi momento, compreso nel caso di un uso non autorizzato effettivo o presunto del Servizio o di mancato rispetto degli Accordi. Qualora l’utente o WANNA PLAYS terminino gli Accordi, oppure laddove WANNA PLAYS sospenda l’accesso al Servizio da parte dell’utente, questi accetta che WANNA PLAYS non avrà alcuna responsabilità nei suoi confronti e che WANNA PLAYS non rimborserà alcun importo già pagato dall’utente, nei limiti massimi consentiti ai sensi della legge vigente. Questa sezione sarà applicata nei limiti massimi previsti dalla legge vigente. L’utente può terminare gli Accordi in qualsiasi momento.


A tale termine sopravvivranno le Sezioni: Contenuti generati dagli utenti, Diritti  riconosciuti dagli utenti a WANNA PLAYS, Linee guida per gli utenti, Limitazioni e variazioni del Servizio, Termine e annullamento, Garanzia e disconoscimento di responsabilità, Limitazioni, Diritti di terze parti, Intero accordo, Indennizzo,  Scelta di giurisdizione arbitrato obbligatorio e competenza,  qui riportate, e qualsiasi altra sezione degli Accordi che, sia esplicitamente che per propria natura, devono rimanere in vigore anche dopo il termine degli Accordi.


21 – Diritti di terze parti


Qualora abbia scaricato l’app dall’App Store di Apple, Inc. (“Apple”) o in caso di utilizzo dell’app su un dispositivo iOS, l’utente conferma di aver letto, compreso e accettato la seguente informativa su Apple. Questo Accordo viene sottoscritto solo dall’utente e da WANNA PLAYS, non con Apple, pertanto Apple non è responsabile del Servizio e dei suoi contenuti. Apple non ha alcun obbligo di fornire servizi di manutenzione e supporto in relazione al Servizio. In caso di un malfunzionamento del Servizio nel rispettare qualsiasi garanzia applicabile, è possibile informare Apple e Apple rimborserà all’utente eventuali costi di acquisti applicabili per l’app; inoltre, nei limiti previsti dalla legge vigente, Apple non ha alcun altro obbligo di garanzia di qualsiasi tipo in relazione al Servizio. Apple non è responsabile della risoluzione di eventuali richieste presentate dall’utente o da terze parti in relazione al Servizio o al possesso e/o utilizzo del Servizio da parte dell’utente, compresi in forma non limitativa: (1) reclami per responsabilità del prodotto; (2) reclami secondo cui il Servizio non è conforme ai requisiti legali o normativi vigenti; e (3) reclami presentati ai sensi di norme per la protezione del consumatore o legislazione simile. Apple non è responsabile di indagini, difesa, liquidazione ed estinzione di eventuali reclami di terze parti secondo cui il Servizio e/o il possesso e l’utilizzo dell’app da parte dell’utente viola i diritti di proprietà intellettuale di tali terze parti. Durante l’uso del Servizio, l’utente accetta di rispettare i termini vigenti di terze parti. Apple e le sue consociate sono beneficiari terze parti di questo Accordo e, con l’accettazione dell’Accordo da parte dell’utente, Apple avrà il diritto (e sarà ritenuta come avente accettato il diritto) di applicare questo Accordo nei confronti dell’utente come beneficiario terza parte dell’Accordo.






22 – Indennizzo


Nei limiti massimi previsti dalla legge vigente, l’utente accetta di indennizzare e ritenere WANNA PLAYS indenne da e in relazione a danni, perdite e spese di qualsiasi genere (ivi inclusi ragionevoli costi e onorari di legali) derivanti da: (1) la violazione di questo Accordo da parte dell’utente; (2) qualsiasi Contenuto utente; (3) qualsiasi attività in cui l’utente si impegna o esegue tramite il Servizio WANNA PLAYS; e (4) la violazione di qualsiasi legge o dei diritti di una terza parte a opera dell’utente.


23 – Scelta di giurisdizione, arbitrato obbligatorio


23.1. Legge/giurisdizione competente


L’interpretazione, esecuzione e risoluzione del presente contratto sono rette dalla legge italiana. In caso di controversie, l’unico foro competente in via esclusiva è quello di Brescia.


23.2. Clausola di Mediazione


L’utente accetta che per qualsiasi controversia in marito al contratto ed alla sua esecuzione sarà obbligatorio esperire un tentativo di Conciliazione presso un Organismo di Mediazione Civile operante nel Foro del Tribunale di Brescia.


23.3.  Rinuncia al diritto di Class Action


L’UTENTE E WANNA PLAYS CONCORDANO CHE CIASCUNO POTRÀ PRESENTARE RICHIESTE NEI CONFRONTI DELL’ALTRO SOLO NELLA PROPRIA VESTE INDIVIDUALE E NON COME UN RICORRENTE O MEMBRO DI UNA CLASS ACTION IN QUALSIASI CLASSE PRESUNTA O AZIONE RAPPRESENTATIVA. Tranne ove concordato da utente e WANNA PLAYS, nessun arbitro o giudice potrà consolidare le richieste di più di una persona o altrimenti presiedere a qualsiasi forma di procedimento rappresentante o di classe.


24 – Contatti


Per ulteriori informazioni e per entrare in contatto con WANNA PLAYS potrete scrivere a WANNA PLAYS andare sul sito www.wannaplays.fun oppure scrivere all’indirizzo email playswanna@gmail.com.


Ultimo aggiornamento: 25/03/2024
""";
  static showSnackBar(context, msg, {button}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: AppColor.maincolor,
      margin: const EdgeInsets.all(5),
      behavior: SnackBarBehavior.floating,
    ));
  }

  // static double calculateDistance(lat1, lon1, lat2, lon2) {
  //   var p = 0.017453292519943295;
  //   var c = cos;
  //   var a = 0.5 -
  //       c((lat2 - lat1) * p) / 2 +
  //       c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  //   return 12742 * asin(sqrt(a));
  // }

  static hideKeypad(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static String kGoogleApiKey = "AIzaSyDsgaZKVLKFwXctNJ2n5HMjt_N7-IwGSmY";
  static FirebaseAuth auth = FirebaseAuth.instance;

  static User? currentUser = auth.currentUser;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static UserModel? user;

  static Future<DateTime?> datePicker(
    context, {
    required DateTime initialDate,
  }) async {
    return await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1950),
        lastDate: DateTime.now());
  }

  static Future<File?> imagePickerSheet(context) {
    late var imageVar;
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context, ImageSource.camera);
                    },
                    horizontalTitleGap: 0,
                    title: const Text('Camera', style: TextStyle(fontSize: 18)),
                    leading:
                        const Icon(Icons.camera_alt, color: AppColor.maincolor),
                  ),
                  ListTile(
                    horizontalTitleGap: 0,
                    onTap: () {
                      Navigator.pop(context, ImageSource.gallery);
                    },
                    title: const Text("Gallery",
                        style: TextStyle(
                          fontSize: 18,
                        )),
                    leading: const Icon(Icons.image, color: AppColor.maincolor),
                  ),
                ],
              ),
            ),
          );
        },
        elevation: 20.0,
        useRootNavigator: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ))).then((value) {
      if (value != null) {
        return imageVar = onCameraTap(context, value);
      } else {
        return imageVar = value;
      }
    });
  }

  static Future<File?> onCameraTap(context, ImageSource source) {
    return ImagePicker.platform
        .getImageFromSource(source: source)
        .then((value) {
      if (value != null) {
        File imageVar = File(value.path);
        return imageVar;
      } else {
        BaseHelper.showSnackBar(context, 'Please Select any file');
      }
      return null;
    });
  }

  static int getAge(String data){
if (data!="") {
   final startDate= DateFormat("MMM,dd,yyyy").parse(data);
final now=DateTime.now();
Duration duration=now.difference(startDate);
 double age=(duration.inDays)/365.toInt();
 return age.toInt();
}
return 23;
  }
}
