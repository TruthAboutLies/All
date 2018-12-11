#!/usr/bin/env bash

clear &

echo -ne "\e[8;19;77t"

tput bold; tput setaf 11;
function detect_gnome()
{
    ps -e | grep -E '^.* gnome-session$' > /dev/null
    if [ $? -ne 0 ];
    then
    return 0
    fi
    VERSION=`gnome-session --version | awk '{print $2}'`
    DESKTOP="GNOME"
    return 1
}

function detect_kde()
{
    ps -e | grep -E '^.* kded4$' > /dev/null
    if [ $? -ne 0 ];
    then
        return 0
    else    
        VERSION=`kded4 --version | grep -m 1 'KDE' | awk -F ':' '{print $2}' | awk '{print $1}'`
        DESKTOP="KDE"
        return 1
    fi
}

function detect_unity()
{
    ps -e | grep -E 'unity-panel' > /dev/null
    if [ $? -ne 0 ];
    then
    return 0
    fi
    VERSION=`unity --version | awk '{print $2}'`
    DESKTOP="UNITY"
    return 1
}

function detect_xfce()
{
    ps -e | grep -E '^.* xfce4-session$' > /dev/null
    if [ $? -ne 0 ];
    then
    return 0
    fi
    VERSION=`xfce4-session --version | grep xfce4-session | awk '{print $2}'`
    DESKTOP="XFCE"
    return 1
}

function detect_cinnamon()
{
    ps -e | grep -E '^.* cinnamon$' > /dev/null
    if [ $? -ne 0 ];
    then
    return 0
    fi
    VERSION=`cinnamon --version | awk '{print $2}'`
    DESKTOP="CINNAMON"
    return 1
}

function detect_mate()
{
    ps -e | grep -E '^.* mate-panel$' > /dev/null
    if [ $? -ne 0 ];
    then
    return 0
    fi
    VERSION=`mate-about --version | awk '{print $4}'`
    DESKTOP="MATE"
    return 1
}

function detect_lxde()
{
    ps -e | grep -E '^.* lxsession$' > /dev/null
    if [ $? -ne 0 ];
    then
    return 0
    fi

    # We can detect LXDE version only thru package manager
    which apt-cache > /dev/null 2> /dev/null
    if [ $? -ne 0 ];
    then
    which yum > /dev/null 2> /dev/null
    if [ $? -ne 0 ];
    then
        VERSION='UNKNOWN'
    else
        # For Fedora
        VERSION=`yum list lxde-common | grep lxde-common | awk '{print $2}' | awk -F '-' '{print $1}'`
    fi
    else    
    # For Lubuntu and Knoppix
    VERSION=`apt-cache show lxde-common /| grep 'Version:' | awk '{print $2}' | awk -F '-' '{print $1}'`
    fi
    DESKTOP="LXDE"
    return 1
}

function detect_sugar()
{
    if [ "$DESKTOP_SESSION" == "sugar" ];
    then
    VERSION=`python -c "from jarabe import config; print config.version"`
    DESKTOP="SUGAR"
    else
    return 0
    fi
}

DESKTOP="UNKNOWN"
if detect_unity;
then
    if detect_kde;
    then
    if detect_gnome;
    then
        if detect_xfce;
        then
        if detect_cinnamon;
        then
            if detect_mate;
            then
            if detect_lxde;
            then
                detect_sugar
            fi
            fi
        fi
        fi
    fi
    fi
fi

sleep 4

if [ "$1" == '-v' ];
then
    echo $VERSION
else
    if [ "$1" == '-n' ];
    then
    echo $DESKTOP
    else
    echo $DESKTOP $VERSION
    fi
fi

uname -r
sleep 4

tset
reset

notify-send "Hello! ȶօȶǟʟ ʀɛքօ Script Is Now Running"
clear &

phases=( 
    '       Little To No User Interaction Is Required'
    '         A Good Internet Connection Is Required'
    '            Always Remember With Kali-Linux'                   
    '                ~The Sky Is The Limit~'
  
)
for i in $(seq 1 100); do  
    sleep 0.1

    if [ $i -eq 100 ]; then
        echo -e "XXX\n100\nDone!\nXXX"
    elif [ $(($i % 25)) -eq 0 ]; then
        let "phase = $i / 25"
        echo -e "XXX\n$i\n${phases[phase]}\nXXX"
    else
        echo $i
    fi 
done | whiptail --title '♦️ ӄǟʟɨ ʟɨռʊӼ n0bodysl364cy ȶօȶǟʟ ʀɛքօ ♦️' --gauge "${phases[0]}" 6 60 0

tset
reset

tput bold; tput setaf 6;
DELAY=1 # Number of seconds to display results
while [[ $REPLY != 0 ]]; do
    clear
    cat <<_EOF_
  ┏━━┳━┳━━┳━┳┓ ┏━┳━┳━┳━┓                                  
  ┗┓┏┫┃┣┓┏┫╻┃┃ ┃┃┃━┫┃┃┃┃
   ┃┃┃┃┃┃┃┃╻┃┗┓┃┏┃━┫┏┫┃┃
   ┗┛┗━┛┗┛┗┻┻━┛┗┻┻━┻┛┗━┛
     ┏━┳━┳━┓┏┳┳━┳┓┏┓┏┓┏┳━┳┳┳┳┓┏┓
     ┃━┫┃┃┃┃┃┗┫╻┃┃┃┃┃┃┃┃┃┃┃┃┣┗┛┛                          
     ┃┏┫┃┃┏┃┃┃┃╻┃┗┫┃┃┗┫┃┃┃┃┻┣┏┓┓
     ┗┛┗━┻┻┛┗┻┻┻┻━┻┛┗━┻┻┻━┻━┻┛┗┛ 
        ┏━┳┳━┳━┳━┳━┳┓┏┳━┳┓┏━┳━┳┓┏━┳┓┏┓
        ┃┃┃┃╋┃━┃╋┃┃┣┓┏┫━┫┃┣┛┃━┫┣┫┏┻┓┏┛
        ┃┃┃┃╋┃━┃╋┃┃┃┃┃┣━┃┗╋┫┃━┣┓┃┗┓┃┃
        ┗┻━┻━┻━┻━┻━┛┗┛┗━┻━┻━┻━┛┗┻━┛┗┛ 
Basic System Info
        1. Display System Information
        2. Display Disk Space
        3. Display Home Space 
        0. Start
_EOF_
    read -p "Enter selection [0-3] > "
    if [[ $REPLY =~ ^[0-3]$ ]]; then
        if [[ $REPLY == 1 ]]; then
        echo "Hostname: $HOSTNAME"
        uptime
        sleep 6
        fi
    if [[ $REPLY == 2 ]]; then
        df -h
        sleep 6
    fi
    if [[ $REPLY == 3 ]]; then
        if [[ $(id -u) -eq 0 ]]; then
            echo "Home Space Utilization (All Users)"
            du -sh /home/*
        else
            echo "Home Space Utilization ($USER)"
            du -sh $HOME
        fi
    sleep 6
    fi
    else
        echo "Invalid entry."
        sleep 6
    fi
done
echo "Here We Go..." &
clear &

tset
reset

printf '\e[3;0;0t'

printf '\e[50;35;100t'

xdotool key Ctrl+minus &

echo -ne "\e[8;24;80t" 
clear &

tput bold; tput setaf 15;
while true; do
    read -p "
 Important! Do You Wish To Replace etc/apt/sources.list
 Fixes Updates & Upgrades Not Working But...
 Remember! For Docker Ngrok & Different App Versions Etc.
 sources.list.d Can Cause Issues... Examine And Remove Old
 Contents If Needed! When Re-Running Parts Of This Script.
 In Simple Terms This Is Where Errors Mostly Occur. 
 Ngrok, Docker Etc. This Script Was Tested On Arch x86_64
 4.18.0-kali2-amd64 XFCE 4.12.1 Results May Vary
 
 This Option Is Safe If You Understand (y)Yes (n)No?" yn
    case $yn in
        [Yy]* ) tput bold; tput setaf 15;
notify-send "♦️ /etc/apt/sources.list Updating ♦️"

tset
reset

tput bold; tput setaf 1; arch
sleep 3

tput bold; tput setaf 1; 
sudo rm /var/cache/apt/archives/lock 
sudo rm /var/lib/dpkg/lock 

tput bold; tput setaf 6; 
sudo dpkg --configure -a 
sleep 1

tput bold; tput setaf 6;
sudo apt-get -f install 
sleep 1

tput bold; tput setaf 6;
sudo rm /etc/apt/sources.list -

tput bold; tput setaf 6;
sudo rm /var/lib/apt/lists 

tset
reset

tput bold; tput setaf 15;
sudo sh -c 'echo "deb http://http.kali.org/kali kali-rolling main non-free contrib
deb-src http://http.kali.org/kali kali-rolling main non-free contrib 
#deb http://http.kali.org/kali kali main non-free contrib 
#deb-src http://http.kali.org/kali kali main non-free contrib 
#deb http://security.kali.org/kali-security kali/updates main contrib non-free 
#deb-src http://security.kali.org/kali-security kali/updates main contrib non-free 
#deb http://http.kali.org/kali kali main non-free contrib 
#deb http://security.kali.org/kali-security kali/updates main contrib non-free 
#deb-src http://http.kali.org/kali kali main non-free contrib 
#deb-src http://security.kali.org/kali-security kali/updates main contrib non-free 
#deb http://old.kali.org/kali sana main non-free contrib
#deb-src http://old.kali.org/kali sana main non-free contrib 
#deb http://old.kali.org/kali moto main non-free contrib
#deb-src http://old.kali.org/kali moto main non-free contrib" >> /etc/apt/sources.list'  
#when drinking to much is not an option you... replace source list blindly.
tset
reset ; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done
clear &

phases=( 
    '                 POST UPGRADE STARTING'
    '               NEVERMIND FALSE POSITIVES '
    '              LISTING NETWORK INFORMATION'
    '                  LISTING CONNECTIVITY'
)   

for i in $(seq 1 100); do  
    sleep 0.1

    if [ $i -eq 100 ]; then
        echo -e "XXX\n100\nDone!\nXXX"
    elif [ $(($i % 25)) -eq 0 ]; then
        let "phase = $i / 25"
        echo -e "XXX\n$i\n${phases[phase]}\nXXX"
    else
        echo $i
    fi 
done | whiptail --title '♦️ ӄǟʟɨ ʟɨռʊӼ n0bodysl364cy ȶօȶǟʟ ʀɛքօ ♦️' --gauge "${phases[0]}" 6 60 0 

tset
reset

tput bold; tput setaf 10; 
ip route list 
ls -l /etc/init.d/network-manager
sleep 3

tput bold; tput setaf 10;
ping 8.8.8.8 -c1 -s1 -w1 -q || ping 8.8.8.8 -c1 -s1 -w1 -q 
sleep 3

tput bold; tput setaf 10;
ps -aef | grep accountsservice
sleep 2

tset
reset

tput bold; tput setaf 10;
    if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
      echo "IPv4 is up"
    else
      echo "IPv4 is down"
    fi 
sleep 2

notify-send "♦️ ȶօȶǟʟ ʀɛքօ Is A Work In Progess ♦️"

tset
reset

tput bold; tput setaf 10;
nc -z 8.8.8.8 53  >/dev/null 2>&1
online=$?
if [ $online -eq 0 ]; then
    echo "Online"
else
    echo "Offline"
fi
sleep 1

tput bold; tput setaf 10;
iwconfig 
sleep 1

tput bold; tput setaf 10;
who
sleep 1

tput bold; tput setaf 10;
tty
sleep 1

tput bold; tput setaf 10;
arch
sleep 1

tset
reset

tput bold; tput setaf 12; cat /etc/os-release
sleep 2

tset 
reset

tput bold; tput setaf 15;
while true; do
    read -p "       
 Do You Wish To Create A Temporary Non Sudo User root2? If So. Do Not Repeat 
 This Step If You Re-Run This Script. (Results In Total Loss Of Data For root2) 
 (y)Yes (n)No?" yn
    case $yn in
        [Yy]* ) 

tput bold; tput setaf 15;

clear &

tput bold; tput setaf 15; echo "WARNING, 

Important Notice
 
Remember That I Made & Use This Script Personally As A Reminder After Fresh 
Installs Of Kali Linux Light. Do The Same For Best Results e.g. AFTER FRESH 
INSTALLS.
MAKE CERTAIN TO ALWAYS, ALWAYS, ALWAYS BACK UP YOUR DATA.
This Script Is Now Deleting Any Users Named root2
If You Already Have A User Named root2 Hit (Ctl+c) To Exit Immediately 
Or
Lose Everything Related To This Account In The Rare Cases root2 Exists. 
A New User root2 Will Than Be Created For You.
You Can Change The Username & Password For root2 At Any Point In The Future
THIS IS ONLY BEING DONE AS A SECURITY MEASURE FOR YOUR OWN (SAFETY) 
So As. 
Not To Harm The Core Of Your OS, Its Good Practice On Any Operating 
System To Run Your Applications On A User Level And Leave Administrative Tasks 
To The Root User, And Only On A Per-Need Basis.  
A Big Thank You To Those Who Helped & To The Authors Of Any Scripts, Programs 
Software, Or Applications Depicted, Used Or Installed By This Script.

n0b0dysl364cy

"


for (( i=60; i>0; i--)); do
    printf "\rStarting script in $i seconds.  Hit any key to continue."
    read -s -n 1 -t 1 key
    if [ $? -eq 0 ]
    then
        break
    fi
done
echo " Resumeing script"


spinner() {
    local i sp n
    sp='/-\|'
    n=${#sp}
    printf ' '
    while sleep 0.1; do
        printf "%s\b" "${sp:i++%n:1}"
    done
}


tput bold; tput setaf 6; printf '
Patience is a virtue '
spinner &

sleep 4  # sleeping for 4 seconds is important work

kill "$!" # kill the spinner
printf '\n'

tset
reset

clear &

notify-send "♦️ New User root2 Added ♦️"


tput bold; tput setaf 1; sudo deluser --remove-home root2
sleep .4

clear &

tput bold; tput setaf 1; printf -- 'Creating New User root2 \n';
sleep .4

clear &

tput bold; tput setaf 3; printf -- 'User root2 Adding Home Directory \n';
sleep .4

clear &

tput bold; tput setaf 2; printf -- 'User root2 Adding Some Privileges \n';
sleep .4

notify-send "♦️ Create A Strong Password ♦️"
sleep 2

notify-send "♦️ You Can Skip Personal Info ♦️"
clear &

sudo adduser root2 

while true; do
    read -s -p "Password: " password
    echo
    read -s -p "Password (again): " password2 
    echo
    [ "$password" = "$password2" ] && break || echo "Please try again"
done
clear &

tput bold; tput setaf 10;
msg="Remember Root Account Is For Administative Actions"
# Determine the number of lines and columns for the terminal
eval "`resize`"
# Calculate the indent
length=`expr \( $COLUMNS - ${#msg} \) / 2`
indent=`printf "%${length}s"`
 
a="`echo $msg|sed 's#.#.#g'`"
b="`echo $msg|sed 's#.#o#g'`"
c="`echo $msg|sed 's#.#O#g'`"
d="`echo $msg|sed 's#.#o#g'`"
e="`echo $msg|sed 's#.#\\\b#g'`"
 
printf "$indent$msg\n"
 
for n in 1 2 3 4
do
    for x in $a $b $c $d
    do 
        printf "$indent%b%b" $x $e
        sleep .3
        printf "\r"
    done
done
clear &

tput bold; tput setaf 15;
echo """You Can Now Log In To This New User root2 At Start Up""" 
sleep 6

 break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done
clear &

tput bold; tput setaf 15;
while true; do
    read -p "
 Do You Wish To Install Kali-Archive-Keyring (y)Yes (n)No?" yn
    case $yn in
        [Yy]* ) 
clear &
sudo apt-get update
cd /root/Downloads
gpgconf --kill all
tput bold; tput setaf 6; sudo apt-get install kali-archive-keyring
tput bold; tput setaf 15; wget https://http.kali.org/kali/pool/main/k/kali-archive-keyring/kali-archive-keyring_2018.1_all.deb
chmod +x kali-archive-keyring_2018.1_all.deb
dpkg -i kali-archive-keyring_2018.1_all.deb
dpkg --configure -a
apt install -f
rm -f kali-archive-keyring_2018.1_all.deb
cd
sudo apt-get update; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done
clear &

tput bold; tput setaf 15;
while true; do
    read -p "
 Do You Wish To Install Public/Private PGP Key. 
 (On A Per-Need Basis) (y)Yes (n)No?" yn
    case $yn in
        [Yy]* ) tput setaf 6; gpg --full-generate-key ; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done
clear & 

tput bold; tput setaf 15;
while true; do
    read -p "
 Do You Wish To Install Python Postgesql, Apache. (y)Yes (n)No?" yn
    case $yn in
        [Yy]* ) tput bold; tput setaf 12; sudo aptitude upgrade -y
clear &

tput bold; tput setaf 8; sudo rm /var/cache/apt/archives/lock
tput bold; tput setaf 8; sudo rm /var/lib/dpkg/lock
tput bold; tput setaf 8; sudo rm /var/lib/dpkg/lock
tput bold; tput setaf 8; sudo apt-get install -f
tput bold; tput setaf 8; sudo dpkg --configure -a 
tput bold; tput setaf 8; sudo apt-get clean -y
tput bold; tput setaf 8; sudo apt autoremove -y
clear &

notify-send "♦️ Checking Python ♦️"
clear &

cd /root/Downloads

tput bold; tput setaf 15; sudo wget https://bootstrap.pypa.io/get-pip.py
tput bold; tput setaf 6; sudo python get-pip.py
tput bold; tput setaf 15; sudo python /root/get-pip.py
tput bold; tput setaf 6; sudo rm -f get-pip.py
tput bold; tput setaf 15; sudo apt-get remove python-pip -y
tput bold; tput setaf 6; sudo apt autoremove -y 
tput bold; tput setaf 15; sudo apt-get update
clear &
cd

notify-send "♦️ Replacing Old Postgresql ♦️"
tput bold; tput setaf 6; sudo apt-get update
clear &

tput bold; tput setaf 6; sudo apt remove --purge postgresql-10* postgresql-client-10* -y 
clear &

notify-send "♦️ Please Be Patient ♦️"
sudo apt-get install postgresql-11 postgresql-client-11 -y 
clear &


tput bold; tput setaf 8; sudo rm /var/cache/apt/archives/lock
tput bold; tput setaf 8; sudo rm /var/lib/dpkg/lock
tput bold; tput setaf 8; sudo rm /var/lib/dpkg/lock
tput bold; tput setaf 8; sudo apt-get install -f
tput bold; tput setaf 8; sudo dpkg --configure -a 
tput bold; tput setaf 8; sudo apt-get clean -y
tput bold; tput setaf 8; sudo apt autoremove -y
clear &

tput bold; tput setaf 6; sudo apt-get install apache2 -y
tput bold; tput setaf 15; sudo update-rc.d apache2 defaults
tput bold; tput setaf 6; sudo update-pciids
sudo /etc/init.d/mysql start
clear &

tput bold; tput setaf 6; sudo apt-get install apt-file -y
tput bold; tput setaf 15; apt-file search add-apt-repository
apt-file udate
clear &

tput bold; tput setaf 7; pg_ctlcluster 10 start 
tput bold; tput setaf 7; pg_ctlcluster 10 main start 

tput bold; tput setaf 7; pg_ctlcluster 11 start 
tput bold; tput setaf 7; pg_ctlcluster 11 main start 

service postgresql restart
clear &

tput bold; tput setaf 11;
pg_isready
sleep 3

sudo apt-get update; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done
clear & 

tput bold; tput setaf 15;
	echo ""
	echo " Choose Desktop Environment Wisely. "
	echo " More Options Will Be Made Available Shortly. "

options=(
    "Kali-Desktop-Gnome" "Kali-Desktop-Cinnamon" "Kali-Desktop-Kde" "Skip" 
)

select option in "${options[@]}"; do
    case "$REPLY" in 
        1) sudo apt install kali-desktop-gnome -y ;;
        2) sudo apt-get install kali-defaults kali-root-login desktop-base cinnamon -y ;;
        3) sudo apt-get install kali-defaults kali-root-login desktop-base kde-plasma-desktop -y ;;
        4) break;;
    esac
done
clear &

notify-send "♦️ Number 2 Recommended ♦️"
tput bold; tput setaf 15;
echo "Apt-Cache Search Kali-Linux"

tput bold; tput setaf 6;
sudo apt-cache search kali-linux 

tput bold; tput setaf 15;
echo "Choose (1-14) Hit Return When You See #? To Get Back To Menu"
	

options=("Kali Linux base system" 
  "Kali Linux - all packages" 
  "Kali Linux forensic tools" 
  "Kali Linux complete system" 
  "Kali Linux GPU tools"  
  "Kali Linux Nethunter tools" 
  "Kali Linux password cracking tools" 
  "Kali Linux RFID tools" 
  "Kali Linux SDR tools" 
  "Kali Linux Top 10 tools" 
  "Kali Linux VoIP tools" 
  "Kali Linux webapp assessment tools" 
  "kali-linux-wireless"
  "Skip"
)
tput bold; tput setaf 6;
select option in "${options[@]}"; do
    case "$REPLY" in 
        1) tput bold; tput setaf 6; clear && sudo apt-get install kali-linux -y ;;
        2) tput bold; tput setaf 6; clear && sudo apt-get install kali-linux-all -y ;;
        3) tput bold; tput setaf 6; clear && sudo apt-get install kali-linux-forensic -y ;;
        4) tput bold; tput setaf 6; clear && sudo apt-get install kali-linux-full -y ;;
        5) tput bold; tput setaf 6; clear && sudo apt-get install kali-linux-gpu -y ;;
        6) tput bold; tput setaf 6; clear && sudo apt-get install kali-linux-nethunter -y ;;
        7) tput bold; tput setaf 6; clear && sudo apt-get install kali-linux-pwtools -y ;;
        8) tput bold; tput setaf 6; clear && sudo apt-get install kali-linux-rfid -y ;;
        9) tput bold; tput setaf 6; clear && sudo apt-get install kali-linux-sdr -y ;;
       10) tput bold; tput setaf 6; clear && sudo apt-get install kali-linux-top10 -y ;;
       11) tput bold; tput setaf 6; clear && sudo apt-get install kali-linux-voip -y ;;
       12) tput bold; tput setaf 6; clear && sudo apt-get install kali-linux-web -y ;;
       13) tput bold; tput setaf 6; clear && sudo apt-get install kali-linux-wireless -y ;;
       14) break;;
    esac
done
clear &

tput bold; tput setaf 15;
while true; do
    read -p "
 Do You Wish To Install Docker! Results May Vary. (y)Yes (n)No?" yn
    case $yn in
        [Yy]* ) apt install curl -y

apt update

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add - 

echo 'deb [arch=amd64] https://download.docker.com/linux/debian stretch stable' >> /etc/apt/sources.list.d/docker.list 

apt-get update && apt-get upgrade -y

apt-get remove docker docker-engine docker.io -y

apt update

apt-get install docker-ce -y

apt-get update && apt-get upgrade -y

dpkg --configure -a

apt install -f

systemctl enable docker 

systemctl daemon-reload 

systemctl restart docker.service 

docker run hello-world
sleep 6
clear &

sudo apt-get update; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done
clear &

tput bold; tput setaf 15;
while true; do
    read -p "
 Do You Wish To Install Android Studio. (y)Yes (n)No?" yn
    case $yn in
        [Yy]* ) 
tset
reset
cd /opt
notify-send "♦️ Installing Android-Studio ♦️" 
wget https://dl.google.com/dl/android/studio/ide-zips/3.2.1.0/android-studio-ide-181.5056338-linux.zip 
chmod +x android-studio-ide-181.5056338-linux.zip 
unzip android-studio-ide-181.5056338-linux.zip 
cd /opt/android-studio/bin 
./studio.sh 
cd; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done
clear &

tput bold; tput setaf 15;
while true; do
    read -p "
 Do You Wish To Install OpenVAS (ADVANCED) (y)Yes (n)No?" yn
    case $yn in
        [Yy]* ) 
tset 
reset
notify-send "♦️ Please Be Patient ♦️"
notify-send "♦️ This Can Be Long ♦️" 
notify-send "♦️ (Ctl+C) If Hung Up ♦️" 
apt-get install openvas && openvas-setup; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done
clear &

tput bold; tput setaf 15;
while true; do
    read -p "
 Do You Wish To Install ngrok-beta-linux-amd64.deb (y)Yes (n)No?" yn
    case $yn in
        [Yy]* ) tput bold; tput setaf 6; tset
reset

wget https://bin.equinox.io/c/6raCnPaTf2c/ngrok-beta-linux-amd64.deb
chmod +x ngrok-beta-linux-amd64.deb
dpkg -i ngrok-beta-linux-amd64.deb
dpkg --configure -a
sudo apt install -f
notify-send "♦️ Hold Ctl+C To Continue ♦️" 
ngrok http 80

tset
reset; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done
clear &

tput bold; tput setaf 15;
while true; do
    read -p "
 Do You Wish To Install Visual Studio. (y)Yes (n)No?" yn
    case $yn in
        [Yy]* ) 
tset
reset 
cd /root/Downloads
tput bold; tput setaf 15; curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg 
tput bold; tput setaf 6; sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ 
tput bold; tput setaf 15; sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' 
tput bold; tput setaf 6; sudo apt update 
tput bold; tput setaf 15; sudo apt-get upgrade  
notify-send "♦️ Installing Visual Studio ♦️"
tput bold; tput setaf 15; sudo apt-get install apt-transport-https 
tput bold; tput setaf 6; sudo apt-get update 
tput bold; tput setaf 15; sudo apt-get install code  
tput bold; tput setaf 6; sudo apt-get install code-insiders 
rm -f microsoft.gpg; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done
clear &

tput bold; tput setaf 15;
while true; do
    read -p "
 Do You Wish To Install Some Of The Best Apps 
 Kali Linux Has To Offer. Kazam, Vlc, Virtual-Box
 Wine32, Steam, Sublime, Snort, Etc. (y)Yes (n)No?" yn
    case $yn in
        [Yy]* ) 
sudo apt-get update
clear &
notify-send "♦️ Adding Some Great Apps ♦️"

tput bold; tput setaf 15; sudo aptitude update
tput bold; tput setaf 6; sudo aptitude upgrade -y 

notify-send "♦️ Installing SublimeText Free ♦️"

tput bold; tput setaf 15; 
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

tset
reset

notify-send "♦️ Installing ShellCheck ♦️"
tput bold; tput setaf 15; sudo apt-get install shellcheck -y
clear &

tput bold; tput setaf 6; sudo apt-get update
clear &

tput bold; tput setaf 15; sudo apt-get install sublime-text -y

notify-send "♦️ Installing Android-Tools ♦️"

tput bold; tput setaf 6; sudo apt-get install android-tools-adb android-tools-fastboot -y

tput bold; tput setaf 15; sudo apt-get install mitmf -y 

tput bold; tput setaf 15; sudo echo "deb https://deb.etcher.io stable etcher" | sudo tee /etc/apt/sources.list.d/etcher.list 

tput bold; tput setaf 6; sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 379CE192D401AB61

tput bold; tput setaf 6; sudo apt-get update

tput bold; tput setaf 15; sudo dpkg --add-architecture i386

tput bold; tput setaf 6; sudo apt-get update

tset
reset

tput bold; tput setaf 15; sudo apt-get install wine-bin:i386 -y

notify-send "♦️ Installing Wine32 ♦️"
tput bold; tput setaf 6; sudo apt-get install wine32 -y

tset
reset

tput bold; tput setaf 6; sudo apt-get install python g++ make fakeroot -y
clear &

tput bold; tput setaf 6; sudo apt-get install wget -y
clear &

tput bold; tput setaf 15; sudo apt-get install npm -y 
clear &

notify-send "♦️ Installing Node.js ♦️"
tput bold; tput setaf 6; sudo apt-get install node.js -y 
clear &

tput bold; tput setaf 15; sudo apt-get install libjs-skeleton node-normalize.css python-unicodecsv -y
clear &
 
notify-send "♦️ Installing Aptitude ♦️"
tput bold; tput setaf 6; sudo apt-get install aptitude -y
clear &
 
notify-send "♦️ Installing WineTricks ♦️"
tput bold; tput setaf 15; sudo apt-get install winetricks -y
clear &
 
notify-send "♦️ Installing Etcher ♦️"
tput bold; tput setaf 6; sudo apt-get install etcher-electron -y 
clear &

notify-send "♦️ Installing Qbittorrent ♦️"
tput bold; tput setaf 15; sudo apt-get install qbittorrent -y 
clear &
 
notify-send "♦️ Installing Synaptic ♦️" 
tput bold; tput setaf 6; sudo apt-get install synaptic -y
clear &

notify-send "♦️ Installing steam ♦️"
tput bold; tput setaf 15; sudo apt-get install steam -y
clear &

notify-send "♦️ Installing Playonlinux ♦️"
tput bold; tput setaf 6; sudo apt-get install playonlinux -y
clear &

tput bold; tput setaf 15; sudo apt-get install proxychains -y
clear &

notify-send "♦️ Installing Libreoffice ♦️"
tput bold; tput setaf 6; sudo apt-get install libreoffice -y
clear &

notify-send "♦️ Installing Rhythmbox ♦️"
tput bold; tput setaf 15; sudo apt-get install rhythmbox -y
clear &

notify-send "♦️ Installing Kmix ♦️"
tput bold; tput setaf 6; sudo apt-get install kmix -y
clear &

notify-send "♦️ Installing Cmus ♦️"
tput bold; tput setaf 6; sudo apt-get install cmus -y 
clear &

notify-send "♦️ Installing Krita ♦️"
tput bold; tput setaf 15; sudo apt-get install krita -y
clear &

notify-send "♦️ Installing Alacarte ♦️" 
tput bold; tput setaf 6; sudo apt-get install alacarte -y
clear &

notify-send "♦️ Installing File Roller ♦️"
apt-get install unrar unace rar unrar p7zip zip unzip p7zip-full p7zip-rar file-roller -y
clear &

notify-send "♦️ Installing Kdenlive ♦️" 
tput bold; tput setaf 15; sudo apt-get install kdenlive -y
clear &

notify-send "♦️ Installing Blender ♦️"
tput bold; tput setaf 6; sudo apt-get install blender -y
clear &

notify-send "♦️ Installing Gimp ♦️"
tput bold; tput setaf 15; sudo apt-get install gimp -y
clear &

notify-send "♦️ Installing Inkscape ♦️"
tput bold; tput setaf 6; sudo apt-get install inkscape -y
clear &

notify-send "♦️ Installing Snort IDS ♦️"
tput bold; tput setaf 6; sudo apt-get install snort -y

notify-send "♦️ Installing DigiKam ♦️" 
tput bold; tput setaf 15; sudo apt-get install digikam -y 
clear &

notify-send "♦️ Installing Audacity ♦️"
tput bold; tput setaf 6; sudo apt-get install audacity -y 
clear &

notify-send "♦️ Installing Vokoscreen ♦️"
tput bold; tput setaf 15; sudo apt-get install vokoscreen -y
clear &

notify-send "♦️ Installing Tor ♦️" 
tput bold; tput setaf 6; sudo apt-get install tor -y 
clear &

notify-send "♦️ Installing UFW FireWall ♦️"
tput bold; tput setaf 6; sudo apt-get install ufw -y
clear &

notify-send "♦️ Installing Bleachbit ♦️"
tput bold; tput setaf 6; sudo apt-get install bleachbit -y
clear &

notify-send "♦️ Installing Kazam ♦️"
tput bold; tput setaf 15; sudo apt-get install kazam -y
clear &

notify-send "♦️ Installing vlc ♦️"
tput bold; tput setaf 15; sudo apt-get install vlc -y
clear &

notify-send "♦️ Installing Phonon ♦️" 
tput bold; tput setaf 6; sudo apt-get install phonon-backend-gstreamer -y 
clear &

tput bold; tput setaf 15; sudo apt-get install phonon-backend-vlc -y 
clear &

notify-send "♦️ vlc Will Now Run As Root ♦️" 
sudo sed -i 's/geteuid/getppid/' /usr/bin/vlc 
clear &

notify-send "♦️ Installing Wordpress ♦️"
tput bold; tput setaf 6; sudo apt-get install wordpress -y
clear &

notify-send "♦️ Installing Virtualbox ♦️"
tput bold; tput setaf 15; sudo apt-get install -y virtualbox-guest-x11  
clear &

sudo apt-get update && apt-get install -y linux-headers-$(uname -r)
clear &

notify-send "♦️ Installing ClamTk Anti-Virus ♦️" 
tput bold; tput setaf 6; sudo apt-get install clamtk -y 
clear &

notify-send "♦️ Installing Thunderbird ♦️"
tput bold; tput setaf 6; sudo apt-get install thunderbird -y
clear &

notify-send "♦️ Installing Pidgin ♦️"
tput bold; tput setaf 15; sudo apt-get install pidgin -y 
clear &

notify-send "♦️ Installing Thonny ♦️"
tput bold; tput setaf 15; sudo apt-get install thonny -y 
clear &

notify-send "♦️ Installing Kodi ♦️"
tput bold; tput setaf 15; sudo apt-get install kodi -y
clear &

tput bold; tput setaf 15; sudo apt-get install dh-autoreconf libnfc-dev libssl-dev -y
sudo apt-get update; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done
clear &

tput bold; tput setaf 15;
while true; do
    read -p "
 Do You Wish To Download Some Of The Best Of GitHub. 
 Veil/KatanaFramework Etc. Over 4GB Of Disk Space 
 Is Required To Continue(Recommended) (y)Yes (n)No?" yn
    case $yn in
        [Yy]* ) 
tset
reset
notify-send "♦️ SOME FILES ARE PLACED IN root ♦️"
tput bold; tput setaf 15;
sudo mkdir -m 777 /root/Downloads/Best-Of-GitHUb
cd /root/Downloads/Best-Of-GitHUb/
sudo git clone https://github.com/v1s1t0r1sh3r3/airgeddon.git  
sudo git clone https://github.com/carpedm20/awesome-hacking.git 
sudo git clone https://github.com/prabinzz/powerpack.git 
sudo git clone https://github.com/lawrenceamer/zero-attacker.git 
sudo git clone https://github.com/mehedishakeel/Hack-With-Kali-Linux-2017.2-Unofficial-Documentation.git 
sudo git clone https://github.com/Skull00/Fuck_Society.git 
sudo git clone https://github.com/Rajkumrdusad/Tool-X.git 
sudo git clone https://github.com/evyatarmeged/Raccoon.git
sudo git clone https://github.com/D4Vinci/PasteJacker.git
sudo git clone https://github.com/0xInfection/TIDoS-Framework.git 
sudo git clone https://github.com/ntrippar/ARPwner.git 
sudo git clone https://github.com/Tuhinshubhra/CMSeeK.git 
sudo git clone https://github.com/smicallef/spiderfoot.git 
sudo git clone https://github.com/Yukinoshita47/Yuki-Chan-The-Auto-Pentest.git 
sudo git clone https://github.com/WeebSec/PhishX.git 
sudo git clone https://github.com/Tuhinshubhra/RED_HAWK.git 
sudo git clone https://github.com/hacktoolspack/hack-tools.git 
sudo git clone https://github.com/MisterBianco/BoopSuite.git 
sudo git clone https://github.com/FluxionNetwork/fluxion.git 
sudo git clone https://github.com/Hacker-EG/Wifi-Cracker.git 
sudo git clone https://github.com/wifiphisher/wifiphisher.git 
sudo git clone https://github.com/0x90/wifi-arsenal.git 
sudo git clone https://github.com/brannondorsey/wifi-cracking.git 
sudo git clone https://github.com/P0cL4bs/Shellcodes.git 
sudo git clone https://github.com/P0cL4bs/WiFi-Pumpkin/archive/v0.8.7.tar.gz 
sudo git clone https://github.com/Hack-with-Github/Awesome-Hacking.git 
sudo git clone https://github.com/Hax4us/Nethunter-In-Termux.git 
sudo git clone https://github.com/brainfucksec/kalitorify.git 
sudo git clone https://github.com/LionSec/wifresti.git 
sudo git clone https://github.com/NoorQureshi/kali-linux-cheatsheet.git 
sudo git clone https://github.com/FreelancePentester/ddos-script.git 
sudo git clone https://github.com/LionSec/xerosploit.git 
sudo git clone https://github.com/wmealing/easy-sploit.git 
sudo git clone https://github.com/peterpt/fuzzbunch.git 
sudo git clone https://github.com/rapid7/metasploit-payloads.git
sudo git clone https://github.com/misterch0c/shadowbroker.git 
sudo git clone https://github.com/x0rz/EQGRP.git 
sudo git clone https://github.com/nullsecuritynet/tools.git 
sudo git clone https://github.com/francisck/DanderSpritz_docs.git 
sudo git clone https://github.com/REPTILEHAUS/Eternal-Blue.git 
sudo git clone https://github.com/op7ic/shadowbroker-smb-scanner.git 
sudo git clone https://github.com/xc0d3rz/NSA.py.git 
sudo git clone https://github.com/UndeadSec/SocialFish.git 
sudo git clone https://github.com/games647/doublepulsar-detection-script.git 
sudo git clone https://github.com/adamcaudill/EquationGroupLeak.git 

tset
reset

notify-send "♦️ ӄǟʟɨ ʟɨռʊӼ ȶօȶǟʟ ʀɛքօ ♦️"
sleep 1

tput bold; tput setaf 15;
sudo apt-get -y install git
git clone https://github.com/Veil-Framework/Veil.git
cd Veil/
./config/setup.sh --force --silent

tset
reset

tput bold; tput setaf 6;
tput bold; tput setaf 15;
sudo git clone https://github.com/Veil-Framework/Veil-Evasion.git
cd /root/Downloads/Best-Of-GitHUb/Veil-Evasion/
bash setup/setup.sh -s

tset
reset

tput bold; tput setaf 15;
sudo git clone https://github.com/PowerScript/KatanaFramework.git
cd KatanaFramework
sudo sh dependencies
sudo python install

tset
reset

tput bold; tput setaf 6;
sudo apt-get update && sudo apt-get upgrade -y

tset
reset

notify-send "Check Out This New Directory"
sleep 1

notify-send "/root/Downloads/Best-Of-GitHUb"
sleep 1

tput bold; tput setaf 8; sudo rm /var/cache/apt/archives/lock
tput bold; tput setaf 8; sudo rm /var/lib/dpkg/lock
tput bold; tput setaf 8; sudo rm /var/lib/dpkg/lock
tput bold; tput setaf 8; sudo apt-get install -f
tput bold; tput setaf 8; sudo dpkg --configure -a 
tput bold; tput setaf 8; sudo apt-get clean -y
tput bold; tput setaf 8; sudo apt autoremove -y
clear &

tput bold; tput setaf 15;
echo """Check In /root/Downloads/Best-Of-GitHUb/ """
sleep 6

tset
reset

cd Veil/
./config/setup.sh --force --silent
git clone https://github.com/frizb/--force --silentVanquish ; break;;
        [Nn]* ) break;;
        * ) echo "Please Answer Yes Or No.";;
    esac
done
clear &

tput bold; tput setaf 15;
while true; do
    read -p "
 Do You Wish To Do A apt dist-upgrade (y)Yes (n)No?" yn
    case $yn in
        [Yy]* ) 
tset
reset
tput bold; tput setaf 15;
notify-send "♦️ Full Dist Upgrade ♦️"

tset 
reset

tput bold; tput setaf 13; sudo aptitude update 
tput bold; tput setaf 13; sudo aptitude full-upgrade -y
tput bold; tput setaf 13; sudo apt-get autoremove -y
tput bold; tput setaf 13; sudo apt-get clean; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done
clear &

tput bold; tput setaf 15;
while true; do
    read -p "
 Do You Wish To Clean Up Your System Now. 
 Your PC May Seem Unresponsive At Times. (y)Yes (n)No?" yn
    case $yn in
        [Yy]* ) 
tset
reset
tput bold; tput setaf 1; bleachbit --list | grep -E "[a-z0-9_\-]+\.[a-z0-9_\-]+" | grep -v system.free_disk_space | xargs bleachbit --clean; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done
clear & 

tput bold; tput setaf 8; sudo apt-get update
clear &

notify-send "♦️ Installing Neofetch ♦️"
tput bold; tput setaf 8; sudo apt-get install neofetch -y 
clear &

spinner() {
    local i sp n
    sp='/-\|'
    n=${#sp}
    printf ' '
    while sleep 0.1; do
        printf "%s\b" "${sp:i++%n:1}"
    done
}

clear &

tput bold; tput setaf 11; printf '






 


 The quieter you become, The more you are able to hear.  '
spinner &

sleep 8  # sleeping for 8 seconds is important work

kill "$!" # kill the spinner
printf '\n'

tset
reset
sudo dpkg --add-architecture i386 && sudo apt update
sudo apt install \
      wine-development \
      wine32-development \
      wine64-development \
      libwine-development \
      libwine-development:i386 \
      fonts-wine

mv .wine .wine.old
winecfg

tset
reset

notify-send "♦️ All Finished Here ♦️"
sleep 1

notify-send "♦️ n0b0dysl364cy ♦️"
sleep 1

sudo update-pciids

clear &

neofetch
