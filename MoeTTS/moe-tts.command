#!/bin/bash

# change script directory
cd `dirname $0`

# require xcode commandline tools
xcode-select --install

if [ ! -d homebrew ]; then
  echo "HOMEBREW NOT INSTALLED"
  mkdir homebrew
  curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip-components 1 -C homebrew
  eval "$(homebrew/bin/brew shellenv)"
  brew update --force --quiet
  chmod -R go-w "$(brew --prefix)/share/zsh"
  brew install cmake python@3.10
  hash -r 
fi

eval "$(homebrew/bin/brew shellenv)"
hash -r

if [ ! -d moe-tts ]; then
  echo "moe-tts NOT INSTALLED"

  /usr/bin/git lfs install
  /usr/bin/git clone --depth=1 https://huggingface.co/spaces/skytnt/moe-tts

  cd moe-tts
  ../homebrew/bin/python3.10 -m venv venv
  . venv/bin/activate
  hash -r

  # workaround for cmake & pyopenjtalk build bug (2025/4/6)
  pip3 install "git+https://github.com/r9y9/pyopenjtalk.git@fix-cmake4"

  pip3 install --pre torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/nightly/cpu
  pip3 install -r requirements.txt
  pip3 install gradio librosa
  cd ..
  deactivate
fi

cd moe-tts
. venv/bin/activate
exec python3 app.py
