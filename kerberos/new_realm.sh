#!/bin/sh -e

cat <<eof
This script should be run on the master KDC/admin server to initialize
a Kerberos realm.  It will ask you to type in a master key password.
This password will be used to generate a key that is stored in
/etc/krb5kdc/stash.  You should try to remember this password, but it
is much more important that it be a strong password than that it be
remembered.  However, if you lose the password and /etc/krb5kdc/stash,
you cannot decrypt your Kerberos database.
eof

kdb5_util create -s -P storm
/etc/init.d/krb5-kdc start || true
/etc/init.d/krb5-admin-server start ||true 
if [ ! -r /etc/krb5kdc/kadm5.acl ] ; then
    cat <<EOF >/etc/krb5kdc/kadm5.acl
# This file Is the access control list for krb5 administration.
# When this file is edited run /etc/init.d/krb5-admin-server restart to activate
# One common way to set up Kerberos administration is to allow any principal 
# ending in /admin  is given full administrative rights.
# To enable this, uncomment the following line:
# */admin *
EOF
    fi
cat <<eof


Now that your realm is set up you may wish to create an administrative
principal using the addprinc subcommand of the kadmin.local program.
Then, this principal can be added to /etc/krb5kdc/kadm5.acl so that
you can use the kadmin program on other computers.  Kerberos admin
principals usually belong to a single user and end in /admin.  For
example, if jruser is a Kerberos administrator, then in addition to
the normal jruser principal, a jruser/admin principal should be
created.

Don't forget to set up DNS information so your clients can find your
KDC and admin servers.  Doing so is documented in the administration
guide.
eof
