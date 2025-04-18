#!/bin/bash
# SPDX-FileCopyrightText: 2025 asfdrwe <asfdrwe@gmail.com>
# SPDX-License-Identifier: MIT

FOLDER_PATH=`osascript -e 'POSIX path of (choose folder with prompt "ComfyUIのフォルダを選択してください")'`
echo ${FOLDER_PATH}
cd "${FOLDER_PATH}"

if [ ! -d .venv/ ]; then
   osascript -e 'display dialog "ComfyUIのフォルダではありません。" buttons {"終了"} with icon 2 with title "エラー" '
   exit
fi

. .venv/bin/activate

cd custom_nodes
git clone https://github.com/p1atdev/danbot-comfy-node
cd danbot-comfy-node
pip3 install -r requirements.txt

osascript -e 'display dialog "インストールが完了しました。" with title "完了通知" with text buttons {"OK"} with icon 1'
