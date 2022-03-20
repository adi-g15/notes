**Result**: KDE was using powerdevil to show battery percent, wo upower.service ko use kr rha tha, upower.service fail ho rha tha isliye KDE bhi start hone me time leta tha (mtlb taskbar, notifications etc. dikhne tk me, wallpaper and keyboard shortcuts kaam krte the), upower.service was failing since kernel didn't have CONFIG_USER_NS

1. Custom kernel pe KDE ko load hone me bahut time lgta tha

2. Kucch din baad, aaj dekha iska kya ho skta h

3. Kaafi dhundha tha, nahi mila kuchh bhi, na hi dmesg me tha kuchh... yaha thoda bhatak bhi gya tha mtlb Arch wiki se performance improve krne ka pdhne lga for eg. khud ke multiple initramfs bnaye boot nhi hue phir bnaye etc.

4. Kmsekam logs dekhna chahta tha, to sddm kya command run krta h etc etc bhi try kiya kaam nhi kiye (ie. required X server to be started, like uske saath start hi na hota tha)... phir kisi running process ka stdout kaise dekhe wo bhi dhundha tha kuchh nhi mil paya ek gdb ka mila but yha pe lagu nhi hota

4. Phir kahi jake ek reply me tha arch wiki ka problem asking site pe ye commands: `kquit plasmashell`; `plasmashell` ka,
 run kiya, kquit to nhi tha kquit5 tha but eitherway kaam ho gya, ab plasmashell khtm but konsole, keyboard shortcuts etc still working, phir plasmashell ko manually run kiya, file me log save kiya, phir zen kernel se boot krke waha ka save kiya (jaha sahi kaam kr rha tha), ek do baar aur lga phir inko diff kiya, pta chala No such signal QDBusAbstractInterface::DeviceAdded krke error hai ek, uske baare me dhundha nhi mila, code dekhne ka bhi sochha tha, next UPower:: related error tha 2.

5. journalctl aur systemctl ka kai attempt baad sahi argument se upower ka log bhi mila, phir uska service file dekh ke manually run kiya, wo /usr/bin me nhi tha, balki /lib/ me tha..., eitherway wo kaam kiya manually run krne pe, mereko lga phir kuchh aur problem h, status code 217 dikha rha tha journalctl jo ki kuchh nhi mila net pe, sayad valid errno bhi nhi wo

6. Phir upower wale me hi ye mila: upower.service: Failed to set up user namespacing: Invalid argument, ab thoda ghanti bja, mtlb kernel config bahut baar kiya kuchh dino me, to dhyan tha kuchh user namespacing tha, kernel config grep kiya Namespac to nhi mila user krke kuchh bhi, to sayad wo to hai, phir yahi search kiya to same error wala https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=939510 ye mila, usme maintainer suggest kiya ek aur bande ka tha ye problem dono custom kernel, to wahi panauti h sayad tumlog ka, phir user likha "CONFIG_USER_NS was not set. Thanks for the hint."… bas ab ghanti baj gya mera bhi, grep kiya kernel config me "CONFIG_USER_NS", wo set nhi tha... next compilation me krta hu phir :)

PS: Actually is se jyada bhi kiya tha, for eg. 4 ke baad zen kernel aur mera kernel config me diff krke grep (-i) kiya tha power, usme differences the mai sochha wo problem h next time fix krke dekhta hu, but abhi tk 5.16-rc9 nhi aaya tha, mai usiko compile krunga direct, to aur dhundhne lga... and 6 me wo link pe jane se pehle upower ka website pe jake phir git clone bhi kiya tha code upower ka ye error kaun line declare kiya h nhi mila us se phir Failed to set up user namespacing me matha thanka and rest is written

