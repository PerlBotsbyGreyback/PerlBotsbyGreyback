#!/opt/ActivePerl-5.10/bin/perl

use Socket;                                    
use IO::Socket;                                
use IO::Socket::INET;                          
use IO::Select;
use threads;
use threads::shared;
use Net::IP;                               

#NOME PROCESSO
bot:
my $np = 'guardiano-notturno';


#DATI ACCESSO IRCD
my $mynick = 'guardiano-notturno';           
my $passn = 'abele241162';  
my $ircd = '23.249.161.162'; 
my $porta = 6666;
my $channel = "#MusicStyle_staff";
my $chanpass    = "spy";
my $channelspia = "#MusicStyle";
my $admin = "abele";
my $admin2 = "^maestro";
my $operNick = "abele";
my $operPass = "silvano1162";
my $numutenti   = 0;
my $ip          = "5.196.100.116"; # <<== ip del server sul quale lo carichi
my $passwdChat = "coccolone"; # <<== password di DCC chat
my $variabileStop = "NULL";
my $nickInizioShell = "Aura|"; # <<== inizio delle shell, Es: AnIme|DragonBall
my $checkCounter = 0;
my $checkCount = "off";
my $checkConnessione = 0;


#PROCESSO CGI
$0="$np"."\0"x16;;
my $PID = fork;
exit if $PID;

#CHECPOINT CONNESSIONE
connetti:

#CONNESSIONE
my $net = new IO::Socket::INET(	PeerAddr => $ircd, 
				PeerPort => $porta, 
				Proto => 'tcp') or print "Non riesco a connettermi al server\r\n" and goto connetti;

#DICO AL SERVER IL MIO NICK E IL MIO NOME REALE
print $net "NICK $mynick\r\n";
print $net "USER Bot 0 * :SpyBot By Greyback\r\n";


while ($ircmsg = <$net>){
$ircmsg =~ s/\r\n$//;
#SOLO DOPO AVER TERMINATO IL MESSAGGIO DI BENVENUTO DEL SERVER ESEGUO ULTERIORI COMANDI
if ($ircmsg=~ /^:(.+?)\.(.+?)\.(.+?) (.+?) $mynick :(.+?) (.+?) \/MOTD (.+?)\./i){
print $net "JOIN $channel $chanpass\r\n";
print $net "JOIN $channelspia $chanpass\r\n";
print $net "NS IDENTIFY $passn\r\n";
unlink ("status.db");
open ( FILE, ">> status.db");
print FILE "on\n";
close(FILE);
sendraw ("OPER $operNick $operPass");
sendraw ("PART #irc-files");
sendraw ("PART #irchelp");
sendraw ("PART #services");
sendraw ("PART #vhost");
sendraw ("PART #OPERS");
}

#RISPONDO AI PING DEL SERVER
    if ($ircmsg =~ /^PING \:(.*)/) {
        sendraw("PONG :$1");
    }

if ( ($ircmsg =~/:.+ 366 .+ :End of \/NAMES/i ) ) 
	{
		if ( $variabileStop eq "0" && $checkCount eq "on")
		{
			sendraw ("PRIVMSG $channel 8A11ggiornamento 8L11ista 8S11hell 8C11ompletato");
		}
		$variabileStop = "NULL";

    		if ( $checkCount eq "on" ) {
        	$file = 'shells.lst';
         	open(INFO, $file);
         	@righe = <INFO>;
         	close(INFO);

         	@bot = @righe;

       		&contabot($nick);

      		&msg ("$channel", "13 \[11LoaDing ShELLs13\] 8Tutti i Bot Sono Stati Caricati 13\[8$numBot13\]");
                              		    }
	}


	if ( ($ircmsg =~ /:.+? 353 (.+?) . (.+?) :(.+)/i ) )
	{
		my $nickU = $1;
		my $chanU = $2;
		my $nomi = $3;

		if ( ($nickU =~ m/$mynick/i) and ($chanU =~ m/$channelspia/i) )
		{

			@nomi = split(" ", $nomi);
			if ( $variabileStop eq "0" )
			{
				foreach $y (@nomi)
				{
					if ( ($y =~ m/\+$nickInizioShell\-/i) ) #prende le shell
					{
						$y =~ s/\+//g;
						my $result = open ( FILE, ">> shells.lst");
						print FILE "${y}\n";
						close(FILE);
					}
					if ( ($y =~ m/\%$nickInizioShell\-/i) ) #prende le shell
					{
						$y =~ s/\%//g;
						my $result = open ( FILE, ">> shells.lst");
						print FILE "${y}\n";
						close(FILE);
					}
					if ( ($y =~ m/\@$nickInizioShell\-/i) ) #prende le shell
					{
						$y =~ s/\@//g;
						my $result = open ( FILE, ">> shells.lst");
						print FILE "${y}\n";
						close(FILE);
					}
				}
			}
		}
	}


     if ($ircmsg =~ /^\:(.+?)\!(.+?)\@(.+?) PRIVMSG (.+?) \:(.+)/) {
            my ($nick,$ident,$host,$path,$msg) = ($1,$2,$3,$4,$5);

            if (&isAdmin($nick) && $msg =~ /^!esci$/i) {
                   system("kill -USR1 `pidof $np`");
                }

      if ((uc($path) eq uc($channel)) && &isAdmin($nick) && $msg =~ /^!help$/i) {


	&msg ("$channel", "8>> SpyBot Help");
        &msg ("$channel", "811Lista comandi: 813!attiva antireflex  ==>  11Per attivare l'antireflex");
        &msg ("$channel", "811Lista comandi: 813!disattiva antireflex  ==>  11Per disattivare l'antireflex");
        &msg ("$channel", "811Lista comandi: 813!add nickUtente  ==>  11Per aggiungere un nick alle eccezioni reflex");
        &msg ("$channel", "811Lista comandi: 813!del nickUtente  ==>  11Per rimuovere un nick alle eccezioni reflex");
        &msg ("$channel", "811Lista comandi: 813!elenco  ==>  11Per visualizzare la lista eccezioni reflex");
        &msg ("$channel", "811Lista comandi: 813!reset  ==>  11Per cancellare la lista eccezioni");
        &msg ("$channel", "811Lista comandi: 813!conta  ==>  11Per contare le shells");
        &msg ("$channel", "811Lista comandi: 813!attiva  ==>  11Per connettere tutte le shells");
        &msg ("$channel", "811Lista comandi: 813!disattiva  ==>  11Per disconnettere tutte le shells");
        &msg ("$channel", "811Lista comandi: 813!apri nomeShell  ==>  11Per aprire una singola shell");
        &msg ("$channel", "811Lista comandi: 813!chiudi nomeShell  ==>  11Per chiudere una singola shell");
        &msg ("$channel", "811Lista comandi: 813!dcld  ==>  11Per visualizzare i trasferimenti di tutte le shells");
        &msg ("$channel", "811Lista comandi: 813!dcld nomeShell  ==>  11Per visualizzare i trasferimenti di una singola shell");
        &msg ("$channel", "811Lista comandi: 813!esci  ==>  11Perquittare il bot");

	}

      if ((uc($path) eq uc($channel)) && &isAdmin($nick) && $msg =~ /^!attiva antireflex$/i) {

	unlink ("status.db");
	open ( FILE, ">> status.db");
	print FILE "on\n";
	close(FILE);
       

      &msg ("$channel", "13 \[11StaTus AnTiReflex13\] 8L'AntiReflex è Stato Attivato.");
              
	}

      if ((uc($path) eq uc($channel)) && &isAdmin($nick) && $msg =~ /^!disattiva antireflex$/i) {
	
	unlink ("status.db");
	open ( FILE, ">> status.db");
	print FILE "off\n";
	close(FILE);
       

      &msg ("$channel", "13 \[11StaTus AnTiReflex13\] 8L'AntiReflex è Stato Disattivato.");
              
	}

      if ((uc($path) eq uc($channel)) && &isAdmin($nick) && $msg =~ /^!add (.*)/i) {
	
		my $flag = 0;

			$except = substr ($except, 0, -1);
			$except =~ s/ //g;
			my $fileId = open ( FILE, "< except.lst");
			while ( $riga = <FILE> )
			{
				$riga = substr ($riga, 0, -1);
				if ( $riga eq $1 || $riga =~ /^$1$/i ) { $flag = 1; }
			}
			close(FILE);
			if ( $flag == 0 )
			{
				my $fileId = open ( FILE, ">> except.lst");
				print FILE "$1\n";
				sendraw ("PRIVMSG $channel 13[E8xcept 13I8nserita13]");
				close(FILE);
			} else {
				sendraw ("PRIVMSG $channel 13[E8rror... 13E8xcept 13G9ia 31P8resente13]");
			}
		

	}


      if ((uc($path) eq uc($channel)) && &isAdmin($nick) && $msg =~ /^!del (.*)/i) {
	
	{
		my $flag = 0;


			my $fileId = open ( FILE, "< except.lst");
			while ( $riga = <FILE> )  {
				$riga = substr ($riga, 0, -1);
				if ( $riga eq $1 || $riga =~ /^$1$/i ) { $flag = 1; }
			}
			close(FILE);
			if ( $flag == 1 )
			{
				my $fileId = open ( FILE, "< except.lst");
				my $fileId2 = open ( FILE2, ">> except2.lst");
				while ( $riga = <FILE> )  {
					$riga = substr ($riga, 0, -1);
					if ( !($riga eq $1 || $riga =~ /^$1$/i) ) { print FILE2 "$riga\n"; }
				}
				close(FILE);
				close(FILE2);
				sendraw ("PRIVMSG $channel 13[E8xcept 13C8ancellata13]");
				unlink("except.lst");
				rename("except2.lst", "except.lst");
				unlink("except2.lst");
			} else {
				sendraw ("PRIVMSG $channel :13[E9rror... 13A8dmin 13N8on 13P8resente13]");
			}
		
		}	

	}


      if ((uc($path) eq uc($channel)) && &isAdmin($nick) && $msg =~ /^!elenco$/i) {
	

			my $fileId = open ( FILE, "< except.lst");
			my $i = 0;
			sendraw ("PRIVMSG $channel 13[L8ista 13E8xcept13]");
			while ( $riga = <FILE> )  {
				$i++;
				$riga = substr ($riga, 0, -1);
				sendraw ("PRIVMSG $channel 13$i.8 ${riga}");
			}
			sendraw ("PRIVMSG $channel 13[T8otale 13E8xcept13:8 ${i}13]");
			close(FILE);
			
	}

      if ((uc($path) eq uc($channel)) && &isAdmin($nick) && $msg =~ /^!reset/i) {
		unlink ("except.lst");
		sendraw ("PRIVMSG $channel 8Lista Resettata Correttamente");
	}

      if ((uc($path) eq uc($channel)) && &isAdmin($nick) && $msg =~ /^!attiva$/i) {

      		sendraw("PRIVMSG $channel 8Richiesta DCC Chat 13Inviata 8Alle SheLLs, Attendere Prego...");
       
      if ($checkCounter eq 1 && $checkConnessione eq 0) { 

       		&contabot($nick);

        	for ( $i = 0 ; $i < $numBot ; $i++) {

            	chomp $bot[$i];
            	&connectDccChatApri($bot[$i]);

          	}

      		&msg ("$channel", "13 \[11Open ShEllS13\] 8Tutti i Bot Sono Stati Connessi."); $checkConnessione = 1; 

                }

        else {
        	if ($checkCounter eq 0) { &msg ("$channel", "13 \[11Open ShEllS13\] 8Impossibile Eseguire L'Operazione: 11Lista Bot Vuota. 8Digitare !Conta Per Creare L'elenco Dei Bot"); }
             
        	if ($checkConnessione eq 1) { &msg ("$channel", "13 \[11Open ShEllS13\] 8Impossibile Eseguire L'Operazione: 11I Bot Sono Stati già Connessi! ");}
             }
              
	}


      if ((uc($path) eq uc($channel)) && &isAdmin($nick) && $msg =~ /^!disattiva$/i) {
       
       		&contabot($nick);

        	for ( $i = 0 ; $i < $numBot ; $i++) {

            	chomp $bot[$i];
            	&msg ("$bot[$i]", "admin $passwdChat lag");


          }
      		&msg ("$channel", "13 \[11CloSe ShEllS13\] 8Tutti i Bot Sono Stati Disconnessi."); $checkConnessione = 0;
              
	}

      if ((uc($path) eq uc($channel)) && &isAdmin($nick) && &isAdmin($nick) && $msg =~ /^!apri (.*)/i) {
      		&msg ("$channel", "13\[11Open ShEllS13\] 8RiChieSta Di DCC Chat Inviata Al nick 11$1.");
             	$nickss = $1;
       		if (&isBot($nickss)) {

		&connectDccChatApri($nickss);

                       }

         else { &msg ("$channel", "13 \[11Open ShEllS13\] 8Impossibile Connettersi a $nickss: 11Non è Un Bot.");}
	}

      if ((uc($path) eq uc($channel)) && &isAdmin($nick) && $msg =~ /^!chiudi (.*)/i) {
       		$nickss = $1;
       		if (&isBot($nickss)) {
       		&msg ("$nickss", "admin $passwdChat lag");
       		&msg ("$channel", "13 \[11CloSe ShELLs13\] 8 Bot $nickss Chiuso.");
                            }
       		else { &msg ("$channel", "13 \[11CloSe ShEllS13\] 8Impossibile Disconnettersi da $nickss: 11Non è Un Bot.");}


	}


      if ((uc($path) eq uc($channel)) && &isAdmin($nick) && $msg =~ /^!dcld$/i) {

       		if ($checkConnessione eq 1) {

       		&contabot($nick);

        	for ( $i = 0 ; $i < $numBot ; $i++) {

            	&msg ("$bot[$i]", "admin $passwdChat dcld");

	          	}
		}

		else {&msg ("$channel", "13 \[11Open ShEllS13\] 8Impossibile Eseguire L'Operazione: 11I Bot Non Sono Connessi! ");}
              
	}

      if ((uc($path) eq uc($channel)) && &isAdmin($nick) && $msg =~ /^!dcld (.*)/i) {
                $nickss = $1;
       		if (&isBot($nickss)) {

            	&msg ("$nickss", "admin $passwdChat dcld");
              
                            }
            	else { &msg ("$channel", "8Impossibile Eseguire L'Operazione: 11$nickss Non è Un Bot.");}
	}


      if ((uc($path) eq uc($channel)) && &isAdmin($nick) && $msg =~ /^!conta$/i)
		{

			$variabileStop = "0";
			$checkCount = "on";
			unlink("shells.lst");
			sendraw ("PRIVMSG $channel 8A11ggiornamento 8L11ista 8S11hell 8I11n 8C11orso...");
			sendraw ("NAMES $channelspia"); $checkCounter = 1;



		}


	}



}


sub dccChat
{
	my $nick = shift;
	my $realip = new Net::IP ( $ip ) || die "Inserisci un ip valido..";
	my $intip = $realip->intip();
	my $DCCsocket = new IO::Socket::INET ( Listen => 1, Proto => 'tcp' );
	$DCCsocket->autoflush(1);
	my $DCCport = $DCCsocket->sockport();
	print $net "PRIVMSG " . $nick . " :\001DCC CHAT chat " . $intip . " " . $DCCport . "\001\r\n";
	my $DCCsock = $DCCsocket->accept();
	close $DCCsocket;

	while ($rcv = <$DCCsock>)
	{
		
		if ($rcv =~ /Password/i) { print $DCCsock "$passwdChat\012"; } 
                if ($rcv =~ /^Password errata$/i) { sendraw ("PRIVMSG $channel 13\[11Open ShEllS13\] 8Errore: Pass DCC $nick errata! "); }
                                                                                    
		if ($rcv =~ /Entrato nell'interfaccia Admin della DCC Chat/i) {

		unlink("/home/Anime/prova/shellapertes.lst");
		      open(SUKA, '>>', "shellsaperte.db");
      		      print SUKA "$nick\r\n";
      		      close (SUKA);
                                                                                  }


		if ($rcv =~ /XDCC SEND (.*): richiesto \((.*) (.+?)!/i)
		{


			sendraw ("PRIVMSG $channel :13 \[11Download Avviato13\]8 Dall'User13 $2, 8Pacco 13$1 8Dal Bot 13" .$nick. ". ");

			$rcv = "";
		}
		if ($rcv =~ /ADMIN DCLD Richiesto \(MSG.+?\)/i) { print $DCCsock "dcld\012"; }

		if ($rcv =~ /([0-9]+?)( +?)(.+?)( +?)([0-9]+?)( +?)(.+?)( +?)Sto inviando( +?)([0-9]+?)%/i)
		{ 
			my $ids = $1;
			my $nicks = $3;
			my $packs = $5;
			my $files = $7;
			my $percents = $10;
			$files =~ s/ //g;
			$nicks =~ s/ //g;
			sendraw ("PRIVMSG $channel 13 \[11TraSfeRimenTi13\]8 Dalla SheLL13 $nick8 l'User13 $nicks 8Sta Scaricando Il File13 $files 8(id13 $ids8, Pack13 #${packs}8) e Sta Al13 $percents%8. ");	$rcv = "";
		}

		if ($rcv =~ /XDCC \[(.*):(.*) on (.*)\]: Trasferimento Completato \((.*) KB, (.*) sec, (.*) Kb\/s/i)
		{ 

			sendraw ("PRIVMSG $channel 13 \[11TraSfeRimenTi13\]8 l'User13 $2 8Ha TeRmiNatO Il Download 8 Dalla SheLL13 " .$nick ." 8in13 $5 sec 8Alla Velocità Di 13$6 Kb\s");	$rcv = "";
		}

		if ($rcv =~ /XDCC SEND (.+?): Accodato \(slot\) \((.*) (.*)\!\~(.*)\@(.*) on (.*)\)/i)
		{
			my $number = $1;
			my $nicks = $2;
			$number =~ s/#//;
		        sendraw ("PRIVMSG $channel 13 \[11In Coda13\]8 L'User13 $nicks 8è In Coda Per Il Pack13 #${number} 8Sulla SheLL13 $nick8. ");
			$rcv = "";
		}

		if ($rcv =~ /QUEUED SEND: (.+?) \(.+?\), Pack (.+)/i)
		{
			my $nicks = $1;
			my $packs = $2;
			$packs =~ s/#//;

			sendraw ("PRIVMSG $channel 13 \[11DownloaD13\]8 L'User13 $nicks 8Dopo La Coda, Sta ScaRicanDo Il Pack13 #${packs} 8Dalla SheLL13 $nick8. "); 
			$rcv = "";

		}

		if ($rcv =~ /XDCC \[([0-9]+?):(.+?) on .+?\]: Connessione Terminata:/i) {

			my $nickDL = $2;

                        sendraw ("PRIVMSG $channel 13 \[11TraSfeRimenTi13\]8 L'User13 $2 8Ha InTeRRoTTo Il Download 8 DaLLa SheLL13 " .$nick ."");	$rcv = "";

                  }

		if ($rcv =~ /Nessun trasferimento attivo/i) { &msg ("$channel", "13 \[11TraSfeRimenTi13\]8 Dalla SheLL13 $nick: 8Non Ci Sono Download In Corso. "); 	$rcv = "";}

		if ($rcv =~ /ADMIN LAG/i) { close($DCCsock); last; }


		if ($rcv =~ /XDCC \[([0-9]+?):(.+?) on .+?\]: Connessione stabilita \(host=(.+?)\.(.+?)\.(.+?)\.(.+?) porta=[0-9]+? -> host=.+?\..+?\..+?\..+? porta=[0-9]+?\)/i)
		{

			my $ids = $1;
			my $nickDL = $2;
			my $ipDL = "$3.$4.$5.$6";
			$reflex = inet_aton("$ipDL");
			$controllo = gethostbyaddr($reflex, AF_INET);

			if ( &getStatusReflex =~ /on/ ) {

                        sendraw ("PRIVMSG $channel 13 \[11HoSt CHeCk13\]8 Sull'Ip13 $ipDL 8in corso..");
                     
			if ($controllo =~ /(.*).rapidevps.(.*)|(.*).ovh.(.*)|(.*).kimsufi.(.*)|ks(.*).(.*)|(.*).trueshell-host.(.*)|(.*).hostingjoker.(.*)|(.*).myhostlife.(.*)|(.*).engine-solution.(.*)|(.*).digicube.(.*)|(.*).unishell.(.*)/i )
			{
				my $flagAdm = &controllaExcept($nickDL);
				if ( $flagAdm == 1 ) {sendraw ("PRIVMSG $channel 13 \[11HoSt CHeCk13\]8 Il nick13 $nickDL 8 E' Abilitato a Reflexare");}
				else {
                                        sendraw ("PRIVMSG $channel 13 \[11HoSt CHeCk13\]8 Il nick13 $nickDL 8Sta Reflexando, BAN IMMEDIATO!");
                                        sendraw ("MODE $channelspia +b $nickDL");
                                        sendraw ("KICK $channelspia $nickDL Non Si Reflexa!");
					sendraw ("PRIVMSG $nick admin $passwdChat close ${ids}");
					sendraw ("PRIVMSG $admin 13 \[11HoSt CHeCk13\]8 Il nick13 $nickDL 8Stava RefleXanDo, Ho ProVVeDuto a BannarLo! ;D");
					sendraw ("PRIVMSG $admin2 13 \[11HoSt CHeCk13\]8 Il nick13 $nickDL 8Stava RefleXanDo, Ho ProVVeDuto a BannarLo! ;D");
		      			open(SUKA, '>>', "furbi.lst");
      		     		        print SUKA "Nick del furbo: $nickDL - IP Del server: $ipDL\r\n";
      		      			close (SUKA);
					
					}

		       }
                       else { sendraw ("PRIVMSG $channel 13 \[11HoSt CHeCk13\]8 Nessuna Anomalia Riscontrata Sul nick13 $nickDL!");}
		
	}

    }
		
}
}


sub sendraw {
    if ($#_ == '1') {
    my $net = $_[0];
    print $net "$_[1]\n";
    } else {
        print $net "$_[0]\n";
    }
}

sub getStatusReflex
{
	my $fileId = open ( FILE, "< status.db");
	$statusReflex = <FILE>;
	return $statusReflex;
}

sub isBot() {
    my $status = 0;
    my $nick = $_[0];
    if ($nick =~ /^$nickInizioShell\-/i) { $status = 1; }
    return $status;
}

sub controllaExcept
{
	my $nick = shift;
	my $flagAdm = 0;
	my $fileId = open ( FILE, "< except.lst");
	while ( $riga = <FILE> )  {
		$riga = substr ($riga, 0, -1);
		if ( ${riga} eq ${nick} || ${riga} =~ /^${nick}/i ) { $flagAdm = 1; }
	}
	close(FILE);
	return $flagAdm;
}

sub contabot() {
                   my $status = 0;
                   my $nick = $_[0];

     $count = 0;

while ($bot[$count] =~ /^$nickInizioShell\-/i) {

  $count++;

}
 $numBot = $count;


      return $status;
}


sub connectDccChatApri
{
	my $nickss = shift;

		(threads->new(\&dccChat, $nickss))->detach();


}

sub msg() {
    return unless $#_ == 1;
    sendraw($net, "PRIVMSG $_[0] :$_[1]");
}

sub nick() {
    return unless $#_ == 0;
    sendraw("NICK $_[0]");
}

sub notice() {
    return unless $#_ == 1;
    sendraw("NOTICE $_[0] :$_[1]");
}

sub isAdmin() {
    my $status = 0;
    my $nick = $_[0];
    if (uc($nick) eq uc($admin) || uc($nick) eq uc($admin2)) { $status = 1; }
    return $status;
}


# Auto-riconnessione
$irc_state = 0;
while($irc_state != 1)
{
    goto bot;
}
