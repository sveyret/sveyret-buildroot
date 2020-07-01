################################################################################
#
# pam-krb5
#
################################################################################

PAM_KRB5_VERSION = 4.9
PAM_KRB5_SOURCE = pam-krb5-$(PAM_KRB5_VERSION).tar.gz
PAM_KRB5_SITE = https://archives.eyrie.org/software/kerberos
PAM_KRB5_DEPENDENCIES = libkrb5 linux-pam

$(eval $(autotools-package))
