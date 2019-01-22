Windows
=======

Boot
====
To fix various issues with boot use Win10 recovery ISO (on thumbdrive), go to
"Repair this PC" and "Troubleshooting". From there run "Command Line".

Recreate ESD + MSR
------------------
- Run `diskpart` and delete ESD (SYSTEM) and MSR partitions
- Create new ones:
  ```
  create partition efi size=256
  select partition N
  format quick fs=fat32 label="SYSTEM"
  assign letter=X
  create partition msr size=16
  ```
- Create EFI directory on newly created ESD and copy files from C:
  ``` dos
  mkdir G:\EFI\Microsoft\Boot
  xcopy /s C:\Windows\Boot\EFI\*.* G:\EFI\Microsoft\Boot
  ```
- Re-create BCD Bootloader configuration and write to EFI
  ```
  G:
  cd EFI\Microsoft\Boot
  bcdedit /createstore BCD
  bcdedit /store BCD /create {bootmgr} /d "Windows Boot Manager"
  bcdedit /store BCD /creade /d "Microsoft Windows 10" /application osloader
  ```
  That will return GUID of entry. Copy that and do following commands:
  ```
  bcdedit /store BCD /set {bootmgr} default GUID
  bcdedit /store BCD /set {bootmgr} path \EFI\Microsoft\Boot\bootmgfw.efi
  bcdedit /store BCD /set {bootmgr} displayorder {default}
  bcdedit /store BCD /set {default} device partition=C:
  bcdedit /store BCD /set {default} osdevice partition=C:
  bcdedit /store BCD /set {default} path \Windows\System32\winload.efi
  bcdedit /store BCD /set {default} systemroot \Windows
  ```

Drivers
=======
This section describes how to solve some driver issues.

Intel Drivers
-------------
In some cases vendors don't allow to install newer version of Intel GPU
drivers. To override Windows/Vendor driver version:

- Download drivers from Intel, exe won't install with "not validated" error.
- Rename to .zip and extract somewhere.
- Go to Device Manager and under Display Adapters find Intel.
- Open Properties and go to Driver tab, click "Update Driver".
- Click "Browse My Computer" and navigate to extracted directory.
- If needed point Windows to proper .inf file.
- As Windows would replace driver automatically use wushowhide.diagcab to
  Hide "Intel Corporation - Extension" update
