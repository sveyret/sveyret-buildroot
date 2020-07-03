# My Buildroot overlay

:us: :gb:

This overlay contains packages that I need but which are not in the _Buildroot_ official repository.

:fr:

Cette surcouche au dépôt officiel de _Buildroot_ contient les paquets dont j'ai besoin et qui ne se trouvent pas dans le dépôt officiel.

# Usage

:us: :gb:

In order to use this overlay:

* clone this repository (out of the _Buildroot_ directory): `git clone https://github.com/sveyret/sveyret-buildroot.git /path/to/workspace`;
* declare the overlay in your _Buildroot_ working directory: `make BR2_EXTERNAL=/path/to/workspace/sveyret-buildroot menuconfig`;
* the packages will be in the _External options_ menu.

For more information on using external overlays, refer to the [Buildroot manual](https://buildroot.org/downloads/manual/manual.html#outside-br-custom).

Note that some packages requires that you install patchs to the main _Buildroot_ repository. When this is the case, the patchs to install are identified by the :pill: icon in this document, in the package related paragraph.

The patchs are located in the root of the overlay (e.g. `/path/to/workspace/sveyret-buildroot/*.patch`). To install a patch, go to the main _Buildroot_ directory and type `patch -p1 -i /path/to/workspace/sveyret-buildroot/patch-to-install.patch`.

:fr:

Pour utiliser cette surcouche :

* clonez ce dépôt (en dehors du répertoire de _Buildroot_) : `git clone https://github.com/sveyret/sveyret-buildroot.git /path/to/workspace` ;
* déclarez la surcouche dans votre espace de travail de _Buildroot_ : `make BR2_EXTERNAL=/path/to/workspace/sveyret-buildroot menuconfig` ;
* les paquets seront dans le menu _External options_.

Pour plus d'information sur l'utilisation de surcouches externes, référez-vous au [manuel de Buildroot](https://buildroot.org/downloads/manual/manual.html#outside-br-custom).

Notez que certains paquets nécessitent d'installer des correctifs sur le dépôt principal de _Buildroot_. Lorsque c'est le cas, les correctifs à installer sont identifiés par l'icône :pill: dans ce document, dans le paragraphe concernant le paquet.

Ces correctifs se trouvent à la racine de cette surcouche (par exemple `/path/to/workspace/sveyret-buildroot/*.patch`). Pour installer un patch, allez dans le répertoire principal de _Buildroot_ et tapez `patch -p1 -i /path/to/workspace/sveyret-buildroot/patch-a-installer.patch`.

# Packages

## duniter

:ticket: Duniter server

:speech_balloon: Crypto-currency software to manage libre currency.

:link: https://duniter.org/

:pill: **Warning:** requires `rust-update.patch`.

## gecogvidanto

:ticket: ĞecoĞvidanto

:speech_balloon: A tool to help game masters of the Ğeconomicus game.

:link: https://git.duniter.org/gecogvidanto/gecogvidanto

## incron

:ticket: incron

:speech_balloon: Cron-like daemon which handles filesystem events.

:link: https://github.com/ar-/incron

## pam-krb5

:ticket: Kerberos V PAM

:speech_balloon: Pluggable authentication module (PAM) for Kerberos V.

:link: https://www.eyrie.org/~eagle/software/pam-krb5/

