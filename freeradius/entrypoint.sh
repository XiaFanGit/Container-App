#!/bin/sh
set -xe

# Create Sites Config
cd /etc/raddb/sites-available

cat >ldap <<_EOF_
server ldap_auth { 
    listen { 
         ipaddr = 0.0.0.0
         port = 1833
         type = auth
    } 
    authorize {
         update {
             control:Auth-Type := ldap
         }
    }
    authenticate {
        Auth-Type ldap {
            ldap
        }
    }
    post-auth {
        Post-Auth-Type Reject {
        }
    }
}
_EOF_

# Config Client Share Key ...
cd /etc/raddb

rm -rf /etc/raddb/clients.conf

cat >clients.conf <<_EOF_
client localhost {
        ipv4addr = *
        proto = *
        secret = Saber965RDShare
        require_message_authenticator = no
        limit {
                max_connections = 16
                lifetime = 0
                idle_timeout = 30
        }
}
_EOF_

# Change LDAP Config
sed -i "s/aaaaaaaaaa/${PASSWORD}/g" /etc/raddb/mods-available/ldap

# Enable Config
ln -s /etc/raddb/mods-available/ldap /etc/raddb/mods-enabled/
ln -s /etc/raddb/sites-available/ldap /etc/raddb/sites-enabled/

radiusd -xxf