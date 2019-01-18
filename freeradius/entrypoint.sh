#!/bin/sh
set -xe

# Create Sites Config
cd /etc/raddb/sites-available

cat >ldap <<_EOF_
server site_ldap { 
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

# Change LDAP Config
sed -i "s/aaaaaaaaaa/${PASSWORD}/g" /etc/raddb/mods-available/ldap

# Enable Config
ln -s /etc/raddb/mods-available/ldap /etc/raddb/mods-enabled/
ln -s /etc/raddb/sites-available/ldap /etc/raddb/sites-enabled/

radiusd -xxf