LUKS Device Encryption
======================
This describes how to encrypt device using LUKS.

Randomizing Drive
-----------------
Good practice is to fill drive with noise so in event of attack is less
obvious where are encrypted data.

    # openssl enc -aes-256-ctr -nosalt -pass \
        pass:"$(dd if=/dev/urandom bs=128 count=1 2>/dev/null | base64)" \
        < /dev/zero \
        | \
        pv --progress --eta --rate --bytes \
            --size $(</proc/partitions awk '$4=="'/dev/drive'" \
                {print sprintf("%.0f",$3*1024)}') \
        | \
        dd of=/dev/drive bs=2M

Encrypting Drive
----------------
To encrypt drive use command ``cryptsetup luksFormat``:

    # cryptsetup -v \
        --cipher aes-xts-plain64 --key-size 256 --hash sha256 \
        --iter-time 2000 \
        --use-random \
        --verify-passphrase luksFormat /dev/drive

/etc/crypttab
-------------
Once encrypted device should be added to /etc/crypttab so it can be unlocked
using command ``cryptdisks_start id``

    id1  UUID=1234-5678  none              luks,discard,noauto,nofail
    id2  UUID=90ab-cdef  /path/to/keyfile  luks,discard,auto
