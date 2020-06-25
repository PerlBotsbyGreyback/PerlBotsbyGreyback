#!/usr/bin/perl
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

################################################  
use Socket;                                    #
use IO::Socket;                                #
use IO::Socket::INET;                          #
use IO::Select;                                #
################################################
#COMANDI ADMIN :
#!elenco
#!aggiungi
#!backup
#!del
#!add
#!esci
#!elenco
#
#
#
#
#


my $datetime = localtime;

my $ircserver   = "irc.irc-files.org";
my $ircport   	= "6667";
my $nickname  	= "BotKiller";
my $ident     	= "Killer";
my $channel   	= "#prova";
my $channeladd  = "#prova2";
my $admin    	= "Greyback";
my $admin2      = "admin2";
my $admin3      = "admin3";
my $admin4      = "admin4";
my $fullname  	= "Perl bot Killer";
my $identify    = "botkiller";
my $away        = "Bot Perl Killer codato da Greyabck";

our @bot        = "AnIme|Gto, AnIme|DragonBall";

my $vuoto       = "vu0t0";

my $utente1     = "vu0t0";
my $utente2     = "vu0t0";
my $utente3     = "vu0t0";
my $utente4     = "vu0t0";
my $utente5     = "vu0t0";
my $utente6     = "vu0t0";
my $utente7     = "vu0t0";
my $utente8     = "vu0t0";
my $utente9     = "vu0t0";
my $utente10    = "vu0t0";
my $utente11    = "vu0t0";
my $utente12    = "vu0t0";
my $utente13    = "vu0t0";
my $utente14    = "vu0t0";
my $utente15    = "vu0t0";
my $utente16    = "vu0t0";
my $utente17    = "vu0t0";
my $utente18    = "vu0t0";
my $utente19    = "vu0t0";
my $utente20    = "vu0t0";
my $utente21    = "vu0t0";
my $utente22    = "vu0t0";
my $utente23    = "vu0t0";
my $utente24    = "vu0t0";
my $utente25    = "vu0t0";
my $utente26    = "vu0t0";
my $utente27    = "vu0t0";
my $utente28    = "vu0t0";
my $utente29    = "vu0t0";
my $utente30    = "vu0t0";
my $utente31    = "vu0t0";
my $utente32    = "vu0t0";
my $utente33    = "vu0t0";
my $utente34    = "vu0t0";
my $utente35    = "vu0t0";
my $utente36    = "vu0t0";
my $utente37    = "vu0t0";
my $utente38    = "vu0t0";
my $utente39    = "vu0t0";
my $utente40    = "vu0t0";
my $utente41    = "vu0t0";
my $utente42    = "vu0t0";
my $utente43    = "vu0t0";
my $utente44    = "vu0t0";
my $utente45    = "vu0t0";
my $utente46    = "vu0t0";
my $utente47    = "vu0t0";
my $utente48    = "vu0t0";
my $utente49    = "vu0t0";
my $utente50    = "vu0t0";






bot:

my $np = 'PERLBOT_killer';


$ircserver = "$ARGV[0]" if $ARGV[0];
$0 = "$np"."\0" x 16;;
my $pid = fork;
exit if $pid;
die "\n[!] Qualcosa è andato storto !!!: $!\n\n" unless defined($pid);

our %irc_servers;
our %DCC;
my $dcc_sel = new IO::Select->new();
$sel_client = IO::Select->new();
sub sendraw {
    if ($#_ == '1') {
    my $socket = $_[0];
    print $socket "$_[1]\n";
    } else {
        print $IRC_cur_socket "$_[0]\n";
    }
}

sub connector {
    my $mynick = $_[0];
    my $ircserver_con = $_[1];
    my $ircport_con = $_[2];
    my $IRC_socket = IO::Socket::INET->new(Proto=>"tcp", PeerAddr=>"$ircserver_con", PeerPort=>$ircport_con) or return(1);
    if (defined($IRC_socket)) {
        $IRC_cur_socket = $IRC_socket;
        $IRC_socket->autoflush(1);
        $sel_client->add($IRC_socket);
		$irc_servers{$IRC_cur_socket}{'host'} = "$ircserver_con";
        $irc_servers{$IRC_cur_socket}{'port'} = "$ircport_con";
        $irc_servers{$IRC_cur_socket}{'nick'} = $mynick;
        $irc_servers{$IRC_cur_socket}{'myip'} = $IRC_socket->sockhost;
        nick("$mynick");
        my $versi   = "Perl bot List";
        sendraw("USER $ident ".$IRC_socket->sockhost." $ircserver_con :$versi");
        sleep (1);}}
sub parse {
    my $servarg = shift;
    if ($servarg =~ /^PING \:(.*)/) {
        sendraw("PONG :$1");
    }
    elsif ($servarg =~ /^\:(.+?)\!(.+?)\@(.+?)\s+NICK\s+\:(\S+)/i) {
        if (lc($1) eq lc($mynick)) {
            $mynick = $4;
            $irc_servers{$IRC_cur_socket}{'nick'} = $mynick;
        }
    }
    elsif ($servarg =~ m/^\:(.+?)\s+433/i) {
        nick("$mynick".int rand(1));
    }
    elsif ($servarg =~ m/^\:(.+?)\s+001\s+(\S+)\s/i) {
        $mynick = $2;
        $irc_servers{$IRC_cur_socket}{'nick'} = $mynick;
        $irc_servers{$IRC_cur_socket}{'nome'} = "$1";
        sendraw("MODE $mynick +I");
        sendraw("NS identify $identify");
        sendraw("OPER Greyback grey1990");
        sendraw("PART #irc-files");
        sendraw("PART #opers");
        sendraw("PART #vhost");
        sendraw("PART #services");
        sendraw("PART #irchelp");
        sendraw("JOIN $channel");
	sendraw("away $away");
        sendraw("NICK $nickname");
        sendraw("PRIVMSG $channel :4Bot Killer Pronto!!!");
    }
}
my $line_temp;
while( 1 ) {
    while (!(keys(%irc_servers))) { &connector("$nickname", "$ircserver", "$ircport"); }
    select(undef, undef, undef, 0.01);;
    delete($irc_servers{''}) if (defined($irc_servers{''}));
    my @ready = $sel_client->can_read(0);
    next unless(@ready);
    foreach $fh (@ready) {
        $IRC_cur_socket = $fh;
        $mynick = $irc_servers{$IRC_cur_socket}{'nick'};
        $nread = sysread($fh, $ircmsg, 4096);
        if ($nread == 0) {
            $sel_client->remove($fh);
            $fh->close;
            delete($irc_servers{$fh});
        }
        @lines = split (/\n/, $ircmsg);
        $ircmsg =~ s/\r\n$//;

     if ($ircmsg =~ /:(.*)!.*KICK/) {
        sendraw("JOIN $channel");
}

     if ($ircmsg =~ /:(.*)!.*JOIN/) {
        if ($1 eq $utente1 || $1 eq $utente2 || $1 eq $utente3 || $1 eq $utente4 || $1 eq $utente5 || $1 eq $utente6 || $1 eq $utente7 || $1 eq $utente8 || $1 eq $utente9 || $1 eq $utente10 || $1 eq $utente11 || $1 eq $utente12 || $1 eq $utente13 || $1 eq $utente14 || $1 eq $utente15 || $1 eq $utente16 ||$1 eq $utente17 || $1 eq $utente18 || $1 eq $utente18 || $1 eq $utente19 || $1 eq $utente20 || $1 eq $utente21 || $1 eq $utente22 || $1 eq $utente23 || $1 eq $utente24 || $1 eq $utente25 || $1 eq $utente26 || $1 eq $utente27 || $1 eq $utente28 || $1 eq $utente29 || $1 eq $utente30 || $1 eq $utente31 || $1 eq $utente32 || $1 eq $utente33 || $1 eq $utente34 || $1 eq $utente35 || $1 eq $utente36 || $1 eq $utente37  || $1 eq $utente39 || $1 eq $utente40 || $1 eq $utente41 || $1 eq $utente42 || $1 eq $utente43 || $1 eq $utente44 || $1 eq $utente45 || $1 eq $utente46 || $1 eq $utente47 || $1 eq $utente48 || $1 eq $utente49 || $1 eq $utente50 || $1 eq @bot || $1 eq $nickname || $1 eq $admin) { 
           &msg ("$channel", "Benvenuto $1!");  
            }

   else {
          sendraw("MODE $channel +b $1");
          sendraw("KICK $channel $1 Non sei autorizzato ad entrare in questo canale. Enra su #prova2 per avere l'autorizzazione"); sleep(2);
          sendraw("MODE $channel -b $1");
        }
}


     if ($ircmsg =~ /:(.*) NOTICE (.*) :\*\*\* (.+?) (.*)did a \/whois on you/) {
        sendraw("NOTICE $3 Ciao $3 sono un bot perl codato da Greyback, per info contatta il founder.");
       }


     if ($ircmsg =~ /^\:(.+?)\!(.+?)\@(.+?) PRIVMSG (.+?) \:(.+)/) {
            my ($nick,$ident,$host,$path,$msg) = ($1,$2,$3,$4,$5);

                if (($path eq $mynick) && &isAdmin($nick) && $msg =~ /^!nick (.+)/i) {
                    sendraw("NICK ".$1);
                }

                if ($msg =~ /^TIME/) {
                    sendraw("NOTICE $nick :TIME ".$datetime."");
                }

                if ($msg =~ /^VERSION/) {
                    sendraw("NOTICE $nick :4,12Perl bot Killer By Greyback");
                }
                if (($path eq $mynick) && &isAdmin($nick) && $msg =~ /^!bot/i) {
                    &msg ("$nick", "Lista bot: @bot");
                }
                if (($path eq $mynick) && &isAdmin($nick) && $msg =~ /^!elenco/i) {
                    &msg ("$nick", "Lista utenti: $utente1, $utente2, $utente3, $utente4, $utente5, $utente6, $utente7, $utente8, $utente9, $utente10, $utente11, $utente12, $utente13, $utente14, $utente15, $utente16, $utente17, $utente18, $utente19, $utente20, $utente21, $utente22, $utente23, $utente24, $utente25, $utente26, $utente27, $utente28, $utente29, $utente30, $utente31, $utente32, $utente33, $utente34, $utente35, $utente36, $utente37, $utente38, $utente39, $utente40, $utente41, $utente42, $utente43, $utente44, $utente45, $utente46, $utente47, $utente48, $utente49, $utente50.");
                }
                if (($path eq $mynick) && &isAdmin($nick) && $msg =~ /^!aggiungi (.+)/) {
                     unshift @bot, $1;
                    &msg ("$nick", "$nick il bot $1 è stato aggiunto correttamente alla lista.");
                }
               

if (&isAdmin($nick) && $msg=~/^!backup/){

  system("rm -r utenti.db");

  if (my $pid = fork) {
    waitpid($pid, 0);
  }
  else {
    if (fork) {
      exit;
    }
    else {
      open(SUKA, '>>', "utenti.db");
      print SUKA "$utente1, $utente2, $utente3, $utente4, $utente5, $utente6, $utente7, $utente8, $utente9, $utente10, $utente11, $utente12, $utente13, $utente14, $utente15, $utente16, $utente17, $utente18, $utente19, $utente20, $utente21, $utente22, $utente23, $utente24, $utente25, $utente26, $utente27, $utente28, $utente29, $utente30, $utente31, $utente32, $utente33, $utente34, $utente35, $utente36, $utente37, $utente38, $utente39, $utente40, $utente41, $utente42, $utente43, $utente44, $utente45, $utente46, $utente47, $utente48, $utente49, $utente50.";
      close (SUKA);

   &msg ("$nick", "87Backup effettuato correttamente!");

exit;
    }
  }
}



                if (($path eq $mynick) && &isAdmin($nick) && $msg =~ /^!add (.+)/i) {

                                    if ($1 eq $utente1 || $1 eq $utente2 || $1 eq $utente3|| $1 eq $utente4 || $1 eq $utente5 || $1 eq $utente6 || $1 eq $utente7 || $1 eq $utente8 || $1 eq $utente9 || $1 eq $utente10 || $1 eq $utente11 || $1 eq $utente12 || $1 eq $utente13 || $1 eq $utente14 || $1 eq $utente15 || $1 eq $utente16 ||$1 eq $utente17 || $1 eq $utente18 || $1 eq $utente18 || $1 eq $utente19 || $1 eq $utente20 || $1 eq $utente21 || $1 eq $utente22 || $1 eq $utente23 || $1 eq $utente24 || $1 eq $utente25 || $1 eq $utente26 || $1 eq $utente27 || $1 eq $utente28 || $1 eq $utente29 || $1 eq $utente30 || $1 eq $utente31 || $1 eq $utente32 || $1 eq $utente33 || $1 eq $utente34 || $1 eq $utente35 || $1 eq $utente36 || $1 eq $utente37  || $1 eq $utente39 || $1 eq $utente40 || $1 eq $utente41 || $1 eq $utente42 || $1 eq $utente43 || $1 eq $utente44 || $1 eq $utente45 || $1 eq $utente46 || $1 eq $utente47 || $1 eq $utente48 || $1 eq $utente49 || $1 eq $utente50 ) {
                                    &msg ("$nick", "Errore: nick già presente nel database!");
                                    }

                                    elsif ($utente1 eq $vuoto) {
                                    $utente1 = $1;
                                    &msg ("$nick", "$utente1 aggiunto correttamente.");
                                    }
                                    elsif ($utente2 eq $vuoto) {
                                    $utente2 = $1;
                                    &msg ("$nick", "$utente2 aggiunto correttamente.");
                                          }
                                    elsif ($utente3 eq $vuoto) {
                                    $utente3 = $1;
                                    &msg ("$nick", "$utente3 aggiunto correttamente.");
                                          }
                                    elsif ($utente4 eq $vuoto) {
                                    $utente4 = $1;
                                    &msg ("$nick", "$utente4 aggiunto correttamente.");
                                          }
                                    elsif ($utente5 eq $vuoto) {
                                    $utente5 = $1;
                                    &msg ("$nick", "$utente5 aggiunto correttamente.");
                                          }
                                    elsif ($utente6 eq $vuoto) {
                                    $utente6 = $1;
                                    &msg ("$nick", "$utente6 aggiunto correttamente.");
                                          }
                                    elsif ($utente7 eq $vuoto) {
                                    $utente7 = $1;
                                    &msg ("$nick", "$utente7 aggiunto correttamente.");
                                          }
                                    elsif ($utente8 eq $vuoto) {
                                    $utente8 = $1;
                                    &msg ("$nick", "$utente8 aggiunto correttamente.");
                                          }
                                    elsif ($utente9 eq $vuoto) {
                                    $utente9 = $1;
                                    &msg ("$nick", "$utente9 aggiunto correttamente.");
                                          }
                                    elsif ($utente10 eq $vuoto) {
                                    $utente10 = $1;
                                    &msg ("$nick", "$utente10 aggiunto correttamente.");
                                          }
                                    elsif ($utente11 eq $vuoto) {
                                    $utente11 = $1;
                                    &msg ("$nick", "$utente11 aggiunto correttamente.");
                                          }
                                    elsif ($utente12 eq $vuoto) {
                                    $utente12 = $1;
                                    &msg ("$nick", "$utente12 aggiunto correttamente.");
                                          }
                                    elsif ($utente13 eq $vuoto) {
                                    $utente13 = $1;
                                    &msg ("$nick", "$utente13 aggiunto correttamente.");
                                          }
                                    elsif ($utente14 eq $vuoto) {
                                    $utente14 = $1;
                                    &msg ("$nick", "$utente14 aggiunto correttamente.");
                                          }
                                    elsif ($utente15 eq $vuoto) {
                                    $utente15 = $1;
                                    &msg ("$nick", "$utente15 aggiunto correttamente.");
                                          }
                                    elsif ($utente16 eq $vuoto) {
                                    $utente16 = $1;
                                    &msg ("$nick", "$utente16 aggiunto correttamente.");
                                          }
                                    elsif ($utente17 eq $vuoto) {
                                    $utente17 = $1;
                                    &msg ("$nick", "$utente17 aggiunto correttamente.");
                                          }
                                    elsif ($utente18 eq $vuoto) {
                                    $utente18 = $1;
                                    &msg ("$nick", "$utente18 aggiunto correttamente.");
                                          }
                                    elsif ($utente19 eq $vuoto) {
                                    $utente19 = $1;
                                    &msg ("$nick", "$utente19 aggiunto correttamente.");
                                          }
                                    elsif ($utente20 eq $vuoto) {
                                    $utente20 = $1;
                                    &msg ("$nick", "$utente20 aggiunto correttamente.");
                                          }
                                    elsif ($utente21 eq $vuoto) {
                                    $utente21 = $1;
                                    &msg ("$nick", "$utente21 aggiunto correttamente.");
                                          }
                                    elsif ($utente22 eq $vuoto) {
                                    $utente22 = $1;
                                    &msg ("$nick", "$utente22 aggiunto correttamente.");
                                          }
                                    elsif ($utente23 eq $vuoto) {
                                    $utente23 = $1;
                                    &msg ("$nick", "$utente23 aggiunto correttamente.");
                                          }
                                    elsif ($utente24 eq $vuoto) {
                                    $utente24 = $1;
                                    &msg ("$nick", "$utente24 aggiunto correttamente.");
                                          }
                                    elsif ($utente25 eq $vuoto) {
                                    $utente25 = $1;
                                    &msg ("$nick", "$utente25 aggiunto correttamente.");
                                          }
                                    elsif ($utente26 eq $vuoto) {
                                    $utente26 = $1;
                                    &msg ("$nick", "$utente26 aggiunto correttamente.");
                                          }
                                    elsif ($utente27 eq $vuoto) {
                                    $utente27 = $1;
                                    &msg ("$nick", "$utente27 aggiunto correttamente.");
                                          }
                                    elsif ($utente28 eq $vuoto) {
                                    $utente28 = $1;
                                    &msg ("$nick", "$utente28 aggiunto correttamente.");
                                          }
                                    elsif ($utente29 eq $vuoto) {
                                    $utente29 = $1;
                                    &msg ("$nick", "$utente29 aggiunto correttamente.");
                                          }
                                    elsif ($utente30 eq $vuoto) {
                                    $utente30 = $1;
                                    &msg ("$nick", "$utente30 aggiunto correttamente.");
                                          }
                                    elsif ($utente31 eq $vuoto) {
                                    $utente31 = $1;
                                    &msg ("$nick", "$utente31 aggiunto correttamente.");
                                          }
                                    elsif ($utente32 eq $vuoto) {
                                    $utente32 = $1;
                                    &msg ("$nick", "$utente32 aggiunto correttamente.");
                                          }
                                    elsif ($utente33 eq $vuoto) {
                                    $utente33 = $1;
                                    &msg ("$nick", "$utente33 aggiunto correttamente.");
                                          }
                                    elsif ($utente34 eq $vuoto) {
                                    $utente34 = $1;
                                    &msg ("$nick", "$utente34 aggiunto correttamente.");
                                          }
                                    elsif ($utente35 eq $vuoto) {
                                    $utente35 = $1;
                                    &msg ("$nick", "$utente35 aggiunto correttamente.");
                                          }
                                    elsif ($utente36 eq $vuoto) {
                                    $utente36 = $1;
                                    &msg ("$nick", "$utente36 aggiunto correttamente.");
                                          }
                                    elsif ($utente37 eq $vuoto) {
                                    $utente37 = $1;
                                    &msg ("$nick", "$utente37 aggiunto correttamente.");
                                          }
                                    elsif ($utente38 eq $vuoto) {
                                    $utente38 = $1;
                                    &msg ("$nick", "$utente38 aggiunto correttamente.");
                                          }
                                    elsif ($utente39 eq $vuoto) {
                                    $utente39 = $1;
                                    &msg ("$nick", "$utente39 aggiunto correttamente.");
                                          }
                                    elsif ($utente40 eq $vuoto) {
                                    $utente40 = $1;
                                    &msg ("$nick", "$utente40 aggiunto correttamente.");
                                          }
                                    elsif ($utente41 eq $vuoto) {
                                    $utente41 = $1;
                                    &msg ("$nick", "$utente41 aggiunto correttamente.");
                                          }
                                    elsif ($utente42 eq $vuoto) {
                                    $utente42 = $1;
                                    &msg ("$nick", "$utente42 aggiunto correttamente.");
                                          }
                                    elsif ($utente43 eq $vuoto) {
                                    $utente43 = $1;
                                    &msg ("$nick", "$utente43 aggiunto correttamente.");
                                          }
                                    elsif ($utente44 eq $vuoto) {
                                    $utente44 = $1;
                                    &msg ("$nick", "$utente44 aggiunto correttamente.");
                                          }
                                    elsif ($utente45 eq $vuoto) {
                                    $utente45 = $1;
                                    &msg ("$nick", "$utente45 aggiunto correttamente.");
                                          }
                                    elsif ($utente46 eq $vuoto) {
                                    $utente46 = $1;
                                    &msg ("$nick", "$utente46 aggiunto correttamente.");
                                          }
                                    elsif ($utente47 eq $vuoto) {
                                    $utente47 = $1;
                                    &msg ("$nick", "$utente47 aggiunto correttamente.");
                                          }
                                    elsif ($utente48 eq $vuoto) {
                                    $utente48 = $1;
                                    &msg ("$nick", "$utente48 aggiunto correttamente.");
                                          }
                                    elsif ($utente49 eq $vuoto) {
                                    $utente49 = $1;
                                    &msg ("$nick", "$utente49 aggiunto correttamente.");
                                          }
                                    elsif ($utente50 eq $vuoto) {
                                    $utente50 = $1;
                                    &msg ("$nick", "$utente50 aggiunto correttamente.");
                                          }



                            }

                if (($path eq $mynick) && &isAdmin($nick) && $msg =~ /^!del (.+)/) {

                                    if ($utente1 eq $1) {
                                    &msg ("$nick", "$utente1 rimosso correttamente.");
                                    $utente1 = $vuoto;
                                    sendraw("KICK $channel $1");
                                    }
                                    elsif ($utente2 eq $1) {
                                    &msg ("$nick", "$utente2 rimosso correttamente.");
                                    $utente2 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente3 eq $1) {
                                    &msg ("$nick", "$utente3 rimosso correttamente.");
                                    $utente3 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente4 eq $1) {
                                    &msg ("$nick", "$utente4 rimosso correttamente.");
                                    $utente4 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente5 eq $1) {
                                    &msg ("$nick", "$utente5 rimosso correttamente.");
                                    $utente5 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente6 eq $1) {
                                    &msg ("$nick", "$utente6 rimosso correttamente.");
                                    $utente6 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente7 eq $1) {
                                    &msg ("$nick", "$utente7 rimosso correttamente.");
                                    $utente7 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente8 eq $1) {
                                    &msg ("$nick", "$utente8 rimosso correttamente.");
                                    $utente8 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente9 eq $1) {
                                    &msg ("$nick", "$utente9 rimosso correttamente.");
                                    $utente9 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente10 eq $1) {
                                    &msg ("$nick", "$utente10 rimosso correttamente.");
                                    $utente10 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente11 eq $1) {
                                    &msg ("$nick", "$utente11 rimosso correttamente.");
                                    $utente11 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente12 eq $1) {
                                    &msg ("$nick", "$utente12 rimosso correttamente.");
                                    $utente12 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente13 eq $1) {
                                    &msg ("$nick", "$utente13 rimosso correttamente.");
                                    $utente13 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente14 eq $1) {
                                    &msg ("$nick", "$utente14 rimosso correttamente.");
                                    $utente14 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente15 eq $1) {
                                    &msg ("$nick", "$utente15 rimosso correttamente.");
                                    $utente15 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente16 eq $1) {
                                    &msg ("$nick", "$utente16 rimosso correttamente.");
                                    $utente16 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente17 eq $1) {
                                    &msg ("$nick", "$utente17 rimosso correttamente.");
                                    $utente17 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente18 eq $1) {
                                    &msg ("$nick", "$utente18 rimosso correttamente.");
                                    $utente18 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente19 eq $1) {
                                    &msg ("$nick", "$utente19 rimosso correttamente.");
                                    $utente19 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente20 eq $1) {
                                    &msg ("$nick", "$utente20 rimosso correttamente.");
                                    $utente20 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente21 eq $1) {
                                    &msg ("$nick", "$utente21 rimosso correttamente.");
                                    $utente21 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente22 eq $1) {
                                    &msg ("$nick", "$utente22 rimosso correttamente.");
                                    $utente22 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente23 eq $1) {
                                    &msg ("$nick", "$utente23 rimosso correttamente.");
                                    $utente23 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente24 eq $1) {
                                    &msg ("$nick", "$utente24 rimosso correttamente.");
                                    $utente24 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente25 eq $1) {
                                    &msg ("$nick", "$utente25 rimosso correttamente.");
                                    $utente25 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente26 eq $1) {
                                    &msg ("$nick", "$utente26 rimosso correttamente.");
                                    $utente26 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente27 eq $1) {
                                    &msg ("$nick", "$utente27 rimosso correttamente.");
                                    $utente27 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente28 eq $1) {
                                    &msg ("$nick", "$utente28 rimosso correttamente.");
                                    $utente28 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente29 eq $1) {
                                    &msg ("$nick", "$utente29 rimosso correttamente.");
                                    $utente29 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente30 eq $1) {
                                    &msg ("$nick", "$utente30 rimosso correttamente.");
                                    $utente30 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente31 eq $1) {
                                    &msg ("$nick", "$utente31 rimosso correttamente.");
                                    $utente31 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente32 eq $1) {
                                    &msg ("$nick", "$utente32 rimosso correttamente.");
                                    $utente32 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente33 eq $1) {
                                    &msg ("$nick", "$utente33 rimosso correttamente.");
                                    $utente33 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente34 eq $1) {
                                    &msg ("$nick", "$utente34 rimosso correttamente.");
                                    $utente34 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente35 eq $1) {
                                    &msg ("$nick", "$utente35 rimosso correttamente.");
                                    $utente35 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente36 eq $1) {
                                    &msg ("$nick", "$utente36 rimosso correttamente.");
                                    $utente36 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente37 eq $1) {
                                    &msg ("$nick", "$utente37 rimosso correttamente.");
                                    $utente37 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente38 eq $1) {
                                    &msg ("$nick", "$utente38 rimosso correttamente.");
                                    $utente38 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente39 eq $1) {
                                    &msg ("$nick", "$utente39 rimosso correttamente.");
                                    $utente39 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente40 eq $1) {
                                    &msg ("$nick", "$utente40 rimosso correttamente.");
                                    $utente40 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente41 eq $1) {
                                    &msg ("$nick", "$utente41 rimosso correttamente.");
                                    $utente41 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente42 eq $1) {
                                    &msg ("$nick", "$utente42 rimosso correttamente.");
                                    $utente42 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente43 eq $1) {
                                    &msg ("$nick", "$utente43 rimosso correttamente.");
                                    $utente43 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente44 eq $1) {
                                    &msg ("$nick", "$utente44 rimosso correttamente.");
                                    $utente44 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente45 eq $1) {
                                    &msg ("$nick", "$utente45 rimosso correttamente.");
                                    $utente45 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente46 eq $1) {
                                    &msg ("$nick", "$utente46 rimosso correttamente.");
                                    $utente46 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente47 eq $1) {
                                    &msg ("$nick", "$utente47 rimosso correttamente.");
                                    $utente47 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente48 eq $1) {
                                    &msg ("$nick", "$utente48 rimosso correttamente.");
                                    $utente48 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente49 eq $1) {
                                    &msg ("$nick", "$utente49 rimosso correttamente.");
                                    $utente49 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    elsif ($utente50 eq $1) {
                                    &msg ("$nick", "$utente50 rimosso correttamente.");
                                    $utente50 = $vuoto;
                                    sendraw("KICK $channel $1");
                                          }
                                    else {
                                    &msg ("$nick", "Errore: nick non presente nel database!");
                                         }
                     }

        if (&isAdmin($nick) && $msg =~ /^!esci/) {
        sendraw("QUIT 4Free Tools 19By Greyback");
        system("kill -USR1 `pidof PERLBOT_killer`");
   } 
         				
            
        }

        for(my $c=0; $c<= $#lines; $c++) {
            $line = $lines[$c];
            $line = $line_temp.$line if ($line_temp);
            $line_temp = '';
            $line =~ s/\r$//;
            unless ($c == $#lines) {
                &parse("$line");
            } else {
                if ($#lines == 0) {
                    &parse("$line");
                } elsif ($lines[$c] =~ /\r$/) {
                    &parse("$line");
                } elsif ($line =~ /^(\S+) NOTICE AUTH :\*\*\*/) {
                    &parse("$line");
                } else {
                    $line_temp = $line;
                }
            }
        }
    }
}





sub shell() {
    my $path = $_[0];
    my $cmd = $_[1];
    if ($cmd =~ /cd (.*)/) {
        chdir("$1") || &msg("$path","4,1No such file or directory");
        return;
    }
    elsif ($pid = fork) { waitpid($pid, 0); }
    else { if (fork) { exit; } else {
        my @output = `$cmd 2>&1 3>&1`;
        my $c = 0;
        foreach my $output (@output) {
            $c++;
            chop $output;
            &msg("$path","$output");
            if ($c == 5) { $c = 0; sleep 2; }
        }
        exit;
    }}
}

sub isAdmin() {
    my $status = 0;
    my $nick = $_[0];
    if ($nick eq $admin || $nick eq $admin2 || $nick eq $admin3 || $nick eq $admin4 || $nick eq $admin5 || $nick eq $admin6) { $status = 1; }
    return $status;
}

sub msg() {
    return unless $#_ == 1;
    sendraw($IRC_cur_socket, "PRIVMSG $_[0] :$_[1]");
}

sub nick() {
    return unless $#_ == 0;
    sendraw("NICK $_[0]");
}

sub notice() {
    return unless $#_ == 1;
    sendraw("NOTICE $_[0] :$_[1]");
}



$irc_state = 0;
while($irc_state != 1)
{
    goto bot;
}


