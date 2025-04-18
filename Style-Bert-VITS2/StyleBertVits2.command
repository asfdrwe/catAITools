#!/bin/bash
# SPDX-FileCopyrightText: 2025 asfdrwe <asfdrwe@gmail.com>
# SPDX-License-Identifier: MIT

# to the script folder
cd `dirname $0`

# check install
if [ ! -d Style-Bert-VITS2 ]; then
  osascript -e 'display dialog "Style-Bert-VITS2がインストールされていません。\nプログラムとモデルをダウンロードしますか？" with title "ダウンロード" with text buttons {"キャンセル","はい"} default button 2'

  echo "downloading Style-Bert-VITS2... "
  # fetch Style-Bert-VITS2 via git
  git clone https://github.com/litagin02/Style-Bert-VITS2

  cd Style-Bert-VITS2

  #  make venv envirnoment & activate
  /usr/bin/python3 -m venv venv
  . venv/bin/activate
  hash -r

  pip3 install --pre torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/nightly/cpu
  pip3 install -r requirements.txt
  echo "DONE."

  echo "downloading models..."
  python3 initialize.py
  echo "DONE."

  osascript -e 'display dialog "ダウンロードが完了しました。" with title "完了通知" with text buttons {"OK"} with icon 1'
else 
  cd Style-Bert-VITS2
  . venv/bin/activate
  hash -r
fi

# run Style-Bert-VITS2
echo "Style-Bert-VITS2を起動します。"
exec python3 server_editor.py --inbrowser
