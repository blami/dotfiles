# Role `base`
Base role that does mostly Ubuntu Linux OS-level setup, namely:

* Configures WSL to store UNIX file attributes on NTFS.
* Re-configures `apt` to **not install** recommendations.
* Installs essential APT 3rd party repositories, GPG keys and packages.
* Removes some unneeded packages.
* Changes `sudo` behavior to retain environment.

NOTE: In order to take effect this role needs to install `wsl.conf` **and
restart WSL** which will kill it when run on WSL system. In such case re-run is
needed which will go ahead as `wsl.conf` will be detected in place.
