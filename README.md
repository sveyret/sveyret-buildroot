# My Buildroot overlay

:us: :gb:

This overlay contains packages that I need but which are not in the _Buildroot_ official repository.

:fr:

Cette surcouche au dépôt officiel de _Buildroot_ contient les paquets dont j'ai besoin et qui ne se trouvent pas dans le dépôt officiel.

# Usage

:us: :gb:

In order to use this overlay:

* clone this repository: `git clone https://github.com/sveyret/sveyret-buildroot.git $WORKSPACE`;
* declare the overlay in your _Buildroot_ working directory: `make BR2_EXTERNAL=$WORKSPACE/sveyret-buildroot menuconfig`.

Note that some package will require that you install patch to the main _Buildroot_ repository. You will find those patch in the root of this repository. The patch to install will be identified by the :pill: icon.

:fr:

Pour utiliser cette surcouche :

* clonez ce dépôt : `git clone https://github.com/sveyret/sveyret-buildroot.git $WORKSPACE` ;
* déclarez la surcouche dans votre espace de travail de _Buildroot_ : `make BR2_EXTERNAL=$WORKSPACE/sveyret-buildroot menuconfig`.

Notez que certains paquets nécessitent d'installer une rustine sur le dépôt principal de _Buildroot_. Vous trouverez ces rustines à la racine de ce dépôt. Les rustines a installer sont identifiées par l'icône :pill:.

# Packages

## duniter

:ticket: Duniter server

:speech_balloon: Crypto-currency software to manage libre currency.

:link: https://duniter.org/

:pill: **Warning:** requires `rust-update.patch`.

## pam-krb5

:ticket: Kerberos V PAM

:speech_balloon: Pluggable authentication module (PAM) for Kerberos V.

:link: https://www.eyrie.org/~eagle/software/pam-krb5/

