################################################################################
#
# pam-krb5
#
################################################################################

PAM_KRB5_VERSION = 4.9
PAM_KRB5_SOURCE = pam-krb5-$(PAM_KRB5_VERSION).tar.gz
PAM_KRB5_SITE = https://archives.eyrie.org/software/kerberos
PAM_KRB5_DEPENDENCIES = libkrb5 linux-pam
PAM_KRB5_LICENSE = BSD-2 or GPL-2
PAM_KRB5_LICENSE_FILES = LICENSE

$(eval $(autotools-package))
