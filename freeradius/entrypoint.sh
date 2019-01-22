#!/bin/sh
set -xe

ldap_subst() {
    sed -i -e "s/${1}/${2}/g" /etc/raddb/mods-available/ldap
}

# substitute variables into LDAP configuration file
ldap_subst "@LDAP_HOST@" "${LDAP_HOST}"
ldap_subst "@LDAP_PORT@" "${LDAP_PORT}"
ldap_subst "@BASE_DN@" "${BASE_DN}"
ldap_subst "@BIND_DN@" "${BIND_DN}"
ldap_subst "@PASSWORD@" "${PASSWORD}"
ldap_subst "@USERS_DN@" "${USERS_DN}"
ldap_subst "@GROUP_DN@" "${GROUP_DN}"

# Enable LDAP Config
ln -s /etc/raddb/mods-available/ldap /etc/raddb/mods-enabled/

# Configure the default site for ldap
sed -i -e 's/-ldap/ldap/g' /etc/raddb/sites-available/default
sed -i -e '/^#[[:space:]]*Auth-Type LDAP {$/{N;N;s/#[[:space:]]*Auth-Type LDAP {\n#[[:space:]]*ldap\n#[[:space:]]*}/        Auth-Type LDAP {\n                ldap\n        }/}' /etc/raddb/sites-available/default
sed -i -e 's/^#[[:space:]]*ldap/        ldap/g' /etc/raddb/sites-available/default

# Configure the inner-tunnel site for ldap
sed -i -e 's/-ldap/ldap/g' /etc/raddb/sites-available/inner-tunnel
sed -i -e '/^#[[:space:]]*Auth-Type LDAP {$/{N;N;s/#[[:space:]]*Auth-Type LDAP {\n#[[:space:]]*ldap\n#[[:space:]]*}/        Auth-Type LDAP {\n                ldap\n        }/}' /etc/raddb/sites-available/inner-tunnel
sed -i -e 's/^#[[:space:]]*ldap/        ldap/g' /etc/raddb/sites-available/inner-tunnel

# Set Clients.conf
cat > /etc/raddb/clients.conf << EOF
client ocserv {
        ipv4addr = *
        proto = *
        secret = ${RD_SHAREKEY}
        require_message_authenticator = no
        shortname = ocserv
}
EOF

# Set LDAP.attr Mapping
cat > /etc/raddb/ldap.attrmap << EOF
checkItem NT-Password sambaNTPassword
checkItem User-Password userPassword
replyItem Tunnel-Type radiusTunnelType
replyItem Tunnel-Medium-Type radiusTunnelMediumType
replyItem Tunnel-Private-Group-Id radiusTunnelPrivateGroupId
EOF

# Set User Check
cat > /etc/raddb/users << EOF
DEFAULT LDAP-Group == "ocserv", Auth-Type := Accept
        Reply-Message = "Login Success!"
DEFAULT LDAP-Group != "ocserv", Auth-Type := Reject
        Reply-Message = "OOPS! You are not a member of the required group"
DEFAULT Auth-Type := LDAP
        Fall-Through = 1
EOF

radiusd -xxf