echo "DOWNLOADING TABLET-UI"
/opt/fhem/fhem.pl 7072 "update all https://raw.githubusercontent.com/knowthelist/fhem-tablet-ui/master/controls_fhemtabletui.txt"
echo "CONFIGURING TABLET-UI"
/opt/fhem/fhem.pl 7072 "define TABLETUI HTTPSRV ftui/ ./www/tablet Tablet-UI"
/opt/fhem/fhem.pl 7072 "attr WEB longpoll websocket"
echo "SAVING CONFIG"
/opt/fhem/fhem.pl 7072 "save"
echo "RESTARTING ..."
/opt/fhem/fhem.pl 7072 "shutdown restart"


