#!/bin/bash

# AUR Package for the specific python version needed
PYTHON_VERSION_PACKAGE=python36

DEEPSPEECH_VERSION=v0.9.3

check_python() {
	if pacman -Qi python36 > /dev/null; then
		echo "Python 3.6 Exists in System"
		return 0
	else
		echo "Python 3.6 Does not exist"
		return 1
	fi
}

install_python() {
	git clone https://aur.archlinux.org/$PYTHON_VERSION_PACKAGE
	cd $PYTHON_VERSION_PACKAGE
	makepkg -si
	cd ..
}

fetch_deepspeech() {
	git clone --branch $DEEPSPEECH_VERSION https://github.com/mozilla/DeepSpeech
}

setup_venv() {
	mkdir deepspeech-train-venv
	python3.6 -m venv deepspeech-train-venv
	source deepspeech-train-venv/bin/activate
	cd DeepSpeech
	pip3 install --upgrade pip==20.2.2 wheel==0.34.2 setuptools==49.6.0
	pip3 install --upgrade -e .
}

check_python
if [ $? -eq 1 ]; then
	echo "Installing Python3.6"
	install_python
fi
fetch_deepspeech
setup_venv
echo "All done"
echo "Run :"
echo "source deepspeech-train-venv/bin/activate"
echo "In order to activate DeepSpeech Environment"
