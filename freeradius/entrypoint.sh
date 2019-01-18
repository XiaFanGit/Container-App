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
sed -i "s/ldapserver/${LDAP_SERVER}/g" /etc/raddb/mods-available/ldap
sed -i "s/ldapuser/${BIND_DN}/g" /etc/raddb/mods-available/ldap
sed -i "s/ldappwd/${PASSWD}/g" /etc/raddb/mods-available/ldap
sed -i "s/389/${PORT}/g" /etc/raddb/mods-available/ldap
sed -i "s/ldapbasedn/${BASE_DN}/g" /etc/raddb/mods-available/ldap

# Enable Config
ln -s /etc/raddb/mods-available/ldap /etc/raddb/mods-enabled/
ln -s /etc/raddb/sites-available/ldap /etc/raddb/sites-enabled/

exec nohup radiusd -xxf >/dev/null 2>%1 &