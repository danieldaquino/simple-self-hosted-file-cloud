# A link to /etc/samba/smb.conf might already exist, so we remove it first
# to avoid a "File exists" error.
rm -f /etc/samba/smb.conf

if [ "$TIME_MACHINE" = "true" ]; then
    ln -s /config/timemachine.conf /etc/samba/smb.conf
else
    ln -s /config/normal.conf /etc/samba/smb.conf
fi

/usr/sbin/smbd -F
