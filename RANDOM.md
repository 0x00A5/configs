### Keyring

To use gnome-keyring with a minimal sway setup, install gnome keyring and gnome keyring pam.
With display manager, edit the display manager's pam file. Otherwise, edit `/etc/pam.d/login`.

Add these three lines in their sections:
```
auth optional pam_gnome_keyring.so
session optional pam_gnome_keyring.so auto_start
password optional pam_gnome_keyring.so
```

This ensures that on login, the login keyring can be unlocked by entering the login password.
