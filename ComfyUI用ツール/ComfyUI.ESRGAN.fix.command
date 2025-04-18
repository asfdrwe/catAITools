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

patch -p1 <<EOF
--- ComfyUI.orig/.venv/lib/python3.12/site-packages/spandrel/architectures/ESRGAN/__arch/RRDB.py	2025-04-09 16:33:52
+++ ComfyUI/.venv/lib/python3.12/site-packages/spandrel/architectures/ESRGAN/__arch/RRDB.py	2025-04-09 16:34:18
@@ -134,6 +134,7 @@
         )
 
     def forward(self, x):
+        x = x.contiguous()  # Make tensor ready for the next operation
         if self.shuffle_factor:
             true_scale = self.scale // self.shuffle_factor
             _, _, h, w = x.size()
EOF

osascript -e 'display dialog "コード修正が完了しました。" with title "完了通知" with text buttons {"OK"} with icon 1'
