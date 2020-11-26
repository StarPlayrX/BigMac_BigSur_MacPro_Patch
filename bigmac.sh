#!/bin/sh

#  sudo ./preinstall.sh
#  BigMac MacPro pre-install tool v0.0.12
#  Created by StarPlayrX on 10.17.2020

#AutoSwitch to current directory
dir=$(dirname "$0")
cd "$dir"

bigmac=$(pwd)

printf '\e[48;5;0m\e[K'
printf '\e[K'

printf "\e[38;5;172m=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
printf "\r\n[38;5;112m -=> 🥤 Big Sur Downloader 🍟 Big Mac USB Installer 🍔 mini bigmac partition <=-"
printf '\e[K'
printf "\r\n\e[38;5;172m=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
printf '\e[K'
printf "\r\n[38;5;112m"
printf '\e[K'
printf "\r\n[38;5;112m"
printf '\e[K'

read -p "📦 Would you like to download Big Sur macOS 11.0.1 (20B29)? [y]: " install


if [[ "$install" == *"y"* ]]
    then
        printf '\e[K'
        echo
        printf '\e[K'
        rm -Rf ~/Downloads/InstallAssistant.pkg
        curl http://swcdn.apple.com/content/downloads/50/49/001-79699-A_93OMDU5KFG/dkjnjkq9eax1n2wpf8rik5agns2z43ikqu/InstallAssistant.pkg -o ~/Downloads/InstallAssistant.pkg
        echo
        printf '\e[K'
        echo 'Installing the Install macOS Big Sur.app via InstallAssistant.pkg'
        sudo installer -pkg ~/Downloads/InstallAssistant.pkg -target /
fi

    echo
    printf '\e[K'
    
read -p "🍦 Would you like to create a USB Installer, excluding thumb drives [y]: " create
    echo
    printf '\e[K'
    
while [ ! -d "/Applications/Install macOS Big Sur.app" ] && [[ "$create" == *"y"* ]]

do
    if [ ! -d "/Applications/Install macOS Big Sur.app" ] && [[ "$create" == *"y"* ]]
        then
            read -p "🤯 Please place the Install macOS Big Sur.app in your 🍎 Applications 📂 Folder and press Return: " install
    fi
done

disk=""
media=""
volumes="/Volumes/"


if [[ "$create" == *"y"* ]]
    then
        while [[ "$media" != *"$volumes"* ]] || [[ "$disk" != *"disk"* ]]
            do
                if [[ "$media" != *"$volumes"* ]] || [[ "$disk" != *"disk"* ]]
              then
                read -p "🍪 Please drag your external USB disk here. The entire 💾 USB disk will be erased -> " media
                disk=$(diskutil info "$media" | grep 'Part of Whole:' | awk '{print $4}')
                
                echo
                printf '\e[K'
                echo "🔍 Detected Whole disk: "$disk
                printf '\e[K'
    
                number=$RANDOM
                
                disk="$disk"
                
                ##echo '🧻 Wiping clean the USB disk your missing toilet paper.'
                ##printf '\e[K'
                ##echo
                ##printf '\e[K'
                ##diskutil erasedisk jhfs+ bmo "$disk"
                
                echo
                printf '\e[K'
                
                echo '🍩 Paritioning the drive with bigmac and install volumes.'
                printf '\e[K'
                echo
                printf '\e[K'
                sudo diskutil partitionDisk "$disk" GPT jhfs+ bigmac_"$disk$number" 1g jhfs+ installer_"$disk$number" 0
                
                echo
                printf '\e[K'
                echo 🍟 Copying bigmac patcher to volume: bigmac_"$disk$number"
                echo
                printf '\e[K'
                
                sudo ditto -v $bigmac /Volumes/bigmac_"$disk$number"
                
                echo
                printf '\e[K'
                echo 🍔 Renaming bigmac_"$disk$number" volume to bigmac
                echo
                printf '\e[K'
                diskutil rename bigmac_"$disk$number" bigmac
                
                echo
                printf '\e[K'
                echo 🦾 Creating bootable installer using volume: installer_"$disk$number"
                
                printf '\e[K'
                echo
                sudo /Applications/'Install macOS Big Sur.app'/Contents/Resources/createinstallmedia --nointeraction --volume /Volumes/installer_"$disk$number"

                bootplist="com.apple.Boot.plist"
                boot="/💾/"
                echo "Boot.plist -v -no_compat_check to USB Installer"
                systemconfig="/Volumes/Install macOS Big Sur/Library/Preferences/SystemConfiguration/"
                bootdisk=$(pwd)$boot
                base="base/"
                rm -Rf "$systemconfig$bootplist"
                ditto -v "$bootdisk$base$bootplist" "$systemconfig$bootplist"
                sudo chown -R 0:0 "$systemconfig$bootplist"
                chmod -R 755 "$systemconfig$bootplist"
                echo
                printf '\e[K'
                ##echo "☠️  Renaming Install macOS Big Sur volume to BigMac11USB"
                ##diskutil rename "Install macOS Big Sur" "BigMac11USB"
                ##printf '\e[K'
            fi
        done
fi


echo
echo "Reboot -> hold down OPTION key -> macOS Big Sur Installer"
echo
echo "Workflow -> Boot USB -> Preinstall.sh -> Install -> Postinstall.sh"
echo
echo "Boot the USB installer, from its Terminal type:"
echo
echo "cd /Volumes/bigmac"
echo "./preinstall.sh"
echo
echo "open Big Sur Installer"
echo
echo "after install is completed (hint: it takes 3 stages to complete.)"
echo
echo "Boot the USB installer, from its Terminal type:"
echo
echo "cd /Volumes/bigmac"
echo "./postinstall.sh"
echo
echo "Wait, no Boot Screen? I'll leave that adventure up to you."
echo
echo "Your mileage may vary. Support is not included with this software."
echo
