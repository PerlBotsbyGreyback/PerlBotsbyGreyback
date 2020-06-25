#!/opt/ActivePerl-5.10/bin/perl

use Socket;
use IO::Socket;
use IO::Socket::INET;
use IO::Select;
use threads;
use threads::shared;
use Net::IP;
use Net::FTP;
use Sys::Hostname;
use Math::BigInt::Calc;   #fixa problema col thread
use LWP::UserAgent;
use HTTP::Request::Common qw(GET);
use HTTP::Cookies;

#NOME PROCESSO
bot:
my $np = '2014D';

#DATI ACCESSO IRCD
my $mynick = 'Canale';
my $passn = 'Password';
my $ircd = 'server';
my $porta = 6667;
my $channel = "#canale-staff";
my $chanpass    = "spy";
my $channelspia = "#canale";
my $operNick = "Admin";
my $operPass = "pass";
my $numutenti   = 0;
my $ip          = "".&getIp.""; 
my $passwdChat = "Pass dcc chat";
my $variabileStop = "NULL";
my $nickInizioShell = "MMM";
my $checkCounter = 0;
my $checkCount = "off";
my $lastBotXdl : shared = 0;
my $lastBotXdlSezioni : shared = 0;
our @bot : shared;
our @codaAgg : shared;
my $logoz = "logo.png";
my $MioLogo = "MIOLOGO.png";
my $logo = "4[8LiStaWeB-XDL_PeRL \© 20144] [8Created By Greyback4]";
my $logo2 = "4~ 7..:: 4 Bot ReaLiZZaTo Da 8 Gr3yb4ck 7 ::.. 4~";
my $controlla    = "off";
my $radio = "http://radio.eu:1080";

my $founder = "Greyback";

my $list = "http://www.sitolista.eu/";

#DATI FTP
my $sftp = "ftp server";
my $portaftp = "21";
my $userftp = "user";
my $passftp = "Pass ftp";

print('
__________             .__    ___.           __    ___.          
\______   \ ___________|  |   \_ |__   _____/  |_  \_ |__ ___.__.
 |     ___// __ \_  __ \  |    | __ \ /  _ \   __\  | __ <   |  |
 |    |   \  ___/|  | \/  |__  | \_\ (  <_> )  |    | \_\ \___  |
 |____|    \___  >__|  |____/  |___  /\____/|__|    |___  / ____|
               \/                  \/                   \/\/   

  ________                     ___.                  __    
 /  _____/______   ____ ___.__.\_ |__ _____    ____ |  | __
/   \  __\_  __ \_/ __ <   |  | | __ \\__  \ _/ ___\|  |/ /
\    \_\  \  | \/\  ___/\___  | | \_\ \/ __ \\  \___|    < 
 \______  /__|    \___  > ____| |___  (____  /\___  >__|_ \
        \/            \/\/          \/     \/     \/     \/
 
');


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
print $net "USER Bot 0 * :4[8LiStaWeB-XDL_PeRL \© 2014 By Greyback4]\r\n";


while ($ircmsg = <$net>){
$ircmsg =~ s/\r\n$//;
#SOLO DOPO AVER TERMINATO IL MESSAGGIO DI BENVENUTO DEL SERVER ESEGUO ULTERIORI COMANDI
#:N30N.QuartzNet.Org 422 asdd :MOTD File is missing
if ($ircmsg=~ /^:(.+?)\.(.+?)\.(.+?) (.+?) $mynick :MOTD File is missing/i){
print $net "JOIN $channelspia\r\n";
print $net "JOIN $channel $chanpass\r\n";
print $net "NS IDENTIFY $passn\r\n";
sendraw ("OPER $operNick $operPass");
#sendraw ("PART #irchelp");
#sendraw ("PART #services");
#sendraw ("PART #opers");
#sendraw ("PART #vhost");
#system ("rm $nickInizioShell*");
unlink ("lst.html");
unlink ("news.html");
if (&notExist("firsttime.db")) {

unlink ("timer.db");
open ( FILE, ">> timer.db");
print FILE "300\n";
close(FILE);
unlink ("griglia.db");
open ( FILE, ">> griglia.db");
print FILE "10\n";
close(FILE);
unlink ("numerovetrine.db");
open ( FILE, ">> numerovetrine.db");
print FILE "4\n";
close(FILE);
unlink ("oscura.db");
open ( FILE, ">> oscura.db");
print FILE "off\n";
close(FILE);
unlink ("statusmexjoin.db");
open ( FILE, ">> statusmexjoin.db");
print FILE "off\n";
close(FILE);
unlink ("rispostalista.db");
open ( FILE, ">> rispostalista.db");
print FILE "off\n";
close(FILE);
unlink ("rispostacomandi.db");
open ( FILE, ">> rispostacomandi.db");
print FILE "off\n";
close(FILE);
unlink ("cartella.db");
open ( FILE, ">> cartella.db");
print FILE "1010\n";
close(FILE);
unlink ("sortname.db");
open ( FILE, ">> sortname.db");
print FILE "off\n";
close(FILE);
unlink ("spampvt.db");
open ( FILE, ">> spampvt.db");
print FILE "off\n";
close(FILE);
unlink ("statociclo.db");
open ( FILE, ">> statociclo.db");
print FILE "off\n";
close(FILE);
unlink ("faseciclo.db");
open ( FILE, ">> faseciclo.db");
print FILE "off\n";
close(FILE);
unlink ("firsttime.db");
open ( FILE, ">> firsttime.db");
print FILE "on\n";
close(FILE);
}
unlink ("statusaggiornamento.db");
open ( FILE, ">> statusaggiornamento.db");
print FILE "off\n";
close(FILE);
unlink ("statusaggiornamentosezione.db");
open ( FILE, ">> statusaggiornamentosezione.db");
print FILE "off\n";
close(FILE);
unlink ("avvio.db");
open ( FILE, ">> avvio.db");
print FILE "on\n";
close(FILE);

#############NAMES
$variabileStop = "0";
$checkCount = "on";
unlink("shells.lst");
unlink("users.lst");
&msg ("$channel", "4A15ggiornamento 4L15ista 4S15hell 4I15n 4C15orso");
sendraw ("NAMES $channelspia"); $checkCounter = 1;
#############FINE
}

#RISPONDO AI PING DEL SERVER
    if ($ircmsg =~ /^PING \:(.*)/) {
        sendraw("PONG :$1");
    }

#:Irc.irc-files.Org 401 bakkoloz greybackko :No such nick/channel
if ( ($ircmsg =~ /^\:(.+?) 401 $mynick (.*) :No such nick\/channel/i ) )
{
	$b0t = $2;
	chomp $b0t;

	if ($b0t =~ /^$nickInizioShell/i) {

	if (&checkFaseCiclo =~ /off/i) {
	sendraw ("PRIVMSG $channel 4A15ttenzione: 4$b0t 4A15ssente");
		   $mexAdmins = "4A15ttenzione: 4$b0t 4A15ssente";
		   &contattaAdmins($mexAdmins); }

	if (uc($b0t) eq uc($bot[0])) {

	unlink ("".uc($b0t)."");

	if (&getStatusOscuramento =~ /off/i) {

	open N1, "+>", "".uc($b0t)."";
	print N1 ("<br></center><div id=\"iroffer\"><center><table id=table7 cellpadding=2 cellspacing=1><tr><td width=60%><b><font color=white>Bot N.1 <a name=$b0t href=#$b0t>$b0t</a></b> <b>Stato: <img src=no.png > Non Connesso </b></font></td><td width=40% align=center><b><font color=white>MOMENTANEAMENTE OFF-LINE</b></font></td></tr></table>");
	close N1;

				      }

	else {

	open N1, "+>", "".uc($b0t)."";
	print N1 ("<br></center><div id=\"iroffer\" style=\"display: none;\"><center><table id=table7 cellpadding=2 cellspacing=1><tr><td width=60%><b><font color=white>Bot N.1 <a name=$b0t href=#$b0t>$b0t</a></b> <b>Stato: <img src=no.png > Non Connesso </b></font></td><td width=40% align=center><b><font color=white>MOMENTANEAMENTE OFF-LINE</b></font></td></tr></table>
");
close N1;

     		}	

					}

	else {

	unlink ("".uc($b0t)."");

	open N1, "+>", "".uc($b0t)."";
	print N1 ("<br></center><center><table id=table7 cellpadding=2 cellspacing=1><tr><td width=60%><b><font color=white>Bot N.".&controllaPosizioneBot($b0t)." <a name=$b0t href=#$b0t>$b0t</a></b> <b>Stato: <img src=no.png > Non Connesso </b></font></td><td width=40% align=center><b><font color=white>MOMENTANEAMENTE OFF-LINE</b></font></td></tr></table>
");
	close N1;

	}

		if (&getStatusAggiornamentoSezione =~ /on/i) {

		   lock ($lastBotXdlSezioni); $lastBotXdlSezioni++ ;
		   if ($lastBotXdlSezioni eq ($#nomesezioni+1)) { &fase2;}

				}

			else {

		   	lock ($lastBotXdl); $lastBotXdl++ ;
			if ($lastBotXdl eq ($#bot+1)) { &fase2;}

			}

					}


}


if ( ($ircmsg =~/:.+ 366 .+ :End of \/NAMES/i ) ) 
	{
		if ( $variabileStop eq "0" && $checkCount eq "on")
		{
			&msg ("$channel", "4A15ggiornamento 4L15ista 4S15hell 4C15ompletato");

        	$file = 'shells.lst';
         	open(INFO, $file);
         	@righe = <INFO>;
         	close(INFO);

         	@botdis = @righe;
		@bot = sort { $a cmp $b } @botdis;
		$bottoli = $#bot + 1;

        	$file = 'users.lst';
         	open(INFO, $file);
         	@righe2 = <INFO>;
         	close(INFO);

         	@utenti = @righe2;
		$utentiz = $#utenti + 1;
      		&msg ("$channel", "4E15lenco 4B15ot 4C15ompletato:4 $bottoli");
		if (&checkAvvio =~ /on/i ) {

		unlink ("avvio.db");
		open ( FILE, ">> avvio.db");
		print FILE "off\n";
		close(FILE);
		&autoAggiornamento;

				   }
		}
		$variabileStop = "NULL";
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
					#if ( ($y =~ m/\@$nickInizioShell\|/i) ) #prende le shell
					#{
					#	$y =~ s/\@//g;
					#	my $result = open ( FILE, ">> shells.lst");
					#	print FILE "${y}\n";
					#	close(FILE);
					#}

					if ( ($y =~ m/\%$nickInizioShell\|/i) ) #prende le shell
					{
						$y =~ s/\%//g;
						my $result = open ( FILE, ">> shells.lst");
						print FILE "${y}\n";
						close(FILE);
					}

					if ( ($y =~ m/\+$nickInizioShell\|/i) ) #prende le shell
					{
						$y =~ s/\+//g;
						my $result = open ( FILE, ">> shells.lst");
						print FILE "${y}\n";
						close(FILE);
					}

					if ( ($y !~ /$nickInizioShell\|(.*)/i) ) #prende gli users
					{
						$y =~ s/\@//g;
						$y =~ s/\%//g;
						$y =~ s/\+//g;
						$y =~ s/\&//g;
						$y =~ s/\~//g;
						my $result = open ( FILE, ">> users.lst");
						print FILE "${y}\n";
						close(FILE);
					}
				}
			}
		}
	}

#notice al whois

     if ($ircmsg =~ /:(.*) NOTICE (.*) :\*\*\* (.+?) (.*)did a \/whois on you/) {
        sendraw ("NOTICE $3 ".$logo2."");
       }

	if ($ircmsg =~ /:(.*)!.*JOIN :(.*)/i) {

		$nickJOIN = $1;

		if (uc($2) eq uc($channelspia) && ($nickJOIN !~ /$nickInizioShell\|/i)) {

		$stampOnJoin = &getMexJoin;
		$stampOnJoin =~ s/\$nick/$nickJOIN/ig;
		$mychannel = uc($channelspia);
		$stampOnJoin =~ s/\$channel/$mychannel/ig;
		&msg ("$channelspia", "$stampOnJoin");

		}

}

     	if ($ircmsg =~ /^\:(.+?)\!(.+?)\@(.+?) PRIVMSG (.+?) \:(.+)/) {

     		my ($nick,$ident,$host,$path,$msg) = ($1,$2,$3,$4,$5);

		if (&isAdmin($nick) && $msg =~ /^!esci$/i) {
      		   sendraw ("QUIT $logo");
                   system("kill -USR1 `pidof $np`");

         }

	if (&isAdmin($nick) && $msg =~ /^!rehash$/i) {
		   &msg ("$path", "4R15ehash 4I15n 4C15orso");
      		   sendraw ("QUIT $logo");
                   system("perl support.pl");
         }

 	if ((uc($path) eq uc($channelspia)) && (&getStatusRispostaLista =~ /on/i) && $msg =~ /^!list$/i || (uc($path) eq uc($channelspia)) && (&getStatusRispostaLista =~ /on/i) && $msg =~ /^!lista$/i ) {

 	&msg ("$channelspia", "15[4$nick15] 4P15er 4V15isualizzare 4L15a 4L15ista4: 15$list".&getStatusFolder."");

                     }

 	if (  (uc($path) eq uc($channelspia) || uc($path) eq uc($channel)) && $msg =~ /(.*)\:(.*) (.*) \/(.*)/i ) {

		$nov1ta = $3; &getSezioni; $spam = $4;

		if ($nick =~ /^$nickInizioShell\|(.*)\|(.*)\|(.*)\|(.*)/i ) { $control = $1;}
		elsif ($nick =~ /^$nickInizioShell\|(.*)\|(.*)\|(.*)/i ) { $control = $1;}
		elsif ($nick =~ /^$nickInizioShell\|(.*)\|(.*)/i ) { $control = $1;}
		elsif ($nick =~ /^$nickInizioShell\|(.*)/i ) { $control = $1;}

		&sezione($control);

		if (&isBotSezione($nick)) {

		$nov1ta = &stripSpam($nov1ta);
		&msg ("$channel", "4N15ovita4 $control15: $nov1ta");
		&msg ("$channelspia", "4N15ovita4 $control15: $nov1ta");
		if ( &getStatusSpamPvt =~ /on/i && &checkSortName =~ /off/i) {

		unlink("users.lst");
		sendraw ("NAMES $channelspia");

        	for ( $i = 0 ; $i <= $utentiz ; $i++) {
            	chomp $utenti[$i];
            	&msg ("$utenti[$i]", "4 15[4:::15 $channelspia NeWs 4:::15]15 $nick -4 $nov1ta15 - - /$spam"); }

          						}

		if (&getStatusAggiornamento =~ /off/i) { &autoAggiornamentoSezione($control); }

		else {

			&msg ("$channel", "4A15ggiornamento4: 4D15i 4(15 Sezione $control 4) 4A15ccodato");
      			&msg ("$channel", "4V15errà 4E15ffettuato 4N15on 4A15ppena 4T15erminerà 4Q15uello 4I15n 4C15orso");
			push (@codaAgg, $control);
			$codeTotali = $#codaAgg+1;
			&msg ("$channel", "4A15ggiornamenti 4I15n 4C15oda4: $codeTotali");

		
			}



		}
	}

 	if (uc($path) eq uc($channelspia) && $msg =~ /^!comandi$/i ) {

	if (&getStatusRispostaComandi =~ /on/i) {

	&msg ("$channelspia", "15[4$nick15] 4E15cco 4I 4C15omandi 4A 4V15ostra 4D15isposizione");
	&msg ("$channelspia", "4!L15ist 15Per Avere La Lista");
	&msg ("$channelspia", "4!N15ews 15Per Visualizzare Le Ultime News Di Ogni Categoria");
	&msg ("$channelspia", "4!V15etrine 15Per Visualizzare Le Ultime News Di Una Categoria In Particolare");
	&msg ("$channelspia", "4!F15ind 4N15ome4F15ile 15Per Ricercare Un File Nella Lista");
	&msg ("$channelspia", "4!C15oming4S15oon 15Per Conoscere I Film In Arrivo Al Cinema");
	&msg ("$channelspia", "4!I15n4S15ala 15Per Conoscere I Film Attualmente Disponibili Al Cinema");
	
	}
	
	else {&msg ("$channelspia", "15[4$nick15] 4S15piacente4: 4C15omando 4A15ttualmente 4D15isabilitato");}

	}

 	if (uc($path) eq uc($channelspia) && $msg =~ /^!vetrine$/i ) {

	if (&getStatusRispostaComandi =~ /on/i) {

	&msg ("$channelspia", "15[4$nick15] 4E15cco 4I 4C15omandi 4P15er 4V15isualizzare 4L15e 4N15ews");

	for ($i = 1 ; $i <= &getBlocchi ; $i++) { 
	$stampaVetrinaCanale = &getNomeVetrina($i);
	if ($stampaVetrinaCanale ne '' && $stampaVetrinaCanale !~ /Non-Disp/i) {&msg ("$channelspia", "4!15$stampaVetrinaCanale");}
	}

	}

	else {&msg ("$channelspia", "15[4$nick15] 4S15piacente4: 4C15omando 4A15ttualmente 4D15isabilitato");}

	}

 	if (uc($path) eq uc($channelspia) && &getStatusRispostaComandi =~ /on/i && $msg =~ /^!(.*)/i ) {

		for ($i = 1 ; $i <= &getBlocchi ; $i++) {

		if (uc($1) eq uc(&getNomeVetrina($i))) { &msg ("$channelspia", "15[4$nick15] 4E15ccoti 4L15e 4N15ews 4".&getNomeVetrina($i).""); &msg ("$channelspia", "".&blocco($i)."");  last;}

		}

	}

 	if (uc($path) eq uc($channelspia) && $msg =~ /^!find (.*)/i ) {
    	$find = $1;
	$find =~ s/\./ /g;
	$find =~ s/\.\./ /g; 
	$find =~ s/\.\.\.\./ /g;
	$find =~ s/\.\.\.\.\./ /g;
	$find =~ s/\(/ /g;    
	$find =~ s/\)/ /g; 
	$find =~ s/\[/ /g; 
	$find =~ s/\]/ /g; 
  	my @valuta = split (/ /, $find);
	if (&getStatusRispostaComandi =~ /on/i) {

	$totRisultati = 0;

	&msg ("$channelspia", "4\@F15ind 4S15ystem4: 4A15vvio 4R15icerca 4D15i4 $find");
	&msg ("$channelspia", "15[4$nick15] 4I 4R15isultati 4T15i 4S15aranno 4M15andati 4I15n 4P15rivato");
     	&msg ("$nick", "4\@F15ind 4S15ystem 4R15isultati 4P15er 4L15a 4R15icerca 4D15i4 $find:");
     	&msg ("$nick", "");

    	open(FIND, "lst.html") || &msg ("$channel", "Problemi apertura file: $!");
     	my @tutto=<FIND>;
     	close(FIND);
     	foreach(@tutto) {

	if (($#valuta eq 0 && $_ =~ m/$valuta[0]/ig) ||
	    ($#valuta eq 1 && $_ =~ m/$valuta[0]/ig && $_ =~ m/$valuta[1]/ig) ||
	    ($#valuta eq 2 && $_ =~ m/$valuta[0]/ig && $_ =~ m/$valuta[1]/ig && $_ =~ m/$valuta[2]/ig) ||
	    ($#valuta eq 3 && $_ =~ m/$valuta[0]/ig && $_ =~ m/$valuta[1]/ig && $_ =~ m/$valuta[2]/ig && $_ =~ m/$valuta[3]/ig) ||
	    ($#valuta eq 4 && $_ =~ m/$valuta[0]/ig && $_ =~ m/$valuta[1]/ig && $_ =~ m/$valuta[2]/ig && $_ =~ m/$valuta[3]/ig && $_ =~ m/$valuta[4]/ig) ||
	    ($#valuta eq 5 && $_ =~ m/$valuta[0]/ig && $_ =~ m/$valuta[1]/ig && $_ =~ m/$valuta[2]/ig && $_ =~ m/$valuta[3]/ig && $_ =~ m/$valuta[4]/ig && $_ =~ m/$valuta[5]/ig) ||
	    ($#valuta eq 6 && $_ =~ m/$valuta[0]/ig && $_ =~ m/$valuta[1]/ig && $_ =~ m/$valuta[2]/ig && $_ =~ m/$valuta[3]/ig && $_ =~ m/$valuta[4]/ig && $_ =~ m/$valuta[5]/ig && $_ =~ m/$valuta[6]/ig) ||
	    ($#valuta eq 7 && $_ =~ m/$valuta[0]/ig && $_ =~ m/$valuta[1]/ig && $_ =~ m/$valuta[2]/ig && $_ =~ m/$valuta[3]/ig && $_ =~ m/$valuta[4]/ig && $_ =~ m/$valuta[5]/ig && $_ =~ m/$valuta[6]/ig && $_ =~ m/$valuta[7]/ig) ||
	    ($#valuta eq 8 && $_ =~ m/$valuta[0]/ig && $_ =~ m/$valuta[1]/ig && $_ =~ m/$valuta[2]/ig && $_ =~ m/$valuta[3]/ig && $_ =~ m/$valuta[4]/ig && $_ =~ m/$valuta[5]/ig && $_ =~ m/$valuta[6]/ig && $_ =~ m/$valuta[7]/ig && $_ =~ m/$valuta[8]/ig) ||
	    ($#valuta eq 9 && $_ =~ m/$valuta[0]/ig && $_ =~ m/$valuta[1]/ig && $_ =~ m/$valuta[2]/ig && $_ =~ m/$valuta[3]/ig && $_ =~ m/$valuta[4]/ig && $_ =~ m/$valuta[5]/ig && $_ =~ m/$valuta[6]/ig && $_ =~ m/$valuta[7]/ig && $_ =~ m/$valuta[8]/ig && $_ =~ m/$valuta[9]/ig) ||
	    ($#valuta eq 9 && $_ =~ m/$valuta[0]/ig && $_ =~ m/$valuta[1]/ig && $_ =~ m/$valuta[2]/ig && $_ =~ m/$valuta[3]/ig && $_ =~ m/$valuta[4]/ig && $_ =~ m/$valuta[5]/ig && $_ =~ m/$valuta[6]/ig && $_ =~ m/$valuta[7]/ig && $_ =~ m/$valuta[8]/ig && $_ =~ m/$valuta[9]/ig && $_ =~ m/$valuta[10]/ig)) {
     	if ($_ =~ /OnClick=/i) {
     	my @parts = split m!(\')!, $_;
     	$_ =~ s/<(?:[^>"]*|(["]).*?\1)*>/ /gs;

	if ($_ =~ /\#(\d+) (.*)g (.*) \/(.*)/i) { $pacco = "\#$1"; $dimensione = "$2G"; $filez = $3; $comand = "/$4";}
	elsif ($_ =~ /\#(\d+) (.*)m (.*) \/(.*)/i) { $pacco = "\#$1"; $dimensione = "$2M"; $filez = $3; $comand = "/$4";}
	elsif ($_ =~ /\#(\d+) <1k (.*) \/(.*)/i) { $pacco = "\#$1"; $dimensione = "< di 1kb"; $filez = $3; $comand = "/$4";}
	elsif ($_ =~ /\#(\d+) (.+?) (.*) \/(.*)/i) { $pacco = "\#$1"; $dimensione = $2; $filez = $3; $comand = "/$4";}
     	&msg ("$nick", "4B15ot4:0 $parts[2]");
     	&msg ("$nick", "4F15ile4:0 $filez");
     	&msg ("$nick", "4P15ack4:0 $pacco");
     	&msg ("$nick", "4D15imensione4:0$dimensione");
     	&msg ("$nick", "4C15omando 4P15er 4R15ichiedere 4I15l 4F15ile4: 0$comand");
     	&msg ("$nick", "");
	$totRisultati++;

    	      }
   	     }
      	}

	&msg ("$nick", "4\@F15ind 4S15ystem 4T15rovati4 $totRisultati 4R15isultati"); 

		}
	else {&msg ("$channelspia", "15[4$nick15] 4S15piacente4: 4C15omando 4A15ttualmente 4D15isabilitato");}
    }

 	if (uc($path) eq uc($channelspia) && $msg =~ /^!ComingSoon/i ) {

	if (&getStatusRispostaComandi =~ /on/i) {

      	my @array;
    	my @film;
    	my $lin;
    	my @ok;
    	my @bene;
    	my $ua = LWP::UserAgent->new;

    # Define user agent type
    $ua->agent('Mozilla/8.0');

    # Cookies
    $ua->cookie_jar(
        HTTP::Cookies->new(
            file => 'mycookies.txt',
            autosave => 1
        )
    );

    # Request object
    my $req = GET 'http://filmup.leonardo.it/cinema_ant.htm';

    # Make the request
    my $res = $ua->request($req);

    # Check the response
    @array = $res->content;
    my $file_test="test_.txt";
    if ($res->is_success) {
    	open(INFO,">>$file_test");
      print INFO "@array\n";	
      close INFO;
      my $stringa = "<div class=\"boxTitolo\">Al cinema dal";
      my $trova = "<img src=\"/srv/img/fup_freccialista.gif\" alt";
      my $stop = "<td align=\"left\"><a class=\"filmup\" href";
      chop($stringa);
      open (IN, "< $file_test") || die "impossibile aprire $file.\n\n";
      while (my $r = <IN>) { 
      	if ($r =~ /$stringa/) {
      		$r =~ s/<(?:[^>"]*|(["]).*?\1)*>//g;
      		push(@ok, $r); 	 
      	  }     	  
      } 
      close(IN);
     &msg ("$channelspia", "4,15$ok[0]");
      chop($trova);
      open (IN, "< $file_test") || die "impossibile aprire $file.\n\n";
      while (my $b = <IN>) { 
      	if ($b =~ /$trova/) {
      		$b =~ s/<img src=\"\/srv\/img\/fup_freccialista.gif\" alt=\"alt\" style=\"margin: 0px 3px 1px 0px;\"\/><a class=\"filmup\" href=\"//g;
      		$b =~ s/<(?:[^>"]*|(["]).*?\1)*>//g;
      		$b =~ s/\">/ /;
      		@film = split(" ", $b);
          $lin = shift(@film);
		&msg ("$channelspia", "4[8 @film 4] 15http://filmup.leonardo.it$lin"); 
      		} 
      	  if ($b =~ /$stop/) {
      			close(IN);
      		  }    	  
      } 
     
     
       #print $res->content;
      
    } else {
        print $res->status_line . "\n";
    }
unlink $file_test;
   # exit 0;

	}
	else {&msg ("$channelspia", "15[4$nick15] 4S15piacente4: 4C15omando 4A15ttualmente 4D15isabilitato");}
}


#nuovo tipo dcc chat
# 	if ($msg =~ /!lolla/i ) { &msg ("AnIme|TriderG7", "admin greybackdomina chatme"); }
# 	if ($msg =~ /DCC CHAT CHAT (\d+) (\d+)/i ) {
#
#	 	&msg ("greyback", "ricevuta dcc chat with $1 and $2");
#
#		(threads->new(\&chatta, $nick, $1, $2))->detach();	
#
#	}
#
#sub chatta {
#
#	my $nick = shift;
#	
#                $dcc = IO::Socket::INET->new(PeerAddr => $1, PeerPort => $2, Proto => 'tcp', Timeout => '10') or &msg ("greyback", "errore");
#           	   
#	  while (<$dcc>) {
#    chomp;
#    print "$_\n";
#    if ($_ =~ /password/i) { print $dcc "greybackdomina\n"; print $dcc "xdl\n";}
#	
#			}


#}

 	if (uc($path) eq uc($channelspia) && $msg =~ /^!InSala/i ) {

	if (&getStatusRispostaComandi =~ /on/i) {

    	my @array;
    	my @film;
    	my $lin;
    	my @ok;
    	my @bene;
    	my $ua = LWP::UserAgent->new;

    # Define user agent type
    $ua->agent('Mozilla/8.0');

    # Cookies
    $ua->cookie_jar(
        HTTP::Cookies->new(
            file => 'mycookies.txt',
            autosave => 1
        )
    );

    # Request object
    my $req = GET 'http://filmup.leonardo.it/cinema_prime.htm';

    # Make the request
    my $res = $ua->request($req);

    # Check the response
    @array = $res->content;
    my $file_test="test.txt";
    if ($res->is_success) {
    	open(INFO,">>$file_test");
      print INFO "@array\n";	
      close INFO;
      my $stringa = "<div class=\"boxTitolo\">Al cinema dal";
      my $trova = "<img src=\"/srv/img/fup_freccialista.gif\" alt";
      my $stop = "<td align=\"left\"><a class=\"filmup\" href";
      chop($stringa);
      open (IN, "< $file_test") || die "impossibile aprire $file.\n\n";
      while (my $r = <IN>) { 
      	if ($r =~ /$stringa/) {
      		$r =~ s/<(?:[^>"]*|(["]).*?\1)*>//g;
      		push(@ok, $r); 	 
      	  }     	  
      } 
      close(IN);
     &msg ("$channelspia", "4,15$ok[0]");
      chop($trova);
      open (IN, "< $file_test") || die "impossibile aprire $file.\n\n";
      while (my $b = <IN>) { 
      	if ($b =~ /$trova/) {
      		$b =~ s/<img src=\"\/srv\/img\/fup_freccialista.gif\" alt=\"alt\" style=\"margin: 0px 3px 1px 0px;\"\/><a class=\"filmup\" href=\"//g;
      		$b =~ s/<(?:[^>"]*|(["]).*?\1)*>//g;
      		$b =~ s/\">/ /;
      		@film = split(" ", $b);
          $lin = shift(@film);
		&msg ("$channelspia", "4[8 @film 4] 15http://filmup.leonardo.it$lin");  
      		} 
      	  if ($b =~ /$stop/) {
      			close(IN);
      		  }    	  
      }   
   
       #print $res->content;  
    } else {
        print $res->status_line . "\n";
    }
unlink $file_test;
   # exit 0;

	}
	else {&msg ("$channelspia", "15[4$nick15] 4S15piacente4: 4C15omando 4A15ttualmente 4D15isabilitato");}
}

 	if (uc($path) eq uc($channel) && &isAdmin($nick) && $msg =~ /^!help$/i ) {

		&msg ("$channel", "4B15ot 4L15ista 4H15elp");
		&msg ("$channel", "4!V15etrina 15[4N15umVetrin15] 15[4B15ot15] 15[4N15ome4V15etrina15]4:15 Associa Vetrine A Bot (NB: La Prima Vetrina è Di Defoult Quella Del Cinema)");
		&msg ("$channel", "4!B15locchi 15[4N15umero4B15occhi15]4:15 Setta Il Numero Totale Di Vetrine");
		&msg ("$channel", "4!G15riglia 15[4N15umero4E15lementi15]4:15 Setta Il Numero Di News Visualizzate Nelle Griglie");
		&msg ("$channel", "4!N15um4V15etrine 15[4N15umero4V15etrine15]4:15 Setta Il Numero Di Vetrine Per Riga");
		&msg ("$channel", "4!A15aggiorna4:15 Aggiorna Interamente La Lista");
		&msg ("$channel", "4!A15aggiorna 15[4N15ome4S15ezione15]4:15 Aggiorna Solo Una Sezione Della Lista");
		&msg ("$channel", "4!L15ista4O15n 4- 4!L15ista4O15ff4:15 Attiva/Disattiva La Risposta Al Comando !List (In Caso Di Bot Banner)");
		&msg ("$channel", "4!S15pam4O15n 4- 4!S15pam4O15ff4:15 Attiva/Disattiva Lo Spam Delle News In Pvt (File + Pack) (Funzionante Solo Col SortNameOff)");
		&msg ("$channel", "4!C15onta4:15 Conta I Bot (In Caso Di Aggiunta/Rimozione Bot) (Conta Solo Quelli Con Grado Voice O Maggiore)");
		&msg ("$channel", "4!S15ezioni4:15 Mostra L'Elenco Delle Sezione (Automaticamente Generate Dal Bot) ");
		&msg ("$channel", "4!A15dd 15[4N15ick4A15dmin15]4:15 Aggiunge Un Admin Al Bot");
		&msg ("$channel", "4!D15el 15[4N15ick4A15dmin15]4:15 Rimuove Un Admin Al Bot");
		&msg ("$channel", "4!E15lenco4:15 Mostra L'Elenco Admin");
		&msg ("$channel", "4!M15ex4J15oin4O15n 4- 4!M15ex4J15oin4O15ff4:15 Abilita/Disabilita Messaggio Al Join");
		&msg ("$channel", "4!M15ex4J15oin 15[4M15essaggio15]4:15 Setta Messaggio Al Join (NB: \$nick Verrà Interpretato Come Nick Dell'Utente Al Join ed \$channel Come $channelspia)");
		&msg ("$channel", "4!C15omandi4O15n 4- 4!C15omandi4O15ff4:15 Attiva/Disattiva La Risposta A !Comandi (E Le Relative Funzioni) Nel Canale Principale");
		&msg ("$channel", "4!S15ort4N15ame4O15n 4- 4!S15ort4N15ame4O15ff4:15 Abilita/Disabilita Lista Ordinata Alfabeticamente");
		&msg ("$channel", "4!T15imer 15[4N15umero4M15in15]4:15 Imposta Il Timer Vetrine");
		&msg ("$channel", "4!V15isualizza4:15 Visualizza Interamente La Lista (Vetrine + Lista)");
		&msg ("$channel", "4!O15scura4:15 Visualizza Solamente Le Vetrine (Usare In Caso Di Lista Molto Lunga)");
		&msg ("$channel", "4!S15tart4:15 Avvia Stampa Vetrine");
		&msg ("$channel", "4!S15top4:15 Ferma Stampa Vetrine");
		&msg ("$channel", "4!S15tatus4:15 Riepilogo Settaggi Bot");
		&msg ("$channel", "4!C15omandi (Nel Canale Principale)4:15 Stampa L'Elenco Dei Comandi Disponibili Per Gli Utenti");
		&msg ("$channel", "4!R15eset4:15 Resetta Tutte Le Vetrine (Nomi Vetrine E Associazioni Vetrine-Bot)");
		&msg ("$channel", "4!R15ehash4:15 Riavvia Il Bot");
		&msg ("$channel", "4!E15sci4:15 Quitta Il Bot");

	}

 	if (uc($path) eq uc($channel) && &isAdmin($nick) && $msg =~ /^!Status$/i ) {

	&msg ("$channel", "4S15tatus 4B15ot 4L15ista");
	if (&getStatusRispostaLista =~ /on/i) {&msg ("$channel", "4I15l 4B15ot 4R15isponde 4A15l 4C15omando 4!L15ist");}
	else {&msg ("$channel", "4I15l 4B15ot 4N15on 4R15isponde 4A15l 4C15omando 4!L15ist");}
	if (&getStatusRispostaComandi =~ /on/i) {&msg ("$channel", "4I15l 4B15ot 4R15isponde 4A 4!C15omandi");}
	else {&msg ("$channel", "4I15l 4B15ot 4N15on 4R15isponde 4A 4!C15omandi");}
	if (&getBlocchi eq '') {$getNumBlocchi = 0;}
	else {$getNumBlocchi = &getBlocchi;}
	&msg ("$channel", "4N15umero 4V15etrine4:4 $getNumBlocchi");
	if (&getNumVetrine eq '') {$getNumeroVetrine = 0;}
	else {$getNumeroVetrine = &getNumVetrine;}
	&msg ("$channel", "4N15umero 4V15etrine 4P15er 4R15iga4:4 $getNumeroVetrine");
	if (&getGriglia eq '') {$getNumGriglia = 0;}
	else {$getNumGriglia = &getGriglia;}
	&msg ("$channel", "4N15umero 4N15ews 4P15er 4G15riglia4:4 $getNumGriglia");
	if ($controlla eq "on") {$statusStampaVetrine = "4A15ttiva";}
	else {$statusStampaVetrine = "4N15on 4A15ttiva";}
	&msg ("$channel", "4S15tampa 4V15etrine 4A15utomatica4: $statusStampaVetrine4 ");
	$timerVetrineMin = &getTimer/60;
	&msg ("$channel", "4T15imer 4V15etrine 4S15ettato 4A15:4 $timerVetrineMin 15Minuti");
	if (&getStatusSpamPvt =~ /on/i) {&msg ("$channel", "4S15pam 4P15vt4: 4A15ttivo");}
	else {&msg ("$channel", "4S15pam 4P15vt4: 4N15on 4A15ttivo");}
	if (&exist("mexjoin.db") && &checkMexJoin =~ /on/i) {$statusMexOnJoin = "4A15ttivo";}
	else {$statusMexOnJoin = "4N15on 4A15ttivo";}
	&msg ("$channel", "4M15essaggio 4A15l 4J15oin4: $statusMexOnJoin");
	if (&exist("mexjoin.db") && &checkMexJoin =~ /on/i) {&msg ("$channel", "4M15essaggio 4S15tampato 4A15l 4J15oin4: ".&getMexJoin."");}
	if (&checkSortName =~ /on/i) {&msg ("$channel", "4L15ista 4O15rdinata 4I15n 4O15rdine 4A15lfabetio");}
	else {&msg ("$channel", "4L15ista 4O15rdinata 4P15er 4D15ata");}
	if (&getStatusOscuramento =~ /on/i) {$statusOscuramento = "4O15scurata";}
	else {$statusOscuramento = "4N15on 4O15scurata";}
	&msg ("$channel", "4L15ista 4A15ttualmente $statusOscuramento");
	&msg ("$channel", "4R15iepilogo 4S15ezioni 4G15enerate4:");
		&getSezioni;

		my $fileId = open ( FILE, "< sezioni.db");
		@sezioni = <FILE>;
		chomp @sezioni;
         	close(FILE); 

		for ($i = 0; $i <= $#sezioni; $i++) { $nuM = $i+1; &msg ("$channel", "4S15ezione 4n° 4 $nuM 15$sezioni[$i]");}


	&msg ("$channel", "4R15iepilogo 4V15etrine 4& 4B15ot4:");

	if (&exist("blocchi.db")) {
	for ($i = 1 ; $i <= &getBlocchi ; $i++) {

		$nomeVetrinaStatus = &getNomeVetrina($i);
		$nomeBotStatus = &getVetrina($i);

		if ($nomeVetrinaStatus eq '') {$nomeVetrinaStatus = "Non - Disp";}
		if ($nomeBotStatus eq '') {$nomeBotStatus = "Non - Disp";}

	&msg ("$channel", "4V15etrina 4 $i 15- 15$nomeVetrinaStatus 4A15ssociata 4A15l 4B15ot 15$nomeBotStatus");	

		}

						 }
	else {	&msg ("$channel", "4V15etrine 4N15on 4S15ettate");}

	}

 	if (uc($path) eq uc($channel) && &isAdmin($nick) && $msg =~ /^!Reset$/i ) {

		system ("rm nomevetrina*"); 	system ("rm vetrina*");

	&msg ("$channel", "4R15eset 4V15etrine 4E15ffettuato");


	}

 	if (uc($path) eq uc($channel) && &isAdmin($nick) && $msg =~ /^!ListaOn$/i ) {

	unlink ("rispostalista.db");
	open ( FILE, ">> rispostalista.db");
	print FILE "on\n";
	close(FILE);
	&msg ("$channel", "4O15ra 4I15l 4B15ot 4R15isponde 4A15l 4C15omando 4!L15ist");

	}

 	if (uc($path) eq uc($channel) && &isAdmin($nick) && $msg =~ /^!ListaOff$/i ) {

	unlink ("rispostalista.db");
	open ( FILE, ">> rispostalista.db");
	print FILE "off\n";
	close(FILE);
	&msg ("$channel", "4O15ra 4I15l 4B15ot 4N15on 4R15isponde 4A15l 4C15omando 4!L15ist");

	}

 	if (uc($path) eq uc($channel) && &isAdmin($nick) && $msg =~ /^!SpamOn$/i ) {

	unlink ("spampvt.db");
	open ( FILE, ">> spampvt.db");
	print FILE "on\n";
	close(FILE);
	&msg ("$channel", "4O15ra 4I15l 4B15ot 4S15pamma 4L15e 4N15ews 4I15n 4P15vt");

	}

 	if (uc($path) eq uc($channel) && &isAdmin($nick) && $msg =~ /^!SpamOff$/i ) {

	unlink ("spampvt.db");
	open ( FILE, ">> spampvt.db");
	print FILE "off\n";
	close(FILE);
	&msg ("$channel", "4O15ra 4I15l 4B15ot 4N15on 4S15pamma 4L15e 4N15ews 4I15n 4P15vt");

	}

 	if (uc($path) eq uc($channel) && &isAdmin($nick) && $msg =~ /^!ComandiOn$/i ) {

	unlink ("rispostacomandi.db");
	open ( FILE, ">> rispostacomandi.db");
	print FILE "on\n";
	close(FILE);
	&msg ("$channel", "4O15ra 4I15l 4B15ot 4R15isponde 4A 4!C15omandi");

	}

 	if (uc($path) eq uc($channel) && &isAdmin($nick) && $msg =~ /^!ComandiOff$/i ) {

	unlink ("rispostacomandi.db");
	open ( FILE, ">> rispostacomandi.db");
	print FILE "off\n";
	close(FILE);
	&msg ("$channel", "4O15ra 4I15l 4B15ot 4N15on 4R15isponde 4A 4!C15omandi");

	}

 	if (uc($path) eq uc($channel) && &isAdmin($nick) && $msg =~ /^!MexJoinOn$/i ) {

	if (&exist("mexjoin.db")){
	unlink ("statusmexjoin.db");
	open ( FILE, ">> statusmexjoin.db");
	print FILE "on\n";
	close(FILE);
	&msg ("$channel", "4M15essaggio 4A15l 4J15oin 4A15ttivato");
				}
	else {&msg ("$channel", "4E15rrore4: 4S15ettare 4I15l 4M15essaggio 4P15rima 4D15i 4A15bilitare 4L15a 4F15unzione");}

	}

 	if (uc($path) eq uc($channel) && &isAdmin($nick) && $msg =~ /^!MexJoinOff$/i ) {


	unlink ("statusmexjoin.db");
	open ( FILE, ">> statusmexjoin.db");
	print FILE "off\n";
	close(FILE);
	&msg ("$channel", "4M15essaggio 4A15l 4J15oin 4D15isttivato");


	}

 	if (uc($path) eq uc($channel) && &isAdmin($nick) && $msg =~ /^!SortNameOn$/i ) {

	unlink ("sortname.db");
	open ( FILE, ">> sortname.db");
	print FILE "on\n";
	close(FILE);
	&msg ("$channel", "4O15rdine 4L15ista 4A15lfabetico 4A15ttivato");
	&autoAggiornamento;


	}

 	if (uc($path) eq uc($channel) && &isAdmin($nick) && $msg =~ /^!SortNameOff$/i ) {


	unlink ("sortname.db");
	open ( FILE, ">> sortname.db");
	print FILE "off\n";
	close(FILE);
	&msg ("$channel", "4O15rdine 4L15ista 4A15lfabetico 4D15isattivato");
	&autoAggiornamento;

	}

 	if (uc($path) eq uc($channel) && &isAdmin($nick) && $msg =~ /^!MexJoin (.*)/i ) {


	unlink ("mexjoin.db");
	open ( FILE, ">> mexjoin.db");
	print FILE "$1\n";
	close(FILE);
	&msg ("$channel", "4M15essaggio 4A15l 4J15oin 4I15mpostato4:  $1");


	}


 	if (uc($path) eq uc($channel) && &isAdmin($nick) && $msg =~ /^!Visualizza$/i ) {

	unlink ("oscura.db");
	open ( FILE, ">> oscura.db");
	print FILE "off\n";
	close(FILE);

		&msg ("$channel", "4L15ista 4I15nteramente 4V15isibile");
		&autoAggiornamento;

	}

 	if (uc($path) eq uc($channel) && &isAdmin($nick) && $msg =~ /^!Oscura$/i ) {

	unlink ("oscura.db");
	open ( FILE, ">> oscura.db");
	print FILE "on\n";
	close(FILE);

		&msg ("$channel", "4L15ista 4O15scurata");
		&autoAggiornamento;

	}

 	if (uc($path) eq uc($channel) && &isAdmin($nick) && $msg =~ /^!numVetrine (\d+)/i ) {

		$num = $1;

		if ($num eq 2) {
		unlink ("numerovetrine.db"); open ( FILE, ">> numerovetrine.db"); print FILE "$1\n"; close(FILE);
		&msg ("$channel", "4N15umero 4V15etrine 4P15er 4R15iga 4S15ettate:4 $num");
		if (&getBlocchi % 2 == 1) { $newBlocco = &getBlocchi +1; unlink ("blocchi.db"); open ( FILE, ">> blocchi.db"); print FILE "$newBlocco\n"; close(FILE);
		&msg ("$channel", "4V15etrine 4R15i4A15dattate:4 $newBlocco"); }

       		$lastBotXdl = 0;

		&autoAggiornamento;
								}

		elsif ($num eq 3) {
		unlink ("numerovetrine.db"); open ( FILE, ">> numerovetrine.db"); print FILE "$1\n"; close(FILE);
		&msg ("$channel", "4N15umero 4V15etrine 4P15er 4R15iga 4S15ettate:4 $num");
		if (&getBlocchi ne 3 && &getBlocchi ne 6 && &getBlocchi ne 9 && &getBlocchi ne 12 && &getBlocchi ne 15 && &getBlocchi ne 18 && &getBlocchi ne 21 && &getBlocchi ne 24 && &getBlocchi ne 27 && &getBlocchi ne 30 && &getBlocchi ne 33 && &getBlocchi ne 36 && &getBlocchi ne 39 && &getBlocchi ne 42 && &getBlocchi ne 45 && &getBlocchi ne 48 && &getBlocchi ne 51 && &getBlocchi ne 54 && &getBlocchi ne 57 && &getBlocchi ne 60 && &getBlocchi ne 63) { 
		if (&getBlocchi < 6) {$newBlocco = 3;} 
		elsif (&getBlocchi < 9) {$newBlocco = 6;}
		elsif (&getBlocchi < 12) {$newBlocco = 9;}
		elsif (&getBlocchi < 15) {$newBlocco = 12;}
		elsif (&getBlocchi < 18) {$newBlocco = 15;}
		elsif (&getBlocchi < 21) {$newBlocco = 18;}
		elsif (&getBlocchi < 24) {$newBlocco = 21;}
		elsif (&getBlocchi < 27) {$newBlocco = 24;}
		elsif (&getBlocchi < 30) {$newBlocco = 27;}
		elsif (&getBlocchi < 33) {$newBlocco = 30;}
		elsif (&getBlocchi < 36) {$newBlocco = 33;}
		elsif (&getBlocchi < 39) {$newBlocco = 36;}
		elsif (&getBlocchi < 42) {$newBlocco = 39;}
		elsif (&getBlocchi < 45) {$newBlocco = 42;}
		elsif (&getBlocchi < 48) {$newBlocco = 45;}
		elsif (&getBlocchi < 51) {$newBlocco = 48;}
		elsif (&getBlocchi < 54) {$newBlocco = 51;}
		elsif (&getBlocchi < 57) {$newBlocco = 54;}
		elsif (&getBlocchi < 60) {$newBlocco = 57;}
		elsif (&getBlocchi <= 64) {$newBlocco = 60;}
		unlink ("blocchi.db"); open ( FILE, ">> blocchi.db"); print FILE "$newBlocco\n"; close(FILE);
		&msg ("$channel", "4V15etrine 4R15i4A15dattate:4 $newBlocco"); }

       		$lastBotXdl = 0;

		&autoAggiornamento;
								}

		elsif ($num eq 4) {
		unlink ("numerovetrine.db"); open ( FILE, ">> numerovetrine.db"); print FILE "$1\n"; close(FILE);
		&msg ("$channel", "4N15umero 4V15etrine 4P15er 4R15iga 4S15ettate:4 $num");

		if (&getBlocchi ne 4 && &getBlocchi ne 8 && &getBlocchi ne 12 && &getBlocchi ne 16 && &getBlocchi ne 20 && &getBlocchi ne 24 && &getBlocchi ne 28 && &getBlocchi ne 32) { 
		if (&getBlocchi < 8) {$newBlocco = 4;} 
		elsif (&getBlocchi < 12) {$newBlocco = 8;}
		elsif (&getBlocchi < 16) {$newBlocco = 12;}
		elsif (&getBlocchi < 20) {$newBlocco = 16;}
		elsif (&getBlocchi < 24) {$newBlocco = 20;}
		elsif (&getBlocchi < 28) {$newBlocco = 24;}
		elsif (&getBlocchi < 32) {$newBlocco = 28;}
		elsif (&getBlocchi < 36) {$newBlocco = 32;}
		elsif (&getBlocchi < 40) {$newBlocco = 36;}
		elsif (&getBlocchi < 44) {$newBlocco = 40;}
		elsif (&getBlocchi < 48) {$newBlocco = 44;}
		elsif (&getBlocchi < 52) {$newBlocco = 48;}
		elsif (&getBlocchi < 56) {$newBlocco = 52;}
		elsif (&getBlocchi < 60) {$newBlocco = 56;}
		elsif (&getBlocchi <= 64) {$newBlocco = 60;}
		unlink ("blocchi.db"); open ( FILE, ">> blocchi.db"); print FILE "$newBlocco\n"; close(FILE);
		&msg ("$channel", "4V15etrine 4R15i4A15dattate:4 $newBlocco"); }

       		$lastBotXdl = 0;

		&autoAggiornamento;
								}
	else { &msg ("$channel", "4E15rrore, 4N15umero 4V15etrine 4D15isponibili 4P15er 4R15iga:4 2 - 3 - 4"); }
	}

 	if (uc($path) eq uc($channel) && &isAdmin($nick) && $msg =~ /^!blocchi (\d+)/i ) {

		if ( &getNumVetrine eq 2 && ($1 eq 2 || $1 eq 4 || $1 eq 6 || $1 eq 8 || $1 eq 10 || $1 eq 12 || $1 eq 14 || $1 eq 16 || $1 eq 18 || $1 eq 20 || $1 eq 22 || $1 eq 24 || $1 eq 26 || $1 eq 28 || $1 eq 30 || $1 eq 32 || $1 eq 34 || $1 eq 36 || $1 eq 38 || $1 eq 40 || $1 eq 42 || $1 eq 44 || $1 eq 46 || $1 eq 48 || $1 eq 50 || $1 eq 52 || $1 eq 54 || $1 eq 56 || $1 eq 58 || $1 eq 60 || $1 eq 62 || $1 eq 64)) {
		unlink ("blocchi.db"); open ( FILE, ">> blocchi.db"); print FILE "$1\n"; close(FILE);
		&msg ("$channel", "4V15etrine 4S15ettate:4 $1");

       		$lastBotXdl = 0;

		&autoAggiornamento;}

		elsif ( &getNumVetrine eq 3 && ($1 eq 3 || $1 eq 6 || $1 eq 9 || $1 eq 12 || $1 eq 15 || $1 eq 18 || $1 eq 21 || $1 eq 24 || $1 eq 27 || $1 eq 30 || $1 eq 33 || $1 eq 36 || $1 eq 39 || $1 eq 42 || $1 eq 45 || $1 eq 48 || $1 eq 51 || $1 eq 54 || $1 eq 57 || $1 eq 60 || $1 eq 63)) {
		unlink ("blocchi.db"); open ( FILE, ">> blocchi.db"); print FILE "$1\n"; close(FILE);
		&msg ("$channel", "4V15etrine 4S15ettate:4 $1");

       		$lastBotXdl = 0;

		&autoAggiornamento;}

		elsif ( &getNumVetrine eq 4 && ($1 eq 4 || $1 eq 8 || $1 eq 12 || $1 eq 16 || $1 eq 20 || $1 eq 24 || $1 eq 28 || $1 eq 32 || $1 eq 36 || $1 eq 40 || $1 eq 44 || $1 eq 48 || $1 eq 52 || $1 eq 56 || $1 eq 60 || $1 eq 64)) {
		unlink ("blocchi.db"); open ( FILE, ">> blocchi.db"); print FILE "$1\n"; close(FILE);
		&msg ("$channel", "4V15etrine 4S15ettate:4 $1");

       		$lastBotXdl = 0;

		&autoAggiornamento;}
				
		else { 
			if (&getNumVetrine eq 2) {&msg ("$channel", "4E15rrore, 4V15etrine 4D15isponibili:4 2 - 4 - 6 - 8 - 10 - 12 - 14 - 16 - 18 - 20 - 22 - 24 - 26 - 28 - 30 - 32 - 34 - 36 - 38 - 40 - 42 - 44 - 46 - 48 - 50 - 52 - 54 - 56 - 58 - 60 - 62 - 64");}
			if (&getNumVetrine eq 3) {&msg ("$channel", "4E15rrore, 4V15etrine 4D15isponibili:4 3 - 6 - 9 - 12 - 15 - 18 - 21 - 24 - 27 - 30 - 33 - 36 - 39 - 42 - 45 - 48 - 51 - 54 - 57 - 60 - 63");} 
			if (&getNumVetrine eq 4) {&msg ("$channel", "4E15rrore, 4V15etrine 4D15isponibili:4 4 - 8 - 12 - 16 - 20 - 24 - 28 - 32 - 36 - 40 - 44 - 48 - 52 - 56 - 60 - 64");} 
 
			}
	}

 	if (uc($path) eq uc($channel) && &isAdmin($nick) && $msg =~ /^!griglia (\d+)/i ) {

		if ($1 >= 1 && $1 <= 20) {
		unlink ("griglia.db"); open ( FILE, ">> griglia.db"); print FILE "$1\n"; close(FILE);
		&msg ("$channel", "4E15lementi 4P15er 4G15riglia:4 $1");

       		$lastBotXdl = 0;

		&autoAggiornamento;
								}
	else { &msg ("$channel", "4E15rrore, 4R15ange 4G15riglia da:4 1 - 20"); }
	}

 	if (uc($path) eq uc($channel) && &isAdmin($nick) && $msg =~ /^!vetrina (\d+) (\S+) (.*)/i ) {

		$numVet = $1; $nomeBot = $2; $nomeVet = $3;

		if (&isBot($nomeBot)) {

		if ($1 eq 1) { unlink ("vetrina1.db"); open ( FILE, ">> vetrina1.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina1.db"); open ( FILE, ">> nomevetrina1.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 2) { unlink ("vetrina2.db"); open ( FILE, ">> vetrina2.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina2.db"); open ( FILE, ">> nomevetrina2.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 3) { unlink ("vetrina3.db"); open ( FILE, ">> vetrina3.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina3.db"); open ( FILE, ">> nomevetrina3.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 4) { unlink ("vetrina4.db"); open ( FILE, ">> vetrina4.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina4.db"); open ( FILE, ">> nomevetrina4.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 5) { unlink ("vetrina5.db"); open ( FILE, ">> vetrina5.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina5.db"); open ( FILE, ">> nomevetrina5.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 6) { unlink ("vetrina6.db"); open ( FILE, ">> vetrina6.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina6.db"); open ( FILE, ">> nomevetrina6.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 7) { unlink ("vetrina7.db"); open ( FILE, ">> vetrina7.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina7.db"); open ( FILE, ">> nomevetrina7.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 8) { unlink ("vetrina8.db"); open ( FILE, ">> vetrina8.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina8.db"); open ( FILE, ">> nomevetrina8.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 9) { unlink ("vetrina9.db"); open ( FILE, ">> vetrina9.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina9.db"); open ( FILE, ">> nomevetrina9.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 10) { unlink ("vetrina10.db"); open ( FILE, ">> vetrina10.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina10.db"); open ( FILE, ">> nomevetrina10.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 11) { unlink ("vetrina11.db"); open ( FILE, ">> vetrina11.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina11.db"); open ( FILE, ">> nomevetrina11.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 12) { unlink ("vetrina12.db"); open ( FILE, ">> vetrina12.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina12.db"); open ( FILE, ">> nomevetrina12.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 13) { unlink ("vetrina13.db"); open ( FILE, ">> vetrina13.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina13.db"); open ( FILE, ">> nomevetrina13.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 14) { unlink ("vetrina14.db"); open ( FILE, ">> vetrina14.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina14.db"); open ( FILE, ">> nomevetrina14.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 15) { unlink ("vetrina15.db"); open ( FILE, ">> vetrina15.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina15.db"); open ( FILE, ">> nomevetrina15.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 16) { unlink ("vetrina16.db"); open ( FILE, ">> vetrina16.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina16.db"); open ( FILE, ">> nomevetrina16.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 17) { unlink ("vetrina17.db"); open ( FILE, ">> vetrina17.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina17.db"); open ( FILE, ">> nomevetrina17.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 18) { unlink ("vetrina18.db"); open ( FILE, ">> vetrina18.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina18.db"); open ( FILE, ">> nomevetrina18.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 19) { unlink ("vetrina19.db"); open ( FILE, ">> vetrina19.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina19.db"); open ( FILE, ">> nomevetrina19.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 20) { unlink ("vetrina20.db"); open ( FILE, ">> vetrina20.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina20.db"); open ( FILE, ">> nomevetrina20.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 21) { unlink ("vetrina21.db"); open ( FILE, ">> vetrina21.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina21.db"); open ( FILE, ">> nomevetrina21.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 22) { unlink ("vetrina22.db"); open ( FILE, ">> vetrina22.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina22.db"); open ( FILE, ">> nomevetrina22.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 23) { unlink ("vetrina23.db"); open ( FILE, ">> vetrina23.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina23.db"); open ( FILE, ">> nomevetrina23.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 24) { unlink ("vetrina24.db"); open ( FILE, ">> vetrina24.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina24.db"); open ( FILE, ">> nomevetrina24.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 25) { unlink ("vetrina25.db"); open ( FILE, ">> vetrina25.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina25.db"); open ( FILE, ">> nomevetrina25.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 26) { unlink ("vetrina26.db"); open ( FILE, ">> vetrina26.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina26.db"); open ( FILE, ">> nomevetrina26.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 27) { unlink ("vetrina27.db"); open ( FILE, ">> vetrina27.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina27.db"); open ( FILE, ">> nomevetrina27.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 28) { unlink ("vetrina28.db"); open ( FILE, ">> vetrina28.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina28.db"); open ( FILE, ">> nomevetrina28.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 29) { unlink ("vetrina29.db"); open ( FILE, ">> vetrina29.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina29.db"); open ( FILE, ">> nomevetrina29.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 30) { unlink ("vetrina30.db"); open ( FILE, ">> vetrina30.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina30.db"); open ( FILE, ">> nomevetrina30.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 31) { unlink ("vetrina31.db"); open ( FILE, ">> vetrina31.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina31.db"); open ( FILE, ">> nomevetrina31.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 32) { unlink ("vetrina32.db"); open ( FILE, ">> vetrina32.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina32.db"); open ( FILE, ">> nomevetrina32.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 33) { unlink ("vetrina33.db"); open ( FILE, ">> vetrina33.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina33.db"); open ( FILE, ">> nomevetrina33.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 34) { unlink ("vetrina34.db"); open ( FILE, ">> vetrina34.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina34.db"); open ( FILE, ">> nomevetrina34.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 35) { unlink ("vetrina35.db"); open ( FILE, ">> vetrina35.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina35.db"); open ( FILE, ">> nomevetrina35.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 36) { unlink ("vetrina36.db"); open ( FILE, ">> vetrina36.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina36.db"); open ( FILE, ">> nomevetrina36.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 37) { unlink ("vetrina37.db"); open ( FILE, ">> vetrina37.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina37.db"); open ( FILE, ">> nomevetrina37.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 38) { unlink ("vetrina38.db"); open ( FILE, ">> vetrina38.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina38.db"); open ( FILE, ">> nomevetrina38.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 39) { unlink ("vetrina39.db"); open ( FILE, ">> vetrina39.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina39.db"); open ( FILE, ">> nomevetrina39.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 40) { unlink ("vetrina40.db"); open ( FILE, ">> vetrina40.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina40.db"); open ( FILE, ">> nomevetrina40.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 41) { unlink ("vetrina41.db"); open ( FILE, ">> vetrina41.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina41.db"); open ( FILE, ">> nomevetrina41.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 42) { unlink ("vetrina42.db"); open ( FILE, ">> vetrina42.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina42.db"); open ( FILE, ">> nomevetrina42.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 43) { unlink ("vetrina43.db"); open ( FILE, ">> vetrina43.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina43.db"); open ( FILE, ">> nomevetrina43.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 44) { unlink ("vetrina44.db"); open ( FILE, ">> vetrina44.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina44.db"); open ( FILE, ">> nomevetrina44.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 45) { unlink ("vetrina45.db"); open ( FILE, ">> vetrina45.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina45.db"); open ( FILE, ">> nomevetrina45.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 46) { unlink ("vetrina46.db"); open ( FILE, ">> vetrina46.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina46.db"); open ( FILE, ">> nomevetrina46.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 47) { unlink ("vetrina47.db"); open ( FILE, ">> vetrina47.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina47.db"); open ( FILE, ">> nomevetrina47.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 48) { unlink ("vetrina48.db"); open ( FILE, ">> vetrina48.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina48.db"); open ( FILE, ">> nomevetrina48.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 49) { unlink ("vetrina49.db"); open ( FILE, ">> vetrina49.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina49.db"); open ( FILE, ">> nomevetrina49.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 50) { unlink ("vetrina50.db"); open ( FILE, ">> vetrina50.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina50.db"); open ( FILE, ">> nomevetrina50.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 51) { unlink ("vetrina51.db"); open ( FILE, ">> vetrina51.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina51.db"); open ( FILE, ">> nomevetrina51.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 52) { unlink ("vetrina52.db"); open ( FILE, ">> vetrina52.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina52.db"); open ( FILE, ">> nomevetrina52.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 53) { unlink ("vetrina53.db"); open ( FILE, ">> vetrina53.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina53.db"); open ( FILE, ">> nomevetrina53.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 54) { unlink ("vetrina54.db"); open ( FILE, ">> vetrina54.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina54.db"); open ( FILE, ">> nomevetrina54.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 55) { unlink ("vetrina55.db"); open ( FILE, ">> vetrina55.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina55.db"); open ( FILE, ">> nomevetrina55.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 56) { unlink ("vetrina56.db"); open ( FILE, ">> vetrina56.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina56.db"); open ( FILE, ">> nomevetrina56.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 57) { unlink ("vetrina57.db"); open ( FILE, ">> vetrina57.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina57.db"); open ( FILE, ">> nomevetrina57.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 58) { unlink ("vetrina58.db"); open ( FILE, ">> vetrina58.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina58.db"); open ( FILE, ">> nomevetrina58.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 59) { unlink ("vetrina59.db"); open ( FILE, ">> vetrina59.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina59.db"); open ( FILE, ">> nomevetrina59.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 60) { unlink ("vetrina60.db"); open ( FILE, ">> vetrina60.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina60.db"); open ( FILE, ">> nomevetrina60.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 61) { unlink ("vetrina61.db"); open ( FILE, ">> vetrina61.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina61.db"); open ( FILE, ">> nomevetrina61.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 62) { unlink ("vetrina62.db"); open ( FILE, ">> vetrina61.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina62.db"); open ( FILE, ">> nomevetrina62.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 63) { unlink ("vetrina63.db"); open ( FILE, ">> vetrina63.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina63.db"); open ( FILE, ">> nomevetrina63.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}
		elsif ($1 eq 64) { unlink ("vetrina64.db"); open ( FILE, ">> vetrina64.db"); print FILE "$nomeBot\n"; close(FILE);  unlink ("nomevetrina64.db"); open ( FILE, ">> nomevetrina64.db"); print FILE "$nomeVet\n"; close(FILE);&msg ("$channel", "4V15etrina4 $numVet 4A15ssociata 4A15l 4B15ot 4$nomeBot 4C15ol 4N15ome 4$nomeVet"); &msg ("$channel", "4A15ggiornare 4L15a 4L15ista 4P15er 4A15pportare 4L15e 4M15odifiche");}

	     else { &msg ("$channel", "4N15umero 4V15etrina 4N15on 4V15alido");}

			}

		else {&msg ("$channel", "4E15rrore4: 4I15l 4N15ick 4$nomeBot 4N15on 4è 4U15n 4B15ot");}

	}

      if ((uc($path) eq uc($channelspia)) && $msg =~ /^!news$/i) {
	if (&getStatusRispostaComandi =~ /on/i) {
	&msg ("$channelspia", "15[4$nick15] 4E15ccoti 4L15e 4U15ltime 4N15ews"); &vetrine;}
	else {&msg ("$channelspia", "15[4$nick15] 4S15piacente4: 4C15omando 4A15ttualmente 4D15isabilitato");}
}

      if ((uc($path) eq uc($channel)) && &isAdmin($nick) && $msg =~ /^!sezioni/i) {

		&getSezioni;

		my $fileId = open ( FILE, "< sezioni.db");
		@sezioni = <FILE>;
		chomp @sezioni;
         	close(FILE); 

		&msg ("$channel", "4E15lenco 4S15ezioni4:");

		for ($i = 0; $i <= $#sezioni; $i++) { $nuM = $i+1; &msg ("$channel", "4S15ezione 4n° 4 $nuM 15$sezioni[$i]");}

                }

      if ((uc($path) eq uc($channel)) && &isAdmin($nick) && $msg =~ /^!aggiorna (.*)/i) {

	$sezio = $1;

	if (&getStatusAggiornamento =~ /off/i) {

	if (&isSezione($sezio)) { &autoAggiornamentoSezione($sezio);}

	else {&msg ("$channel", "4A15ttenzione:4 $sezio 4N15on 4F15a 4P15arte 4D15elle 4S15ezioni");
	      &msg ("$channel", "4D15igita:4 4!S15ezioni 4P15er 4A15ver 4L'15Elenco 4S15ezioni");}

			}

		else {

			&msg ("$channel", "4A15ggiornamento4: 4D15i 4(15 Sezione $sezio 4) 4A15ccodato");
      			&msg ("$channel", "4V15errà 4E15ffettuato 4N15on 4A15ppena 4T15erminerà 4Q15uello 4I15n 4C15orso");
			push (@codaAgg, $sezio);
			$codeTotali = $#codaAgg+1;
			&msg ("$channel", "4A15ggiornamenti 4I15n 4C15oda4: $codeTotali");

		
			}

               }

      if ((uc($path) eq uc($channel)) && &isAdmin($nick) && $msg =~ /^!aggiorna$/i) {

	&autoAggiornamento;

	if (my $pid = fork) {
  	waitpid($pid, 0);
	}
	else {
   	if (fork) {
     	exit;
   	}
   	else {
			sleep 20;
			unlink ("statusaggiornamento.db");
			open ( FILE, ">> statusaggiornamento.db");
			print FILE "off\n";
			close(FILE);  
   	exit;
		}
  		}
              
	}

      if ((uc($path) eq uc($channel)) && &isAdmin($nick) && $msg =~ /^!add (.*)/i) {
	
		my $flag = 0;

			$except = substr ($except, 0, -1);
			$except =~ s/ //g;
			my $fileId = open ( FILE, "< admins.lst");
			while ( $riga = <FILE> )
			{
				$riga = substr ($riga, 0, -1);
				if ( uc($riga) eq uc($1) ) { $flag = 1; }
			}
			close(FILE);
			if ( $flag == 0 )
			{
				if ( uc($1) ne uc($founder) ) {

				my $fileId = open ( FILE, ">> admins.lst");
				print FILE "$1\n";
				&msg ("$channel","4A15dmin4 $1 4A15ggiunto");
				close(FILE);

				}

				else {&msg ("$channel", "4A15ttenzione: 4A15dmin4 $1 4G15ià 4P15resente");}
			} else {
				&msg ("$channel", "4A15ttenzione: 4A15dmin4 $1 4G15ià 4P15resente");
			}
		

	}


      if ((uc($path) eq uc($channel)) && &isAdmin($nick) && $msg =~ /^!del (.*)/i) {
	
	{
		my $flag = 0;

		if ( uc($1) ne uc($founder) ) {

			my $fileId = open ( FILE, "< admins.lst");
			while ( $riga = <FILE> )  {
				$riga = substr ($riga, 0, -1);
				if ( uc($riga) eq uc($1) ) { $flag = 1; }
			}
			close(FILE);
			if ( $flag == 1 )
			{	
				my $fileId = open ( FILE, "< admins.lst");
				my $fileId2 = open ( FILE2, ">> admins2.lst");
				while ( $riga = <FILE> )  {
					$riga = substr ($riga, 0, -1);
					if ( !(uc($riga) eq uc($1) ) ) { print FILE2 "$riga\n"; }
				}
				close(FILE);
				close(FILE2);
				&msg ("$channel", "4A15dmin4 $1 4C15ancellato");
				unlink("admins.lst");
				rename("admins2.lst", "admins.lst");
				unlink("admins2.lst");

			} else {
				&msg ("$channel", "4A15ttenzione: 4A15dmin4 $1 4N15on 4P15resente");
			}
                    }

		else {&msg ("$channel", "4A15ttenzione: 4A15dmin4 $1 4N15on 4R15imovibile 15(4F15ounder15)");}

		}	

	}

      if ((uc($path) eq uc($channel)) && &isAdmin($nick) && $msg =~ /^!elenco$/i) {

	if (my $pid = fork) {
  	waitpid($pid, 0);
	}
	else {
   	if (fork) {
     	exit;
   	}
   	else {

			my $fileId = open ( FILE, "< admins.lst");
			my $i = 0;
			&msg ("$channel", "4L15ista 4A15dmin");
			&msg ("$channel", "41.15 $founder 15(4F15ounder15)");
			while ( $riga = <FILE> )  {
				$i++;
				$riga = substr ($riga, 0, -1);
				$totz = $i+1;
				&msg ("$channel", "4$totz.15 ${riga}");
			}
			if (&existAndSize("admins.lst")) {&msg ("$channel", "4T15otale 4A15dmin:4 $totz");}
			else {&msg ("$channel", "4T15otale 4A15dmin:4 1");}
			close(FILE);
   	exit;
		}
  		}
			
	}

      if ((uc($path) eq uc($channel)) && &isAdmin($nick) && $msg =~ /^!conta$/i)
		{

			$variabileStop = "0";
			$checkCount = "on";
			unlink("shells.lst");
			unlink("users.lst");
			&msg ("$channel", "4A15ggiornamento 4L15ista 4S15hell 4i15n 4C15orso");
			sendraw ("NAMES $channelspia"); $checkCounter = 1;



		}

      if ((uc($path) eq uc($channel)) && &isAdmin($nick) && $msg =~ /^!folder (\d+)/i) {

	unlink ("cartella.db");
	open ( FILE, ">> cartella.db");
	print FILE "$1\n";
	close(FILE);
	&msg ("$channel", "4N15ome 4C15artella 4I15mpostata:4 $1");

	}

      		if ((uc($path) eq uc($channel)) && &isAdmin($nick) && $msg =~ /^!timer (\d+)/i) {

                    $timer = $1 * 60;

	unlink ("timer.db");
	open ( FILE, ">> timer.db");
	print FILE "$timer\n";
	close(FILE);

                    &msg ("$channel", "4T15imer 4I15mpostato:4 $1 4M15inuti");
                }

      		if ((uc($path) eq uc($channel)) && &isAdmin($nick) && $msg =~ /^!start$/i) {


 			if ($controlla eq "off" && &getStatusFolder =~ /(\d+)/i) {

			$controlla = "on";

   			&msg ("$channel", "4S15ampa 4V15etrine 4A15ttivata");

			if (my $pid = fork) { 
			waitpid($pid, 0); }
			else { if (fork) { exit; }
			else {
			for (;;) {
			my $pid = fork();
			if ($pid) {
			automessaggio($pid);
			while () {
			my $counter=0; 

			$contatoreBlocchi = 1;

			loop:


			&blocco("$contatoreBlocchi"); 
			sleep &getTimer;
			#&vetrine;
			#sleep &getTimer;

			if ($contatoreBlocchi ne &getBlocchi)  { $contatoreBlocchi++; goto loop; }

		   }}
		   exit;
	   	   }}}


		   }

            elsif ($controlla eq "on") { &msg ("$channel", "4E15rrore: 4S15tampa 4G15ià 4A15ttiva"); }
		else   { &msg ("$channel", "4E15rrore: 4S15pecificare 4N15ome 4C15artella"); }


	}

      		if ((uc($path) eq uc($channel)) && &isAdmin($nick) && $msg =~ /^!stop$/i) {

 			if ($controlla eq "on") {

  			$controlla = "off";


   			if (my $pid = fork) {
  			waitpid($pid, 0);
			}
			else {
   			if (fork) {
     			exit;
   			}
   			else {
  		        open(SUKA , "pidmessaggio.db");
   			while ($_ = <SUKA>) {
     			my @info=split(/\ÃÂ§/,$_);
     			my $pid= @info[0];
     			system("kill -9 $pid");
			}
   			close (SUKA);
            		&msg ("$channel", "4S15ampa 4V15etrine 4D15isattivata");
         		system ("rm -rf pidmessaggio.db*"); 
   			exit;
  			}
			}
			}

			else { &msg ("$channel", "4E15rrore: 4S15tampa 4V15etrine 4N15on 4A15ttiva");}

		}


#risposta ai ctcp

     if ($msg =~ /^TIME/) {

	if (my $pid = fork) {
  	waitpid($pid, 0);
	}
	else {
   	if (fork) {
     	exit;
   	}
   	else {

 	($sec,$min,$ore,$giom,$mese,$anno,$gios,$gioa,$oraleg) = localtime(time);
 	my @abbr = qw( Gennaio Febbraio Marzo Aprile Maggio Giugno Luglio Agosto Settembre Ottobre Novembre Dicembre );
 	my @abbr2 = qw( Domenica Lunedi Martedi Mercoledi Giovedi Venerdi Sabato );
 	$anno += 1900;
                    if ($min eq "1") {$min = "01"}
                    if ($min eq "2") {$min = "02"}
                    if ($min eq "3") {$min = "03"}
                    if ($min eq "4") {$min = "04"}
                    if ($min eq "5") {$min = "05"}
                    if ($min eq "6") {$min = "06"}
                    if ($min eq "7") {$min = "07"}
                    if ($min eq "8") {$min = "08"}
                    if ($min eq "9") {$min = "09"}
                     
                    sendraw ("NOTICE $nick :Sono le $ore:$min del $giom $abbr[$mese] $anno");

   	exit;
		}
  		}
	}

        if ($msg =~ /^VERSION/) {
        	sendraw ("NOTICE $nick :$logo");
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

		if ($rcv =~ /Digita la tua password/i) { print $DCCsock "$passwdChat\012";

		    if (&checkFaseCiclo =~ /off/i && &checkSortName =~ /off/i) { print $DCCsock "sort added\012"; print $DCCsock "xdl\012";}
		    elsif (&checkFaseCiclo =~ /off/i && &checkSortName =~ /on/i) { print $DCCsock "sort added\012"; print $DCCsock "xdl\012";}
		    else { print $DCCsock "sort name\012"; print $DCCsock "xdl\012";}
		
									}

                if ($rcv =~ /^Password errata$/i) { &msg ("$channel", "13\[11Open ShEllS13\] 8Errore: Pass DCC $nick errata! "); }

                if ($rcv =~ /([0-9]+?) Pack (.*) Min\: (.*)\, Max\: (.*)kB(.*)/i || $rcv =~ /([0-9]+?) Packs (.*) Min\: (.*)\, Max\: (.*)kB(.*)/i) {

			$PACK = $1;
			$MIN = $3;
			$MAX = $4;
			$counterNews = 0;

 			($sec,$min,$ore,$giom,$mese,$anno,$gios,$gioa,$oraleg) = localtime(time);
 			my @abbr = qw( Gennaio Febbraio Marzo Aprile Maggio Giugno Luglio Agosto Settembre Ottobre Novembre Dicembre );
 			my @abbr2 = qw( Domenica Lunedi Martedi Mercoledi Giovedi Venerdi Sabato );
 			$anno += 1900;

                        if ($min eq "0") {$min = "00"}
                        if ($min eq "1") {$min = "01"}
                    	if ($min eq "2") {$min = "02"}
                    	if ($min eq "3") {$min = "03"}
                    	if ($min eq "4") {$min = "04"}
                    	if ($min eq "5") {$min = "05"}
                    	if ($min eq "6") {$min = "06"}
                    	if ($min eq "7") {$min = "07"}
                    	if ($min eq "8") {$min = "08"}
                    	if ($min eq "9") {$min = "09"}

                        if ($sec eq "0") {$sec = "00"}
                        if ($sec eq "1") {$sec = "01"}
                    	if ($sec eq "2") {$sec = "02"}
                    	if ($sec eq "3") {$sec = "03"}
                    	if ($sec eq "4") {$sec = "04"}
                    	if ($sec eq "5") {$sec = "05"}
                    	if ($sec eq "6") {$sec = "06"}
                    	if ($sec eq "7") {$sec = "07"}
                    	if ($sec eq "8") {$sec = "08"}
                    	if ($sec eq "9") {$sec = "09"}

                        if ($ore eq "0") {$ore = "00"}
                        if ($ore eq "1") {$ore = "01"}
                    	if ($ore eq "2") {$ore = "02"}
                    	if ($ore eq "3") {$ore = "03"}
                    	if ($ore eq "4") {$ore = "04"}
                    	if ($ore eq "5") {$ore = "05"}
                    	if ($ore eq "6") {$ore = "06"}
                    	if ($ore eq "7") {$ore = "07"}
                    	if ($ore eq "8") {$ore = "08"}
                    	if ($ore eq "9") {$ore = "09"}

	if (uc($nick) eq uc($bot[0])) {
unlink ("".uc($nick)."");

if (&getStatusOscuramento =~ /off/i) {
open N1, "+>", "".uc($nick)."";
print N1 ("<br></center><div id=\"iroffer\"><center><table id=table7 cellpadding=2 cellspacing=1><tr><td width=60%><b><font color=white>Bot N.1 <a name=$nick href=#$nick>$nick</a></b> <b>Stato: <img src=si.png > Connesso </b></font></td><td width=40% align=center><b><font color=white><img src=calendario.png> Aggiornato al - $giom $abbr[$mese] $anno Alle ORE - $ore:$min:$sec </td></tr></table>
</center><center><table id=table7 cellpadding=2 cellspacing=1><tr><td width=60%><b><font color=white><b><img src=statistiche.png> INFORMAZIONI BOT:  (Packs: $PACK) (Vel.Minima: $MIN, Vel.Massima: $MAX kB/s)</b></font></td></tr></table>
<table id=table7 cellpadding=2 cellspacing=1><tr><td width=4% align=center><font color=\"white\"><b>Pack</b></font></td><td width=4% align=center><font color=\"white\"><b>Dim.</b></font></td><td width=62% align=left><font color=\"white\"><b>Files</b></font></td><td width=33% align=left><font color=\"white\"><b>COMANDO PER RICHIEDERE IL FILE</b></font></td></tr></table>
");
close N1;

	}

else {
open N1, "+>", "".uc($nick)."";
print N1 ("<br></center><div id=\"iroffer\" style=\"display: none;\"><center><table id=table7 cellpadding=2 cellspacing=1><tr><td width=60%><b><font color=white>Bot N.1 <a name=$nick href=#$nick>$nick</a></b> <b>Stato: <img src=si.png > Connesso </b></font></td><td width=40% align=center><b><font color=white><img src=calendario.png> Aggiornato al - $giom $abbr[$mese] $anno Alle ORE - $ore:$min:$sec </td></tr></table>
</center><center><table id=table7 cellpadding=2 cellspacing=1><tr><td width=60%><b><font color=white><b><img src=statistiche.png> INFORMAZIONI BOT:  (Packs: $PACK) (Vel.Minima: $MIN, Vel.Massima: $MAX kB/s)</b></font></td></tr></table>
<table id=table7 cellpadding=2 cellspacing=1><tr><td width=4% align=center><font color=\"white\"><b>Pack</b></font></td><td width=4% align=center><font color=\"white\"><b>Dim.</b></font></td><td width=62% align=left><font color=\"white\"><b>Files</b></font></td><td width=33% align=left><font color=\"white\"><b>COMANDO PER RICHIEDERE IL FILE</b></font></td></tr></table>
");
close N1;

      }

					}

else {

unlink ("".uc($nick)."");

open N1, "+>", "".uc($nick)."";
print N1 ("<br></center><center><table id=table7 cellpadding=2 cellspacing=1><tr><td width=60%><b><font color=white>Bot N.".&controllaPosizioneBot($nick)." <a name=$nick href=#$nick>$nick</a></b> <b>Stato: <img src=si.png > Connesso </b></font></td><td width=40% align=center><b><font color=white><img src=calendario.png> Aggiornato al - $giom $abbr[$mese] $anno Alle ORE - $ore:$min:$sec </td></tr></table>
</center><center><table id=table7 cellpadding=2 cellspacing=1><tr><td width=60%><b><font color=white><b><img src=statistiche.png> INFORMAZIONI BOT:  (Packs: $1) (Vel.Minima: $3, Vel.Massima: $4kB/s)</b></font></td></tr></table>
<table id=table7 cellpadding=2 cellspacing=1><tr><td width=4% align=center><font color=\"white\"><b>Pack</b></font></td><td width=4% align=center><font color=\"white\"><b>Dim.</b></font></td><td width=62% align=left><font color=\"white\"><b>Files</b></font></td><td width=33% align=left><font color=\"white\"><b>COMANDO PER RICHIEDERE IL FILE</b></font></td></tr></table>
");
close N1;
}

                }

		if ($rcv =~ /Totale offerto:(.*) Totale trasferito:(.*)/i ) { 

			lock ($lastBotXdl); $lastBotXdl++ ;
		if ($lastBotXdl eq ($#bot+1) && &checkSortName =~ /off/i) { &fase2; close($DCCsock); last;}
		elsif ($lastBotXdl eq ($#bot+1) && &checkSortName =~ /on/i) { &faseCiclo; close($DCCsock); last;}

		else { print $DCCsock "quit\012"; }


}	
		if ( $rcv =~ /Totale offerto: 0B/i ) {


open N1, ">>","".uc($nick)."";
print N1 ("<table id=table7 cellpadding=2 cellspacing=1><td width=62% align=left>Nessun File Presente Nel Bot</tr>
");
close N1;

	lock ($lastBotXdl);
	      $lastBotXdl++ ;

	        if ($lastBotXdl eq ($#bot+1) && &checkSortName =~ /off/i) { &fase2;  close($DCCsock); last;}
		elsif ($lastBotXdl eq ($#bot+1) && &checkSortName =~ /on/i) { &faseCiclo; close($DCCsock); last;}
		else { print $DCCsock "quit\012"; }

}
		if ( $rcv =~ /(.*) (.*)x \[(.*)\] ([0-9]+?)\-([0-9]+?)\-([0-9]+?) ([0-9]+?):([0-9]+?) (.*)/i ) {

		$pack = $1;
		$downloads = $2;
		$file = $9;
		$data = "$6/$5/$4";
		$size = $3;
		chomp $pack;
		if ($pack =~ /\#(\d+)/i) { $pack = "\#$1";}

		if (&checkSortName =~ /on/i) {
		$fileOpenz = "".uc($nick)."";
		$fileOpenz = "$fileOpenz.DT";
		if (&isDataNews($data, $fileOpenz)) {$TAGG = "<img align=right src=news.gif> </td>";}

		else {$TAGG = "</td>";} }

open N1, ">>","".uc($nick)."";
print N1 ("<table id=table7 cellpadding=2 cellspacing=1><tr align=center><th width=4%><a OnClick=\"t(\'$nick\',\'$pack\');\"href=\#void>$pack</a><td width=4%>$size <td width=62% align=left> $file $TAGG<td width=30% align=left> /msg $nick xdcc send $pack </td></tr>
");
close N1;


			if (&checkFaseCiclo =~ /off/i) {

			my $flag = 0;
			$moreDownloaded = $file;
			$file = &strip($file);
			$fileopen = "$nick.vt";
			$except = substr ($except, 0, -1);
			$except =~ s/ //g;
			my $fileId = open ( FILE, "< ".uc($fileopen)."");
			while ( $riga = <FILE> )
			{
				$riga = substr ($riga, 0, -1);
				if ( $riga eq $file ) { $flag = 1; }
			}
			close(FILE);
			if ( $flag == 0 )
			{
				my $fileId = open ( FILE, ">> ".uc($fileopen)."");
				print FILE "$file\n";
				close(FILE);

				$fileopen2 = "$nick.dt";
				open N3, ">>","".uc($fileopen2)."";
				print N3 ("$data\n");
				close N3;
			}

				my $fileId = open ( FILE, ">> ".uc($nick).".MN");
				print FILE "$moreDownloaded\n";
				close(FILE);
				my $fileId = open ( FILE, ">> ".uc($nick).".MD");
				print FILE "$downloads\n";
				close(FILE);
			
								}

		}



		if ($rcv =~ /ADMIN GETL/i ) {

		open (MYFILE, '>>check.txt');
		print MYFILE "$nick\n";
		close (MYFILE);
 
		}



}

}

sub dccChatSezioni
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

		if ($rcv =~ /Digita la tua password/i) { print $DCCsock "$passwdChat\012"; 

		    if (&checkFaseCiclo =~ /off/i && &checkSortName =~ /off/i) { 
			print $DCCsock "sort added\012"; print $DCCsock "xdl\012"; 			
			unlink ("".uc($nick).".MN"); unlink ("".uc($nick).".MD");}

		    elsif (&checkFaseCiclo =~ /off/i && &checkSortName =~ /on/i) { print $DCCsock "sort added\012"; print $DCCsock "xdl\012"; unlink ("".uc($nick).".MN"); unlink ("".uc($nick).".MD"); }
		    else { print $DCCsock "sort name\012"; print $DCCsock "xdl\012";}
		
									}

                if ($rcv =~ /^Password errata$/i) { &msg ("$channel", "13\[11Open ShEllS13\] 8Errore: Pass DCC $nick errata! "); }

                if ($rcv =~ /([0-9]+?) Pack (.*) Min\: (.*)\, Max\: (.*)kB(.*)/i || $rcv =~ /([0-9]+?) Packs (.*) Min\: (.*)\, Max\: (.*)kB(.*)/i) {

			$PACK = $1;
			$MIN = $3;
			$MAX = $4;
			$counterNews = 0;

 			($sec,$min,$ore,$giom,$mese,$anno,$gios,$gioa,$oraleg) = localtime(time);
 			my @abbr = qw( Gennaio Febbraio Marzo Aprile Maggio Giugno Luglio Agosto Settembre Ottobre Novembre Dicembre );
 			my @abbr2 = qw( Domenica Lunedi Martedi Mercoledi Giovedi Venerdi Sabato );
 			$anno += 1900;

                        if ($min eq "0") {$min = "00"}
                        if ($min eq "1") {$min = "01"}
                    	if ($min eq "2") {$min = "02"}
                    	if ($min eq "3") {$min = "03"}
                    	if ($min eq "4") {$min = "04"}
                    	if ($min eq "5") {$min = "05"}
                    	if ($min eq "6") {$min = "06"}
                    	if ($min eq "7") {$min = "07"}
                    	if ($min eq "8") {$min = "08"}
                    	if ($min eq "9") {$min = "09"}

                        if ($sec eq "0") {$sec = "00"}
                        if ($sec eq "1") {$sec = "01"}
                    	if ($sec eq "2") {$sec = "02"}
                    	if ($sec eq "3") {$sec = "03"}
                    	if ($sec eq "4") {$sec = "04"}
                    	if ($sec eq "5") {$sec = "05"}
                    	if ($sec eq "6") {$sec = "06"}
                    	if ($sec eq "7") {$sec = "07"}
                    	if ($sec eq "8") {$sec = "08"}
                    	if ($sec eq "9") {$sec = "09"}

                        if ($ore eq "0") {$ore = "00"}
                        if ($ore eq "1") {$ore = "01"}
                    	if ($ore eq "2") {$ore = "02"}
                    	if ($ore eq "3") {$ore = "03"}
                    	if ($ore eq "4") {$ore = "04"}
                    	if ($ore eq "5") {$ore = "05"}
                    	if ($ore eq "6") {$ore = "06"}
                    	if ($ore eq "7") {$ore = "07"}
                    	if ($ore eq "8") {$ore = "08"}
                    	if ($ore eq "9") {$ore = "09"}

	if (uc($nick) eq uc($bot[0])) {
unlink ("".uc($nick)."");

if (&getStatusOscuramento =~ /off/i) {
open N1, "+>", "".uc($nick)."";
print N1 ("<br></center><div id=\"iroffer\"><center><table id=table7 cellpadding=2 cellspacing=1><tr><td width=60%><b><font color=white>Bot N.1 <a name=$nick href=#$nick>$nick</a></b> <b>Stato: <img src=si.png > Connesso </b></font></td><td width=40% align=center><b><font color=white><img src=calendario.png> Aggiornato al - $giom $abbr[$mese] $anno Alle ORE - $ore:$min:$sec </td></tr></table>
</center><center><table id=table7 cellpadding=2 cellspacing=1><tr><td width=60%><b><font color=white><b><img src=statistiche.png> INFORMAZIONI BOT:  (Packs: $PACK) (Vel.Minima: $MIN, Vel.Massima: $MAX kB/s)</b></font></td></tr></table>
<table id=table7 cellpadding=2 cellspacing=1><tr><td width=4% align=center><font color=\"white\"><b>Pack</b></font></td><td width=4% align=center><font color=\"white\"><b>Dim.</b></font></td><td width=62% align=left><font color=\"white\"><b>Files</b></font></td><td width=33% align=left><font color=\"white\"><b>COMANDO PER RICHIEDERE IL FILE</b></font></td></tr></table>
");
close N1;

	}

else {
open N1, "+>", "".uc($nick)."";
print N1 ("<br></center><div id=\"iroffer\" style=\"display: none;\"><center><table id=table7 cellpadding=2 cellspacing=1><tr><td width=60%><b><font color=white>Bot N.1 <a name=$nick href=#$nick>$nick</a></b> <b>Stato: <img src=si.png > Connesso </b></font></td><td width=40% align=center><b><font color=white><img src=calendario.png> Aggiornato al - $giom $abbr[$mese] $anno Alle ORE - $ore:$min:$sec </td></tr></table>
</center><center><table id=table7 cellpadding=2 cellspacing=1><tr><td width=60%><b><font color=white><b><img src=statistiche.png> INFORMAZIONI BOT:  (Packs: $PACK) (Vel.Minima: $MIN, Vel.Massima: $MAX kB/s)</b></font></td></tr></table>
<table id=table7 cellpadding=2 cellspacing=1><tr><td width=4% align=center><font color=\"white\"><b>Pack</b></font></td><td width=4% align=center><font color=\"white\"><b>Dim.</b></font></td><td width=62% align=left><font color=\"white\"><b>Files</b></font></td><td width=33% align=left><font color=\"white\"><b>COMANDO PER RICHIEDERE IL FILE</b></font></td></tr></table>
");
close N1;

      }

					}

else {

unlink ("".uc($nick)."");

open N1, "+>", "".uc($nick)."";
print N1 ("<br></center><center><table id=table7 cellpadding=2 cellspacing=1><tr><td width=60%><b><font color=white>Bot N.".&controllaPosizioneBot($nick)." <a name=$nick href=#$nick>$nick</a></b> <b>Stato: <img src=si.png > Connesso </b></font></td><td width=40% align=center><b><font color=white><img src=calendario.png> Aggiornato al - $giom $abbr[$mese] $anno Alle ORE - $ore:$min:$sec </td></tr></table>
</center><center><table id=table7 cellpadding=2 cellspacing=1><tr><td width=60%><b><font color=white><b><img src=statistiche.png> INFORMAZIONI BOT:  (Packs: $1) (Vel.Minima: $3, Vel.Massima: $4kB/s)</b></font></td></tr></table>
<table id=table7 cellpadding=2 cellspacing=1><tr><td width=4% align=center><font color=\"white\"><b>Pack</b></font></td><td width=4% align=center><font color=\"white\"><b>Dim.</b></font></td><td width=62% align=left><font color=\"white\"><b>Files</b></font></td><td width=33% align=left><font color=\"white\"><b>COMANDO PER RICHIEDERE IL FILE</b></font></td></tr></table>
");
close N1;
}

                }

		if ($rcv =~ /Totale offerto:(.*) Totale trasferito:(.*)/i ) { 
			lock ($lastBotXdlSezioni); $lastBotXdlSezioni++ ;
		if ($lastBotXdlSezioni eq ($#nomesezioni+1) && &checkSortName =~ /off/i) { &fase2; close($DCCsock); last;}
		elsif ($lastBotXdlSezioni eq ($#nomesezioni+1) && &checkSortName =~ /on/i) { &faseCiclo2; close($DCCsock); last;}

		else { print $DCCsock "quit\012"; }


}	
		if ( $rcv =~ /Totale offerto: 0B/i ) {


open N1, ">>","".uc($nick)."";
print N1 ("<table id=table7 cellpadding=2 cellspacing=1><td width=62% align=left>Nessun File Presente Nel Bot</tr>
");
close N1;

	lock ($lastBotXdlSezioni);
	      $lastBotXdlSezioni++ ;

	        if ($lastBotXdlSezioni eq ($#nomesezioni+1) && &checkSortName =~ /off/i) { &fase2;  close($DCCsock); last;}
		elsif ($lastBotXdlSezioni eq ($#nomesezioni+1) && &checkSortName =~ /on/i) { &faseCiclo2; close($DCCsock); last;}
		else { print $DCCsock "quit\012"; }

}
		if ( $rcv =~ /(.*) (.*)x \[(.*)\] ([0-9]+?)\-([0-9]+?)\-([0-9]+?) ([0-9]+?):([0-9]+?) (.*)/i ) {

		$pack = $1;
		$downloads = $2;
		$file = $9;
		$data = "$6/$5/$4";
		$size = $3;
		chomp $pack;
		if ($pack =~ /\#(\d+)/i) { $pack = "\#$1";}

		if (&checkSortName =~ /on/i) {
		$fileOpenz = "".uc($nick)."";
		$fileOpenz = "$fileOpenz.DT";
		if (&isDataNews($data, $fileOpenz)) {$TAGG = "<img align=right src=news.gif> </td>";}

		else {$TAGG = "</td>";} }

open N1, ">>","".uc($nick)."";
print N1 ("<table id=table7 cellpadding=2 cellspacing=1><tr align=center><th width=4%><a OnClick=\"t(\'$nick\',\'$pack\');\"href=\#void>$pack</a><td width=4%>$size <td width=62% align=left> $file $TAGG<td width=30% align=left> /msg $nick xdcc send $pack </td></tr>
");
close N1;


			if (&checkFaseCiclo =~ /off/i) { 

			my $flag = 0;
			$moreDownloaded = $file;
			$file = &strip($file);
			$fileopen = "$nick.vt";
			$except = substr ($except, 0, -1);
			$except =~ s/ //g;
			my $fileId = open ( FILE, "< ".uc($fileopen)."");
			while ( $riga = <FILE> )
			{
				$riga = substr ($riga, 0, -1);
				if ( $riga eq $file ) { $flag = 1; }
			}
			close(FILE);
			if ( $flag == 0 )
			{
				my $fileId = open ( FILE, ">> ".uc($fileopen)."");
				print FILE "$file\n";
				close(FILE);

				$fileopen2 = "$nick.dt";
				open N3, ">>","".uc($fileopen2)."";
				print N3 ("$data\n");
				close N3;
			}

				my $fileId = open ( FILE, ">> ".uc($nick).".MN");
				print FILE "$moreDownloaded\n";
				close(FILE);
				my $fileId = open ( FILE, ">> ".uc($nick).".MD");
				print FILE "$downloads\n";
				close(FILE);
								}

		}



		if ($rcv =~ /ADMIN GETL/i ) {

		open (MYFILE, '>>check.txt');
		print MYFILE "$nick\n";
		close (MYFILE);
 
		}



}

}


sub vetrinaFinale {

for ($i = 1 ; $i <= &getBlocchi ; $i++) { if (&getNomeVetrina($i) eq '') { $fileOpen = "nomevetrina$i.db"; unlink ("$fileOpen"); open ( FILE, ">> $fileOpen"); print FILE "Non Disponibile\n"; close(FILE);} }

@newsVetrina1Stamp = &newsVetrinaStamp(1); @newsVetrina1Query = &newsVetrinaQuery(1); @dataVetrina1 = &newsData(1);
@newsVetrina2Stamp = &newsVetrinaStamp(2); @newsVetrina2Query = &newsVetrinaQuery(2); @dataVetrina2 = &newsData(2);
@newsVetrina3Stamp = &newsVetrinaStamp(3); @newsVetrina3Query = &newsVetrinaQuery(3); @dataVetrina3 = &newsData(3);
@newsVetrina4Stamp = &newsVetrinaStamp(4); @newsVetrina4Query = &newsVetrinaQuery(4); @dataVetrina4 = &newsData(4);
@newsVetrina5Stamp = &newsVetrinaStamp(5); @newsVetrina5Query = &newsVetrinaQuery(5); @dataVetrina5 = &newsData(5);
@newsVetrina6Stamp = &newsVetrinaStamp(6); @newsVetrina6Query = &newsVetrinaQuery(6); @dataVetrina6 = &newsData(6);
@newsVetrina7Stamp = &newsVetrinaStamp(7); @newsVetrina7Query = &newsVetrinaQuery(7); @dataVetrina7 = &newsData(7);
@newsVetrina8Stamp = &newsVetrinaStamp(8); @newsVetrina8Query = &newsVetrinaQuery(8); @dataVetrina8 = &newsData(8);
@newsVetrina9Stamp = &newsVetrinaStamp(9); @newsVetrina9Query = &newsVetrinaQuery(9); @dataVetrina9 = &newsData(9); 
@newsVetrina10Stamp = &newsVetrinaStamp(10); @newsVetrina10Query = &newsVetrinaQuery(10); @dataVetrina10 = &newsData(10);

@newsVetrina11Stamp = &newsVetrinaStamp(11); @newsVetrina11Query = &newsVetrinaQuery(11); @dataVetrina11 = &newsData(11);
@newsVetrina12Stamp = &newsVetrinaStamp(12); @newsVetrina12Query = &newsVetrinaQuery(12); @dataVetrina12 = &newsData(12);
@newsVetrina13Stamp = &newsVetrinaStamp(13); @newsVetrina13Query = &newsVetrinaQuery(13); @dataVetrina13 = &newsData(13);
@newsVetrina14Stamp = &newsVetrinaStamp(14); @newsVetrina14Query = &newsVetrinaQuery(14); @dataVetrina14 = &newsData(14);
@newsVetrina15Stamp = &newsVetrinaStamp(15); @newsVetrina15Query = &newsVetrinaQuery(15); @dataVetrina15 = &newsData(15);
@newsVetrina16Stamp = &newsVetrinaStamp(16); @newsVetrina16Query = &newsVetrinaQuery(16); @dataVetrina16 = &newsData(16);
@newsVetrina17Stamp = &newsVetrinaStamp(17); @newsVetrina17Query = &newsVetrinaQuery(17); @dataVetrina17 = &newsData(17);
@newsVetrina18Stamp = &newsVetrinaStamp(18); @newsVetrina18Query = &newsVetrinaQuery(18); @dataVetrina18 = &newsData(18);
@newsVetrina19Stamp = &newsVetrinaStamp(19); @newsVetrina19Query = &newsVetrinaQuery(19); @dataVetrina19 = &newsData(19);
@newsVetrina20Stamp = &newsVetrinaStamp(20); @newsVetrina20Query = &newsVetrinaQuery(20); @dataVetrina20 = &newsData(20);

@newsVetrina21Stamp = &newsVetrinaStamp(21); @newsVetrina21Query = &newsVetrinaQuery(21); @dataVetrina21 = &newsData(21);
@newsVetrina22Stamp = &newsVetrinaStamp(22); @newsVetrina22Query = &newsVetrinaQuery(22); @dataVetrina22 = &newsData(22);
@newsVetrina23Stamp = &newsVetrinaStamp(23); @newsVetrina23Query = &newsVetrinaQuery(23); @dataVetrina23 = &newsData(23);
@newsVetrina24Stamp = &newsVetrinaStamp(24); @newsVetrina24Query = &newsVetrinaQuery(24); @dataVetrina24 = &newsData(24);
@newsVetrina25Stamp = &newsVetrinaStamp(25); @newsVetrina25Query = &newsVetrinaQuery(25); @dataVetrina25 = &newsData(25);
@newsVetrina26Stamp = &newsVetrinaStamp(26); @newsVetrina26Query = &newsVetrinaQuery(26); @dataVetrina26 = &newsData(26);
@newsVetrina27Stamp = &newsVetrinaStamp(27); @newsVetrina27Query = &newsVetrinaQuery(27); @dataVetrina27 = &newsData(27);
@newsVetrina28Stamp = &newsVetrinaStamp(28); @newsVetrina28Query = &newsVetrinaQuery(28); @dataVetrina28 = &newsData(28);
@newsVetrina29Stamp = &newsVetrinaStamp(29); @newsVetrina29Query = &newsVetrinaQuery(29); @dataVetrina29 = &newsData(29);
@newsVetrina30Stamp = &newsVetrinaStamp(30); @newsVetrina30Query = &newsVetrinaQuery(30); @dataVetrina30 = &newsData(30);

@newsVetrina31Stamp = &newsVetrinaStamp(31); @newsVetrina31Query = &newsVetrinaQuery(31); @dataVetrina31 = &newsData(31);
@newsVetrina32Stamp = &newsVetrinaStamp(32); @newsVetrina32Query = &newsVetrinaQuery(32); @dataVetrina32 = &newsData(32);

@newsVetrina33Stamp = &newsVetrinaStamp(33); @newsVetrina33Query = &newsVetrinaQuery(33); @dataVetrina33 = &newsData(33);
@newsVetrina34Stamp = &newsVetrinaStamp(34); @newsVetrina34Query = &newsVetrinaQuery(34); @dataVetrina34 = &newsData(34);
@newsVetrina35Stamp = &newsVetrinaStamp(35); @newsVetrina35Query = &newsVetrinaQuery(35); @dataVetrina35 = &newsData(35);
@newsVetrina36Stamp = &newsVetrinaStamp(36); @newsVetrina36Query = &newsVetrinaQuery(36); @dataVetrina36 = &newsData(36);
@newsVetrina37Stamp = &newsVetrinaStamp(37); @newsVetrina37Query = &newsVetrinaQuery(37); @dataVetrina37 = &newsData(37);
@newsVetrina38Stamp = &newsVetrinaStamp(38); @newsVetrina38Query = &newsVetrinaQuery(38); @dataVetrina38 = &newsData(38);
@newsVetrina39Stamp = &newsVetrinaStamp(39); @newsVetrina39Query = &newsVetrinaQuery(39); @dataVetrina39 = &newsData(39);
@newsVetrina40Stamp = &newsVetrinaStamp(40); @newsVetrina40Query = &newsVetrinaQuery(40); @dataVetrina40 = &newsData(40);
@newsVetrina41Stamp = &newsVetrinaStamp(41); @newsVetrina41Query = &newsVetrinaQuery(41); @dataVetrina41 = &newsData(41);
@newsVetrina42Stamp = &newsVetrinaStamp(42); @newsVetrina42Query = &newsVetrinaQuery(42); @dataVetrina42 = &newsData(42);

@newsVetrina43Stamp = &newsVetrinaStamp(43); @newsVetrina43Query = &newsVetrinaQuery(43); @dataVetrina43 = &newsData(43);
@newsVetrina44Stamp = &newsVetrinaStamp(44); @newsVetrina44Query = &newsVetrinaQuery(44); @dataVetrina44 = &newsData(44);
@newsVetrina45Stamp = &newsVetrinaStamp(45); @newsVetrina45Query = &newsVetrinaQuery(45); @dataVetrina45 = &newsData(45);
@newsVetrina46Stamp = &newsVetrinaStamp(46); @newsVetrina46Query = &newsVetrinaQuery(46); @dataVetrina46 = &newsData(46);
@newsVetrina47Stamp = &newsVetrinaStamp(47); @newsVetrina47Query = &newsVetrinaQuery(47); @dataVetrina47 = &newsData(47);
@newsVetrina48Stamp = &newsVetrinaStamp(48); @newsVetrina48Query = &newsVetrinaQuery(48); @dataVetrina48 = &newsData(48);
@newsVetrina49Stamp = &newsVetrinaStamp(49); @newsVetrina49Query = &newsVetrinaQuery(49); @dataVetrina49 = &newsData(49);
@newsVetrina50Stamp = &newsVetrinaStamp(50); @newsVetrina50Query = &newsVetrinaQuery(50); @dataVetrina50 = &newsData(50);
@newsVetrina51Stamp = &newsVetrinaStamp(51); @newsVetrina51Query = &newsVetrinaQuery(51); @dataVetrina51 = &newsData(51);
@newsVetrina52Stamp = &newsVetrinaStamp(52); @newsVetrina52Query = &newsVetrinaQuery(52); @dataVetrina52 = &newsData(52);

@newsVetrina53Stamp = &newsVetrinaStamp(53); @newsVetrina53Query = &newsVetrinaQuery(53); @dataVetrina53 = &newsData(53);
@newsVetrina54Stamp = &newsVetrinaStamp(54); @newsVetrina54Query = &newsVetrinaQuery(54); @dataVetrina54 = &newsData(54);
@newsVetrina55Stamp = &newsVetrinaStamp(55); @newsVetrina55Query = &newsVetrinaQuery(55); @dataVetrina55 = &newsData(55);
@newsVetrina56Stamp = &newsVetrinaStamp(56); @newsVetrina56Query = &newsVetrinaQuery(56); @dataVetrina56 = &newsData(56);
@newsVetrina57Stamp = &newsVetrinaStamp(57); @newsVetrina57Query = &newsVetrinaQuery(57); @dataVetrina57 = &newsData(57);
@newsVetrina58Stamp = &newsVetrinaStamp(58); @newsVetrina58Query = &newsVetrinaQuery(58); @dataVetrina58 = &newsData(58);
@newsVetrina59Stamp = &newsVetrinaStamp(59); @newsVetrina59Query = &newsVetrinaQuery(59); @dataVetrina59 = &newsData(59);
@newsVetrina60Stamp = &newsVetrinaStamp(60); @newsVetrina60Query = &newsVetrinaQuery(60); @dataVetrina60 = &newsData(60);
@newsVetrina61Stamp = &newsVetrinaStamp(61); @newsVetrina61Query = &newsVetrinaQuery(61); @dataVetrina61 = &newsData(61);
@newsVetrina62Stamp = &newsVetrinaStamp(62); @newsVetrina62Query = &newsVetrinaQuery(62); @dataVetrina62 = &newsData(62);

@newsVetrina63Stamp = &newsVetrinaStamp(63); @newsVetrina63Query = &newsVetrinaQuery(63); @dataVetrina63 = &newsData(63);
@newsVetrina64Stamp = &newsVetrinaStamp(64); @newsVetrina64Query = &newsVetrinaQuery(64); @dataVetrina64 = &newsData(64);

@d4taVetrina1 = &newsData2(1); @d4taVetrina2 = &newsData2(2); @d4taVetrina3 = &newsData2(3); @d4taVetrina4 = &newsData2(4);
@d4taVetrina5 = &newsData2(5); @d4taVetrina6 = &newsData2(6); @d4taVetrina7 = &newsData2(7); @d4taVetrina8 = &newsData2(8); 

@d4taVetrina9 = &newsData2(9); @d4taVetrina10 = &newsData2(10); @d4taVetrina11 = &newsData2(11); @d4taVetrina12 = &newsData2(12);
@d4taVetrina13 = &newsData2(13); @d4taVetrina14 = &newsData2(14); @d4taVetrina15 = &newsData2(15); @d4taVetrina16 = &newsData2(16);  

@d4taVetrina17 = &newsData2(17); @d4taVetrina18 = &newsData2(18); @d4taVetrina19 = &newsData2(19); @d4taVetrina20 = &newsData2(20);
@d4taVetrina21 = &newsData2(21); @d4taVetrina22 = &newsData2(22); @d4taVetrina23 = &newsData2(23); @d4taVetrina24 = &newsData2(24);  

@d4taVetrina25 = &newsData2(25); @d4taVetrina26 = &newsData2(26); @d4taVetrina27 = &newsData2(27); @d4taVetrina28 = &newsData2(28);
@d4taVetrina29 = &newsData2(29); @d4taVetrina30 = &newsData2(30); @d4taVetrina31 = &newsData2(31); @d4taVetrina32 = &newsData2(32); 

@d4taVetrina33 = &newsData2(33); @d4taVetrina34 = &newsData2(34); @d4taVetrina35 = &newsData2(35); @d4taVetrina36 = &newsData2(36);
@d4taVetrina37 = &newsData2(37); @d4taVetrina38 = &newsData2(38); @d4taVetrina39 = &newsData2(39); @d4taVetrina40 = &newsData2(40); 

@d4taVetrina41 = &newsData2(41); @d4taVetrina42 = &newsData2(42); @d4taVetrina43 = &newsData2(43); @d4taVetrina44 = &newsData2(44);
@d4taVetrina45 = &newsData2(45); @d4taVetrina46 = &newsData2(46); @d4taVetrina47 = &newsData2(47); @d4taVetrina48 = &newsData2(48); 

@d4taVetrina49 = &newsData2(49); @d4taVetrina50 = &newsData2(50); @d4taVetrina51 = &newsData2(51); @d4taVetrina52 = &newsData2(52);
@d4taVetrina53 = &newsData2(53); @d4taVetrina54 = &newsData2(54); @d4taVetrina55 = &newsData2(55); @d4taVetrina56 = &newsData2(56); 

@d4taVetrina57 = &newsData2(57); @d4taVetrina58 = &newsData2(58); @d4taVetrina59 = &newsData2(59); @d4taVetrina60 = &newsData2(60);
@d4taVetrina61 = &newsData2(61); @d4taVetrina62 = &newsData2(62); @d4taVetrina63 = &newsData2(63); @d4taVetrina64 = &newsData2(64);  

 	($sec,$min,$ore,$giom,$mese,$anno,$gios,$gioa,$oraleg) = localtime(time);

	$mese++;

	my $totBotVetr = &getGriglia; #tanti quanti i bot totali in vetrina

	for ( $i = 0 ; $i < $totBotVetr ; $i++ ) {

	     if ($dataVetrina1[$i] eq '' ) { $dataVetrina1[$i] = "-/-"; }
	     if ($dataVetrina2[$i] eq '' ) { $dataVetrina2[$i] = "-/-"; }
	     if ($dataVetrina3[$i] eq '' ) { $dataVetrina3[$i] = "-/-"; }
	     if ($dataVetrina4[$i] eq '' ) { $dataVetrina4[$i] = "-/-"; }
	     if ($dataVetrina5[$i] eq '' ) { $dataVetrina5[$i] = "-/-"; }
	     if ($dataVetrina6[$i] eq '' ) { $dataVetrina6[$i] = "-/-"; }
	     if ($dataVetrina7[$i] eq '' ) { $dataVetrina7[$i] = "-/-"; }
	     if ($dataVetrina8[$i] eq '' ) { $dataVetrina8[$i] = "-/-"; }

	     if ($dataVetrina9[$i] eq '' ) { $dataVetrina9[$i] = "-/-"; }
	     if ($dataVetrina10[$i] eq '' ) { $dataVetrina10[$i] = "-/-"; }
	     if ($dataVetrina11[$i] eq '' ) { $dataVetrina11[$i] = "-/-"; }
	     if ($dataVetrina12[$i] eq '' ) { $dataVetrina12[$i] = "-/-"; }
	     if ($dataVetrina13[$i] eq '' ) { $dataVetrina13[$i] = "-/-"; }
	     if ($dataVetrina14[$i] eq '' ) { $dataVetrina14[$i] = "-/-"; }
	     if ($dataVetrina15[$i] eq '' ) { $dataVetrina15[$i] = "-/-"; }
	     if ($dataVetrina16[$i] eq '' ) { $dataVetrina16[$i] = "-/-"; }

	     if ($dataVetrina17[$i] eq '' ) { $dataVetrina17[$i] = "-/-"; }
	     if ($dataVetrina18[$i] eq '' ) { $dataVetrina18[$i] = "-/-"; }
	     if ($dataVetrina19[$i] eq '' ) { $dataVetrina19[$i] = "-/-"; }
	     if ($dataVetrina20[$i] eq '' ) { $dataVetrina20[$i] = "-/-"; }
	     if ($dataVetrina21[$i] eq '' ) { $dataVetrina21[$i] = "-/-"; }
	     if ($dataVetrina22[$i] eq '' ) { $dataVetrina22[$i] = "-/-"; }
	     if ($dataVetrina23[$i] eq '' ) { $dataVetrina23[$i] = "-/-"; }
	     if ($dataVetrina24[$i] eq '' ) { $dataVetrina24[$i] = "-/-"; }

	     if ($dataVetrina25[$i] eq '' ) { $dataVetrina25[$i] = "-/-"; }
	     if ($dataVetrina26[$i] eq '' ) { $dataVetrina26[$i] = "-/-"; }
	     if ($dataVetrina27[$i] eq '' ) { $dataVetrina27[$i] = "-/-"; }
	     if ($dataVetrina28[$i] eq '' ) { $dataVetrina28[$i] = "-/-"; }
	     if ($dataVetrina29[$i] eq '' ) { $dataVetrina29[$i] = "-/-"; }
	     if ($dataVetrina30[$i] eq '' ) { $dataVetrina30[$i] = "-/-"; }
	     if ($dataVetrina31[$i] eq '' ) { $dataVetrina31[$i] = "-/-"; }
	     if ($dataVetrina32[$i] eq '' ) { $dataVetrina32[$i] = "-/-"; }

	     if ($dataVetrina33[$i] eq '' ) { $dataVetrina33[$i] = "-/-"; }
	     if ($dataVetrina34[$i] eq '' ) { $dataVetrina34[$i] = "-/-"; }
	     if ($dataVetrina35[$i] eq '' ) { $dataVetrina35[$i] = "-/-"; }
	     if ($dataVetrina36[$i] eq '' ) { $dataVetrina36[$i] = "-/-"; }
	     if ($dataVetrina37[$i] eq '' ) { $dataVetrina37[$i] = "-/-"; }
	     if ($dataVetrina38[$i] eq '' ) { $dataVetrina38[$i] = "-/-"; }
	     if ($dataVetrina39[$i] eq '' ) { $dataVetrina39[$i] = "-/-"; }
	     if ($dataVetrina40[$i] eq '' ) { $dataVetrina40[$i] = "-/-"; }

	     if ($dataVetrina41[$i] eq '' ) { $dataVetrina41[$i] = "-/-"; }
	     if ($dataVetrina42[$i] eq '' ) { $dataVetrina42[$i] = "-/-"; }
	     if ($dataVetrina43[$i] eq '' ) { $dataVetrina43[$i] = "-/-"; }
	     if ($dataVetrina44[$i] eq '' ) { $dataVetrina44[$i] = "-/-"; }
	     if ($dataVetrina45[$i] eq '' ) { $dataVetrina45[$i] = "-/-"; }
	     if ($dataVetrina46[$i] eq '' ) { $dataVetrina46[$i] = "-/-"; }
	     if ($dataVetrina47[$i] eq '' ) { $dataVetrina47[$i] = "-/-"; }
	     if ($dataVetrina48[$i] eq '' ) { $dataVetrina48[$i] = "-/-"; }

	     if ($dataVetrina49[$i] eq '' ) { $dataVetrina49[$i] = "-/-"; }
	     if ($dataVetrina50[$i] eq '' ) { $dataVetrina50[$i] = "-/-"; }
	     if ($dataVetrina51[$i] eq '' ) { $dataVetrina51[$i] = "-/-"; }
	     if ($dataVetrina52[$i] eq '' ) { $dataVetrina52[$i] = "-/-"; }
	     if ($dataVetrina53[$i] eq '' ) { $dataVetrina53[$i] = "-/-"; }
	     if ($dataVetrina54[$i] eq '' ) { $dataVetrina54[$i] = "-/-"; }
	     if ($dataVetrina55[$i] eq '' ) { $dataVetrina55[$i] = "-/-"; }
	     if ($dataVetrina56[$i] eq '' ) { $dataVetrina56[$i] = "-/-"; }

	     if ($dataVetrina57[$i] eq '' ) { $dataVetrina57[$i] = "-/-"; }
	     if ($dataVetrina58[$i] eq '' ) { $dataVetrina58[$i] = "-/-"; }
	     if ($dataVetrina59[$i] eq '' ) { $dataVetrina59[$i] = "-/-"; }
	     if ($dataVetrina60[$i] eq '' ) { $dataVetrina60[$i] = "-/-"; }
	     if ($dataVetrina61[$i] eq '' ) { $dataVetrina61[$i] = "-/-"; }
	     if ($dataVetrina62[$i] eq '' ) { $dataVetrina62[$i] = "-/-"; }
	     if ($dataVetrina63[$i] eq '' ) { $dataVetrina63[$i] = "-/-"; }
	     if ($dataVetrina64[$i] eq '' ) { $dataVetrina64[$i] = "-/-"; }

	}

	my $link1Vetrina = &getNomeVetrina1;
	my $link2Vetrina = &getNomeVetrina2;
	my $link3Vetrina = &getNomeVetrina3;
	my $link4Vetrina = &getNomeVetrina4;
	my $link5Vetrina = &getNomeVetrina5;
	my $link6Vetrina = &getNomeVetrina6;
	my $link7Vetrina = &getNomeVetrina7;
	my $link8Vetrina = &getNomeVetrina8;

	my $link9Vetrina = &getNomeVetrina9;
	my $link10Vetrina = &getNomeVetrina10;
	my $link11Vetrina = &getNomeVetrina11;
	my $link12Vetrina = &getNomeVetrina12;
	my $link13Vetrina = &getNomeVetrina13;
	my $link14Vetrina = &getNomeVetrina14;
	my $link15Vetrina = &getNomeVetrina15;
	my $link16Vetrina = &getNomeVetrina16;

	my $link17Vetrina = &getNomeVetrina17;
	my $link18Vetrina = &getNomeVetrina18;
	my $link19Vetrina = &getNomeVetrina19;
	my $link20Vetrina = &getNomeVetrina20;
	my $link21Vetrina = &getNomeVetrina21;
	my $link22Vetrina = &getNomeVetrina22;
	my $link23Vetrina = &getNomeVetrina23;
	my $link24Vetrina = &getNomeVetrina24;

	my $link25Vetrina = &getNomeVetrina25;
	my $link26Vetrina = &getNomeVetrina26;
	my $link27Vetrina = &getNomeVetrina27;
	my $link28Vetrina = &getNomeVetrina28;
	my $link29Vetrina = &getNomeVetrina29;
	my $link30Vetrina = &getNomeVetrina30;
	my $link31Vetrina = &getNomeVetrina31;
	my $link32Vetrina = &getNomeVetrina32;

	my $link33Vetrina = &getNomeVetrina33;
	my $link34Vetrina = &getNomeVetrina34;
	my $link35Vetrina = &getNomeVetrina35;
	my $link36Vetrina = &getNomeVetrina36;
	my $link37Vetrina = &getNomeVetrina37;
	my $link38Vetrina = &getNomeVetrina38;
	my $link39Vetrina = &getNomeVetrina39;
	my $link40Vetrina = &getNomeVetrina40;

	my $link41Vetrina = &getNomeVetrina41;
	my $link42Vetrina = &getNomeVetrina42;
	my $link43Vetrina = &getNomeVetrina43;
	my $link44Vetrina = &getNomeVetrina44;
	my $link45Vetrina = &getNomeVetrina45;
	my $link46Vetrina = &getNomeVetrina46;
	my $link47Vetrina = &getNomeVetrina47;
	my $link48Vetrina = &getNomeVetrina48;

	my $link49Vetrina = &getNomeVetrina49;
	my $link50Vetrina = &getNomeVetrina50;
	my $link51Vetrina = &getNomeVetrina51;
	my $link52Vetrina = &getNomeVetrina52;
	my $link53Vetrina = &getNomeVetrina53;
	my $link54Vetrina = &getNomeVetrina54;
	my $link55Vetrina = &getNomeVetrina55;
	my $link56Vetrina = &getNomeVetrina56;

	my $link57Vetrina = &getNomeVetrina57;
	my $link58Vetrina = &getNomeVetrina58;
	my $link59Vetrina = &getNomeVetrina59;
	my $link60Vetrina = &getNomeVetrina60;
	my $link61Vetrina = &getNomeVetrina61;
	my $link62Vetrina = &getNomeVetrina62;
	my $link63Vetrina = &getNomeVetrina63;
	my $link64Vetrina = &getNomeVetrina64;

	my $totBotVetr = &getGriglia; #tanti quanti i bot totali in vetrina

	for ( $i = 0 ; $i < $totBotVetr ; $i++ ) {

	     if ($newsVetrina1Stamp[$i] eq '') { $newsVetrina1Stamp[$i] = "$link1Vetrina"; $newsVetrina1Query[$i] = "";}
	     if ($newsVetrina2Stamp[$i] eq '') { $newsVetrina2Stamp[$i] = "$link2Vetrina"; $newsVetrina2Query[$i] = "";}
	     if ($newsVetrina3Stamp[$i] eq '') { $newsVetrina3Stamp[$i] = "$link3Vetrina"; $newsVetrina3Query[$i] = "";}
	     if ($newsVetrina4Stamp[$i] eq '') { $newsVetrina4Stamp[$i] = "$link4Vetrina"; $newsVetrina4Query[$i] = "";}
	     if ($newsVetrina5Stamp[$i] eq '') { $newsVetrina5Stamp[$i] = "$link5Vetrina"; $newsVetrina5Query[$i] = "";}
	     if ($newsVetrina6Stamp[$i] eq '') { $newsVetrina6Stamp[$i] = "$link6Vetrina"; $newsVetrina6Query[$i] = "";}
	     if ($newsVetrina7Stamp[$i] eq '') { $newsVetrina7Stamp[$i] = "$link7Vetrina"; $newsVetrina7Query[$i] = "";}
	     if ($newsVetrina8Stamp[$i] eq '') { $newsVetrina8Stamp[$i] = "$link8Vetrina"; $newsVetrina8Query[$i] = "";}

	     if ($newsVetrina9Stamp[$i] eq '') { $newsVetrina9Stamp[$i] = "$link9Vetrina"; $newsVetrina9Query[$i] = "";}
	     if ($newsVetrina10Stamp[$i] eq '') { $newsVetrina10Stamp[$i] = "$link10Vetrina"; $newsVetrina10Query[$i] = "";}
	     if ($newsVetrina11Stamp[$i] eq '') { $newsVetrina11Stamp[$i] = "$link11Vetrina"; $newsVetrina11Query[$i] = "";}
	     if ($newsVetrina12Stamp[$i] eq '') { $newsVetrina12Stamp[$i] = "$link12Vetrina"; $newsVetrina12Query[$i] = "";}
	     if ($newsVetrina13Stamp[$i] eq '') { $newsVetrina13Stamp[$i] = "$link13Vetrina"; $newsVetrina13Query[$i] = "";}
	     if ($newsVetrina14Stamp[$i] eq '') { $newsVetrina14Stamp[$i] = "$link14Vetrina"; $newsVetrina14Query[$i] = "";}
	     if ($newsVetrina15Stamp[$i] eq '') { $newsVetrina15Stamp[$i] = "$link15Vetrina"; $newsVetrina15Query[$i] = "";}
	     if ($newsVetrina16Stamp[$i] eq '') { $newsVetrina16Stamp[$i] = "$link16Vetrina"; $newsVetrina16Query[$i] = "";}

	     if ($newsVetrina17Stamp[$i] eq '') { $newsVetrina17Stamp[$i] = "$link17Vetrina"; $newsVetrina17Query[$i] = "";}
	     if ($newsVetrina18Stamp[$i] eq '') { $newsVetrina18Stamp[$i] = "$link18Vetrina"; $newsVetrina18Query[$i] = "";}
	     if ($newsVetrina19Stamp[$i] eq '') { $newsVetrina19Stamp[$i] = "$link19Vetrina"; $newsVetrina19Query[$i] = "";}
	     if ($newsVetrina20Stamp[$i] eq '') { $newsVetrina20Stamp[$i] = "$link20Vetrina"; $newsVetrina20Query[$i] = "";}
	     if ($newsVetrina21Stamp[$i] eq '') { $newsVetrina21Stamp[$i] = "$link21Vetrina"; $newsVetrina21Query[$i] = "";}
	     if ($newsVetrina22Stamp[$i] eq '') { $newsVetrina22Stamp[$i] = "$link22Vetrina"; $newsVetrina22Query[$i] = "";}
	     if ($newsVetrina23Stamp[$i] eq '') { $newsVetrina23Stamp[$i] = "$link23Vetrina"; $newsVetrina23Query[$i] = "";}
	     if ($newsVetrina24Stamp[$i] eq '') { $newsVetrina24Stamp[$i] = "$link24Vetrina"; $newsVetrina24Query[$i] = "";}

	     if ($newsVetrina25Stamp[$i] eq '') { $newsVetrina25Stamp[$i] = "$link25Vetrina"; $newsVetrina25Query[$i] = "";}
	     if ($newsVetrina26Stamp[$i] eq '') { $newsVetrina26Stamp[$i] = "$link26Vetrina"; $newsVetrina26Query[$i] = "";}
	     if ($newsVetrina27Stamp[$i] eq '') { $newsVetrina27Stamp[$i] = "$link27Vetrina"; $newsVetrina27Query[$i] = "";}
	     if ($newsVetrina28Stamp[$i] eq '') { $newsVetrina28Stamp[$i] = "$link28Vetrina"; $newsVetrina28Query[$i] = "";}
	     if ($newsVetrina29Stamp[$i] eq '') { $newsVetrina29Stamp[$i] = "$link29Vetrina"; $newsVetrina29Query[$i] = "";}
	     if ($newsVetrina30Stamp[$i] eq '') { $newsVetrina30Stamp[$i] = "$link30Vetrina"; $newsVetrina30Query[$i] = "";}
	     if ($newsVetrina31Stamp[$i] eq '') { $newsVetrina31Stamp[$i] = "$link31Vetrina"; $newsVetrina31Query[$i] = "";}
	     if ($newsVetrina32Stamp[$i] eq '') { $newsVetrina32Stamp[$i] = "$link32Vetrina"; $newsVetrina32Query[$i] = "";}

	     if ($newsVetrina33Stamp[$i] eq '') { $newsVetrina33Stamp[$i] = "$link33Vetrina"; $newsVetrina33Query[$i] = "";}
	     if ($newsVetrina34Stamp[$i] eq '') { $newsVetrina34Stamp[$i] = "$link34Vetrina"; $newsVetrina34Query[$i] = "";}
	     if ($newsVetrina35Stamp[$i] eq '') { $newsVetrina35Stamp[$i] = "$link35Vetrina"; $newsVetrina35Query[$i] = "";}
	     if ($newsVetrina36Stamp[$i] eq '') { $newsVetrina36Stamp[$i] = "$link36Vetrina"; $newsVetrina36Query[$i] = "";}
	     if ($newsVetrina37Stamp[$i] eq '') { $newsVetrina37Stamp[$i] = "$link37Vetrina"; $newsVetrina37Query[$i] = "";}
	     if ($newsVetrina38Stamp[$i] eq '') { $newsVetrina38Stamp[$i] = "$link38Vetrina"; $newsVetrina38Query[$i] = "";}
	     if ($newsVetrina39Stamp[$i] eq '') { $newsVetrina39Stamp[$i] = "$link39Vetrina"; $newsVetrina39Query[$i] = "";}
	     if ($newsVetrina40Stamp[$i] eq '') { $newsVetrina40Stamp[$i] = "$link40Vetrina"; $newsVetrina40Query[$i] = "";}

	     if ($newsVetrina41Stamp[$i] eq '') { $newsVetrina41Stamp[$i] = "$link41Vetrina"; $newsVetrina41Query[$i] = "";}
	     if ($newsVetrina42Stamp[$i] eq '') { $newsVetrina42Stamp[$i] = "$link42Vetrina"; $newsVetrina42Query[$i] = "";}
	     if ($newsVetrina43Stamp[$i] eq '') { $newsVetrina43Stamp[$i] = "$link43Vetrina"; $newsVetrina43Query[$i] = "";}
	     if ($newsVetrina44Stamp[$i] eq '') { $newsVetrina44Stamp[$i] = "$link44Vetrina"; $newsVetrina44Query[$i] = "";}
	     if ($newsVetrina45Stamp[$i] eq '') { $newsVetrina45Stamp[$i] = "$link45Vetrina"; $newsVetrina45Query[$i] = "";}
	     if ($newsVetrina46Stamp[$i] eq '') { $newsVetrina46Stamp[$i] = "$link46Vetrina"; $newsVetrina46Query[$i] = "";}
	     if ($newsVetrina47Stamp[$i] eq '') { $newsVetrina47Stamp[$i] = "$link47Vetrina"; $newsVetrina47Query[$i] = "";}
	     if ($newsVetrina48Stamp[$i] eq '') { $newsVetrina48Stamp[$i] = "$link48Vetrina"; $newsVetrina48Query[$i] = "";}

	     if ($newsVetrina49Stamp[$i] eq '') { $newsVetrina49Stamp[$i] = "$link49Vetrina"; $newsVetrina49Query[$i] = "";}
	     if ($newsVetrina50Stamp[$i] eq '') { $newsVetrina50Stamp[$i] = "$link50Vetrina"; $newsVetrina50Query[$i] = "";}
	     if ($newsVetrina51Stamp[$i] eq '') { $newsVetrina51Stamp[$i] = "$link51Vetrina"; $newsVetrina51Query[$i] = "";}
	     if ($newsVetrina52Stamp[$i] eq '') { $newsVetrina52Stamp[$i] = "$link52Vetrina"; $newsVetrina52Query[$i] = "";}
	     if ($newsVetrina53Stamp[$i] eq '') { $newsVetrina53Stamp[$i] = "$link53Vetrina"; $newsVetrina53Query[$i] = "";}
	     if ($newsVetrina54Stamp[$i] eq '') { $newsVetrina54Stamp[$i] = "$link54Vetrina"; $newsVetrina54Query[$i] = "";}
	     if ($newsVetrina55Stamp[$i] eq '') { $newsVetrina55Stamp[$i] = "$link55Vetrina"; $newsVetrina55Query[$i] = "";}
	     if ($newsVetrina56Stamp[$i] eq '') { $newsVetrina56Stamp[$i] = "$link56Vetrina"; $newsVetrina56Query[$i] = "";}

	     if ($newsVetrina57Stamp[$i] eq '') { $newsVetrina57Stamp[$i] = "$link57Vetrina"; $newsVetrina57Query[$i] = "";}
	     if ($newsVetrina58Stamp[$i] eq '') { $newsVetrina58Stamp[$i] = "$link58Vetrina"; $newsVetrina58Query[$i] = "";}
	     if ($newsVetrina59Stamp[$i] eq '') { $newsVetrina59Stamp[$i] = "$link59Vetrina"; $newsVetrina59Query[$i] = "";}
	     if ($newsVetrina60Stamp[$i] eq '') { $newsVetrina60Stamp[$i] = "$link60Vetrina"; $newsVetrina60Query[$i] = "";}
	     if ($newsVetrina61Stamp[$i] eq '') { $newsVetrina61Stamp[$i] = "$link61Vetrina"; $newsVetrina61Query[$i] = "";}
	     if ($newsVetrina62Stamp[$i] eq '') { $newsVetrina62Stamp[$i] = "$link62Vetrina"; $newsVetrina62Query[$i] = "";}
	     if ($newsVetrina63Stamp[$i] eq '') { $newsVetrina63Stamp[$i] = "$link63Vetrina"; $newsVetrina63Query[$i] = "";}
	     if ($newsVetrina64Stamp[$i] eq '') { $newsVetrina64Stamp[$i] = "$link64Vetrina"; $newsVetrina64Query[$i] = "";}

	}

		$filez = "".&getVetrina1.".vt";
		$file = uc($filez);

		open(INFO, $file);
         	@caricaVetrina = <INFO>;
         	close(INFO);

         	@novitazTriler1 = reverse(@caricaVetrina);

		chomp @novitazTriler1;

		@trailer = ("");

		for ($i = 0 ; $i <= $#novitazTriler1 ; $i++) { 

		$novitazTriler1[$i] = &stripTrailer2($novitazTriler1[$i]);

		if ($novitazTriler1[$i] =~ /(.*) (\d\d\d\d)/i) {$novitazTriler1[$i] = $1;}

		if ( grep { uc($_) eq uc($novitazTriler1[$i])} @trailer ) {;}

		else {push (@trailer, $novitazTriler1[$i]);}

		}

		if ($trailer[1] eq '') { $newsTriler1 = "-/-"; } else { $newsTriler1 = "$trailer[1] trailer italiano"; }
		if ($trailer[2] eq '') { $newsTriler2 = "-/-"; } else { $newsTriler2 = "$trailer[2] trailer italiano"; }
		if ($trailer[3] eq '') { $newsTriler3 = "-/-"; } else { $newsTriler3 = "$trailer[3] trailer italiano"; }
		if ($trailer[4] eq '') { $newsTriler4 = "-/-"; } else { $newsTriler4 = "$trailer[4] trailer italiano"; }
		if ($trailer[5] eq '') { $newsTriler5 = "-/-"; } else { $newsTriler5 = "$trailer[5] trailer italiano"; }
		if ($trailer[6] eq '') { $newsTriler6 = "-/-"; } else { $newsTriler6 = "$trailer[6] trailer italiano"; }
		if ($trailer[7] eq '') { $newsTriler7 = "-/-"; } else { $newsTriler7 = "$trailer[7] trailer italiano"; }
		if ($trailer[8] eq '') { $newsTriler8 = "-/-"; } else { $newsTriler8 = "$trailer[8] trailer italiano"; }
		if ($trailer[9] eq '') { $newsTriler9 = "-/-"; } else { $newsTriler9 = "$trailer[9] trailer italiano"; }
		if ($trailer[10] eq '') { $newsTriler10 = "-/-"; } else { $newsTriler10 = "$trailer[10] trailer italiano"; }


open TIT, "+>","lst.html";
print TIT ("
<script type=\"text/javascript\" src=\"362cookies.js\"></script>
<script type=\"text/javascript\" src=\"362lb_common.js\"></script>
<script type=\"text/javascript\" src=\"362lb_html.js\"></script>
<script type=\"text/javascript\" src=\"362lb_menu.js\"></script>
<script type=\"text/javascript\" src=\"../ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js\"></script>
<script type=\"text/javascript\" src=\"d.js\"></script>
<html><title>LiStaWeB-XDL_PeRL &copy; 2014 By Greyback </title><style type=\"text/css\">
\@import url(stile.css);
</style><body OnLoad=\"javascript:window.status=\'XDCC Engine \';\">
<center><img src=\"$logoz\" width=\"90%\"><br><br>
<script type=\"text/javascript\" src=\"swfobject.js\"></script>


<body>	
<script type=\"text/javascript\" src=\"swfobject.js\"></script><body bgcolor=\"#00000\"><div id=\"flashcontent3\"><p><strong><font size=\"1\">per ascoltare la radio direttamente sul sito hai bisogno dei pluginFlash .</font></strong><br />
<center><a href=\"http://www.adobe.com/shockwave/download/download.cgi?p1_prod_version=shockwaveflash\">Download Flash here.</a></center>
&nbsp;<font size=\"2\">in alternativa ascoltala sul tuo mediaplayer cliccando su listen</font></p></div><script type=\"text/javascript\">
	// <![CDATA[
	
	var so = new SWFObject(\"nativeradio2small.swf\", \"nativeradio2small\", \"400\", \"50\", \"10\", \"#cccccc\");
	so.addParam(\"scale\", \"noscale\");
	so.addVariable(\"swfcolor\", \"FF0000\");
	so.addVariable(\"swfwidth\", \"400\");
	so.addVariable(\"swfradiochannel\", \"RaDio By ".uc($channelspia)." >> SOLO LA MIGLIORE MUSICA PER VOI!!! <<\");
	so.addVariable(\"swfstreamurl\", \"$radio\");
	so.addVariable(\"swfpause\", \"1\");
	so.addVariable(\"swfintervall\", \"1\");
	so.write(\"flashcontent3\");
	
	// ]]>
</script></br>
<center><img src=\"$MioLogo\" width=\"40%\"><br><br>
<center><table id=table8 cellpadding=2 cellspacing=1><tr><td id=table8 align=center><a href=\"index.php\"><input type=button value=\"HomePage\" /></td></tr><tr><td id=table8 align=center><form name=\"p\" method=\"get\"><input name=q type=text size=70><button type=submit>Cerca</button></form></td></tr><tr><td id=table8 align=center><input type=\"button\" value=\"Nascondi/Mostra Vetrine\" onClick=\"display_block('sezioni');\"/>&nbsp;<input type=\"button\" value=\"Nascondi/Mostra Lista Completa\" onClick=\"display_block('iroffer')\";/>&nbsp;<a href=\"news.html\"><input type=button value=\"Ultime News Aggiunte\" />&nbsp;<a href=\"scaricati.html\"><input type=button value=\"I Pi&ugrave; Scaricati\" /></td></table></center></br>
<SCRIPT LANGUAGE=\"JavaScript\">
function display_block(campo) {if (document.getElementById(campo).style.display == 'none') {document.getElementById(campo).style.display = \"block\";} else {document.getElementById(campo).style.display = \"none\";}}
var newwindow;
function poptastic(url)
{
	newwindow=window.open(url,'name','height=640,width=720, top=200 ,left=300, toolbar=no, location=no, status=no, menubar=no, scrollbars=yes, resizable=yes');
	if (window.focus) {newwindow.focus()}
}
</script>
<div id=\"sezioni\">

<center>
<table id=table8><tbody><tr><td>
<center>CLICCA SUL TRAILER CHE VUOI VEDERE</center><br>
&nbsp; <input class='search_input' type=\"submit\" value=\" $newsTriler1\" ><br>
&nbsp; <input class='search_input' type=\"submit\" value=\" $newsTriler2\" ><br>
&nbsp; <input class='search_input' type=\"submit\" value=\" $newsTriler3\" ><br>
&nbsp; <input class='search_input' type=\"submit\" value=\" $newsTriler4\" ><br>
&nbsp; <input class='search_input' type=\"submit\" value=\" $newsTriler5\" ><br>
&nbsp; <input class='search_input' type=\"submit\" value=\" $newsTriler6\" ><br>
&nbsp; <input class='search_input' type=\"submit\" value=\" $newsTriler7\" ><br>
&nbsp; <input class='search_input' type=\"submit\" value=\" $newsTriler8\" ><br>
&nbsp; <input class='search_input' type=\"submit\" value=\" $newsTriler9\" ><br>
&nbsp; <input class='search_input' type=\"submit\" value=\" $newsTriler10\" ><br>
</td><td>
NON TI BASTANO QUESTI TRAILER CHE METTIAMO A DISPOSIZIONE??<br>
ALLORA CERCA IL TRAILER CHE TI INTERESSA DIGITANDONE IL TITOLO NELLA CASELLA SOTTOSTANTE<br>
<input class='search_input' type=\"text\" size=40 value=\"Scrivi qui il titolo\" ><br>
<div id=\"result\"></div><br>
</td></tbody></table></center>
<center>
<br>
");
close TIT;

#@colours = ('#66FF33', '#FFFF99', '#FFCC33', '#FF66FF', '#FF3366', '#FF0000', '#CCFFCC', '#66FFFF', '#66FF33', '#FFFF99', '#66FF33', '#FFFF99', '#FFCC33', '#FF66FF', '#FF3366', '#FF0000', '#CCFFCC', '#66FFFF', '#66FF33', '#FFFF99');
@colours = ('#FF3300', '#E26200', '#00FF00', '#00FFFF', '#4141FF', '#E000E0', '#FF0000', '#FF8100', '#00C200', '#FF0000', '#FF3300', '#E26200', '#00FF00', '#00FFFF', '#4141FF', '#E000E0', '#FF0000', '#FF8100', '#00C200', '#FF0000');

if (&getNumVetrine eq 2 ) { $numTabulazioni = &getBlocchi/2;}
elsif (&getNumVetrine eq 3 ) { $numTabulazioni = &getBlocchi/3;}
elsif (&getNumVetrine eq 4 ) { $numTabulazioni = &getBlocchi/4;}	

$class = 1; $class2 = 2;

for ($i = 1 ; $i <= $numTabulazioni ; $i ++) {


	$ciclo = $i;

#blocco ciclo a 2 vetrine
	if ($i eq 2 && &getNumVetrine eq 2) { $ciclo = 3;}
	if ($i eq 3 && &getNumVetrine eq 2) { $ciclo = 5;}
	if ($i eq 4 && &getNumVetrine eq 2) { $ciclo = 7;}
	if ($i eq 5 && &getNumVetrine eq 2) { $ciclo = 9;}
	if ($i eq 6 && &getNumVetrine eq 2) { $ciclo = 11;}
	if ($i eq 7 && &getNumVetrine eq 2) { $ciclo = 13;}
	if ($i eq 8 && &getNumVetrine eq 2) { $ciclo = 15;}
	if ($i eq 9 && &getNumVetrine eq 2) { $ciclo = 17;}
	if ($i eq 10 && &getNumVetrine eq 2) { $ciclo = 19;}
	if ($i eq 11 && &getNumVetrine eq 2) { $ciclo = 21;}
	if ($i eq 12 && &getNumVetrine eq 2) { $ciclo = 23;}
	if ($i eq 13 && &getNumVetrine eq 2) { $ciclo = 25;}
	if ($i eq 14 && &getNumVetrine eq 2) { $ciclo = 27;}
	if ($i eq 15 && &getNumVetrine eq 2) { $ciclo = 29;}
	if ($i eq 16 && &getNumVetrine eq 2) { $ciclo = 31;}
	if ($i eq 17 && &getNumVetrine eq 2) { $ciclo = 33;}
	if ($i eq 18 && &getNumVetrine eq 2) { $ciclo = 35;}
	if ($i eq 19 && &getNumVetrine eq 2) { $ciclo = 37;}
	if ($i eq 20 && &getNumVetrine eq 2) { $ciclo = 39;}
	if ($i eq 21 && &getNumVetrine eq 2) { $ciclo = 41;}
	if ($i eq 22 && &getNumVetrine eq 2) { $ciclo = 43;}
	if ($i eq 23 && &getNumVetrine eq 2) { $ciclo = 45;}
	if ($i eq 24 && &getNumVetrine eq 2) { $ciclo = 47;}
	if ($i eq 25 && &getNumVetrine eq 2) { $ciclo = 49;}
	if ($i eq 26 && &getNumVetrine eq 2) { $ciclo = 51;}
	if ($i eq 27 && &getNumVetrine eq 2) { $ciclo = 53;}
	if ($i eq 28 && &getNumVetrine eq 2) { $ciclo = 55;}
	if ($i eq 29 && &getNumVetrine eq 2) { $ciclo = 57;}
	if ($i eq 30 && &getNumVetrine eq 2) { $ciclo = 59;}
	if ($i eq 31 && &getNumVetrine eq 2) { $ciclo = 61;}
	if ($i eq 32 && &getNumVetrine eq 2) { $ciclo = 63;}

#blocco ciclo a 3 vetrine
	if ($i eq 2 && &getNumVetrine eq 3) { $ciclo = 4;}
	if ($i eq 3 && &getNumVetrine eq 3) { $ciclo = 7;}
	if ($i eq 4 && &getNumVetrine eq 3) { $ciclo = 10;}
	if ($i eq 5 && &getNumVetrine eq 3) { $ciclo = 13;}
	if ($i eq 6 && &getNumVetrine eq 3) { $ciclo = 16;}
	if ($i eq 7 && &getNumVetrine eq 3) { $ciclo = 19;}
	if ($i eq 8 && &getNumVetrine eq 3) { $ciclo = 22;}
	if ($i eq 9 && &getNumVetrine eq 3) { $ciclo = 25;}
	if ($i eq 10 && &getNumVetrine eq 3) { $ciclo = 28;}
	if ($i eq 11 && &getNumVetrine eq 3) { $ciclo = 31;}
	if ($i eq 12 && &getNumVetrine eq 3) { $ciclo = 34;}
	if ($i eq 13 && &getNumVetrine eq 3) { $ciclo = 37;}
	if ($i eq 14 && &getNumVetrine eq 3) { $ciclo = 40;}
	if ($i eq 15 && &getNumVetrine eq 3) { $ciclo = 43;}
	if ($i eq 16 && &getNumVetrine eq 3) { $ciclo = 46;}
	if ($i eq 17 && &getNumVetrine eq 3) { $ciclo = 49;}
	if ($i eq 18 && &getNumVetrine eq 3) { $ciclo = 52;}
	if ($i eq 19 && &getNumVetrine eq 3) { $ciclo = 55;}
	if ($i eq 20 && &getNumVetrine eq 3) { $ciclo = 58;}
	if ($i eq 21 && &getNumVetrine eq 3) { $ciclo = 61;}


#blocco ciclo a 4 vetrine
	if ($i eq 2 && &getNumVetrine eq 4) { $ciclo = 5;}
	if ($i eq 3 && &getNumVetrine eq 4) { $ciclo = 9;}
	if ($i eq 4 && &getNumVetrine eq 4) { $ciclo = 13;}
	if ($i eq 5 && &getNumVetrine eq 4) { $ciclo = 17;}
	if ($i eq 6 && &getNumVetrine eq 4) { $ciclo = 21;}
	if ($i eq 7 && &getNumVetrine eq 4) { $ciclo = 25;}
	if ($i eq 8 && &getNumVetrine eq 4) { $ciclo = 29;}
	if ($i eq 9 && &getNumVetrine eq 4) { $ciclo = 33;}
	if ($i eq 10 && &getNumVetrine eq 4) { $ciclo = 37;}
	if ($i eq 11 && &getNumVetrine eq 4) { $ciclo = 41;}
	if ($i eq 12 && &getNumVetrine eq 4) { $ciclo = 45;}
	if ($i eq 13 && &getNumVetrine eq 4) { $ciclo = 49;}
	if ($i eq 14 && &getNumVetrine eq 4) { $ciclo = 53;}
	if ($i eq 15 && &getNumVetrine eq 4) { $ciclo = 57;}
	if ($i eq 16 && &getNumVetrine eq 4) { $ciclo = 61;}


	if (&getNumVetrine eq 2) {
	
		if ($class eq 5) {$class = 1;}
		if ($class2 eq 6) {$class2 = 2;}

	open ( TIT2, ">> lst.html");
	print TIT2 "<center><table id=table4 cellpadding=2 cellspacing=0><tr><td class=\"table4\" colspan=2 width=\"250px\" align=center><a href=".&getNomeVetrinaSplitted($ciclo).".html><span class=\"img$class\"> ".&getNomeVetrina($ciclo)." </span></a></td><td class=\"table4\" colspan=2 width=\"250px\" align=center><a href=".&getNomeVetrinaSplitted($ciclo+1).".html><span class=\"img$class2\"> ".&getNomeVetrina($ciclo+1)." </span></a></td></tr></table><table id=table6 cellpadding=2 cellspacing=1>\n";
	close(TIT2); $class = $class + 2; $class2 = $class2 +2;}
	elsif (&getNumVetrine eq 3) {
	open ( TIT2, ">> lst.html");
	print TIT2 "<center><table id=table4 cellpadding=2 cellspacing=0><tr><td class=\"table4\" colspan=2 width=\"250px\" align=center><a href=".&getNomeVetrinaSplitted($ciclo).".html><span class=\"img1\"> ".&getNomeVetrina($ciclo)." </span></a></td><td class=\"table4\" colspan=2 width=\"250px\" align=center><a href=".&getNomeVetrinaSplitted($ciclo+1).".html><span class=\"img2\"> ".&getNomeVetrina($ciclo+1)." </span></a></td><td class=\"table4\" colspan=2 width=\"250px\" align=center><a href=".&getNomeVetrinaSplitted($ciclo+2).".html><span class=\"img3\"> ".&getNomeVetrina($ciclo+2)." </span></a></td></tr></table><table id=table6 cellpadding=2 cellspacing=1>\n";
	close(TIT2); }
	elsif (&getNumVetrine eq 4) {
	open ( TIT2, ">> lst.html");
	print TIT2 "<center><table id=table4 cellpadding=2 cellspacing=0><tr><td class=\"table4\" colspan=2 width=\"250px\" align=center><a href=".&getNomeVetrinaSplitted($ciclo).".html><span class=\"img1\"> ".&getNomeVetrina($ciclo)." </span></a></td><td class=\"table4\" colspan=2 width=\"250px\" align=center><a href=".&getNomeVetrinaSplitted($ciclo+1).".html><span class=\"img2\"> ".&getNomeVetrina($ciclo+1)." </span></a></td><td class=\"table4\" colspan=2 width=\"250px\" align=center><a href=".&getNomeVetrinaSplitted($ciclo+2).".html><span class=\"img3\"> ".&getNomeVetrina($ciclo+2)." </span></a></td><td class=\"table4\" colspan=2 width=\"250px\" align=center><a href=".&getNomeVetrinaSplitted($ciclo+3).".html><span class=\"img4\"> ".&getNomeVetrina($ciclo+3)." </span></a></td></tr></table><table id=table6 cellpadding=2 cellspacing=1>\n";
	close(TIT2); }

	for ($conta = 0 ; $conta < &getGriglia ; $conta ++) { 

	if ($i eq 1) {
	if (&getNumVetrine eq 2) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina1[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina1Query[$conta]><font color=$colours[$conta]><b>$newsVetrina1Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina2[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina2Query[$conta]><font color=$colours[$conta]><b>$newsVetrina2Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 3) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina1[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina1Query[$conta]><font color=$colours[$conta]><b>$newsVetrina1Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina2[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina2Query[$conta]><font color=$colours[$conta]><b>$newsVetrina2Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina3[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina3Query[$conta]><font color=$colours[$conta]><b>$newsVetrina3Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 4) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina1[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina1Query[$conta]><font color=$colours[$conta]><b>$newsVetrina1Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina2[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina2Query[$conta]><font color=$colours[$conta]><b>$newsVetrina2Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina3[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina3Query[$conta]><font color=$colours[$conta]><b>$newsVetrina3Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina4[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina4Query[$conta]><font color=$colours[$conta]><b>$newsVetrina4Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
		}

	elsif ($i eq 2) {
	if (&getNumVetrine eq 2) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina3[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina3Query[$conta]><font color=$colours[$conta]><b>$newsVetrina3Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina4[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina4Query[$conta]><font color=$colours[$conta]><b>$newsVetrina4Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 3) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina4[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina4Query[$conta]><font color=$colours[$conta]><b>$newsVetrina4Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina5[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina5Query[$conta]><font color=$colours[$conta]><b>$newsVetrina5Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina6[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina6Query[$conta]><font color=$colours[$conta]><b>$newsVetrina6Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 4) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina5[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina5Query[$conta]><font color=$colours[$conta]><b>$newsVetrina5Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina6[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina6Query[$conta]><font color=$colours[$conta]><b>$newsVetrina6Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina7[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina7Query[$conta]><font color=$colours[$conta]><b>$newsVetrina7Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina8[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina8Query[$conta]><font color=$colours[$conta]><b>$newsVetrina8Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
		}

	elsif ($i eq 3) {
	if (&getNumVetrine eq 2) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina5[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina5Query[$conta]><font color=$colours[$conta]><b>$newsVetrina5Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina6[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina6Query[$conta]><font color=$colours[$conta]><b>$newsVetrina6Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 3) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina7[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina7Query[$conta]><font color=$colours[$conta]><b>$newsVetrina7Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina8[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina8Query[$conta]><font color=$colours[$conta]><b>$newsVetrina8Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina9[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina9Query[$conta]><font color=$colours[$conta]><b>$newsVetrina9Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 4) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina9[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina9Query[$conta]><font color=$colours[$conta]><b>$newsVetrina9Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina10[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina10Query[$conta]><font color=$colours[$conta]><b>$newsVetrina10Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina11[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina11Query[$conta]><font color=$colours[$conta]><b>$newsVetrina11Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina12[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina12Query[$conta]><font color=$colours[$conta]><b>$newsVetrina12Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	
		}

	elsif ($i eq 4) {
	if (&getNumVetrine eq 2) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina7[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina7Query[$conta]><font color=$colours[$conta]><b>$newsVetrina7Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina8[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina8Query[$conta]><font color=$colours[$conta]><b>$newsVetrina8Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 3) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina10[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina10Query[$conta]><font color=$colours[$conta]><b>$newsVetrina10Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina11[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina11Query[$conta]><font color=$colours[$conta]><b>$newsVetrina11Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina12[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina12Query[$conta]><font color=$colours[$conta]><b>$newsVetrina12Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 4) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina13[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina13Query[$conta]><font color=$colours[$conta]><b>$newsVetrina13Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina14[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina14Query[$conta]><font color=$colours[$conta]><b>$newsVetrina14Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina15[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina15Query[$conta]><font color=$colours[$conta]><b>$newsVetrina15Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina16[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina16Query[$conta]><font color=$colours[$conta]><b>$newsVetrina16Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
		}

	elsif ($i eq 5) {
	if (&getNumVetrine eq 2) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina9[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina9Query[$conta]><font color=$colours[$conta]><b>$newsVetrina9Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina10[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina10Query[$conta]><font color=$colours[$conta]><b>$newsVetrina10Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 3) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina13[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina13Query[$conta]><font color=$colours[$conta]><b>$newsVetrina13Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina14[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina14Query[$conta]><font color=$colours[$conta]><b>$newsVetrina14Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina15[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina15Query[$conta]><font color=$colours[$conta]><b>$newsVetrina15Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 4) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina17[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina17Query[$conta]><font color=$colours[$conta]><b>$newsVetrina17Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina18[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina18Query[$conta]><font color=$colours[$conta]><b>$newsVetrina18Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina19[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina19Query[$conta]><font color=$colours[$conta]><b>$newsVetrina19Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina20[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina20Query[$conta]><font color=$colours[$conta]><b>$newsVetrina20Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
		}

	elsif ($i eq 6) {
	if (&getNumVetrine eq 2) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina11[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina11Query[$conta]><font color=$colours[$conta]><b>$newsVetrina11Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina12[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina12Query[$conta]><font color=$colours[$conta]><b>$newsVetrina12Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 3) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina16[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina16Query[$conta]><font color=$colours[$conta]><b>$newsVetrina16Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina17[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina17Query[$conta]><font color=$colours[$conta]><b>$newsVetrina17Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina18[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina18Query[$conta]><font color=$colours[$conta]><b>$newsVetrina18Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 4) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina21[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina21Query[$conta]><font color=$colours[$conta]><b>$newsVetrina21Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina22[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina22Query[$conta]><font color=$colours[$conta]><b>$newsVetrina22Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina23[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina23Query[$conta]><font color=$colours[$conta]><b>$newsVetrina23Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina24[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina24Query[$conta]><font color=$colours[$conta]><b>$newsVetrina24Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
		}

	elsif ($i eq 7) {
	if (&getNumVetrine eq 2) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina13[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina13Query[$conta]><font color=$colours[$conta]><b>$newsVetrina13Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina14[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina14Query[$conta]><font color=$colours[$conta]><b>$newsVetrina14Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 3) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina19[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina19Query[$conta]><font color=$colours[$conta]><b>$newsVetrina19Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina20[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina20Query[$conta]><font color=$colours[$conta]><b>$newsVetrina20Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina21[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina21Query[$conta]><font color=$colours[$conta]><b>$newsVetrina21Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 4) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina25[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina25Query[$conta]><font color=$colours[$conta]><b>$newsVetrina25Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina26[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina26Query[$conta]><font color=$colours[$conta]><b>$newsVetrina26Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina27[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina27Query[$conta]><font color=$colours[$conta]><b>$newsVetrina27Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina28[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina28Query[$conta]><font color=$colours[$conta]><b>$newsVetrina28Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	
		}

	elsif ($i eq 8) {
	if (&getNumVetrine eq 2) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina15[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina15Query[$conta]><font color=$colours[$conta]><b>$newsVetrina15Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina16[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina16Query[$conta]><font color=$colours[$conta]><b>$newsVetrina16Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 3) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina22[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina22Query[$conta]><font color=$colours[$conta]><b>$newsVetrina22Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina23[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina23Query[$conta]><font color=$colours[$conta]><b>$newsVetrina23Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina24[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina24Query[$conta]><font color=$colours[$conta]><b>$newsVetrina24Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 4) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina29[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina29Query[$conta]><font color=$colours[$conta]><b>$newsVetrina29Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina30[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina30Query[$conta]><font color=$colours[$conta]><b>$newsVetrina30Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina31[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina31Query[$conta]><font color=$colours[$conta]><b>$newsVetrina31Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina32[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina32Query[$conta]><font color=$colours[$conta]><b>$newsVetrina32Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	
		}

	elsif ($i eq 9) {
	if (&getNumVetrine eq 2) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina17[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina17Query[$conta]><font color=$colours[$conta]><b>$newsVetrina17Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina18[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina18Query[$conta]><font color=$colours[$conta]><b>$newsVetrina18Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 3) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina25[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina25Query[$conta]><font color=$colours[$conta]><b>$newsVetrina25Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina26[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina26Query[$conta]><font color=$colours[$conta]><b>$newsVetrina26Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina27[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina27Query[$conta]><font color=$colours[$conta]><b>$newsVetrina27Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 4) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina33[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina33Query[$conta]><font color=$colours[$conta]><b>$newsVetrina33Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina34[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina34Query[$conta]><font color=$colours[$conta]><b>$newsVetrina34Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina35[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina35Query[$conta]><font color=$colours[$conta]><b>$newsVetrina35Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina36[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina36Query[$conta]><font color=$colours[$conta]><b>$newsVetrina36Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	
		}

	elsif ($i eq 10) {
	if (&getNumVetrine eq 2) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina19[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina19Query[$conta]><font color=$colours[$conta]><b>$newsVetrina19Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina20[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina20Query[$conta]><font color=$colours[$conta]><b>$newsVetrina20Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 3) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina28[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina28Query[$conta]><font color=$colours[$conta]><b>$newsVetrina28Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina29[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina29Query[$conta]><font color=$colours[$conta]><b>$newsVetrina29Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina30[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina30Query[$conta]><font color=$colours[$conta]><b>$newsVetrina30Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 4) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina37[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina37Query[$conta]><font color=$colours[$conta]><b>$newsVetrina37Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina38[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina38Query[$conta]><font color=$colours[$conta]><b>$newsVetrina38Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina39[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina39Query[$conta]><font color=$colours[$conta]><b>$newsVetrina39Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina40[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina40Query[$conta]><font color=$colours[$conta]><b>$newsVetrina40Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	
		}

	elsif ($i eq 11) {
	if (&getNumVetrine eq 2) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina21[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina21Query[$conta]><font color=$colours[$conta]><b>$newsVetrina21Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina22[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina22Query[$conta]><font color=$colours[$conta]><b>$newsVetrina22Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 3) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina31[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina31Query[$conta]><font color=$colours[$conta]><b>$newsVetrina31Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina32[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina32Query[$conta]><font color=$colours[$conta]><b>$newsVetrina32Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina33[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina33Query[$conta]><font color=$colours[$conta]><b>$newsVetrina33Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 4) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina41[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina41Query[$conta]><font color=$colours[$conta]><b>$newsVetrina41Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina42[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina42Query[$conta]><font color=$colours[$conta]><b>$newsVetrina42Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina43[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina43Query[$conta]><font color=$colours[$conta]><b>$newsVetrina43Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina44[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina44Query[$conta]><font color=$colours[$conta]><b>$newsVetrina44Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	
		}

	elsif ($i eq 12) {
	if (&getNumVetrine eq 2) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina23[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina23Query[$conta]><font color=$colours[$conta]><b>$newsVetrina23Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina24[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina24Query[$conta]><font color=$colours[$conta]><b>$newsVetrina24Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 3) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina34[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina34Query[$conta]><font color=$colours[$conta]><b>$newsVetrina34Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina35[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina35Query[$conta]><font color=$colours[$conta]><b>$newsVetrina35Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina36[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina36Query[$conta]><font color=$colours[$conta]><b>$newsVetrina36Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 4) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina45[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina45Query[$conta]><font color=$colours[$conta]><b>$newsVetrina45Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina46[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina46Query[$conta]><font color=$colours[$conta]><b>$newsVetrina46Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina47[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina47Query[$conta]><font color=$colours[$conta]><b>$newsVetrina47Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina48[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina48Query[$conta]><font color=$colours[$conta]><b>$newsVetrina48Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	
		}

	elsif ($i eq 13) {
	if (&getNumVetrine eq 2) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina25[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina25Query[$conta]><font color=$colours[$conta]><b>$newsVetrina25Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina26[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina26Query[$conta]><font color=$colours[$conta]><b>$newsVetrina26Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 3) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina37[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina37Query[$conta]><font color=$colours[$conta]><b>$newsVetrina37Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina38[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina38Query[$conta]><font color=$colours[$conta]><b>$newsVetrina38Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina39[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina39Query[$conta]><font color=$colours[$conta]><b>$newsVetrina39Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 4) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina49[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina49Query[$conta]><font color=$colours[$conta]><b>$newsVetrina49Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina50[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina50Query[$conta]><font color=$colours[$conta]><b>$newsVetrina50Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina51[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina51Query[$conta]><font color=$colours[$conta]><b>$newsVetrina51Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina52[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina52Query[$conta]><font color=$colours[$conta]><b>$newsVetrina52Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	
		}

	elsif ($i eq 14) {
	if (&getNumVetrine eq 2) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina27[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina27Query[$conta]><font color=$colours[$conta]><b>$newsVetrina27Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina28[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina28Query[$conta]><font color=$colours[$conta]><b>$newsVetrina28Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 3) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina40[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina40Query[$conta]><font color=$colours[$conta]><b>$newsVetrina40Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina41[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina41Query[$conta]><font color=$colours[$conta]><b>$newsVetrina41Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina42[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina42Query[$conta]><font color=$colours[$conta]><b>$newsVetrina42Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 4) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina53[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina53Query[$conta]><font color=$colours[$conta]><b>$newsVetrina53Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina54[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina54Query[$conta]><font color=$colours[$conta]><b>$newsVetrina54Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina55[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina55Query[$conta]><font color=$colours[$conta]><b>$newsVetrina55Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina56[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina56Query[$conta]><font color=$colours[$conta]><b>$newsVetrina56Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	
		}

	elsif ($i eq 15) {
	if (&getNumVetrine eq 2) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina29[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina29Query[$conta]><font color=$colours[$conta]><b>$newsVetrina29Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina30[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina30Query[$conta]><font color=$colours[$conta]><b>$newsVetrina30Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 3) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina43[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina43Query[$conta]><font color=$colours[$conta]><b>$newsVetrina43Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina44[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina44Query[$conta]><font color=$colours[$conta]><b>$newsVetrina44Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina45[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina45Query[$conta]><font color=$colours[$conta]><b>$newsVetrina45Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 4) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina57[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina57Query[$conta]><font color=$colours[$conta]><b>$newsVetrina57Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina58[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina58Query[$conta]><font color=$colours[$conta]><b>$newsVetrina58Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina59[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina59Query[$conta]><font color=$colours[$conta]><b>$newsVetrina59Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina60[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina60Query[$conta]><font color=$colours[$conta]><b>$newsVetrina60Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	
		}

	elsif ($i eq 16) {
	if (&getNumVetrine eq 2) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina31[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina31Query[$conta]><font color=$colours[$conta]><b>$newsVetrina31Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina32[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina32Query[$conta]><font color=$colours[$conta]><b>$newsVetrina32Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 3) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina46[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina46Query[$conta]><font color=$colours[$conta]><b>$newsVetrina46Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina47[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina47Query[$conta]><font color=$colours[$conta]><b>$newsVetrina47Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina48[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina48Query[$conta]><font color=$colours[$conta]><b>$newsVetrina48Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 4) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina61[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina61Query[$conta]><font color=$colours[$conta]><b>$newsVetrina61Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina62[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina62Query[$conta]><font color=$colours[$conta]><b>$newsVetrina62Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina63[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina63Query[$conta]><font color=$colours[$conta]><b>$newsVetrina63Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina64[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina64Query[$conta]><font color=$colours[$conta]><b>$newsVetrina64Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	
		}

	elsif ($i eq 17) {
	if (&getNumVetrine eq 2) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina33[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina33Query[$conta]><font color=$colours[$conta]><b>$newsVetrina33Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina34[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina34Query[$conta]><font color=$colours[$conta]><b>$newsVetrina34Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 3) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina49[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina49Query[$conta]><font color=$colours[$conta]><b>$newsVetrina49Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina50[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina50Query[$conta]><font color=$colours[$conta]><b>$newsVetrina50Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina51[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina51Query[$conta]><font color=$colours[$conta]><b>$newsVetrina51Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}

		}

	elsif ($i eq 18) {
	if (&getNumVetrine eq 2) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina35[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina35Query[$conta]><font color=$colours[$conta]><b>$newsVetrina35Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina36[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina36Query[$conta]><font color=$colours[$conta]><b>$newsVetrina36Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 3) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina52[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina52Query[$conta]><font color=$colours[$conta]><b>$newsVetrina52Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina53[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina53Query[$conta]><font color=$colours[$conta]><b>$newsVetrina53Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina54[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina54Query[$conta]><font color=$colours[$conta]><b>$newsVetrina54Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}

		}

	elsif ($i eq 19) {
	if (&getNumVetrine eq 2) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina37[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina37Query[$conta]><font color=$colours[$conta]><b>$newsVetrina37Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina38[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina38Query[$conta]><font color=$colours[$conta]><b>$newsVetrina38Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 3) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina55[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina55Query[$conta]><font color=$colours[$conta]><b>$newsVetrina55Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina56[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina56Query[$conta]><font color=$colours[$conta]><b>$newsVetrina56Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina57[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina57Query[$conta]><font color=$colours[$conta]><b>$newsVetrina57Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}

		}

	elsif ($i eq 20) {
	if (&getNumVetrine eq 2) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina39[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina39Query[$conta]><font color=$colours[$conta]><b>$newsVetrina39Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina40[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina40Query[$conta]><font color=$colours[$conta]><b>$newsVetrina40Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 3) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina58[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina58Query[$conta]><font color=$colours[$conta]><b>$newsVetrina58Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina59[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina59Query[$conta]><font color=$colours[$conta]><b>$newsVetrina59Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina60[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina60Query[$conta]><font color=$colours[$conta]><b>$newsVetrina60Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}

		}

	elsif ($i eq 21) {
	if (&getNumVetrine eq 2) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina41[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina41Query[$conta]><font color=$colours[$conta]><b>$newsVetrina41Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina42[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina42Query[$conta]><font color=$colours[$conta]><b>$newsVetrina42Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}
	elsif (&getNumVetrine eq 3) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina61[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina61Query[$conta]><font color=$colours[$conta]><b>$newsVetrina61Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina62[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina62Query[$conta]><font color=$colours[$conta]><b>$newsVetrina62Stamp[$conta]</b></a></font></td id=td1>
<td id=td2 width=4% align=center><b>$dataVetrina63[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina63Query[$conta]><font color=$colours[$conta]><b>$newsVetrina63Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}

		}

	elsif ($i eq 22) {
	if (&getNumVetrine eq 2) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina43[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina43Query[$conta]><font color=$colours[$conta]><b>$newsVetrina43Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina44[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina44Query[$conta]><font color=$colours[$conta]><b>$newsVetrina44Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}

		}

	elsif ($i eq 23) {
	if (&getNumVetrine eq 2) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina45[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina45Query[$conta]><font color=$colours[$conta]><b>$newsVetrina45Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina46[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina46Query[$conta]><font color=$colours[$conta]><b>$newsVetrina46Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}

		}

	elsif ($i eq 24) {
	if (&getNumVetrine eq 2) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina47[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina47Query[$conta]><font color=$colours[$conta]><b>$newsVetrina47Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina48[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina48Query[$conta]><font color=$colours[$conta]><b>$newsVetrina48Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}

		}

	elsif ($i eq 25) {
	if (&getNumVetrine eq 2) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina49[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina49Query[$conta]><font color=$colours[$conta]><b>$newsVetrina49Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina50[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina50Query[$conta]><font color=$colours[$conta]><b>$newsVetrina50Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}

		}

	elsif ($i eq 26) {
	if (&getNumVetrine eq 2) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina51[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina51Query[$conta]><font color=$colours[$conta]><b>$newsVetrina51Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina52[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina52Query[$conta]><font color=$colours[$conta]><b>$newsVetrina52Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}

		}

	elsif ($i eq 27) {
	if (&getNumVetrine eq 2) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina53[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina53Query[$conta]><font color=$colours[$conta]><b>$newsVetrina53Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina54[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina54Query[$conta]><font color=$colours[$conta]><b>$newsVetrina54Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}

		}

	elsif ($i eq 28) {
	if (&getNumVetrine eq 2) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina55[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina55Query[$conta]><font color=$colours[$conta]><b>$newsVetrina55Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina56[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina56Query[$conta]><font color=$colours[$conta]><b>$newsVetrina56Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}

		}

	elsif ($i eq 29) {
	if (&getNumVetrine eq 2) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina57[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina57Query[$conta]><font color=$colours[$conta]><b>$newsVetrina57Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina58[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina58Query[$conta]><font color=$colours[$conta]><b>$newsVetrina58Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}

		}

	elsif ($i eq 30) {
	if (&getNumVetrine eq 2) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina59[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina59Query[$conta]><font color=$colours[$conta]><b>$newsVetrina59Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina60[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina60Query[$conta]><font color=$colours[$conta]><b>$newsVetrina60Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}

		}

	elsif ($i eq 31) {
	if (&getNumVetrine eq 2) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina61[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina61Query[$conta]><font color=$colours[$conta]><b>$newsVetrina61Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina62[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina62Query[$conta]><font color=$colours[$conta]><b>$newsVetrina62Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}

		}

	elsif ($i eq 32) {
	if (&getNumVetrine eq 2) {
	open ( TIT3, ">> lst.html");
	print TIT3 "<tr><td id=td2 width=4% align=center><b>$dataVetrina61[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina61Query[$conta]><font color=$colours[$conta]><b>$newsVetrina61Stamp[$conta]</b></a></font></td id=td1><td id=td2 width=4% align=center><b>$dataVetrina64[$conta]</b><td id=td1 width=20% align=left> <a href=?q=$newsVetrina64Query[$conta]><font color=$colours[$conta]><b>$newsVetrina64Stamp[$conta]</b></a></font></td id=td1></tr>\n";
	close(TIT3);}

		}
		
	}

	open ( TIT5, ">> lst.html");
	print TIT5 "</table><br>\n";
	close(TIT5);


}

&addDiv;

 			($sec,$min,$ore,$giom,$mese,$anno,$gios,$gioa,$oraleg) = localtime(time);
 			my @abbr = qw( Gennaio Febbraio Marzo Aprile Maggio Giugno Luglio Agosto Settembre Ottobre Novembre Dicembre );
 			my @abbr2 = qw( Domenica Lunedi Martedi Mercoledi Giovedi Venerdi Sabato );
 			$anno += 1900;

                        if ($min eq "0") {$min = "00"}
                        if ($min eq "1") {$min = "01"}
                    	if ($min eq "2") {$min = "02"}
                    	if ($min eq "3") {$min = "03"}
                    	if ($min eq "4") {$min = "04"}
                    	if ($min eq "5") {$min = "05"}
                    	if ($min eq "6") {$min = "06"}
                    	if ($min eq "7") {$min = "07"}
                    	if ($min eq "8") {$min = "08"}
                    	if ($min eq "9") {$min = "09"}

                        if ($sec eq "0") {$sec = "00"}
                        if ($sec eq "1") {$sec = "01"}
                    	if ($sec eq "2") {$sec = "02"}
                    	if ($sec eq "3") {$sec = "03"}
                    	if ($sec eq "4") {$sec = "04"}
                    	if ($sec eq "5") {$sec = "05"}
                    	if ($sec eq "6") {$sec = "06"}
                    	if ($sec eq "7") {$sec = "07"}
                    	if ($sec eq "8") {$sec = "08"}
                    	if ($sec eq "9") {$sec = "09"}

                        if ($ore eq "0") {$ore = "00"}
                        if ($ore eq "1") {$ore = "01"}
                    	if ($ore eq "2") {$ore = "02"}
                    	if ($ore eq "3") {$ore = "03"}
                    	if ($ore eq "4") {$ore = "04"}
                    	if ($ore eq "5") {$ore = "05"}
                    	if ($ore eq "6") {$ore = "06"}
                    	if ($ore eq "7") {$ore = "07"}
                    	if ($ore eq "8") {$ore = "08"}
                    	if ($ore eq "9") {$ore = "09"}

unlink ("scaricati.html");
unlink ("scaricati.txt");
open TIT, "+>","scaricati.html";
print TIT ("
<body background=\"none\">


<script type=\"text/javascript\" src=\"362cookies.js\"></script>
<script type=\"text/javascript\" src=\"362lb_common.js\"></script>
<script type=\"text/javascript\" src=\"362lb_html.js\"></script>
<script type=\"text/javascript\" src=\"362lb_menu.js\"></script>
<script type=\"text/javascript\" src=\"../ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js\"></script>
<script type=\"text/javascript\" src=\"d.js\"></script>
<html><title>LiStaWeB-XDL_PeRL &copy; 2014 By Greyback </title><style type=\"text/css\">
\@import url(stile.css);
</style><body OnLoad=\"javascript:window.status='XDCC Engine ';\">
<center><img src=\"logo.png\" width=\"90%\"><br><br>
<script type=\"text/javascript\" src=\"swfobject.js\"></script>


<body>	
<script type=\"text/javascript\" src=\"swfobject.js\"></script><body bgcolor=\"#00000\"><div id=\"flashcontent3\"><p><strong><font size=\"1\">per ascoltare la radio direttamente sul sito hai bisogno dei pluginFlash .</font></strong><br />
<center><a href=\"http://www.adobe.com/shockwave/download/download.cgi?p1_prod_version=shockwaveflash\">Download Flash here.</a></center>
&nbsp;<font size=\"2\">in alternativa ascoltala sul tuo mediaplayer cliccando su listen</font></p></div><script type=\"text/javascript\">
	// <![CDATA[
	
	var so = new SWFObject(\"nativeradio2small.swf\", \"nativeradio2small\", \"400\", \"50\", \"10\", \"#cccccc\");
	so.addParam(\"scale\", \"noscale\");
	so.addVariable(\"swfcolor\", \"FF0000\");
	so.addVariable(\"swfwidth\", \"400\");
	so.addVariable(\"swfradiochannel\", \"RaDio By ".uc($channelspia)." >> SOLO LA MIGLIORE MUSICA PER VOI!!! <<\");
	so.addVariable(\"swfstreamurl\", \"$radio\");
	so.addVariable(\"swfpause\", \"1\");
	so.addVariable(\"swfintervall\", \"1\");
	so.write(\"flashcontent3\");
	
	// ]]>
</script><br>
<center><span class=\"img1\"> FILE PIU SCARICATI </span></center></br>
<center><table id=table8 cellpadding=2 cellspacing=1><tr><td id=table8 align=center><a href=\"index.php\"><input type=button value=\"HomePage\" /></td></tr></table></center><br>
<center><table id=table8 cellpadding=2 cellspacing=1><tr align=center><td align=center width=12%><font color=white><b>I 50 File Pi&ugrave; Scaricati  Aggiornati Al - $giom $abbr[$mese] $anno Alle ORE - $ore:$min:$sec</b></font></td></tr></table><br>
<center><table id=table8 cellpadding=2 cellspacing=1><tr align=center><td align=center width=12%><font color=white><b>Cercalo</b></font><td align=center width=17% align=center><font color=white><b>Num. Downloads</b></font><td align=left width=35% align=left><font color=white><b>FILE</b></font></td></tr></table>
");
close TIT;

unlink ("filemoredown.db");
unlink ("filemorenumber.db");
&getSezioni;
my $fileId = open ( FILE, "< sezioni.db");
@sezioni = <FILE>;
chomp @sezioni;
close(FILE);

for ($k = 0 ; $k <= $#sezioni ; $k++) {

&sezione($sezioni[$k]);

		my $fileId = open ( FILE, "< nomesezione.db");
		@nomesezioni = <FILE>;
		chomp @nomesezioni;
        	close(FILE);

		open FILE, ">>", "filemoredown.db";
		open N1, "<", "".uc($nomesezioni[0]).".MN";
		while (<N1>) {
  		print  FILE "$_";
		}

		open FILE, ">>", "filemorenumber.db";
		open N1, "<", "".uc($nomesezioni[0]).".MD";
		while (<N1>) {
  		print  FILE "$_";
		}

}

    my $fileId = open ( FILE, "< filemoredown.db");
    @DOWN = <FILE>;
    chomp @DOWN;
    for ($i = 0 ; $i < $#DOWN ; $i ++ ) { $DOWN[$i] = &stripVetrineStamp($DOWN[$i]);}
    close(FILE);

    my $fileId = open ( FILE, "< filemoredown.db");
    @DOWNQUERY = <FILE>;
    chomp @DOWNQUERY;
    for ($i = 0 ; $i < $#DOWNQUERY ; $i ++ ) { $DOWNQUERY[$i] = &stripVetrineQuery($DOWNQUERY[$i]);}
    close(FILE);  

    my $fileId = open ( FILE, "< filemorenumber.db");
    @DOWNNUMBER = <FILE>;
    chomp @DOWNNUMBER;
    close(FILE); 

my @filePiuScaricati = ( ["<center><table id=table8 cellpadding=2 cellspacing=1><tr align=center><td align=center width=12%><a href=index.php?q=$DOWNQUERY[0] /a>Clicca qui per ricercarlo<td align=center width=17% align=center>", "$DOWNNUMBER[0]", "<td align=left width=35% align=left>$DOWN[0]</td></tr></table>"], ); 

for ($i = 1 ; $i < $#DOWN ; $i++) {

@filePiuScaricati2 = ('');

@filePiuScaricati2 = ("<center><table id=table8 cellpadding=2 cellspacing=1><tr align=center><td align=center width=12%><a href=index.php?q=$DOWNQUERY[$i] /a>Clicca qui per ricercarlo<td align=center width=17% align=center>", "$DOWNNUMBER[$i]", "<td align=left width=35% align=left>$DOWN[$i]</td></tr></table>");

push @filePiuScaricati, [ @filePiuScaricati2 ];

}

 @filePiuScaricatiz = sort { $b->[1] <=> $a->[1] } @filePiuScaricati;


for ($l = 0 ; $l < 50;  $l++) {

open FILE, ">>","scaricati.txt";
print FILE ("
$filePiuScaricatiz[$l][0] $filePiuScaricatiz[$l][1] $filePiuScaricatiz[$l][2]
");
}

open FILE, ">>","scaricati.txt";
print FILE ("
<center><br><font color=yellow face=verdana size=3><div id='footer'><p>LiStaWeB-XDL_PeRL &copy; 2014  By Greyback</p></div>
");
close FILE;

open FILE, ">>", "scaricati.html";
open N1, "<", "scaricati.txt";
while (<N1>) {
print  FILE "$_";
}
close N1;
close FILE;

 			($sec,$min,$ore,$giom,$mese,$anno,$gios,$gioa,$oraleg) = localtime(time);
 			my @abbr = qw( Gennaio Febbraio Marzo Aprile Maggio Giugno Luglio Agosto Settembre Ottobre Novembre Dicembre );
 			my @abbr2 = qw( Domenica Lunedi Martedi Mercoledi Giovedi Venerdi Sabato );
 			$anno += 1900;

                        if ($min eq "0") {$min = "00"}
                        if ($min eq "1") {$min = "01"}
                    	if ($min eq "2") {$min = "02"}
                    	if ($min eq "3") {$min = "03"}
                    	if ($min eq "4") {$min = "04"}
                    	if ($min eq "5") {$min = "05"}
                    	if ($min eq "6") {$min = "06"}
                    	if ($min eq "7") {$min = "07"}
                    	if ($min eq "8") {$min = "08"}
                    	if ($min eq "9") {$min = "09"}

                        if ($sec eq "0") {$sec = "00"}
                        if ($sec eq "1") {$sec = "01"}
                    	if ($sec eq "2") {$sec = "02"}
                    	if ($sec eq "3") {$sec = "03"}
                    	if ($sec eq "4") {$sec = "04"}
                    	if ($sec eq "5") {$sec = "05"}
                    	if ($sec eq "6") {$sec = "06"}
                    	if ($sec eq "7") {$sec = "07"}
                    	if ($sec eq "8") {$sec = "08"}
                    	if ($sec eq "9") {$sec = "09"}

                        if ($ore eq "0") {$ore = "00"}
                        if ($ore eq "1") {$ore = "01"}
                    	if ($ore eq "2") {$ore = "02"}
                    	if ($ore eq "3") {$ore = "03"}
                    	if ($ore eq "4") {$ore = "04"}
                    	if ($ore eq "5") {$ore = "05"}
                    	if ($ore eq "6") {$ore = "06"}
                    	if ($ore eq "7") {$ore = "07"}
                    	if ($ore eq "8") {$ore = "08"}
                    	if ($ore eq "9") {$ore = "09"}

open TIT, "+>","news.html";
print TIT ("
<body background=\"none\">


<script type=\"text/javascript\" src=\"362cookies.js\"></script>
<script type=\"text/javascript\" src=\"362lb_common.js\"></script>
<script type=\"text/javascript\" src=\"362lb_html.js\"></script>
<script type=\"text/javascript\" src=\"362lb_menu.js\"></script>
<script type=\"text/javascript\" src=\"../ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js\"></script>
<script type=\"text/javascript\" src=\"d.js\"></script>
<html><title>LiStaWeB-XDL_PeRL &copy; 2014 By Greyback </title><style type=\"text/css\">
\@import url(stile.css);
</style><body OnLoad=\"javascript:window.status='XDCC Engine ';\">
<center><img src=\"logo.png\" width=\"90%\"><br><br>
<script type=\"text/javascript\" src=\"swfobject.js\"></script>


<body>	
<script type=\"text/javascript\" src=\"swfobject.js\"></script><body bgcolor=\"#00000\"><div id=\"flashcontent3\"><p><strong><font size=\"1\">per ascoltare la radio direttamente sul sito hai bisogno dei pluginFlash .</font></strong><br />
<center><a href=\"http://www.adobe.com/shockwave/download/download.cgi?p1_prod_version=shockwaveflash\">Download Flash here.</a></center>
&nbsp;<font size=\"2\">in alternativa ascoltala sul tuo mediaplayer cliccando su listen</font></p></div><script type=\"text/javascript\">
	// <![CDATA[
	
	var so = new SWFObject(\"nativeradio2small.swf\", \"nativeradio2small\", \"400\", \"50\", \"10\", \"#cccccc\");
	so.addParam(\"scale\", \"noscale\");
	so.addVariable(\"swfcolor\", \"FF0000\");
	so.addVariable(\"swfwidth\", \"400\");
	so.addVariable(\"swfradiochannel\", \"RaDio By ".uc($channelspia)." >> SOLO LA MIGLIORE MUSICA PER VOI!!! <<\");
	so.addVariable(\"swfstreamurl\", \"$radio\");
	so.addVariable(\"swfpause\", \"1\");
	so.addVariable(\"swfintervall\", \"1\");
	so.write(\"flashcontent3\");
	
	// ]]>
</script><br>
<center><span class=\"img1\"> ULTIME NOVITA </span></center></br>
<center><table id=table8 cellpadding=2 cellspacing=1><tr><td id=table8 align=center><a href=\"index.php\"><input type=button value=\"HomePage\" /></td></tr></table></center><br>
<center><table id=table8 cellpadding=2 cellspacing=1><tr align=center><td align=center width=12%><font color=white><b>Ultime News Aggiornate Al - $giom $abbr[$mese] $anno Alle ORE - $ore:$min:$sec</b></font></td></tr></table><br>
<center><table id=table8 cellpadding=2 cellspacing=1><tr align=center><td align=center width=12%><font color=white><b>Ultime News Aggiunte</b></font></td></tr></table><br>
<center><table id=table8 cellpadding=2 cellspacing=1><tr align=center><td align=center width=12%><font color=white><b>Cercalo</b></font><td align=center width=17% align=center><font color=white><b>Data Inserimento</b></font><td align=left width=35% align=left><font color=white><b>FILE</b></font></td></tr></table>
");
close TIT;


unlink ("news.ns"); unlink ("date.ns");

&getSezioni;
my $fileId = open ( FILE, "< sezioni.db");
@sezioni = <FILE>;
chomp @sezioni;
close(FILE);

for ($j = 0; $j <= $#sezioni ; $j ++) {

    unlink ("nomesezione.db");
    &sezione($sezioni[$j]);
    my $fileId = open ( FILE, "< nomesezione.db");
    @nomesezioni = <FILE>;
    chomp @nomesezioni;
    close(FILE); 

		$count = 0;
		while ($count <= $nomesezioni) {
            	chomp $bot[$count];

		open FILE, ">>", "news.ns";
		open N1, "<", "".uc($nomesezioni[0]).".VT";
		while (<N1>) {
  		print  FILE "$_";
		}
		$count ++;
	}

		$count2 = 0;

		while ($count2 <= $nomesezioni) {
            	chomp $bot[$count];

		open FILE, ">>", "date.ns";
		open N1, "<", "".uc($nomesezioni[0]).".DT";
		while (<N1>) {
  		print  FILE "$_";
		}
		$count2 ++;
	}
}


    my $fileId = open ( FILE, "< news.ns");
    @NEWS = <FILE>;
    chomp @NEWS;
    for ($i = 0 ; $i <= $#NEWS ; $i ++ ) { $NEWS[$i] = &stripVetrineStamp($NEWS[$i]);}
    close(FILE);

    my $fileId = open ( FILE, "< news.ns");
    @QUERY = <FILE>;
    chomp @QUERY;
    for ($i = 0 ; $i <= $#QUERY ; $i ++ ) { $QUERY[$i] = &stripVetrineQuery($QUERY[$i]);}
    close(FILE);  

    my $fileId = open ( FILE, "< date.ns");
    @DATE = <FILE>;
    chomp @DATE;
    close(FILE); 

for ($i = 0; $i <= $#DATE ; $i++) {

 if ($DATE[$i] =~ /(\d+)\/(\d+)\/(\d\d\d\d)/i) { $DATE[$i] = "$3-$2-$1";}


}


my @dateLast3 = ( ["<center><table id=table8 cellpadding=2 cellspacing=1><tr align=center><td align=center width=12%><a href=index.php?q=$QUERY[0] /a>Clicca qui per ricercarlo<td align=center width=17% align=center>", "$DATE[0]", "<td align=left width=35% align=left>$NEWS[0]</td></tr>"], );

for ($i = 1 ; $i <= $#NEWS ; $i++) {

@dataSorted = ('');

@dataSorted = ("<center><table id=table8 cellpadding=2 cellspacing=1><tr align=center><td align=center width=12%><a href=index.php?q=$QUERY[$i] /a>Clicca qui per ricercarlo<td align=center width=17% align=center>", "$DATE[$i]", "<td align=left width=35% align=left>$NEWS[$i]</td></tr>");

push @dateLast3, [ @dataSorted ];

}

@dataSorted = ("</table>");
push @dateLast3, [ @dataSorted ];


 @dateLast1 = sort {$b->[1] cmp $a->[1]} @dateLast3;


for ($i = 0 ; $i <= $#dateLast1 ; $i++) {

if ($dateLast1[$i][1] =~ /(\d\d\d\d)\-(\d+)\-(\d+)/i) {$dateLast1[$i][1] = "$3-$2-$1";}

}

unlink ("datadellenews.db");

for ($i = 0 ; $i <= $#dateLast1 ; $i++) {

			my $flag = 0;
			$file = $dateLast1[$i][1];
			$fileopen = "datadellenews.db";
			$except = substr ($except, 0, -1);
			$except =~ s/ //g;
			my $fileId = open ( FILE, "< $fileopen");
			while ( $riga = <FILE> )
			{
				$riga = substr ($riga, 0, -1);
				if ( uc($riga) eq uc($file) ) { $flag = 1; }
			}
			close(FILE);
			if ( $flag == 0 )
			{
				my $fileId = open ( FILE, ">> $fileopen");
				print FILE "$file\n";
				close(FILE);

			}

}

	my $fileId = open ( FILE, "< datadellenews.db");
	@mydate = <FILE>;
	chomp @mydate;


unlink ("last.txt");

$check = 0;
$dataFinale = 0;
$conteggio = 0; 
$linea = 0;

for ($i = 0; $i <= $#dateLast1 ; $i++) {

if ($dateLast1[$i][1] eq "") { open FILE, ">>","last.txt"; print FILE ("</table>"); last; }

if ($dateLast1[$i][1] ne $mydate[$check]) {
$check++; 
open FILE, ">>","last.txt";
print FILE ("</table><br><hr width=\"90%\"><br>"); $linea++; if ($linea eq 7) {last;}
print FILE ("<center><table id=table8 cellpadding=2 cellspacing=1><tr align=center><td align=center width=12%><font color=white><b>Novit&agrave; del $mydate[$check]</b></font></td></tr></table><br>");
					}

open FILE, ">>","last.txt";
print FILE ("
$dateLast1[$i][0] $dateLast1[$i][1] $dateLast1[$i][2]
");

$dataFinale = $dateLast1[$i][1];
$conteggio++;

}

if ($check eq 7) {
open FILE, ">>","last.txt";
print FILE ("
<br><center><font color=white><b>Nella settimana dal </font> <font color=red>$dataFinale</font> <font color=white>al</font> <font color=red>$dateLast1[0][1]</font> <font color=white>Sono state aggiunte</font> <font color=red>$conteggio</font> <font color=white>news.</font></b>
");
}

else {
open FILE, ">>","last.txt";
print FILE ("
<br><center><font color=white><b>Dal</font> <font color=red>$dataFinale</font> <font color=white>al</font> <font color=red>$dateLast1[0][1]</font> <font color=white>Sono state aggiunte</font> <font color=red>$conteggio</font> <font color=white>news.</font></b>
");
}

open FILE, ">>","last.txt";
print FILE ("
<center><br><font color=yellow face=verdana size=3><div id='footer'><p>LiStaWeB-XDL_PeRL &copy; 2014  By Greyback</p></div>
");
close FILE;

open FILE, ">>", "news.html";
open N1, "<", "last.txt";
while (<N1>) {
print  FILE "$_";
}
close N1;
close FILE;

for ($number = 1 ; $number <= &getBlocchi ; $number++) {

	$nomeTagHtml = "".&getNomeVetrina($number).".html";
	$nomeTagHtml =~ s/ /_/ig;


open TIT, "+>","$nomeTagHtml";
print TIT ("
<body background=\"none\">


<script type=\"text/javascript\" src=\"362cookies.js\"></script>
<script type=\"text/javascript\" src=\"362lb_common.js\"></script>
<script type=\"text/javascript\" src=\"362lb_html.js\"></script>
<script type=\"text/javascript\" src=\"362lb_menu.js\"></script>
<script type=\"text/javascript\" src=\"../ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js\"></script>
<script type=\"text/javascript\" src=\"d.js\"></script>
<html><title>LiStaWeB-XDL_PeRL &copy; 2014 By Greyback </title><style type=\"text/css\">
\@import url(stile.css);
</style><body OnLoad=\"javascript:window.status='XDCC Engine ';\">
<center><img src=\"logo.png\" width=\"90%\"><br><br>
<script type=\"text/javascript\" src=\"swfobject.js\"></script>
<body>	
<script type=\"text/javascript\" src=\"swfobject.js\"></script><body bgcolor=\"#00000\"><div id=\"flashcontent3\"><p><strong><font size=\"1\">per ascoltare la radio direttamente sul sito hai bisogno dei pluginFlash .</font></strong><br />
<center><a href=\"http://www.adobe.com/shockwave/download/download.cgi?p1_prod_version=shockwaveflash\">Download Flash here.</a></center>
&nbsp;<font size=\"2\">in alternativa ascoltala sul tuo mediaplayer cliccando su listen</font></p></div><script type=\"text/javascript\">
	// <![CDATA[
	
	var so = new SWFObject(\"nativeradio2small.swf\", \"nativeradio2small\", \"400\", \"50\", \"10\", \"#cccccc\");
	so.addParam(\"scale\", \"noscale\");
	so.addVariable(\"swfcolor\", \"FF0000\");
	so.addVariable(\"swfwidth\", \"400\");
	so.addVariable(\"swfradiochannel\", \"RaDio By ".uc($channelspia)." >> SOLO LA MIGLIORE MUSICA PER VOI!!! <<\");
	so.addVariable(\"swfstreamurl\", \"$radio\");
	so.addVariable(\"swfpause\", \"1\");
	so.addVariable(\"swfintervall\", \"1\");
	so.write(\"flashcontent3\");
	
	// ]]>
	function t(a, b) {
		if ( navigator.appName != 'Microsoft Internet Explorer' ) { 
			prompt('Pack: '+b+'\\nBot: '+a+'\\n\\nCopia e incolla questo comando nel tuo client IRC:', '/msg '+a+' xdcc send '+b);
		} else {
			prompt('\\nCopia e incolla questo comando nel tuo client IRC:\\n', '/msg '+a+' xdcc send '+b);
		}
	}
</script><br>
<center><span class=\"img1\"> TAG ".&getNomeVetrina($number)." </span></center></br>
<center><table id=table8 cellpadding=2 cellspacing=1><tr><td id=table8 align=center><a href=\"index.php\"><input type=button value=\"HomePage\" /></td></tr></table></center>
");
close TIT;

open FILE2, ">>", "$nomeTagHtml";
open N2, "<", "".uc(&getVetrina($number))."";
while (<N2>) {
$_ =~ s/ style="display: none;"//i; 
print  FILE2 "$_";
}
close N2;
close FILE2;

open FILE, ">>","$nomeTagHtml";
print FILE ("
</table><center><br><font color=yellow face=verdana size=3><div id='footer'><p>LiStaWeB-XDL_PeRL &copy; 2014  By Greyback</p></div>
");
close FILE;

} #fine for

}


sub make {
		
		$count = 0;


		while ($count <= $bottoli) {

            	chomp $bot[$count];

		open FILE, ">>", "lst.html";
		open N1, "<", "".uc($bot[$count])."";
		while (<N1>) {
  		print  FILE "$_";
		}
		print FILE ("</table>");
		close N1;
		close FILE;
		$count ++;
	}

}

sub addDiv {

		open (MYFILE, '>>lst.html');
		print MYFILE "</div>";
		close (MYFILE);

}

sub fase2 {

		&vetrinaFinale;

&make; &addDiv;

&invia;
 
&msg ("$channel", "4L15ista 4A15ggiornata"); 
&msg ("$channelspia", "4L15ista 4A15ggiornata"); 

&msg ("$channel", "4L15ink 4L15ista15: $list".&getStatusFolder."");

			unlink ("statusaggiornamento.db");
			open ( FILE, ">> statusaggiornamento.db");
			print FILE "off\n";
			close(FILE); 

			unlink ("statociclo.db");
			open ( FILE, ">> statociclo.db");
			print FILE "off\n";
			close(FILE);

			unlink ("faseciclo.db");
			open ( FILE, ">> faseciclo.db");
			print FILE "off\n";
			close(FILE);

			unlink ("statusaggiornamentosezione.db");
			open ( FILE, ">> statusaggiornamentosezione.db");
			print FILE "off\n";
			close(FILE);

	if ($codaAgg[0] ne '') { &autoAggiornamentoSezione($codaAgg[0]); shift @codaAgg, $codaAgg[0];
				$codeTotali = $#codaAgg+1; 
				&msg ("$channel", "4A15ggiornamenti 4I15n 4C15oda4: $codeTotali");
				}

}

sub automessaggio{
$killmex = $_[0];
if ($killmex =~ /$killmex/) { 
$process0 = 1 - $killmex;
$process0 =~ s/\-//g;
$process0 = "$process0";
  if (my $pid = fork) {
    waitpid($pid, 0);
  }
  else {
    if (fork) {
      exit;
    }
    else {
      open(SUKA, '>>', "pidmessaggio.db");
      print SUKA "$process0\r\n";
      close (SUKA);
exit;
    }
  }
}}

sub sendraw {
    if ($#_ == '1') {
    my $net = $_[0];
    print $net "$_[1]\n";
    } else {
        print $net "$_[0]\n";
    }
}

sub vetrine
{

$number = 1;

			&msg ("$channelspia", "4[8".uc($channelspia)."4] 4[8ULTIME NOVITÀ4]");

	novita:

		
		$filez = "".&getVetrina($number).".vt";
		$file = uc($filez);

		open(INFO, $file);
         	@novitaV3trina1z = <INFO>;
         	close(INFO);

         	@newsV3trina1z = reverse(@novitaV3trina1z);
		chomp @newsV3trina1z;

		$filez = "".&getVetrina($number).".dt";
        	$file = uc($filez);
         	open(INFO, $file);
         	@dateV3trina1z = <INFO>;
         	close(INFO);

         	@dataV3trina1z = reverse(@dateV3trina1z);
		chomp @dataV3trina1z;

		@$newsV3trina1zStamp = ();

		for ($i = 0 ; $i < 20 ; $i ++ ) {
		$newsV3trina1zStamp[$i] = $newsV3trina1z[$i];
		}

		for ($i = 0 ; $i < 20 ; $i ++ ) {
		$newsV3trina1zStamp[$i] =~ s/\./ /ig;
		$newsV3trina1zStamp[$i] =~ s/\-/ /ig;
		$newsV3trina1zStamp[$i] =~ s/\_/ /ig;
		$newsV3trina1zStamp[$i] =~ s/\[/ /ig;
		$newsV3trina1zStamp[$i] =~ s/\]/ /ig;
		$newsV3trina1zStamp[$i] =~ s/\(/ /ig;
		$newsV3trina1zStamp[$i] =~ s/\)/ /ig;
		$dataV3trina1z[$i] = &stripData($dataV3trina1z[$i]);
		}

		my $totBotVetr = 20; #tanti quanti i bot totali in vetrina

	for ( $i = 0 ; $i < $totBotVetr ; $i++ ) {

	     if ($i > $#novitaV3trina1z ) { $newsV3trina1zStamp[$i] = "/-/-/-/- Novità Non Disp /-/-/-/-";}

	}

	for ( $i = 0 ; $i < $totBotVetr ; $i++ ) {

	     if ($dataV3trina1z[$i] eq '') { $dataV3trina1z[$i] = "-/-"; }
	}

	@colourNews = ('3', '4', '5', '6', '7', '8' ,'9', '10', '11', '12', '3', '4', '5', '6', '7', '8' ,'9', '10', '11', '12', '3', '4', '5', '6', '7', '8' ,'9', '10', '11', '12', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '3', '4', '5', '6', '7', '8' ,'9', '10', '11', '12', '3', '4', '5', '6', '7', '8' ,'9', '10', '11', '12', '3', '4', '5', '6');

		$coloreEsatto = $number - 1;

		$nomeDelleVetrina = &getNomeVetrina($number);
		if ($nomeDelleVetrina ne '' && $nomeDelleVetrina !~ /Non-Disp/i) {

          &msg ("$channelspia", "4[8$nomeDelleVetrina4] 4[8$dataV3trina1z[0]4] $colourNews[$coloreEsatto]$newsV3trina1zStamp[0]"); 

		}

		if ($number < &getBlocchi) {$number++ ; goto novita;}

		   &msg ("$channelspia", "$logo2");


}

sub blocco() {

 my $blocco = $_[0];


		$filez = "".&getVetrina($blocco).".vt";
		$file = uc($filez);

		open(INFO, $file);
         	@novitaV3trina1 = <INFO>;
         	close(INFO);

         	@newsV3trina1 = reverse(@novitaV3trina1);
		chomp @newsV3trina1z;

		$filez = "".&getVetrina($blocco).".dt";
        	$file = uc($filez);
         	open(INFO, $file);
         	@dateV3trina1 = <INFO>;
         	close(INFO);

         	@dataV3trina1 = reverse(@dateV3trina1);
		chomp @dataV3trina1;

		@$newsV3trina1Stamp = ();

		for ($i = 0 ; $i < &getGriglia ; $i ++ ) {
		$newsV3trina1Stamp[$i] = $newsV3trina1[$i];
		}

		for ($i = 0 ; $i < &getGriglia ; $i ++ ) {
		$newsV3trina1Stamp[$i] =~ s/\./ /ig;
		$newsV3trina1Stamp[$i] =~ s/\-/ /ig;
		$newsV3trina1Stamp[$i] =~ s/\_/ /ig;
		$newsV3trina1Stamp[$i] =~ s/\[/ /ig;
		$newsV3trina1Stamp[$i] =~ s/\]/ /ig;
		$newsV3trina1Stamp[$i] =~ s/\(/ /ig;
		$newsV3trina1Stamp[$i] =~ s/\)/ /ig;
		$dataV3trina1[$i] = &stripData($dataV3trina1[$i]);
		}

		my $totBotVetr = &getGriglia; #tanti quanti i bot totali in vetrina

	for ( $i = 0 ; $i < $totBotVetr ; $i++ ) {

	     if ($i > $#novitaV3trina1 && $i eq 0 ) { $newsV3trina1Stamp[$i] = "/-/-/-/- Vetrina ".&getNomeVetrina($blocco)." Non Disp /-/-/-/-";}
	     if ($i > $#novitaV3trina1 && $i ne 0) { $newsV3trina1Stamp[$i] = "";}
	}

	for ( $i = 0 ; $i < $totBotVetr ; $i++ ) {

	     if ($i > $#dataV3trina1 && $i eq 0) { $dataV3trina1[$i] = "-/-"; }
	     if ($i > $#dataV3trina1 && $i ne 0) { $dataV3trina1[$i] = ""; }
	}

                   &msg ("$channelspia", "4[8".uc($channelspia)." Novità ".&getNomeVetrina($blocco)."4]");

		   for ($i = 0 ; $i < &getGriglia ; $i++) {
		
		   @colourNews = ('3', '4', '5', '6', '7', '8' ,'9', '10', '11', '12', '3', '4', '5', '6', '7', '8' ,'9', '10', '11', '12', '3', '4', '5', '6', '7', '8' ,'9', '10', '11', '12', '3', '4');

                   if ($dataV3trina1[$i] ne '' && $newsV3trina1Stamp[$i] ne '') {&msg ("$channelspia", "4[8$dataV3trina1[$i]4] $colourNews[$i]$newsV3trina1Stamp[$i]");}


		   if ($i eq ($totBotVetr-1)) {&msg ("$channelspia", "$logo2");}
		   }


}

sub controllaPosizioneBot() {

    my $status = 0;
    my $nick = $_[0];

        	for ( $i = 0 ; $i <= $#bot ; $i++) {

		if (uc($nick) eq uc($bot[$i])) { $status = $i+1;}

          	}

    return $status;

}

sub isBot() {
    my $status = 0;
    my $nick = $_[0];
    if ($nick =~ /^$nickInizioShell\|/i) { $status = 1; }
    return $status;
}

sub isDataNews() {

    my $status = 0;
    my $file = $_[0];
    my $fileData = $_[1];

	my $fileId = open ( FILE, "< $fileData");
	@riga = <FILE>; @riga = reverse(@riga);
	$riga[0] = substr ($riga[0], 0, -1); if ( uc($riga[0]) eq uc(${file})) {$status = 1;}
	close(FILE);

 	return $status;
}

sub isNotDataNews() {

    my $status = 0;
    my $file = $_[0];
    my $fileData = $_[1];

	my $fileId = open ( FILE, "< $fileData");
	@riga = <FILE>; @riga = reverse(@riga);
	for ($i = 0 ; $i < &getGriglia; $i++) {$riga[$i] = substr ($riga[$i], 0, -1); if ( uc($riga[$i]) ne uc(${file})) {$status = 1;}
	}
	close(FILE);

 	return $status;
}

sub controllaExcept
{
	my $nick = shift;
	my $flagAdm = 0;
	my $fileId = open ( FILE, "< except.lst");
	while ( $riga = <FILE> )  {
		$riga = substr ($riga, 0, -1);
		if ( uc(${riga}) eq uc(${nick}) ) { $flagAdm = 1; }
	}
	close(FILE);
	return $flagAdm;
}

sub checkAvvio
{

	my $fileId = open ( FILE, "< avvio.db");
	$statusAvvio = <FILE>;
	chomp $statusAvvio;
	return $statusAvvio;
}

sub checkFaseCiclo
{

	my $fileId = open ( FILE, "< faseciclo.db");
	$statusFaseCiclo = <FILE>;
	chomp $statusFaseCiclo;
	return $statusFaseCiclo;
}

sub connectDccChatApri
{
	my $nickss = shift;

		(threads->new(\&dccChat, $nickss))->detach();

}

sub connectDccChatApriSezioni
{
	my $nickss = shift;

		(threads->new(\&dccChatSezioni, $nickss))->detach();

}

sub msg() {
    return unless $#_ == 1;
    sendraw($net, "PRIVMSG $_[0] :$_[1]");
}

sub topic() {
    return unless $#_ == 1;
    sendraw($net, "TOPIC $_[0] :$_[1]");
}

sub nick() {
    return unless $#_ == 0;
    sendraw("NICK $_[0]");
}

sub notice() {
    return unless $#_ == 1;
    sendraw("NOTICE $_[0] :$_[1]");
}

sub isAdmin {

	$nick = shift;

	my $flagAdm = 0;

        if (uc($nick) eq uc($founder)) {$flagAdm = 1; return $flagAdm;}


	if (&existAndSize("admins.lst")) {

	my $fileId = open ( FILE, "< admins.lst");
	while ( $riga = <FILE> )  {
		$riga = substr ($riga, 0, -1);
		if ( uc(${riga}) eq uc(${nick}) || uc(${nick}) eq uc($founder)) { $flagAdm = 1; }
	}
	close(FILE);
	return $flagAdm;

		}
}

sub existAndSize() {

    my $status = 0;
    my $file = $_[0];

 		if (-s $file) {$status = 1;}
		return $status;

}

sub contattaAdmins {

 	$mex = $_[0];

 	open ( INFO, "< admins.lst");
 	@admins = <INFO>;
 	close(INFO);

	&msg ("$founder", "$mex");

	for ( $i = 0 ; $i <= $#admins ; $i++ ) {
	
	chomp $admins[$i];
	&msg ("$admins[$i]", "$mex");

	}

}

sub isEnabled() {

	my $nick = shift;
	my $flagAdm = 0;
	my $fileId = open ( FILE, "< enable.lst");
	while ( $riga = <FILE> )  {
		$riga = substr ($riga, 0, -1);
		if ( uc(${riga}) eq uc(${nick}) ) { $flagAdm = 1; }
	}
	close(FILE);
	return $flagAdm;
}

sub isSezione() {

	my $nick = shift;
	my $flagAdm = 0;
	&getSezioni;
	my $fileId = open ( FILE, "< sezioni.db");
	while ( $riga = <FILE> )  {
		$riga = substr ($riga, 0, -1);
		if ( uc(${riga}) eq uc(${nick}) ) { $flagAdm = 1; }
	}
	close(FILE);
	return $flagAdm;
}

sub isBotSezione() {

	my $nick = shift;
	my $flagAdm = 0;
	&getSezioni;
	my $fileId = open ( FILE, "< nomesezione.db");
	while ( $riga = <FILE> )  {
		$riga = substr ($riga, 0, -1);
		if ( uc(${riga}) eq uc(${nick}) ) { $flagAdm = 1; }
	}
	close(FILE);
	return $flagAdm;
}

sub listAsked() {

	my $nick = shift;
	my $flagAdm = 0;
	my $fileId = open ( FILE, "< nicklist.lst");
	while ( $riga = <FILE> )  {
		$riga = substr ($riga, 0, -1);
		if ( uc(${riga}) eq uc(${nick}) ) { $flagAdm = 1; }
	}
	close(FILE);
	return $flagAdm;
}

sub exist() {
    my $status = 0;
    my $file = $_[0];

 		if (-e $file) {$status = 1;}
		return $status;
}

sub notExist() {
    my $status = 0;
    my $file = $_[0];

 		unless (-e $file) {$status = 1;}
		return $status;
}

sub checkMexJoin
{

	my $fileId = open ( FILE, "< statusmexjoin.db");
	$statusMexJoin = <FILE>;
	chomp $statusMexJoin;
	return $statusMexJoin;
}

sub checkSortName
{

	my $fileId = open ( FILE, "< sortname.db");
	$statusSortName = <FILE>;
	chomp $statusSortName;
	return $statusSortName;
}

sub getMexJoin
{

	my $fileId = open ( FILE, "< mexjoin.db");
	$getMexJoin = <FILE>;
	chomp $getMexJoin;
	return $getMexJoin;
}

sub getVetrina
{

	$num = $_[0];
	my $fileId = open ( FILE, "< vetrina$num.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina1
{
	my $fileId = open ( FILE, "< vetrina1.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina2
{
	my $fileId = open ( FILE, "< vetrina2.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina3
{
	my $fileId = open ( FILE, "< vetrina3.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina4
{
	my $fileId = open ( FILE, "< vetrina4.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina5
{
	my $fileId = open ( FILE, "< vetrina5.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina6
{
	my $fileId = open ( FILE, "< vetrina6.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina7
{
	my $fileId = open ( FILE, "< vetrina7.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina8
{
	my $fileId = open ( FILE, "< vetrina8.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina9
{
	my $fileId = open ( FILE, "< vetrina9.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina10
{
	my $fileId = open ( FILE, "< vetrina10.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina11
{
	my $fileId = open ( FILE, "< vetrina11.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina12
{
	my $fileId = open ( FILE, "< vetrina12.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina13
{
	my $fileId = open ( FILE, "< vetrina13.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina14
{
	my $fileId = open ( FILE, "< vetrina14.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina15
{
	my $fileId = open ( FILE, "< vetrina15.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina16
{
	my $fileId = open ( FILE, "< vetrina16.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina17
{
	my $fileId = open ( FILE, "< vetrina17.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina18
{
	my $fileId = open ( FILE, "< vetrina18.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina19
{
	my $fileId = open ( FILE, "< vetrina19.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina20
{
	my $fileId = open ( FILE, "< vetrina20.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina21
{
	my $fileId = open ( FILE, "< vetrina21.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina22
{
	my $fileId = open ( FILE, "< vetrina22.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina23
{
	my $fileId = open ( FILE, "< vetrina23.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina24
{
	my $fileId = open ( FILE, "< vetrina24.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina25
{
	my $fileId = open ( FILE, "< vetrina25.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina26
{
	my $fileId = open ( FILE, "< vetrina26.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina27
{
	my $fileId = open ( FILE, "< vetrina27.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina28
{
	my $fileId = open ( FILE, "< vetrina28.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina29
{
	my $fileId = open ( FILE, "< vetrina29.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina30
{
	my $fileId = open ( FILE, "< vetrina30.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina31
{
	my $fileId = open ( FILE, "< vetrina31.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina32
{
	my $fileId = open ( FILE, "< vetrina32.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina33
{
	my $fileId = open ( FILE, "< vetrina33.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina34
{
	my $fileId = open ( FILE, "< vetrina34.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina35
{
	my $fileId = open ( FILE, "< vetrina35.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina36
{
	my $fileId = open ( FILE, "< vetrina36.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina37
{
	my $fileId = open ( FILE, "< vetrina37.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina38
{
	my $fileId = open ( FILE, "< vetrina38.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina39
{
	my $fileId = open ( FILE, "< vetrina39.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina40
{
	my $fileId = open ( FILE, "< vetrina40.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina41
{
	my $fileId = open ( FILE, "< vetrina41.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina42
{
	my $fileId = open ( FILE, "< vetrina42.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina43
{
	my $fileId = open ( FILE, "< vetrina43.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina44
{
	my $fileId = open ( FILE, "< vetrina44.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina45
{
	my $fileId = open ( FILE, "< vetrina45.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina46
{
	my $fileId = open ( FILE, "< vetrina46.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina47
{
	my $fileId = open ( FILE, "< vetrina47.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina48
{
	my $fileId = open ( FILE, "< vetrina48.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina49
{
	my $fileId = open ( FILE, "< vetrina49.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina50
{
	my $fileId = open ( FILE, "< vetrina50.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina51
{
	my $fileId = open ( FILE, "< vetrina51.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina52
{
	my $fileId = open ( FILE, "< vetrina52.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina53
{
	my $fileId = open ( FILE, "< vetrina53.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina54
{
	my $fileId = open ( FILE, "< vetrina54.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina55
{
	my $fileId = open ( FILE, "< vetrina55.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina56
{
	my $fileId = open ( FILE, "< vetrina56.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina57
{
	my $fileId = open ( FILE, "< vetrina57.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina58
{
	my $fileId = open ( FILE, "< vetrina58.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina59
{
	my $fileId = open ( FILE, "< vetrina59.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina60
{
	my $fileId = open ( FILE, "< vetrina60.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina61
{
	my $fileId = open ( FILE, "< vetrina61.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina62
{
	my $fileId = open ( FILE, "< vetrina62.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina63
{
	my $fileId = open ( FILE, "< vetrina63.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getVetrina64
{
	my $fileId = open ( FILE, "< vetrina64.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina
{

	$num = $_[0];
	my $fileId = open ( FILE, "< nomevetrina$num.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrinaSplitted
{

	$num = $_[0];
	my $fileId = open ( FILE, "< nomevetrina$num.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	$statusVetrina =~ s/ /_/ig;
	return $statusVetrina;
}

sub getNomeVetrina1
{
	my $fileId = open ( FILE, "< nomevetrina1.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina2
{
	my $fileId = open ( FILE, "< nomevetrina2.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina3
{
	my $fileId = open ( FILE, "< nomevetrina3.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina4
{
	my $fileId = open ( FILE, "< nomevetrina4.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina5
{
	my $fileId = open ( FILE, "< nomevetrina5.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina6
{
	my $fileId = open ( FILE, "< nomevetrina6.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina7
{
	my $fileId = open ( FILE, "< nomevetrina7.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina8
{
	my $fileId = open ( FILE, "< nomevetrina8.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina9
{
	my $fileId = open ( FILE, "< nomevetrina9.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina10
{
	my $fileId = open ( FILE, "< nomevetrina10.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina11
{
	my $fileId = open ( FILE, "< nomevetrina11.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina12
{
	my $fileId = open ( FILE, "< nomevetrina12.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina13
{
	my $fileId = open ( FILE, "< nomevetrina13.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina14
{
	my $fileId = open ( FILE, "< nomevetrina14.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina15
{
	my $fileId = open ( FILE, "< nomevetrina15.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina16
{
	my $fileId = open ( FILE, "< nomevetrina16.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina17
{
	my $fileId = open ( FILE, "< nomevetrina17.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina18
{
	my $fileId = open ( FILE, "< nomevetrina18.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina19
{
	my $fileId = open ( FILE, "< nomevetrina19.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina20
{
	my $fileId = open ( FILE, "< nomevetrina20.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina21
{
	my $fileId = open ( FILE, "< nomevetrina21.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina22
{
	my $fileId = open ( FILE, "< nomevetrina22.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina23
{
	my $fileId = open ( FILE, "< nomevetrina23.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina24
{
	my $fileId = open ( FILE, "< nomevetrina24.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina25
{
	my $fileId = open ( FILE, "< nomevetrina25.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina26
{
	my $fileId = open ( FILE, "< nomevetrina26.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina27
{
	my $fileId = open ( FILE, "< nomevetrina27.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina28
{
	my $fileId = open ( FILE, "< nomevetrina28.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina29
{
	my $fileId = open ( FILE, "< nomevetrina29.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina30
{
	my $fileId = open ( FILE, "< nomevetrina30.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina31
{
	my $fileId = open ( FILE, "< nomevetrina31.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina32
{
	my $fileId = open ( FILE, "< nomevetrina32.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina33
{
	my $fileId = open ( FILE, "< nomevetrina33.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina34
{
	my $fileId = open ( FILE, "< nomevetrina34.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina35
{
	my $fileId = open ( FILE, "< nomevetrina35.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina36
{
	my $fileId = open ( FILE, "< nomevetrina36.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina37
{
	my $fileId = open ( FILE, "< nomevetrina37.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina38
{
	my $fileId = open ( FILE, "< nomevetrina38.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina39
{
	my $fileId = open ( FILE, "< nomevetrina39.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina40
{
	my $fileId = open ( FILE, "< nomevetrina40.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina41
{
	my $fileId = open ( FILE, "< nomevetrina41.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina42
{
	my $fileId = open ( FILE, "< nomevetrina42.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina43
{
	my $fileId = open ( FILE, "< nomevetrina43.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina44
{
	my $fileId = open ( FILE, "< nomevetrina44.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina45
{
	my $fileId = open ( FILE, "< nomevetrina45.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina46
{
	my $fileId = open ( FILE, "< nomevetrina46.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina47
{
	my $fileId = open ( FILE, "< nomevetrina47.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina48
{
	my $fileId = open ( FILE, "< nomevetrina48.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina49
{
	my $fileId = open ( FILE, "< nomevetrina49.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina50
{
	my $fileId = open ( FILE, "< nomevetrina50.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina51
{
	my $fileId = open ( FILE, "< nomevetrina51.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina52
{
	my $fileId = open ( FILE, "< nomevetrina52.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina53
{
	my $fileId = open ( FILE, "< nomevetrina53.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina54
{
	my $fileId = open ( FILE, "< nomevetrina54.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina55
{
	my $fileId = open ( FILE, "< nomevetrina55.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina56
{
	my $fileId = open ( FILE, "< nomevetrina56.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina57
{
	my $fileId = open ( FILE, "< nomevetrina57.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina58
{
	my $fileId = open ( FILE, "< nomevetrina58.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina59
{
	my $fileId = open ( FILE, "< nomevetrina59.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina60
{
	my $fileId = open ( FILE, "< nomevetrina60.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina61
{
	my $fileId = open ( FILE, "< nomevetrina61.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina62
{
	my $fileId = open ( FILE, "< nomevetrina62.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina63
{
	my $fileId = open ( FILE, "< nomevetrina63.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub getNomeVetrina64
{
	my $fileId = open ( FILE, "< nomevetrina64.db");
	$statusVetrina = <FILE>;
	chomp $statusVetrina;
	return $statusVetrina;
}

sub newsData() {
	
	@dato = 0;
	$number = $_[0];

		$filez = "".&getVetrina($number).".dt";
		$file = uc($filez);

		open(INFO, $file);
         	@dateVetrina = <INFO>;
         	close(INFO);

         	@dataVetrina = reverse(@dateVetrina);
		chomp @dataVetrina;

		for ($i = 0 ; $i < 20 ; $i ++ ) { $dataVetrina[$i] = &stripData($dataVetrina[$i]);}

		@dato = @dataVetrina;
		
		return @dato;

}

sub newsData2() {
	
	@dato = 0;
	$number = $_[0];

		$filez = "".&getVetrina($number).".dt";
		$file = uc($filez);

		open(INFO, $file);
         	@dateVetrina = <INFO>;
         	close(INFO);

         	@dataVetrina = reverse(@dateVetrina);
		chomp @dataVetrina;

		@dato = @dataVetrina;
		
		return @dato;

}

sub newsVetrinaStamp() {
	
	@dato = 0;
	$number = $_[0];

		$filez = "".&getVetrina($number).".vt";
		$file = uc($filez);

		open(INFO, $file);
         	@novitaVetrina = <INFO>;
         	close(INFO);

         	@newsVetrina = reverse(@novitaVetrina);
		chomp @newsVetrina;

		@$newsVetrinaStamp = ();

		@newsVetrinaStamp = @newsVetrina;


		for ($i = 0 ; $i < 20 ; $i ++ ) { $newsVetrinaStamp[$i] = &stripVetrineStamp($newsVetrinaStamp[$i]);}
		
		@dato = @newsVetrinaStamp;

		return @dato;

}

sub newsVetrinaQuery() {
	
	@dato = 0;
	$number = $_[0];

		$filez = "".&getVetrina($number).".vt";
		$file = uc($filez);

		open(INFO, $file);
         	@novitaVetrina = <INFO>;
         	close(INFO);

         	@newsVetrina = reverse(@novitaVetrina);
		chomp @newsVetrina;

		@$newsVetrinaQuery = ();

		@newsVetrinaQuery = @newsVetrina;


		for ($i = 0 ; $i < 20 ; $i ++ ) { $newsVetrinaQuery[$i] = &stripVetrineQuery($newsVetrinaStamp[$i]);}
		
		@dato = @newsVetrinaQuery;

		return @dato;

}

sub autoAggiornamento {

		if (&getStatusAggiornamento =~ /off/i) {		

 			if (&exist("blocchi.db")) {

			unlink ("statusaggiornamento.db");
			open ( FILE, ">> statusaggiornamento.db");
			print FILE "on\n";
			close(FILE);

			unlink ("faseciclo.db");
			open ( FILE, ">> faseciclo.db");
			print FILE "off\n";
			close(FILE);

      			&msg ("$channel", "4A15ggiornamento 4L15ista 4I15n 4C15orso");
      			&msg ("$channelspia", "4A15ggiornamento 4L15ista 4I15n 4C15orso");

			$lastBotXdl = 0; 

			unlink (<*.VT>);
			unlink (<*.DT>);
			unlink (<*.MN>);
			unlink (<*.MD>);
			#unlink (<*.TR>);


        		for ( $i = 0 ; $i <= $#bot ; $i++) {

            		chomp $bot[$i];
            		&connectDccChatApri($bot[$i]);

          		}

							}

			else { &msg ("$channel", "4V15etrine 4N15on 4I15mpostate4: 4I15mpossibile 4E15seguire 4A15ggiornamento 4L15ista");}
							}

		else { &msg ("$channel", "4E15rrore4: 4A15ggiornamento 4I15n 4C15orso");}

}

sub autoAggiornamentoSezione() {

	$sezione = $_[0];

		if (&getStatusAggiornamento =~ /off/i) {
		
		&getSezioni; &sezione($sezione);

		unlink ("statusaggiornamentosezione.db");
		open ( FILE, ">> statusaggiornamentosezione.db");
		print FILE "on\n";
		close(FILE);		

 			if (&exist("blocchi.db")) {

			unlink ("statusaggiornamento.db");
			open ( FILE, ">> statusaggiornamento.db");
			print FILE "on\n";
			close(FILE);

			unlink ("faseciclo.db");
			open ( FILE, ">> faseciclo.db");
			print FILE "off\n";
			close(FILE);

      			&msg ("$channel", "4A15ggiornamento 4L15ista 4(15 Sezione $sezione 4) 4I15n 4C15orso");
      			&msg ("$channelspia", "4A15ggiornamento 4L15ista 4(15 Sezione $sezione 4) 4I15n 4C15orso");

			$lastBotXdlSezioni = 0; 

			my $fileId = open ( FILE, "< nomesezione.db");
			@nomesezioni = <FILE>;
			chomp @nomesezioni;
         		close(FILE); 

        		for ( $i = 0 ; $i <= $#nomesezioni ; $i++) {

            		chomp $nomesezioni[$i];
			$cancellare = uc($nomesezioni[$i]);
			$cancellare1 = "$cancellare.VT";
			$cancellare2 = "$cancellare.DT";
			$cancellare3 = "$cancellare.MN";
			$cancellare4 = "$cancellare.MD";
            		unlink ("$cancellare");
            		unlink ("$cancellare1");
            		unlink ("$cancellare2");
            		unlink ("$cancellare3");
            		unlink ("$cancellare4");
          		}

        		for ( $i = 0 ; $i <= $#nomesezioni ; $i++) {

            		chomp $nomesezioni[$i];
            		&connectDccChatApriSezioni($nomesezioni[$i]);
          		}

							}

			else { &msg ("$channel", "4V15etrine 4N15on 4I15mpostate4: 4I15mpossibile 4E15seguire 4A15ggiornamento 4L15ista");}
							}

		else { &msg ("$channel", "4E15rrore4: 4A15ggiornamento 4I15n 4C15orso"); }

}

	sub getSezioni {

	unlink ("sezioni.db");
	for ($i = 0; $i <= $#bot ; $i++) { 

	if ($bot[$i] =~ /^$nickInizioShell\|(.*)\|(.*)\|(.*)\|(.*)/i) {

			$file = $1;

			my $flag = 0;
			$fileopen = "sezioni.db";
			$except = substr ($except, 0, -1);
			$except =~ s/ //g;
			my $fileId = open ( FILE, "< $fileopen");
			while ( $riga = <FILE> )
			{
				$riga = substr ($riga, 0, -1);
				if ( uc($riga) eq uc($file) ) { $flag = 1; }
			}
			close(FILE);
			if ( $flag == 0 )
			{
				my $fileId = open ( FILE, ">> $fileopen");
				print FILE "$file\n";
				close(FILE);

			}


 		}
	
	elsif ($bot[$i] =~ /^$nickInizioShell\|(.*)\|(.*)\|(.*)/i) { 

			$file = $1;

			my $flag = 0;
			$fileopen = "sezioni.db";
			$except = substr ($except, 0, -1);
			$except =~ s/ //g;
			my $fileId = open ( FILE, "< $fileopen");
			while ( $riga = <FILE> )
			{
				$riga = substr ($riga, 0, -1);
				if ( uc($riga) eq uc($file) ) { $flag = 1; }
			}
			close(FILE);
			if ( $flag == 0 )
			{
				my $fileId = open ( FILE, ">> $fileopen");
				print FILE "$file\n";
				close(FILE);

			}

 		}	

	elsif ($bot[$i] =~ /^$nickInizioShell\|(.*)\|(.*)/i) {

			$file = $1;

			my $flag = 0;
			$fileopen = "sezioni.db";
			$except = substr ($except, 0, -1);
			$except =~ s/ //g;
			my $fileId = open ( FILE, "< $fileopen");
			while ( $riga = <FILE> )
			{
				$riga = substr ($riga, 0, -1);
				if ( uc($riga) eq uc($file) ) { $flag = 1; }
			}
			close(FILE);
			if ( $flag == 0 )
			{
				my $fileId = open ( FILE, ">> $fileopen");
				print FILE "$file\n";
				close(FILE);

			}

 		}	

	elsif ($bot[$i] =~ /^$nickInizioShell\|(.*)/i) {

			$file = $1;

			my $flag = 0;
			$fileopen = "sezioni.db";
			$except = substr ($except, 0, -1);
			$except =~ s/ //g;
			my $fileId = open ( FILE, "< $fileopen");
			while ( $riga = <FILE> )
			{
				$riga = substr ($riga, 0, -1);
				if ( uc($riga) eq uc($file) ) { $flag = 1; }
			}
			close(FILE);
			if ( $flag == 0 )
			{
				my $fileId = open ( FILE, ">> $fileopen");
				print FILE "$file\n";
				close(FILE);

			}

 		}	


					} #fine for


}

sub sezione () {

		$paragone = $_[0];

		unlink ("nomesezione.db");
		&getSezioni;		
		for ($i = 0 ; $i <= $#bot ; $i++) {

			if ($bot[$i] =~ /^$nickInizioShell\|$paragone\|/i ) { 
			open N1, ">>", "nomesezione.db";
			print N1 ("$bot[$i]\n");
			close N1; 

			}

		}

}

sub faseCiclo {

		if (&statoCiclo =~ /off/i) {		


			unlink ("statusaggiornamento.db");
			open ( FILE, ">> statusaggiornamento.db");
			print FILE "on\n";
			close(FILE);

			unlink ("faseciclo.db");
			open ( FILE, ">> faseciclo.db");
			print FILE "on\n";
			close(FILE);

			$lastBotXdl = 0; 

			unlink ("statociclo.db");
			open ( FILE, ">> statociclo.db");
			print FILE "on\n";
			close(FILE);
	
        		for ( $i = 0 ; $i <= $#bot ; $i++) {

            		chomp $bot[$i];
            		&connectDccChatApri($bot[$i]);

          		}

							}


		else { &fase2;}

}

sub faseCiclo2 {

		if (&statoCiclo =~ /off/i) {		


			unlink ("statusaggiornamento.db");
			open ( FILE, ">> statusaggiornamento.db");
			print FILE "on\n";
			close(FILE);

			unlink ("faseciclo.db");
			open ( FILE, ">> faseciclo.db");
			print FILE "on\n";
			close(FILE);

			$lastBotXdlSezioni = 0; 

			unlink ("statociclo.db");
			open ( FILE, ">> statociclo.db");
			print FILE "on\n";
			close(FILE);
	
        		for ( $i = 0 ; $i <= $#nomesezioni ; $i++) {

            		chomp $nomesezioni[$i];
            		&connectDccChatApriSezioni($nomesezioni[$i]); 

          		}

							}


		else { &fase2;}

}

sub statoCiclo #controlla se il ciclo è stato già fatto una volta
{
	my $fileId = open ( FILE, "< statociclo.db");
	$statusCiclo = <FILE>;
	chomp $statusCiclo;
	return $statusCiclo;
}

sub getStatusAggiornamento
{
	my $fileId = open ( FILE, "< statusaggiornamento.db");
	$statusAggiornamento = <FILE>;
	chomp $statusAggiornamento;
	return $statusAggiornamento;
}

sub getStatusAggiornamentoSezione
{
	my $fileId = open ( FILE, "< statusaggiornamentosezione.db");
	$statusAggiornamentoSezione = <FILE>;
	chomp $statusAggiornamentoSezione;
	return $statusAggiornamentoSezione;
}

sub getStatusRispostaLista
{

	my $fileId = open ( FILE, "< rispostalista.db");
	$statusRispostaLista = <FILE>;
	chomp $statusRispostaLista;
	return $statusRispostaLista;

}

sub getStatusRispostaComandi
{

	my $fileId = open ( FILE, "< rispostacomandi.db");
	$statusRispostaComandi = <FILE>;
	chomp $statusRispostaComandi;
	return $statusRispostaComandi;

}

sub getBlocchi
{
	my $fileId = open ( FILE, "< blocchi.db");
	$statusBlocchi = <FILE>;
	chomp $statusBlocchi;
	return $statusBlocchi;
}

sub getStatusOscuramento 
{

	my $fileId = open ( FILE, "< oscura.db");
	$statusOscuramento = <FILE>;
	chomp $statusOscuramento;
	return $statusOscuramento;

}

sub getStatusSpamPvt
{
	my $fileId = open ( FILE, "< spampvt.db");
	$statusSpamPvt = <FILE>;
	return $statusSpamPvt;
}

sub getGriglia
{
	my $fileId = open ( FILE, "< griglia.db");
	$statusGriglia = <FILE>;
	chomp $statusGriglia;
	return $statusGriglia;
}

sub getNumVetrine
{
	my $fileId = open ( FILE, "< numerovetrine.db");
	$statusNumVetrine = <FILE>;
	chomp $statusNumVetrine;
	return $statusNumVetrine;
}

sub getStatusFolder {

	my $fileId = open ( FILE, "< cartella.db");
	$statusFolder = <FILE>;
	chomp $statusFolder;
	return $statusFolder;

}

sub getTimer {

	my $fileId = open ( FILE, "< timer.db");
	$statusTimer = <FILE>;
	chomp $statusTimer;
	return $statusTimer;

}

sub getIp {

my $address = 0;

my $host = hostname();
 my $address = inet_ntoa(
     scalar gethostbyname( $host || 'localhost' )
     );

 return $address;

}

sub strip {

$var = 0 ;

    my $fileStrip = $_[0];

		$fileStrip =~ s/\.rar$//i;
		$fileStrip =~ s/\.avi$//i;
		$fileStrip =~ s/\.mp4$//i;
		$fileStrip =~ s/\.pdf$//i;
		$fileStrip =~ s/\.srt$//i;
		$fileStrip =~ s/\.mkv$//i;
		$fileStrip =~ s/\.zip$//i;
	
		$fileStrip =~ s/\.r(\d+)//i;
		$fileStrip =~ s/\.part(\d+)//i;
		$fileStrip =~ s/\.cd(\d+)//i;
		$fileStrip =~ s/\.cd\.(\d+)//i;

		$fileStrip =~ s/\-/\./ig;

		$fileStrip =~ s/\.\.\.\.\.\./\./ig;
		$fileStrip =~ s/\.\.\.\.\./\./ig;
		$fileStrip =~ s/\.\.\.\./\./ig;
		$fileStrip =~ s/\.\.\./\./ig;
		$fileStrip =~ s/\.\./\./ig;


	
	$var = $fileStrip;

 return $var;

}

sub stripSpam {

$var = 0 ;

    my $fileStrip = $_[0];

		$fileStrip =~ s/\-/\./ig;

		$fileStrip =~ s/\.\.\.\.\.\./\./ig;
		$fileStrip =~ s/\.\.\.\.\./\./ig;
		$fileStrip =~ s/\.\.\.\./\./ig;
		$fileStrip =~ s/\.\.\./\./ig;
		$fileStrip =~ s/\.\./\./ig;
		$fileStrip =~ s/\./ /ig;

	
	$var = $fileStrip;

 return $var;

}


sub stripTrailer2 {

$var = 0 ;

    my $fileStrip = $_[0];

		$fileStrip =~ s/\-/\./ig;
		$fileStrip =~ s/\.\.\.\.\.\./\./ig;
		$fileStrip =~ s/\.\.\.\.\./\./ig;
		$fileStrip =~ s/\.\.\.\./\./ig;
		$fileStrip =~ s/\.\.\./\./ig;
		$fileStrip =~ s/\.\./\./ig;
		$fileStrip =~ s/\./ /ig;
		$fileStrip =~ s/\-/ /ig;
		$fileStrip =~ s/\_/ /ig;
		$fileStrip =~ s/\(/ /ig;
		$fileStrip =~ s/\)/ /ig;
		$fileStrip =~ s/\[/ /ig;
		$fileStrip =~ s/\]/ /ig;
	
	$var = $fileStrip;

 return $var;

}

sub stripVetrineStamp {

$var = 0 ;

    my $fileStrip = $_[0];

		$fileStrip =~ s/\.(\d\d\d\d)//i;
		$fileStrip =~ s/\./ /ig;
		$fileStrip =~ s/\-/ /ig;
		$fileStrip =~ s/\_/ /ig;
		$fileStrip =~ s/\(/ /ig;
		$fileStrip =~ s/\)/ /ig;
		$fileStrip =~ s/\[/ /ig;
		$fileStrip =~ s/\]/ /ig;
	
	$var = $fileStrip;

 return $var;

}

sub stripVetrineQuery {

$var = 0 ;

    my $fileStrip = $_[0];

		$fileStrip =~ s/\.(\d\d\d\d)//i;
		$fileStrip =~ s/\./+/ig;
		$fileStrip =~ s/ /+/ig;
		$fileStrip =~ s/\_/ /ig;
		$fileStrip =~ s/\-/+/ig;
		$fileStrip =~ s/\(/+/ig;
		$fileStrip =~ s/\)/+/ig;
		$fileStrip =~ s/\[/+/ig;
		$fileStrip =~ s/\]/+/ig;
	
	$var = $fileStrip;

 return $var;

}

sub stripData {

$var = 0 ;

    my $fileStrip = $_[0];

		$fileStrip =~ s/\/(\d\d\d\d)//i;
	
	$var = $fileStrip;

 return $var;

}

sub invia {

my $global = '*html';
my $nftp = Net::FTP->new("$sftp", ,Port => $portaftp, Debug => 0) or sendraw ("PRIVMSG $channel Non riesco a connettere al server ftp\r\n");
$nftp->login ("$userftp","$passftp") or sendraw ("PRIVMSG $channel I dati per l'accesso ftp sono errati\! Verifica di averli inseriti in modo corretto.\r\n");
$nftp->cwd("".&getStatusFolder."") or sendraw ("PRIVMSG $channel Non posso accedere alla cartella $dir, verificare che il percorso sia corretto altrimenti tentare un mkdir <dir> e riprovare con l'invio del file\r\n");
our @remote_files = $nftp->ls($global);
foreach $remote_files (@remote_files) { $nftp->delete("$remote_files") or sendraw ("PRIVMSG $channel non riesco a cancellare il file $remtve_files -.-\r\n"); }
$nftp->put("lst.html") or sendraw ("PRIVMSG $channel non riesco ad uppare il file\r\n");
$nftp->put("news.html") or sendraw ("PRIVMSG $channel non riesco ad uppare il file\r\n");
$nftp->put("scaricati.html") or sendraw ("PRIVMSG $channel non riesco ad uppare il file\r\n");

for ($number = 1 ; $number <= &getBlocchi ; $number++) {

	$nomeVetrinaHtml= "".&getNomeVetrina($number).".html";
	$nomeVetrinaHtml =~ s/ /_/ig;

$nftp->put("$nomeVetrinaHtml") or sendraw ("PRIVMSG $channel non riesco ad uppare il file ".&getNomeVetrina($number).".html\r\n");

}

$nftp->quit;

}

# Auto-riconnessione
$irc_state = 0;
while($irc_state != 1)
{
    goto bot;
}