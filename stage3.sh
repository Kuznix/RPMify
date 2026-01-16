#!/usr/bin/env bash

echo -e "\e[1m\e[46m\e[97mSTAGE 3 ACTIVATED\e[0m"

if [ -f /debianify-config/wheel_users ]; then
  while IFS="" read -r p || [ -n "$p" ]
  do
    echo -e "\e[1m\e[46m\e[97mADD USER $p TO GROUP sudo\e[0m"
    usermod -a -G sudo "$p"
  done < /debianify-config/wheel_users

  echo "%sudo ALL=(ALL:ALL) ALL" > /etc/sudoers.d/00_sudo
fi

if [ -f /debianify-config/passwd_delta ]; then
  while IFS="" read -r p || [ -n "$p" ]
  do
    IFS=':' read -r -a arr <<< "$p"
    echo -e "\e[1m\e[46m\e[97mCHOWN HOME DIRECTORY ${arr[5]} FOR USER ${arr[0]}\e[0m"
    chown -R "${arr[0]}:${arr[0]}" "${arr[5]}" 
  done < /debianify-config/passwd_delta
fi

source /debianify-config/config

echo -e "\e[1m\e[46m\e[97mPERFORMING BASIC CONFIGURATION\e[0m"
ln -sf "/usr/share/zoneinfo/$LOCALTIME" /etc/localtime
timedatectl set-timezone $LOCALTIME
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/default/locale
echo "$NEWHOSTNAME" > /etc/hostname

if [[ -n "$NEW_NONSPACE_PASSWORD" ]]; then
  echo "root:$NEW_NONSPACE_PASSWORD" | chpasswd
fi

if [ "$SET_SPACE_PASSWORD" -eq 1  ]; then
  echo "root: " | chpasswd
fi

rm -rf /boot/*

# install DRACUT and tools for it
if [ "$DRACUT" -eq 1  ]; then
  echo -e "\e[1m\e[40m\e[93mINSTALLING DRACUT AND LVM2\e[0m"
  apt install -y lvm2 mdadm dracut
  
  echo -e "\e[1m\e[40m\e[93mINSTALL KERNEL\e[0m"
fi

apt install -y linux-image-amd64

if [[ $GRAPHICS_DRIVER != "no" ]]; then
  echo -e "\e[1m\e[46m\e[97mINSTALLING GRAPHICS DRIVER\e[0m"
  if [[ "$GRAPHICS_DRIVER" == "amd" ]]; then
    apt install -y xserver-xorg-video-amdgpu mesa-vulkan-drivers libva-mesa-driver xserver-xorg
  elif [[ "$GRAPHICS_DRIVER" == "intel" ]]; then
    apt install -y xserver-xorg-video-intel mesa-vulkan-drivers intel-media-va-driver xserver-xorg
  elif [[ "$GRAPHICS_DRIVER" == "nouveau-nvidia" ]]; then
    apt install -y xserver-xorg-video-nouveau mesa-vulkan-drivers xserver-xorg
  elif [[ "$GRAPHICS_DRIVER" == "nvidia" ]]; then
    apt install -y nvidia-driver xserver-xorg
  elif [[ "$GRAPHICS_DRIVER" == "nvidia-open" ]]; then
    apt install -y nvidia-driver xserver-xorg
  elif [[ "$GRAPHICS_DRIVER" == "virt-machine" ]]; then
    apt install -y xserver-xorg-video-vmware mesa-vulkan-drivers xserver-xorg
  else
    apt install -y xserver-xorg-video-amdgpu xserver-xorg-video-intel xserver-xorg-video-nouveau xserver-xorg-video-vmware mesa-vulkan-drivers xserver-xorg
  fi
fi

if [[ $SOUND_SERVER != "no" ]]; then
  echo -e "\e[1m\e[46m\e[97mINSTALLING SOUND SERVER\e[0m"
  if [[ "$SOUND_SERVER" == "pipewire" ]]; then
    apt install -y pipewire
  elif [[ "$SOUND_SERVER" == "pulseaudio" ]]; then
    apt install -y pulseaudio
  fi
fi

if [[ $GRAPHIC != "no" ]]; then

  # delete themes and other garbage from the old system
  for d in /home/*/ ; do
    echo "$d"
    rm -rf "$d/.config/dconf"
    rm -rf "$d/.config/gtk-3.0"
    rm -rf "$d/.config/gtk-4.0"
    rm -rf "$d/.cache/*"

    rm -rf "$d/.local/share/themes"

    rm -rf "$d/.local/share/icons"
    rm -rf "$d/.local/share/fonts"
    rm -rf "$d/.local/share/mime"
    rm -rf "$d/.local/share/applications"
    rm -rf "$d/.local/share/desktop-directories"
    rm -rf "$d/.local/share/pixmaps"
    rm -rf "$d/.local/share/sounds"
    rm -rf "$d/.local/share/gnome"
    rm -rf "$d/.local/share/kde"
    rm -rf "$d/.local/share/xfce4"
    rm -rf "$d/.local/share/lxqt"
    rm -rf "$d/.local/share/cinnamon"
    rm -rf "$d/.local/share/mate"
  done
fi

if [[ $GRAPHIC != "no" ]]; then
  if [ "$DISTRO" = "debian" ]; then
    if [ "$GRAPHIC" = "gnome" ]; then
      apt install -y gnome-session gdm3
    elif [ "$GRAPHIC" = "kde" ]; then
      apt install -y kde-standard sddm
    elif [ "$GRAPHIC" = "xfce" ]; then
      apt install -y xfce4 xfce4-goodies lightdm
    elif [ "$GRAPHIC" = "lxqt" ]; then
      apt install -y lxqt sddm
    elif [ "$GRAPHIC" = "cinnamon" ]; then
      apt install -y cinnamon-desktop-environment lightdm
    elif [ "$GRAPHIC" = "mate" ]; then
      apt install -y mate-desktop-environment lightdm
    fi
  elif [ "$DISTRO" = "ubuntu" ]; then
    if [ "$GRAPHIC" = "gnome" ]; then
      apt install -y ubuntu-desktop
    elif [ "$GRAPHIC" = "kde" ]; then
      apt install -y kubuntu-desktop
    elif [ "$GRAPHIC" = "xfce" ]; then
      apt install -y xubuntu-desktop
    elif [ "$GRAPHIC" = "lxqt" ]; then
      apt install -y lubuntu-desktop
    elif [ "$GRAPHIC" = "mate" ]; then
      apt install -y ubuntu-mate-desktop
    elif [ "$GRAPHIC" = "cinnamon" ]; then
      apt install -y ubuntu-cinnamon-desktop
    fi
  elif [ "$DISTRO" = "kali" ]; then
    apt install -y kali-desktop-gnome
  elif [ "$DISTRO" = "linuxmint" ]; then
    if [ "$GRAPHIC" = "cinnamon" ]; then
      apt install -y mint-meta-cinnamon
    elif [ "$GRAPHIC" = "mate" ]; then
      apt install -y mint-meta-mate
    elif [ "$GRAPHIC" = "xfce" ]; then
      apt install -y mint-meta-xfce
    fi
  fi
fi

if [ "$NETWORKMANAGER" -eq 1 ]; then
  apt install -y network-manager
fi

apt install -y grub-pc neofetch sudo vim bash-completion efibootmgr xfsprogs btrfs-progs

if [ "$NETWORKMANAGER" -eq 0 ]; then
  apt install -y dhcpcd wpasupplicant
fi

echo -e "\e[1m\e[46m\e[97mINSTALLATION COMPLETED\e[0m"

if [ "$FORCE_REBOOT_AFTER_INSTALLATION" -eq 1 ]; then
  echo -e "\e[1m\e[46m\e[97mREBOOTING IN 10 SECONDS\e[0m"
  for i in 10 9 8 7 6 5 4 3 2 1; do
    printf "%s..." "$i"
    sleep 1
  done
  printf "\n"
  reboot
else
  echo -e "\e[1m\e[46m\e[97mINSTALLATION COMPLETED. PLEASE REBOOT MANUALLY.\e[0m"
fi
