#!/opt/ActivePerl-5.10/bin/perl

######################################################
#	XDCCManage  PerlBot v1.1		     #
#	Coder: Greyback				     #
#	Support at: irc.chlame.net, #xdccmanage	     #
######################################################

#######################################################
# Caratteristiche				      #
# - Bot compatibile con xdccmanage v2 e v3	      #
# - Riconoscimento admin tramite login/logout	      #
# - Stampa vetrine a timer (regolabile)		      #
# - Elenco vetrine disponibili [!vetrine] (in canale) #
# - Stampa vetrina specifica su richiesta (in canale) #
# - Grado automatico al join delle shell	      #
# - Risposta al comando !list			      #
# - Comando !ultime in pubblica			      #
# - Mostra/Nascondi data in vetrina		      #
# - Mostra/Nascondi estensioni file		      #
# - Auto-join dopo il kick			      #
# - Colori output personalizzabili 		      #
# - Autoriconnessione in caso di caduta accidentale   #
# - Avviso in pvt in caso di nuova versione           #
#####################################################à#
 
#####################################################################
# Futuri aggiornamenti POTREBBERO includere le seguenti funzioni:   #
# - Retrocomaptibilità per xdccmanage v1	       	            #
# - Messaggio automatico al join				    #
# - Cambio Topic Automatico					    #
# - Ricerca di file direttamente dal canale			    #
# - ComingSoon e InSala (info su film in sala o in arrivo al cinema #		
# In quanto conforme al progetto di puccio, il mio script NON       #
# includerà (nè ora, nè in futuro) alcun sistema per monetizzare    #
#####################################################################

##############################################################################################################################
# - Il bot va inserito in una cartella sul dedicato assieme al .conf a proprio piacimento, dopo di che va avviato da user    #
# - NB: Non appena il bot si sarà connesso bisognerà loggarsi digitando in pvt:				                     #
#  !login pass     (Password precedentemente scritta nei settaggi)					    		     #
# - Una volta loggati lo si rimarrà finchè non si cambierà nick o finchè non si effettuerà il logout	  		     #
# - I comandi da admin funzionano esclusivamente in pvt ad esclusione del comando !esci (anche in pubblica) 		     #
# - Eventuali dipendenze sono facilmente installabili da cpan o con apt-get install [package] (apt-get install libwww-perl)  #
# - Lo sviluppo del bot richiede tempo e pazienza, ragion per cui lo farò nel tempo libero		   		     #
##############################################################################################################################

use threads;
use utf8;
use Cwd 'abs_path';
use IO::Socket;
use LWP::Simple;
my $pathBase = abs_path;
my $np = "xdccPerl";

#Parametri bot

restart:

##################################################################
# Nessuno può vietarti di modificare i crediti ma, sappi che, non
# alterarli è indice di rispetto nei confronti dello sviluppatore
# e soprattutto ricorda che attribuirsi del lavoro altrui è di una
# tristezza unica. ###############################################
								 
my $info = "4[8XDCCManage \© PerlBot By Greyback4]";     
my $versBot = "1.1";						   
my $logoBot = "4[8XDCCManage PerlBot v$versBot4]";  	 
utf8::decode($inf0);					    	 
##################################################################

my $nickBot = "";           
my $passNick = ""; #in caso di nick non registrato eliminare -> XDCCManage <- o sostituire il tutto con: -> my $passNick; <- 
my $net = ""; 
my $ircPort = 6667;
my $channel = "";
my $psswdAdmin = ""; #password login-bot
my $nickInizioShell = ""; #radice delle shell
my $grado = "+"; #grado delle shell (+ -> voice | % -> hop | @ -> op)

my $sito = ""; #inserire l'indirizzo dove è presente l'index.php (senza lo / finale)

#Parametri colori

my @colorNews = ('3', '4', '5', '6', '7', '8', '9', '10', '11', '12'); #colori delle novità
my $colorNameVet = 8; #colore nome vetrina
my $colorDate = 8; #colore della data
my $colorPar = 4; #colore parentesi

my $color1 = "13"; #colori delle stampe del bot
my $color2 = "";

#Begin Code
#da qui in poi non toccare nulla

$0="$np"."\0"x16;;
my $PID = fork;
exit if $PID;

my $timeSleep = 0.2;
my $pid = $$;

print "\n\nInizializzato...\n\nPID: $$\n\n";

&primoAvvioAssoluto;

$sock = IO::Socket::INET->new ( PeerHost => $net, PeerPort => $ircPort, Proto => "tcp" ) or goto restart;
print $sock "NICK $nickBot\r\n";
print $sock "USER BotPerl 0 * :$info\r\n";

my $tmpvar = 0;
while ( $ircmsg = <$sock> )
{
	$ircmsg =~ s/\r\n$//;

	if ($ircmsg =~ /.+00.+/ && !$tmpvar)
	{
		if (defined($passNick)) { print $sock "IDENTIFY $passNick\r\n"; }
		print $sock "MODE $nickBot +W\r\n";
		print $sock "MODE $nickBot +H\r\n";
		print $sock "JOIN $channel\r\n";
		&msg ("$channel", "${color1}X${color2}DCC${color1}M${color2}anage ${color1}P${color2}erl${color1}B${color2}ot ${color1}\©${color2} v$versBot ${color1}B${color2}y ${color1}G${color2}reyback ${color1}A${color2}vviato ${color1}C${color2}on ${color1}S${color2}uccesso");
		(threads->new(\&vetrine))->detach();
		$tmpvar = 1;
	}

	if ($ircmsg =~ /PING :(.+)/) { print $sock "PONG $1\r\n"; }

	if ($ircmsg =~ /:(.*)!.*KICK \#(.+) (.*) \:/) 
	{
		my $chanKick = "\#$2";
		my $nickKicked = $3;
        	if (uc($nickKicked) eq uc($nickBot)) 
		{
			if (uc($chanKick) eq uc($channel)) { sendraw ("JOIN $chanKick"); }
		}
	}

	if ( $ircmsg =~ /:(.+)!~{0,1}.+ JOIN :(.+)/i )
	{
		my $nickK = $1;
		my $chanN = $2;
		if (uc($chanN) eq uc($channel))
		{
			if ( &getStatusGrado =~ /on/i  )
			{
				if ( $nickK =~ m/$nickInizioShell\|/i )
				{
					if ( $grado =~ m/\+/i ) {
						sendraw ("MODE $chanN +v ${nickK}"); sleep 1;
					}
					if ( $grado =~ m/\%/i ) {
						sendraw ("MODE $chanN +h ${nickK}"); sleep 1;
					}
					if ( $grado =~ m/\@/i ) {
						sendraw ("MODE $chanN +o ${nickK}"); sleep 1;
					}
				}
			}
		}
	}

     	if ($ircmsg =~ /^\:(.+?)\!(.+?)\@(.+?) PRIVMSG (.+?) \:(.+)/) 
	{
		my ($nick,$ident,$host,$path,$msg) = ($1,$2,$3,$4,$5);

        	if ($msg =~ /^VERSION/) { sendraw ("NOTICE $nick :$info"); }

		if (uc($path) eq uc($nickBot) && &isAdmin($nick) && $msg =~ /^!help$/i)
		{
			&msg ("$nick", "${color1}X${color2}DCC${color1}M${color2}anage ${color1}H${color2}elp"); sleep 0.5;
			&msg ("$nick", "${color1}!L${color2}ogin ${color2}[${color1}P${color2}assword${color2}] ${color1}- ${color1}!L${color2}ogout${color1}:${color2} Identificazione/Logout Admins"); sleep 0.5;
			&msg ("$nick", "${color1}!L${color2}ista${color1}O${color2}n  ${color1}- ${color1}!L${color2}ista${color1}O${color2}ff${color1}:${color2} Attiva/Disattiva La Risposta Al Comando !list/!lista"); sleep 0.5;
			&msg ("$nick", "${color1}!T${color2}imer ${color2}[${color1}N${color2}um${color1}M${color2}inuti${color2}]${color1}:${color2} Imposta Il Timer Vetrine"); sleep 0.5;
			&msg ("$nick", "${color1}!E${color2}xt${color1}O${color2}n  ${color1}- ${color1}!E${color2}xt${color1}O${color2}ff${color1}:${color2} Attiva/Disattiva Le Estensioni Nelle Vetrine"); sleep 0.5;
			&msg ("$nick", "${color1}!G${color2}rado${color1}O${color2}n  ${color1}- ${color1}!G${color2}rado${color1}O${color2}ff${color1}:${color2} Attiva/Disattiva L'Autogrado Al Join Delle Shell"); sleep 0.5;
			&msg ("$nick", "${color1}!S${color2}tampa${color1}O${color2}n  ${color1}- ${color1}!S${color2}tampa${color1}O${color2}ff${color1}:${color2} Attiva/Disattiva Le Stampe Delle Vetrine"); sleep 0.5;
			&msg ("$nick", "${color1}!U${color2}ltime:${color2} Mostra Le Ultime Novità \(Comando Da Eseguire In Pubblica\)"); sleep 0.5;
			&msg ("$nick", "${color1}!V${color2}etrine:${color2} Mostra L'Elenco Delle Vetrine Disponibili"); sleep 0.5;
			&msg ("$nick", "${color1}!S${color2}tatus${color1}:${color2} Riepilogo Settaggi Bot"); sleep 0.5;
			&msg ("$nick", "${color1}!R${color2}eboot${color1}:${color2} Riavvia Il Bot"); sleep 0.5;
			&msg ("$nick", "${color1}!P${color2}id:${color2} Mostra Il Pid Del Bot"); sleep 0.5;
			&msg ("$nick", "${color1}!E${color2}sci${color1}:${color2} Quitta Il Bot");
		}

		if (uc($path) eq uc($nickBot) && &isAdmin($nick) && $msg =~ /^!ultimoMex$/i)
		{
			&stampaMex;
		}

		if (uc($path) eq uc($nickBot) && &isAdmin($nick) && $msg =~ /^!status$/i)
		{
			&msg ("$nick", "${color1}S${color2}tatus ${color1}X${color2}DCC${color1}M${color2}anage"); sleep 0.5;

			if (&getStatusList =~ /on/i)
			{
				&msg ("$nick", "${color1}C${color2}omando ${color1}!L${color2}ist ${color1}A${color2}ttivo"); sleep 0.5;
			} else {
				&msg ("$nick", "${color1}C${color2}omando ${color1}!L${color2}ist ${color1}N${color2}on ${color1}A${color2}ttivo"); sleep 0.5;
			}

			if (&getStatusStamp =~ /on/i)
			{
				my $realTimer = &getTimer / 60;
				&msg ("$nick", "${color1}S${color2}ampa ${color1}V${color2}etrine ${color1}A${color2}ttiva ${color2}[${color1}O${color2}gni${color1} ${realTimer} ${color1}M${color2}inuti]"); sleep 0.5;
			} else {
				&msg ("$nick", "${color1}S${color2}ampa ${color1}V${color2}etrine ${color1}N${color2}on ${color1}A${color2}ttiva"); sleep 0.5;
			}

			if (&getStatusEstensioni =~ /on/i)
			{
				&msg ("$nick", "${color1}E${color2}stensione ${color1}F${color2}ile ${color1}A${color2}ttiva"); sleep 0.5;
			} else {
				&msg ("$nick", "${color1}E${color2}stensione ${color1}F${color2}ile ${color1}N${color2}on ${color1}A${color2}ttiva"); sleep 0.5;
			}

			if (&getStatusData =~ /on/i)
			{
				&msg ("$nick", "${color1}D${color2}ata ${color1}V${color2}etrine ${color1}A${color2}ttiva"); sleep 0.5;
			} else {
				&msg ("$nick", "${color1}D${color2}ata ${color1}V${color2}etrine ${color1}N${color2}on ${color1}A${color2}ttiva"); sleep 0.5;
			}

			if (&getStatusGrado =~ /on/i)
			{
				&msg ("$nick", "${color1}A${color2}uto${color1}G${color2}rado ${color1}A${color2}ttivo");
			} else {
				&msg ("$nick", "${color1}A${color2}uto${color1}G${color2}rado ${color1}N${color2}on ${color1}A${color2}ttivo");
			}

		}

		if ((uc($path) eq uc($channel)) && &getStatusList =~ /on/i && $msg =~ /^!(list|lista)$/i)
		{
			&msg ("$channel", "${color2}[${color1}$nick${color2}] ${color1}P${color2}er ${color1}V${color2}isualizzare ${color1}L${color2}a ${color1}L${color2}ista${color1}: ${color2}${sito}");	
		}

		if ((uc($path) eq uc($channel)) && $msg =~ /^!ultime$/i)
		{
			my $linkConf = "$sito/vetrina.conf";
			my $fileConf = "vetrina.conf";
			my $res = mirror($linkConf, $fileConf);
			my $contatoreVet = 0;
			my $CC = 0;

			open(F, '< vetrina.conf');
			while ( <F> )
			{
				#($stringa) = m/(.+)\|\:(.+)\:/ ;
				if ($_ =~ /(.+)\|\:(.+)\:/)
				{
					my $vetrina = $1;
					my $files = $2;
					my $contatoreNews = 0;

					($sec,$min,$ore,$giom,$mese,$anno,$gios,$gioa,$oraleg) = localtime(time);
					my @abbr = qw( Gennaio Febbraio Marzo Aprile Maggio Giugno Luglio Agosto Settembre Ottobre Novembre Dicembre );
					my @abbr2 = qw( Domenica Lunedì Martedì Mercoledì Giovedì Venerdì Sabato );
					$anno += 1900;
					$dataOdierna = "$abbr2[$gios] $giom $abbr[$mese] $anno";

					if ($files =~ /(\d\d\d\d)\-(\d+)\-(\d+)\s(\d+)\-(\d+)\s\#\s(.+)/ && $contatoreVet == 0)
					{
						&msg ("$channel", "${colorPar}[${colorNameVet}".uc($channel)." Ultime Novità${colorPar}]"); $contatoreVet = 1; sleep $timeSleep;
					} elsif ($files !~ /\#/ && $contatoreVet == 0) 
					{
						if (&getStatusData =~ /on/i)
						{
							&msg ("$channel", "${colorPar}[${colorNameVet}".uc($channel)." Ultime Novità${colorPar}] ${colorDate}$dataOdierna"); $contatoreVet = 1; sleep $timeSleep;
						} else {
							&msg ("$channel", "${colorPar}[${colorNameVet}".uc($channel)." Ultime Novità${colorPar}]"); $contatoreVet = 1; sleep $timeSleep;
						}
					}
					@singleNews = split /:/, $files;

					foreach $a (@singleNews)
					{
						if ($a =~ /(\d\d\d\d)\-(\d+)\-(\d+)\s(\d+)\-(\d+)\s\#\s(.+)/ && $contatoreNews == 0)
						{
							$data = "$3\/$2";
							$file = $6 ;
							if (&getStatusEstensioni =~ /off/i) { $file = &strip($file); }
							if (&getStatusData =~ /on/i)
							{
								&msg ("$channel", "${colorPar}[${colorNameVet}${vetrina}${colorPar}]${colorPar}[${colorDate}${data}${colorPar}] $colorNews[$CC]${file}"); sleep $timeSleep;
							} else {
								&msg ("$channel", "${colorPar}[${colorNameVet}${vetrina}${colorPar}] $colorNews[$CC]${file}"); sleep $timeSleep;
							}
							$contatoreNews = 1;
						} 
						elsif ($a !~ /\#/ && $contatoreNews == 0) 
						{
							if (&getStatusEstensioni =~ /off/i) { $a = &strip($a); }	
							&msg ("$channel", "${colorPar}[${colorNameVet}${vetrina}${colorPar}] $colorNews[$CC]${a}"); sleep $timeSleep;
							$contatoreNews = 1;
						}	
					}
					if ($CC < $#colorNews) { $CC++; } else { $CC = 0; }
				}
			}
       			close(F);
			&msg ("$channel", "$logoBot");
			$indice = 0;
		}

		if ((uc($path) eq uc($channel)) && $msg =~ /^!vetrine$/i)
		{
			&msg ("$channel", "${color2}[${color1}$nick${color2}] ${color1}E${color2}cco ${color1}I ${color1}C${color2}omandi ${color1}P${color2}er ${color1}V${color2}isualizzare ${color1}L${color2}e ${color1}N${color2}ews");
			my $linkConf = "$sito/vetrina.conf";
			my $fileConf = "vetrina.conf";
			my $res = mirror($linkConf, $fileConf);
			my $CC = 0;
			my $paragone = $1;

			open(F, '< vetrina.conf');
			while ( <F> )
			{
				#($stringa) = m/(.+)\|\:(.+)\:/ ;
				if ($_ =~ /(.+)\|\:(.+)\:/)
				{
					my $vetrina = $1;
						&msg ("$channel", "${color1}!${color2}${vetrina}");
				}
			}
       			close(F);
		}

		if ((uc($path) eq uc($channel)) && $msg =~ /^!(.*)/i)
		{
			my $linkConf = "$sito/vetrina.conf";
			my $fileConf = "vetrina.conf";
			my $res = mirror($linkConf, $fileConf);
			my $CC = 0;
			my $paragone = $1;

			open(F, '< vetrina.conf');
			while ( <F> )
			{
				#($stringa) = m/(.+)\|\:(.+)\:/ ;
				if ($_ =~ /(.+)\|\:(.+)\:/)
				{
					my $vetrina = $1;
					if (uc($vetrina) eq uc($paragone))
					{
						my $files = $2;
						my $contatoreNews = 0;

						($sec,$min,$ore,$giom,$mese,$anno,$gios,$gioa,$oraleg) = localtime(time);
						my @abbr = qw( Gennaio Febbraio Marzo Aprile Maggio Giugno Luglio Agosto Settembre Ottobre Novembre Dicembre );
						my @abbr2 = qw( Domenica Lunedì Martedì Mercoledì Giovedì Venerdì Sabato );
						$anno += 1900;
						$dataOdierna = "$abbr2[$gios] $giom $abbr[$mese] $anno";

						if ($files =~ /(\d\d\d\d)\-(\d+)\-(\d+)\s(\d+)\-(\d+)\s\#\s(.+)/)
						{
							&msg ("$channel", "${colorPar}[${colorNameVet}".uc($channel)." Novità $vetrina${colorPar}]"); sleep $timeSleep;
						} elsif ($files !~ /\#/) 
						{
							if (&getStatusData =~ /on/i)
							{
								&msg ("$channel", "${colorPar}[${colorNameVet}".uc($channel)." Novità $vetrina${colorPar}] ${colorDate}$dataOdierna"); sleep $timeSleep;
							} else {
								&msg ("$channel", "${colorPar}[${colorNameVet}".uc($channel)." Novità $vetrina${colorPar}]"); sleep $timeSleep;
							}
						}
						@singleNews = split /:/, $files;

						foreach $a (@singleNews)
						{
							if ($a =~ /(\d\d\d\d)\-(\d+)\-(\d+)\s(\d+)\-(\d+)\s\#\s(.+)/)
							{
								$data = "$3\/$2";
								$file = $6 ;
								if (&getStatusEstensioni =~ /off/i) { $file = &strip($file); }
								if (&getStatusData =~ /on/i)
								{
									&msg ("$channel", "${colorPar}[${colorDate}${data}${colorPar}] $colorNews[$CC]${file}"); sleep $timeSleep;
									if ($CC < $#colorNews) { $CC++; } else { $CC = 0; }
								} else {
									&msg ("$channel", "$colorNews[$CC]${file}"); sleep $timeSleep;
									if ($CC < $#colorNews) { $CC++; } else { $CC = 0; }
								}
							} 
							elsif ($a !~ /\#/) 
							{
								if (&getStatusEstensioni =~ /off/i) { $a = &strip($a); }	
								&msg ("$channel", "$colorNews[$CC]${a}"); sleep $timeSleep;
								if ($CC < $#colorNews) { $CC++; } else { $CC = 0; }
							}	
						}
						&msg ("$channel", "$logoBot");
					}
				}
			}
       			close(F);
		}

		if (uc($path) eq uc($nickBot) && $msg =~ /^!login (.+)/i)
		{
			my $passDigit = $1;

			if (uc($passDigit) eq uc($psswdAdmin))
			{
				my $admin = $nick;
				my $flag = 0;

				my $fileId = open ( FILE, "< ${pathBase}/XDCCMANAGE/admin/admin.lst");
				while ( $riga = <FILE> )  {
					$riga = substr ($riga, 0, -1);
					if ( uc($riga) eq uc($admin) ) { $flag = 1; }
				}
				close(FILE);
				if ( $flag == 0 )
				{
					my $fileId = open ( FILE, ">> ${pathBase}/XDCCMANAGE/admin/admin.lst");
					print FILE "$admin\n";
					close(FILE);
					&msg ("$nick", "${color1}L${color2}ogin ${color1}E${color2}ffettuato ${color1}C${color2}on ${color1}S${color2}uccesso");
					&msg("$nick", "${color1}D${color2}igita ${color1}!H${color2}elp ${color1}P${color2}er ${color1}L'${color2}elenco ${color1}C${color2}omandi");
				} else {
					&msg ("$nick","${color1}E${color2}rror... ${color1}L${color2}ogin ${color1}G${color2}ia ${color1}E${color2}ffettuato");
				}
			} else {
				&msg ("$nick", "${color1}E${color2}rror... ${color1}P${color2}assword ${color1}E${color2}rrata");
			}
		}

		if (uc($path) eq uc($nickBot) && &isAdmin($nick) && $msg =~ /^!logout$/i)
		{
			my $flag = 0;
			my $admin = $nick ;
			{
				my $fileId = open ( FILE, "< ${pathBase}/XDCCMANAGE/admin/admin.lst");
				my $fileId2 = open ( FILE2, ">> ${pathBase}/XDCCMANAGE/admin/admin2.lst");
				while ( $riga = <FILE> )  {
					$riga = substr ($riga, 0, -1);
					if ( !(uc($riga) eq uc($admin)) ) { print FILE2 "$riga\n"; }
				}
				close(FILE);
				close(FILE2);
				&msg ("$nick", "${color1}L${color2}ogout ${color1}E${color2}ffettuato ${color1}C${color2}on ${color1}S${color2}uccesso");
				unlink("${pathBase}/XDCCMANAGE/admin/admin.lst");
				rename("${pathBase}/XDCCMANAGE/admin/admin2.lst", "${pathBase}/XDCCMANAGE/admin/admin.lst");
				unlink("${pathBase}/XDCCMANAGE/admin/admin2.lst");
			} 
		}

		if (uc($path) eq uc($nickBot) && &isAdmin($nick) && $msg =~ /^!timer (\d+)/i)
		{
			my $realTimer = int($1) * 60;
			my $timerDelay = int($1);

			if ($timerDelay >= 1)
			{
				unlink("${pathBase}/XDCCMANAGE/status/timer.db");
				my $fileId = open (FILE, ">> ${pathBase}/XDCCMANAGE/status/timer.db");
				print FILE "$realTimer\n";
				close(FILE);
				&msg ("$nick", "${color1}T${color2}imer ${color1}I${color2}mpostato:${color1} $timerDelay ${color1}M${color2}inuti");
			} else {
				&msg ("$nick", "${color1}E${color2}rror${color1}: ${color1}V${color2}alore ${color1}A${color2}l ${color1}D${color2}i ${color1}S${color2}otto ${color1}D${color2}el ${color1}M${color2}inuto, ${color1}R${color2}iprovare");
			}
		}

		if (uc($path) eq uc($nickBot) && &isAdmin($nick) && $msg =~ /^!listaOn$/i)
		{
			if (&getStatusList !~ /on/i) 
			{
				unlink("${pathBase}/XDCCMANAGE/status/list.state");
				my $fileId = open (FILE, ">> ${pathBase}/XDCCMANAGE/status/list.state");
				print FILE "on\n";
				close(FILE);
				&msg ("$nick", "${color1}C${color2}omando ${color1}!L${color2}ist${color1}: ${color1}A${color2}ttivato");
			} else {
				&msg ("$nick", "${color1}E${color2}rror${color1}: ${color1}C${color2}omando ${color1}G${color2}ià ${color1}A${color2}ttivato");
			}
		}

		if (uc($path) eq uc($nickBot) && &isAdmin($nick) && $msg =~ /^!listaOff$/i)
		{
			if (&getStatusList !~ /off/i) 
			{
				unlink("${pathBase}/XDCCMANAGE/status/list.state");
				my $fileId = open (FILE, ">> ${pathBase}/XDCCMANAGE/status/list.state");
				print FILE "off\n";
				close(FILE);
				&msg ("$nick", "${color1}C${color2}omando ${color1}!L${color2}ist${color1}: ${color1}D${color2}isattivato");
			} else {
				&msg ("$nick", "${color1}E${color2}rror${color1}: ${color1}C${color2}omando ${color1}G${color2}ià ${color1}D${color2}isattivato");
			}
		}

		if (uc($path) eq uc($nickBot) && &isAdmin($nick) && $msg =~ /^!extOn$/i)
		{
			if (&getStatusEstensioni !~ /on/i) 
			{
				unlink("${pathBase}/XDCCMANAGE/status/extension.state");
				my $fileId = open (FILE, ">> ${pathBase}/XDCCMANAGE/status/extension.state");
				print FILE "on\n";
				close(FILE);
				&msg ("$nick", "${color1}V${color2}isualizza ${color1}E${color2}stensioni${color1}: ${color1}A${color2}ttivato");
			} else {
				&msg ("$nick", "${color1}E${color2}rror${color1}: ${color1}E${color2}stensioni ${color1}G${color2}ià ${color1}A${color2}ttivate");
			}
		}

		if (uc($path) eq uc($nickBot) && &isAdmin($nick) && $msg =~ /^!extOff$/i)
		{
			if (&getStatusEstensioni !~ /off/i) 
			{
				unlink("${pathBase}/XDCCMANAGE/status/extension.state");
				my $fileId = open (FILE, ">> ${pathBase}/XDCCMANAGE/status/extension.state");
				print FILE "off\n";
				close(FILE);
				&msg ("$nick", "${color1}V${color2}isualizza ${color1}E${color2}stensioni${color1}: ${color1}D${color2}isattivato");
			} else {
				&msg ("$nick", "${color1}E${color2}rror${color1}: ${color1}E${color2}stensioni ${color1}G${color2}ià ${color1}D${color2}isattivate");
			}
		}

		if (uc($path) eq uc($nickBot) && &isAdmin($nick) && $msg =~ /^!gradoOn$/i)
		{
			if (&getStatusGrado !~ /on/i) 
			{
				unlink("${pathBase}/XDCCMANAGE/status/grade.state");
				my $fileId = open (FILE, ">> ${pathBase}/XDCCMANAGE/status/grade.state");
				print FILE "on\n";
				close(FILE);
				&msg ("$nick", "${color1}A${color2}uto${color1}G${color2}rado${color1}: ${color1}A${color2}ttivato");
			} else {
				&msg ("$nick", "${color1}E${color2}rror${color1}: ${color1}A${color2}uto${color1}G${color2}rado ${color1}G${color2}ià ${color1}A${color2}ttivato");
			}
		}

		if (uc($path) eq uc($nickBot) && &isAdmin($nick) && $msg =~ /^!gradoOff$/i)
		{
			if (&getStatusGrado !~ /off/i) 
			{
				unlink("${pathBase}/XDCCMANAGE/status/grade.state");
				my $fileId = open (FILE, ">> ${pathBase}/XDCCMANAGE/status/grade.state");
				print FILE "off\n";
				close(FILE);
				&msg ("$nick", "${color1}A${color2}uto${color1}G${color2}rado${color1}: ${color1}D${color2}isattivato");		
			} else {
				&msg ("$nick", "${color1}E${color2}rror${color1}: ${color1}A${color2}uto${color1}G${color2}rado ${color1}G${color2}ià ${color1}D${color2}isattivato");
			}
		}

		if (uc($path) eq uc($nickBot) && &isAdmin($nick) && $msg =~ /^!dataOn$/i)
		{
			if (&getStatusData !~ /on/i) 
			{
				unlink("${pathBase}/XDCCMANAGE/status/data.state");
				my $fileId = open (FILE, ">> ${pathBase}/XDCCMANAGE/status/data.state");
				print FILE "on\n";
				close(FILE);
				&msg ("$nick", "${color1}D${color2}ata: ${color1}A${color2}ttivata");
			} else {
				&msg ("$nick", "${color1}E${color2}rror${color1}: ${color1}D${color2}ata ${color1}G${color2}ià ${color1}A${color2}ttivata");
			}
		}

		if (uc($path) eq uc($nickBot) && &isAdmin($nick) && $msg =~ /^!dataOff$/i)
		{
			if (&getStatusData !~ /off/i) 
			{
				unlink("${pathBase}/XDCCMANAGE/status/data.state");
				my $fileId = open (FILE, ">> ${pathBase}/XDCCMANAGE/status/data.state");
				print FILE "off\n";
				close(FILE);
				&msg ("$nick", "${color1}D${color2}ata${color1}: ${color1}D${color2}isattivata");
			} else {
				&msg ("$nick", "${color1}E${color2}rror${color1}: ${color1}D${color2}ata ${color1}G${color2}ià ${color1}D${color2}isattivata");
			}		
		}

		if (uc($path) eq uc($nickBot) && &isAdmin($nick) && $msg =~ /^!stampaOn$/i)
		{
			if (&getStatusStamp !~ /on/i) 
			{
				if (&existAndSize("${pathBase}/XDCCMANAGE/status/timer.db"))
				{
					unlink("${pathBase}/XDCCMANAGE/status/stamp.state");
					my $fileId = open (FILE, ">> ${pathBase}/XDCCMANAGE/status/stamp.state");
					print FILE "on\n";
					close(FILE);
					&msg ("$nick", "${color1}S${color2}tampa ${color1}V${color2}etrine${color1}: ${color1}A${color2}ttivata");
					&msg ("$nick", "${color1}N${color2}B${color1}: ${color1}L${color2}e ${color1}V${color2}etrine ${color1}R${color2}esteranno ${color1}A${color2}ttive ${color1}A${color2}nche ${color1}R${color2}iavviando ${color1}I${color2}l ${color1}B${color2}ot (Partiranno In Automatico)");
					&msg ("$nick", "${color1}P${color2}er ${color1}D${color2}isattivarle ${color1}B${color2}asterà ${color1}D${color2}igitare${color1}: ${color1}!S${color2}tampa${color1}O${color2}ff");
				} else {
					&msg ("$nick", "${color1}E${color2}rrore${color1}: ${color1}I${color2}mpostare ${color1}P${color2}irima ${color1}I${color2}l ${color1}T${color2}imer (!timer [numMinuti])");
				}
			} else {
				&msg ("$nick", "${color1}E${color2}rror${color1}: ${color1}S${color2}tampa ${color1}V${color2}etrine ${color1}G${color2}ià ${color1}A${color2}ttivata");
			}
		}

		if (uc($path) eq uc($nickBot) && &isAdmin($nick) && $msg =~ /^!stampaOff$/i)
		{
			if (&getStatusStamp !~ /off/i) 
			{
				unlink("${pathBase}/XDCCMANAGE/status/stamp.state");
				my $fileId = open (FILE, ">> ${pathBase}/XDCCMANAGE/status/stamp.state");
				print FILE "off\n";
				close(FILE);
				&msg ("$nick", "${color1}S${color2}tampa ${color1}V${color2}etrine${color1}: ${color1}D${color2}isattivata");
			} else {
				&msg ("$nick", "${color1}E${color2}rror${color1}: ${color1}S${color2}tampa ${color1}V${color2}etrine ${color1}G${color2}ià ${color1}D${color2}isattivata");
			}
		}

		if (uc($path) eq uc($nickBot) && &isAdmin($nick) && $msg =~ /^!pid$/i)
		{
			&msg ("$nick", "${color1}P${color2}id${color1}: ${color1}$$");			
		}

		if (uc($path) eq uc($nickBot) && &isAdmin($nick) && $msg =~ /^!reboot$/i)
		{
			sendraw ("QUIT $info");
			chmod ("${pathBase}/XDCCMANAGE/");
			system ("perl support.pl");
         	} 

		if (&isAdmin($nick) && $msg =~ /^!esci$/i) 
		{
			sendraw ("QUIT $info");
			system("kill -USR1 `pidof $np`");
         	} 
	}
}

#Sottoprogrammi

sub msg
{
    return unless $#_ == 1;
    utf8::decode($_[1]);
    sendraw($sock, "PRIVMSG $_[0] :$_[1]");
}

sub sendraw
{
	if ($#_ == '1')
	{
		my $sock = $_[0];
    		print $sock "$_[1]\n";
    	} else  {
        	print $sock "$_[0]\n";
	}
}

sub isAdmin
{
	my $nick = shift;
	my $flagAdm = 0;
	my $fileId = open ( FILE, "< ${pathBase}/XDCCMANAGE/admin/admin.lst");
	while ( $riga = <FILE> )  {
		$riga = substr ($riga, 0, -1);
		if ( uc($riga) eq uc($nick) ) { $flagAdm = 1; }
	}
	close(FILE);
	return $flagAdm;
}

sub contattaAdmins 
{
	$mex = $_[0];
	my $fileId = open ( INFO, "< ${pathBase}/XDCCMANAGE/admin/admin.lst");
	@admins = <INFO>;
	close(INFO);
	for ( $i = 0 ; $i <= $#admins ; $i++ ) 
	{
		chomp $admins[$i];
		&msg ("$admins[$i]", "$mex"); sleep 0.5;
	}

}

sub existAndSize() 
{
	my $status = 0;
	my $file = $_[0];

	if (-s $file) {$status = 1;}
	return $status;
}

sub getStatusData
{
	my $fileId = open ( FILE, "< ${pathBase}/XDCCMANAGE/status/data.state");
	$statusData = <FILE>;
	return $statusData;
}

sub getStatusEstensioni
{
	my $fileId = open ( FILE, "< ${pathBase}/XDCCMANAGE/status/extension.state");
	$statusEstensioni = <FILE>;
	return $statusEstensioni;
}

sub getStatusGrado
{
	my $fileId = open ( FILE, "< ${pathBase}/XDCCMANAGE/status/grade.state");
	$statusGrado = <FILE>;
	return $statusGrado;
}

sub getStatusStamp
{
	my $fileId = open ( FILE, "< ${pathBase}/XDCCMANAGE/status/stamp.state");
	$statusStamp = <FILE>;
	return $statusStamp;
}

sub getStatusList
{
	my $fileId = open ( FILE, "< ${pathBase}/XDCCMANAGE/status/list.state");
	$statusList = <FILE>;
	return $statusList;
}

sub getTimer
{
	my $fileId = open ( FILE, "< ${pathBase}/XDCCMANAGE/status/timer.db");
	$timer = <FILE>;
	return $timer;
}

sub strip 
{
	$var = 0 ;

	my $fileStrip = $_[0];

	$fileStrip =~ s/\srar$//ig;
	$fileStrip =~ s/\savi$//ig;
	$fileStrip =~ s/\smp4$//ig;
	$fileStrip =~ s/\spdf$//ig;
	$fileStrip =~ s/\ssrt$//ig;
	$fileStrip =~ s/\smkv$//ig;
	$fileStrip =~ s/\szip$//ig;
	$fileStrip =~ s/\siso$//ig;
	$fileStrip =~ s/\stxt$//ig;
	$fileStrip =~ s/\spart$//gi;
	$fileStrip =~ s/\scd$//gi;
	
	$var = $fileStrip;

	return $var;

}

sub checkNewMessage
{
	my $messaggio = "";
	my $testoUltimo = "";	
	
	my $pagina = "http://xdccmanage.irclab.eu/messaggio.log";
	$req=HTTP::Request->new(GET=>$pagina);
	$ua=LWP::UserAgent->new;
	$ua->timeout(20);
	$res=$ua->request($req);
	if ( $res->is_success )
	{
		$result = $res->content;
		$result =~ m/(.+)/;
		$messaggio = $1;
	}
	undef($pagina);
	undef($req);
	undef($res);
	undef($ua);
	
	my $fileId = open ( FILE, "< ${pathBase}/XDCCMANAGE/status/messaggio.log" ); $testoUltimo = <FILE>; close(FILE);
	if ( uc($messaggio) ne uc($testoUltimo) )
	{
		&contattaAdmins ("${color1}H${color2}ai ${color1}U${color2}n ${color1}N${color2}uovo ${color1}M${color2}essaggio. ${color1}D${color2}igita ${color1}!ultimoMex P${color2}er ${color1}L${color2}eggerlo");
	}
}

sub stampaMex
{
	my $messaggio = "";
	
	my $pagina = "http://xdccmanage.irclab.eu/messaggio.log";
	$req=HTTP::Request->new(GET=>$pagina);
	$ua=LWP::UserAgent->new;
	$ua->timeout(20);
	$res=$ua->request($req);
	if ( $res->is_success )
	{
		$result = $res->content;
		$result =~ m/(.+)/;
		$messaggio = $1;
	}
	undef($pagina);
	undef($req);
	undef($res);
	undef($ua);
	
	&contattaAdmins("8$messaggio");
	
	unlink("${pathBase}/XDCCMANAGE/status/messaggio.log"); my $fileId = open ( FILE, ">> ${pathBase}/XDCCMANAGE/status/messaggio.log"); 
	print FILE $messaggio; close(FILE);
}

sub vetrine
{
	chdir ("${pathBase}/XDCCMANAGE/status");
	my $indice = 0;
	my $index = 0;
	my $totVet = 0;
	my $contatore = 1;
	
	while ( 1 )
	{
		sleep(5);

		$index++;

		if ( $index == 180 ) #180
		{
			&checkNewMessage;
			$index = 0;
		}

		if (&getStatusStamp =~ /on/i)
		{
			$indice++;

			if (($indice / 12) >= (&getTimer / 60)) 
			{
				my $linkConf = "$sito/vetrina.conf";
				my $fileConf = "vetrina.conf";
				my $res = mirror($linkConf, $fileConf);

				open(F, '< vetrina.conf');
				while ( <F> )
				{
					#($stringa) = m/(.+)\|\:(.+)\:/ ;
					if ($_ =~ /(.+)\|\:(.+)\:/)
					{
						$vetrina = $1;
						$files = $2;
						$totVet++;
						$CC = 0;
						if ($totVet == $contatore)
						{
							($sec,$min,$ore,$giom,$mese,$anno,$gios,$gioa,$oraleg) = localtime(time);
 							my @abbr = qw( Gennaio Febbraio Marzo Aprile Maggio Giugno Luglio Agosto Settembre Ottobre Novembre Dicembre );
 							my @abbr2 = qw( Domenica Lunedì Martedì Mercoledì Giovedì Venerdì Sabato );
 							$anno += 1900;
							$dataOdierna = "$abbr2[$gios] $giom $abbr[$mese] $anno";

							if ($files =~ /(\d\d\d\d)\-(\d+)\-(\d+)\s(\d+)\-(\d+)\s\#\s(.+)/)
							{
								&msg ("$channel", "${colorPar}[${colorNameVet}".uc($channel)." Novità $vetrina${colorPar}]"); sleep $timeSleep;
							} else {
								if (&getStatusData =~ /on/i)
								{
									&msg ("$channel", "${colorPar}[${colorNameVet}".uc($channel)." Novità $vetrina${colorPar}] ${colorDate}$dataOdierna"); sleep $timeSleep;
								} else {
									&msg ("$channel", "${colorPar}[${colorNameVet}".uc($channel)." Novità  $vetrina${colorPar}]"); sleep $timeSleep;
								}
							}
							@singleNews = split /:/, $files;

							foreach $a (@singleNews)
							{
								if ($a =~ /(\d\d\d\d)\-(\d+)\-(\d+)\s(\d+)\-(\d+)\s\#\s(.+)/)
								{
									$data = "$3\/$2";
									$file = $6 ;
									if (&getStatusEstensioni =~ /off/i) { $file = &strip($file); }
									if (&getStatusData =~ /on/i)
									{
										&msg ("$channel", "${colorPar}[${colorDate}${data}${colorPar}] $colorNews[$CC]${file}"); sleep $timeSleep;
									} else {
										&msg ("$channel", "$colorNews[$CC]${file}"); sleep $timeSleep;
									}
									if ($CC < $#colorNews) { $CC++; } else { $CC = 0; }
								} 
								elsif ($a !~ /\#/) 
								{
									if (&getStatusEstensioni =~ /off/i) { $a = &strip($a); }	
									&msg ("$channel", "$colorNews[$CC]${a}"); sleep $timeSleep;
									if ($CC < $#colorNews) { $CC++; } else { $CC = 0; }
								}	
							}
							&msg ("$channel", "$logoBot");
						}
					}
				}
       				close(F);
				$indice = 0;
				if ($contatore >= $totVet) { $contatore = 1 } else { $contatore++; }
				$totVet = 0;
			}
		}
	}
}

sub primoAvvioAssoluto
{
	$verifica = -e "${pathBase}/XDCCMANAGE";
	if ( !$verifica ) 
	{
		system('mkdir '.$pathBase.'/XDCCMANAGE/');
		system('mkdir '.$pathBase.'/XDCCMANAGE/admin/');
		system('mkdir '.$pathBase.'/XDCCMANAGE/status/');
		my $fileId = open ( FILE, ">> ${pathBase}/XDCCMANAGE/status/data.state");
		print FILE "on\n";
		close(FILE);
		my $fileId = open ( FILE, ">> ${pathBase}/XDCCMANAGE/status/extension.state");
		print FILE "off\n";
		close(FILE);
		my $fileId = open ( FILE, ">> ${pathBase}/XDCCMANAGE/status/grade.state");
		print FILE "on\n";
		close(FILE);
		my $fileId = open ( FILE, ">> ${pathBase}/XDCCMANAGE/status/stamp.state");
		print FILE "off\n";
		close(FILE);
		my $fileId = open ( FILE, ">> ${pathBase}/XDCCMANAGE/status/list.state");
		print FILE "on\n";
		close(FILE);

		unlink ("${pathBase}/XDCCMANAGE/support.pl");
		open ( FILE2, ">> ${pathBase}/XDCCMANAGE/support.pl"); 
		print FILE2 "#!/opt/ActivePerl-5.10/bin/perl\nmy \$np = \$ARGV[0]\;\nsystem(\"kill -USR1 \`pidof \$np\`\")\;\nchdir (\"${pathBase}\")\;\nsystem (\"perl xdccmanage.pl\")\;";
		close(FILE2);

	}
}

# Auto-riconnessione
$irc_state = 0;
while($irc_state != 1)
{
    goto restart;
}
