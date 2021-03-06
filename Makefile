# $Id: Makefile,v 1.6 2015/08/24 22:00:00 Matlink Exp $
#
SHELL := /bin/bash
PYTHON=`which python`
DESTDIR=/
PROJECT=gplayweb
VERSION=0.1

all:
	@echo "make source - Create source package"
	@echo "make install - Install on local system"
	@echo "make builddeb - Generate a deb package"
	@echo "make clean - Get rid of scratch and byte files"

source:
	$(PYTHON) setup.py sdist $(COMPILE)

install:
	$(PYTHON) setup.py install --root $(DESTDIR) $(COMPILE)

deb:
	python setup.py --command-packages=stdeb.command sdist_dsc --sign-results bdist_deb

publish:
	python setup.py register -r pypi
	python setup.py sdist upload -r pypi

gitpush:
	git push origin master && git push github master
clean:
	$(PYTHON) setup.py clean
	rm -rf build/ MANIFEST dist GPlayWeb.egg-info debian/{gplayweb,python-module-stampdir} debian/gplayweb.{debhelper.log,postinst.debhelper,prerm.debhelper,substvars} *.tar.gz* deb_dist srclibs
	find . -name '*.pyc' -delete
