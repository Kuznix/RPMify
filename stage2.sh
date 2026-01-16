#!/usr/bin/env bash

echo -e "\e[1m\e[46m\e[97mSTAGE 2 ACTIVATED\e[0m"

cd /host-system || exit 1

source /host-system/debianify-config/config

echo 'nameserver 1.1.1.1' > /etc/resolv.conf
echo 'nameserver 8.8.8.8' >> /etc/resolv.conf

echo -e "\e[1m\e[46m\e[97mSETTING UP APT\e[0m"

echo "deb $MIRROR $SUITE main contrib non-free" > /etc/apt/sources.list

if [ "$DISTRO" = "ubuntu" ] || [ "$DISTRO" = "linuxmint" ]; then
  echo "deb $MIRROR $SUITE-updates main contrib non-free" >> /etc/apt/sources.list
  echo "deb $MIRROR $SUITE-security main contrib non-free" >> /etc/apt/sources.list
  echo "deb $MIRROR $SUITE-backports main contrib non-free" >> /etc/apt/sources.list
fi

if [ "$DISTRO" = "kali" ]; then
  echo "deb $MIRROR $SUITE main contrib non-free" > /etc/apt/sources.list
fi

if [ "$DISTRO" = "linuxmint" ]; then
  echo "deb $MINT_REPO main upstream import backport" >> /etc/apt/sources.list
fi

apt update

if [ "$REFLECTOR" -eq 1 ]; then
  echo "Using default mirrors"
fi

echo -e "\e[1m\e[41m\e[97mDESTROYING HOST SYSTEM IN 5 SECONDS\e[0m"

for i in 5 4 3 2 1; do
  printf "%s..." "$i"
  sleep 1
done
printf "\n"

echo -e "\e[1m\e[41m\e[97mDESTROYING HOST SYSTEM\e[0m"
rm -rf bin etc lib lib64 sbin srv usr var
echo -e "\e[1m\e[41m\e[97mHOST SYSTEM DESTROYED\e[0m"

cd /

echo -e "\e[1m\e[46m\e[97mINSTALLING BASE SYSTEM\e[0m"

debootstrap $SUITE /host-system $MIRROR

echo -e "\e[1m\e[46m\e[97mCOPYING FSTAB\e[0m"

cp /host-system/debianify-config/fstab /host-system/etc/fstab
cp /host-system/debianify-config/crypttab /host-system/etc/crypttab

chmod +x /host-system/debianify-config/stage3.sh

if [ -f /host-system/debianify-config/passwd_delta ]; then
  echo -e "\e[1m\e[46m\e[97mCONFIGURING USERS\e[0m"

  for word in passwd shadow group gshadow; do
    wrd=$(tail -n+2 /host-system/etc/${word})
    echo -e "$(grep '^root:' /host-system/debianify-config/${word}_delta)\n$wrd\n$(grep -v '^root:' /host-system/debianify-config/${word}_delta)\n" | grep "\S" > /host-system/etc/${word}
  done
fi

echo -e "\e[1m\e[46m\e[97mEXECUTING CHROOT TO NEW SYSTEM\e[0m"
chroot /host-system /debianify-config/stage3.sh || echo -e "\e[1m\e[41m\e[97mOOOPS... CANNOT CHROOT TO NEW SYSTEM\!\e[0m"
echo "Dropping to shell. Note that you are in chroot and your old system is destroyed."
bash
