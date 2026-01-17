#!/usr/bin/env bash


cat << EOF

 ██████╗ ███████╗██████╗ ██╗ █████╗ ███╗   ██╗██╗███████╗██╗   ██╗
██╔══██╗██╔════╝██╔══██╗██║██╔══██╗████╗  ██║██║██╔════╝╚██╗ ██╔╝
██║  ██║█████╗  ██████╔╝██║███████║██╔██╗ ██║██║█████╗   ╚████╔╝ 
██║  ██║██╔══╝  ██╔══██╗██║██╔══██║██║╚██╗██║██║██╔══╝    ╚██╔╝  
██████╔╝███████╗██████╔╝██║██║  ██║██║ ╚████║██║██║        ██║   
╚═════╝ ╚══════╝╚═════╝ ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝╚═╝        ╚═╝   

 Ver 0.1.0
 Copyright (C) 2026 Kuznix ( github.com/Kuznix/debianify )

 Debianify is a fork of Archify
 Copyright (C) 2025 HardRaple ( github.com/hardraple/archify )

EOF

# Detect current OS
if [ -f /etc/os-release ]; then
  . /etc/os-release
  CURRENT_DISTRO=$ID
  CURRENT_VERSION=$VERSION_ID
  echo "Current OS detected: $CURRENT_DISTRO $CURRENT_VERSION"
else
  CURRENT_DISTRO="unknown"
  echo "Current OS: unknown"
fi

echo "Select the distro to install:"
echo "Debian:"
echo "1. oldstable (12, bookworm)"
echo "2. stable (13, trixie)"
echo "3. testing (14, forky)"
echo "4. unstable (sid)"
echo "Ubuntu:"
echo "5. 22.04 LTS jammy (gnome)"
echo "6. 22.04 LTS jammy (kde)"
echo "7. 22.04 LTS jammy (xfce)"
echo "8. 22.04 LTS jammy (lxqt)"
echo "9. 22.04 LTS jammy (mate)"
echo "10. 22.04 LTS jammy (cinnamon)"
echo "11. 24.04 LTS noble (gnome)"
echo "12. 24.04 LTS noble (kde)"
echo "13. 24.04 LTS noble (xfce)"
echo "14. 24.04 LTS noble (lxqt)"
echo "15. 24.04 LTS noble (mate)"
echo "16. 24.04 LTS noble (cinnamon)"
echo "17. 25.10 questing (gnome)"
echo "18. 25.10 questing (kde)"
echo "19. 25.10 questing (xfce)"
echo "20. 25.10 questing (lxqt)"
echo "21. 25.10 questing (mate)"
echo "22. 25.10 questing (cinnamon)"
echo "23. 26.04 resolute (devel) (gnome)"
echo "24. 26.04 resolute (devel) (kde)"
echo "25. 26.04 resolute (devel) (xfce)"
echo "26. 26.04 resolute (devel) (lxqt)"
echo "27. 26.04 resolute (devel) (mate)"
echo "28. 26.04 resolute (devel) (cinnamon)"
echo "Kali:"
echo "29. rolling"
echo "Linux Mint:"
echo "30. 22.3 (zena, cinnamon)"
echo "31. 22.3 (zena, mate)"
echo "32. 22.3 (zena, xfce)"

read -p "Enter the number: " DISTRO_CHOICE

case $DISTRO_CHOICE in
1) DISTRO="debian"; SUITE="bookworm"; DE="none"; MIRROR="http://deb.debian.org/debian/";;
2) DISTRO="debian"; SUITE="trixie"; DE="none"; MIRROR="http://deb.debian.org/debian/";;
3) DISTRO="debian"; SUITE="forky"; DE="none"; MIRROR="http://deb.debian.org/debian/";;
4) DISTRO="debian"; SUITE="sid"; DE="none"; MIRROR="http://deb.debian.org/debian/";;
5) DISTRO="ubuntu"; SUITE="jammy"; DE="gnome"; MIRROR="http://archive.ubuntu.com/ubuntu/";;
6) DISTRO="ubuntu"; SUITE="jammy"; DE="kde"; MIRROR="http://archive.ubuntu.com/ubuntu/";;
7) DISTRO="ubuntu"; SUITE="jammy"; DE="xfce"; MIRROR="http://archive.ubuntu.com/ubuntu/";;
8) DISTRO="ubuntu"; SUITE="jammy"; DE="lxqt"; MIRROR="http://archive.ubuntu.com/ubuntu/";;
9) DISTRO="ubuntu"; SUITE="jammy"; DE="mate"; MIRROR="http://archive.ubuntu.com/ubuntu/";;
10) DISTRO="ubuntu"; SUITE="jammy"; DE="cinnamon"; MIRROR="http://archive.ubuntu.com/ubuntu/";;
11) DISTRO="ubuntu"; SUITE="noble"; DE="gnome"; MIRROR="http://archive.ubuntu.com/ubuntu/";;
12) DISTRO="ubuntu"; SUITE="noble"; DE="kde"; MIRROR="http://archive.ubuntu.com/ubuntu/";;
13) DISTRO="ubuntu"; SUITE="noble"; DE="xfce"; MIRROR="http://archive.ubuntu.com/ubuntu/";;
14) DISTRO="ubuntu"; SUITE="noble"; DE="lxqt"; MIRROR="http://archive.ubuntu.com/ubuntu/";;
15) DISTRO="ubuntu"; SUITE="noble"; DE="mate"; MIRROR="http://archive.ubuntu.com/ubuntu/";;
16) DISTRO="ubuntu"; SUITE="noble"; DE="cinnamon"; MIRROR="http://archive.ubuntu.com/ubuntu/";;
17) DISTRO="ubuntu"; SUITE="questing"; DE="gnome"; MIRROR="http://archive.ubuntu.com/ubuntu/";;
18) DISTRO="ubuntu"; SUITE="questing"; DE="kde"; MIRROR="http://archive.ubuntu.com/ubuntu/";;
19) DISTRO="ubuntu"; SUITE="questing"; DE="xfce"; MIRROR="http://archive.ubuntu.com/ubuntu/";;
20) DISTRO="ubuntu"; SUITE="questing"; DE="lxqt"; MIRROR="http://archive.ubuntu.com/ubuntu/";;
21) DISTRO="ubuntu"; SUITE="questing"; DE="mate"; MIRROR="http://archive.ubuntu.com/ubuntu/";;
22) DISTRO="ubuntu"; SUITE="questing"; DE="cinnamon"; MIRROR="http://archive.ubuntu.com/ubuntu/";;
23) DISTRO="ubuntu"; SUITE="resolute"; DE="gnome"; MIRROR="http://archive.ubuntu.com/ubuntu/";;
24) DISTRO="ubuntu"; SUITE="resolute"; DE="kde"; MIRROR="http://archive.ubuntu.com/ubuntu/";;
25) DISTRO="ubuntu"; SUITE="resolute"; DE="xfce"; MIRROR="http://archive.ubuntu.com/ubuntu/";;
26) DISTRO="ubuntu"; SUITE="resolute"; DE="lxqt"; MIRROR="http://archive.ubuntu.com/ubuntu/";;
27) DISTRO="ubuntu"; SUITE="resolute"; DE="mate"; MIRROR="http://archive.ubuntu.com/ubuntu/";;
28) DISTRO="ubuntu"; SUITE="resolute"; DE="cinnamon"; MIRROR="http://archive.ubuntu.com/ubuntu/";;
29) DISTRO="kali"; SUITE="kali-rolling"; DE="none"; MIRROR="http://http.kali.org/kali";;
30) DISTRO="linuxmint"; SUITE="noble"; DE="cinnamon"; MIRROR="http://archive.ubuntu.com/ubuntu/"; MINT_REPO="http://ftp.icm.edu.pl/pub/Linux/dist/linuxmint/packages zena/";;
31) DISTRO="linuxmint"; SUITE="noble"; DE="mate"; MIRROR="http://archive.ubuntu.com/ubuntu/"; MINT_REPO="http://ftp.icm.edu.pl/pub/Linux/dist/linuxmint/packages zena/";;
32) DISTRO="linuxmint"; SUITE="noble"; DE="xfce"; MIRROR="http://archive.ubuntu.com/ubuntu/"; MINT_REPO="http://ftp.icm.edu.pl/pub/Linux/dist/linuxmint/packages zena/";;
*) echo "Invalid choice"; exit 1;;
esac

if [ "$DISTRO" = "$CURRENT_DISTRO" ] && [ "$SUITE" = "$CURRENT_VERSION" ]; then
  echo "Warning: You are reinstalling your current OS. Proceed? [y/N]"
  read -p "" yn
  if [[ $yn != [Yy]* ]]; then
    exit 1
  fi
fi

if [ "$DISTRO" != "debian" ]; then GRAPHIC="$DE"; fi

if [ "$EUID" -ne 0 ]; then 
  echo "Run as root!"
  exit 1
fi

copy_user_configuration() {

  UID_MIN=$(grep '^UID_MIN' /etc/login.defs | sed 's/[^0-9]//g')
  UID_MAX=$(grep '^UID_MAX' /etc/login.defs | sed 's/[^0-9]//g')

  touch wheel_users
  echo "Found user: root"
  getent passwd root  > passwd_delta
  getent shadow root  > shadow_delta
  getent group root   > group_delta
  getent gshadow root > gshadow_delta

  normaluid=1000

  for d in $(getent passwd | awk -F: "(\$3 >= $UID_MIN && \$3 <= $UID_MAX) {printf \"%s\n\",\$1}") ; do

    IFS=':' read -r -a arr <<< "$(getent group "$d")"
    echo "${arr[0]}:${arr[1]}:$normaluid:${arr[3]}" >> group_delta

    IFS=':' read -r -a arr <<< "$(getent passwd "$d")"
    echo "${arr[0]}:${arr[1]}:$normaluid:$normaluid:${arr[4]}:${arr[5]}:${arr[6]}" >> passwd_delta

    if id -G -n "$d" | grep -qw 'sudo\|wheel'; then
      printf "Found user (sudo/wheel): %s", "$d"
      echo "$d" >> wheel_users
    else
      printf "Found user: %s", "$d"
    fi

    if [[ "${arr[2]}" != "$normaluid" ]]; then
      printf " (uid %s -> %s)" "${arr[2]}" "$normaluid"
    else
      printf " (uid %s)" "${arr[2]}"
    fi

    printf "\n"

    ((normaluid+=1))

    # getent shadow available only in glibc
    getent gshadow &> /dev/null
    if [[ "$?" == "1" ]]; then
      grep "^$d:" /etc/gshadow >> gshadow_delta
      grep "^$d:" /etc/shadow >> shadow_delta
    else
      getent gshadow "$d" >> gshadow_delta
      getent shadow "$d"  >> shadow_delta
    fi

  done
  SET_SPACE_PASSWORD=0
  NEW_NONSPACE_PASSWORD=""
}

if [ ! -f config.default ]; then
  read -p "Do you want to copy user configuration from current system? [Y/n] " -r yn
  if [[ $yn == [Nn]* ]]; then 
    password_confirmed=false
    SET_SPACE_PASSWORD=0
    read -p "Do you want to set ' ' password for root, i. e. space password [y/N] " -r yn
    if [[ $yn == [Yy]* ]]; then
      echo "Root password will be ' ', i. e. space"
      SET_SPACE_PASSWORD=1
      password_confirmed=true
    fi
    while [[ "$password_confirmed" != true ]]; do
      read -p "Set new password for root: " -r NEW_NONSPACE_PASSWORD
      read -p "New root password will be \"$NEW_NONSPACE_PASSWORD\", is it right? [Y/n] " -r yn
      if [[ $yn != [Nn]* ]]; then
        password_confirmed=true
      fi
    done
  else
    copy_user_configuration
  fi

  GRAPHICAL_ENVIRONMENTS=("gnome" "kde" "xfce" "lxqt" "cinnamon" "mate")
  NETWORKMANAGER=1

  if [ "$DISTRO" = "debian" ]; then
    while true; do
      echo "Available graphical environments: gnome kde xfce lxqt cinnamon mate"
      read -p "Do you want to install one of these graphical environments? (type \"no\" to not install any) " -r yn
      if [[ $yn == "no" ]]; then 
        GRAPHIC="no"
      
        read -p "Do you want to use NetworkManager? [Y/n] " -r yn
        if [[ $yn == [Nn]* ]]; then 
          NETWORKMANAGER=0
        fi
      
        break
      else
        match=false
        for str in "${GRAPHICAL_ENVIRONMENTS[@]}"; do
          if [[ "$yn" == "$str" ]]; then
      	  match=true
      	  break
      	fi
        done
        if $match; then
          GRAPHIC="$yn"
          break
        fi
      fi
    done
  else
    read -p "Do you want to use NetworkManager? [Y/n] " -r yn
    if [[ $yn == [Nn]* ]]; then 
      NETWORKMANAGER=0
    fi
  fi

  GRAPHICS_DRIVERS=("amd" "intel" "nouveau-nvidia" "nvidia" "nvidia-open" "virt-machine" "all-open")

  while true; do
    echo "Available graphics drivers: amd intel nouveau-nvidia nvidia nvidia-open virt-machine all-open"
    read -p "Choose one of them based on your GPU (type \"no\" to not install any) " -r yn
    if [[ $yn == "no" ]]; then 
      GRAPHICS_DRIVER="no"
      break
    else
      match=false
      for str in "${GRAPHICS_DRIVERS[@]}"; do
        if [[ "$yn" == "$str" ]]; then
    	  match=true
    	  break
    	fi
      done
      if $match; then
        GRAPHICS_DRIVER="$yn"
        break
      fi
    fi
  done

  SOUND_SERVERS=("pulseaudio" "pipewire")

  while true; do
    read -p "Do you want to install pipewire or pulseaudio as sound server (type \"no\" to not install any) " -r yn
    if [[ $yn == "no" ]]; then 
      SOUND_SERVER="no"
      break
    else
      match=false
      for str in "${SOUND_SERVERS[@]}"; do
        if [[ "$yn" == "$str" ]]; then
    	  match=true
    	  break
    	fi
      done
      if $match; then
        SOUND_SERVER="$yn"
        break
      fi
    fi
  done

  read -p "Set hostname for new system: [debianify] " -r NEWHOSTNAME
  if [ -z "$NEWHOSTNAME" ]; then
    NEWHOSTNAME=debianify
  fi

  LOCALTIME=$(cat /etc/timezone 2> /dev/null)
  if [ -z "$LOCALTIME" ]; then
    # in some strange distros timedatectl does not have operation show
    LOCALTIME="$(timedatectl | grep 'Time zone' | sed 's/.*Time zone: //;s/ .*//')"
    LOCALTIME="${LOCALTIME#*=}"
  fi
  if [ -z "$LOCALTIME" ]; then
    LOCALTIME="$(readlink -f /etc/localtime 2> /dev/null | sed 's/.*\/zoneinfo\///' )"
  fi
  if [ "$LOCALTIME" == "/etc/localtime" ]; then
    LOCALTIME="Europe/Moscow"
  fi
  if [ -z "$LOCALTIME" ]; then
    LOCALTIME="Europe/Moscow"
  fi
  read -p "Set timezone for new system in \"region/city\" format: [$LOCALTIME] " -r INPUTLOCALTIME
  if [ -n "$INPUTLOCALTIME" ]; then
    LOCALTIME=$INPUTLOCALTIME
  fi

  DRACUT=0
  if [[ $(dmsetup ls) != "No devices found" ]] && command -v dmsetup &> /dev/null; then 
    echo -e "\e[1m\e[40m\e[93mWARNING: CRAZY DISK CONFIGURATION FOUND (LUKS/LVM)\e[0m"
    echo -e "\e[1m\e[40m\e[93mNOTE THAT INITRAMFS WILL BE GENERATED BY DRACUT\e[0m"
    DRACUT=1
  else
    read -p "Do you want to use dracut instead of mkinitcpio to generate initramfs? Answer 'y' only if you have some unusual disk configuration with LUKS or LVM. [y/N] " -r yn
    if [[ $yn == [Yy]* ]]; then 
      DRACUT=1
    fi
  fi

  REFLECTOR=1
  read -p "Do you want to use reflector to select fastest mirrors? Otherwise, mirrors from 'mirrorlist.default' will be used. [Y/n] " -r yn
  if [[ $yn == [Nn]* ]]; then 
    REFLECTOR=0
  fi

  FORCE_REBOOT_AFTER_INSTALLATION=1
  read -p "Do you want to reboot after installation? [Y/n] " -r yn
  if [[ $yn == [Nn]* ]]; then 
    FORCE_REBOOT_AFTER_INSTALLATION=0
  fi

else
  source config.default
  echo "Using values from config.default"
  echo "Note that when using a prepared config, you must be sure that the values are correct"
  if [ "$COPY_USER_CONFIGURATION" -eq 1 ]; then
    copy_user_configuration
  fi
fi

echo "GRAPHIC=$GRAPHIC" > config
echo "DISTRO=$DISTRO" >> config
echo "SUITE=$SUITE" >> config
echo "MIRROR=$MIRROR" >> config
echo "DE=$DE" >> config
if [ "$DISTRO" = "linuxmint" ]; then echo "MINT_REPO=$MINT_REPO" >> config; fi
{
  echo "SET_SPACE_PASSWORD=$SET_SPACE_PASSWORD"
  echo "NEW_NONSPACE_PASSWORD=$NEW_NONSPACE_PASSWORD"
  echo "DRACUT=$DRACUT"
  echo "NETWORKMANAGER=$NETWORKMANAGER"
  echo "LOCALTIME=$LOCALTIME"
  echo "NEWHOSTNAME=$NEWHOSTNAME"
  echo "REFLECTOR=$REFLECTOR"
  echo "GRAPHICS_DRIVER=$GRAPHICS_DRIVER"
  echo "SOUND_SERVER=$SOUND_SERVER"
  echo "FORCE_REBOOT_AFTER_INSTALLATION=$FORCE_REBOOT_AFTER_INSTALLATION"
} >> config

set -e

if [ -d '/debian-bootstrap' ]; then
  echo 'Found /debian-bootstrap, using existing'
else
  echo 'Running debootstrap'
  debootstrap --arch=amd64 $SUITE /debian-bootstrap $MIRROR
fi

echo "Mounting root to bootstrap"
mkdir -p /debian-bootstrap/host-system
mount --bind /debian-bootstrap /debian-bootstrap
mount --rbind / /debian-bootstrap/host-system
mount --bind /proc /debian-bootstrap/proc
mount --bind /sys /debian-bootstrap/sys
mount --bind /dev /debian-bootstrap/dev

mkdir -p /debianify-config

cp stage2.sh /debian-bootstrap
cp stage3.sh /debianify-config
chmod +x /debian-bootstrap/stage2.sh
chmod +x /debianify-config/stage3.sh

set +e

if [ -f passwd_delta ]; then
  cp wheel_users /debianify-config/wheel_users
  grep "\S" passwd_delta  > /debianify-config/passwd_delta
  grep "\S" shadow_delta  > /debianify-config/shadow_delta
  grep "\S" group_delta   > /debianify-config/group_delta
  grep "\S" gshadow_delta > /debianify-config/gshadow_delta
fi

cp /etc/fstab /debianify-config
cp /etc/crypttab /debianify-config

cp 90-dracut-install.hook /debianify-config
cp 60-dracut-remove.hook /debianify-config
cp dracut-install /debianify-config
cp dracut-remove /debianify-config

cp config /debianify-config/config


dmesg -n 1

echo -e "\e[1m\e[46m\e[97mEXECUTING CHROOT TO DEBIAN BOOTSTRAP\e[0m"
if [[ $(tty) == /dev/tty* ]]; then
  env -i "$(command -v chroot)" /debian-bootstrap bash --init-file /etc/profile /stage2.sh
elif [[ -n "$SSH_CONNECTION" ]]; then
  echo -e "\e[1m\e[40m\e[93mInstalling via ssh seems like a bad idea. However, it will probably work but you will have to setup ssh manually after installation.\e[0m"
  env -i "$(command -v chroot)" /debian-bootstrap bash --init-file /etc/profile /stage2.sh
elif [[ "$FORCE_NO_OPENVT" == "1" ]]; then
  echo -e "\e[1m\e[40m\e[93mGot FORCE_NO_OPENVT option. As you wish...\e[0m"
  env -i "$(command -v chroot)" /debian-bootstrap bash --init-file /etc/profile /stage2.sh
else
  if command -v openvt &> /dev/null; then 
    openvt -c 13 -f -s -- env -i "$(command -v chroot)" /debian-bootstrap bash --init-file /etc/profile /stage2.sh
  else
    echo "Cannot run openvt. You should manually run this script in tty. If you believe that this is a mistake or you are running script from some kind of remote shell, run script with environment variable FORCE_NO_OPENVT=1"
  fi
fi
