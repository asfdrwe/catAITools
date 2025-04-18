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
git clone https://github.com/kijai/ComfyUI-MMAudio
cd ComfyUI-MMAudio
pip3 install -r requirements.txt

patch -p3 <<EOF
diff -uNr ComfyUI.orig/custom_nodes/comfyui-mmaudio/mmaudio/ext/autoencoder/vae.py ComfyUI/custom_nodes/comfyui-mmaudio/mmaudio/ext/autoencoder/vae.py
--- ComfyUI.orig/custom_nodes/comfyui-mmaudio/mmaudio/ext/autoencoder/vae.py	2025-04-09 16:03:44.257697679 +0900
+++ ComfyUI/custom_nodes/comfyui-mmaudio/mmaudio/ext/autoencoder/vae.py	2025-04-09 16:05:57.202656294 +0900
@@ -75,11 +75,11 @@
         super().__init__()
 
         if data_dim == 80:
-            self.data_mean = nn.Buffer(torch.tensor(DATA_MEAN_80D, dtype=torch.float32).cuda())
-            self.data_std = nn.Buffer(torch.tensor(DATA_STD_80D, dtype=torch.float32).cuda())
+            self.data_mean = nn.Buffer(torch.tensor(DATA_MEAN_80D, dtype=torch.float32).to("mps"))
+            self.data_std = nn.Buffer(torch.tensor(DATA_STD_80D, dtype=torch.float32).to("mps"))
         elif data_dim == 128:
-            self.data_mean = nn.Buffer(torch.tensor(DATA_MEAN_128D, dtype=torch.float32).cuda())
-            self.data_std = nn.Buffer(torch.tensor(DATA_STD_128D, dtype=torch.float32).cuda())
+            self.data_mean = nn.Buffer(torch.tensor(DATA_MEAN_128D, dtype=torch.float32).to("mps"))
+            self.data_std = nn.Buffer(torch.tensor(DATA_STD_128D, dtype=torch.float32).to("mps"))
 
         self.data_mean = self.data_mean.view(1, -1, 1)
         self.data_std = self.data_std.view(1, -1, 1)
diff -uNr ComfyUI.orig/custom_nodes/comfyui-mmaudio/mmaudio/ext/rotary_embeddings.py ComfyUI/custom_nodes/comfyui-mmaudio/mmaudio/ext/rotary_embeddings.py
--- ComfyUI.orig/custom_nodes/comfyui-mmaudio/mmaudio/ext/rotary_embeddings.py	2025-04-09 16:03:44.259557347 +0900
+++ ComfyUI/custom_nodes/comfyui-mmaudio/mmaudio/ext/rotary_embeddings.py	2025-04-09 16:04:46.402496940 +0900
@@ -16,7 +16,7 @@
                            device: Union[torch.device, str] = 'cpu') -> Tensor:
     assert dim % 2 == 0
 
-    with torch.amp.autocast(device_type='cuda', enabled=False):
+    with torch.amp.autocast(device_type='mps', enabled=False):
         pos = torch.arange(length, dtype=torch.float32, device=device)
         freqs = 1.0 / (theta**(torch.arange(0, dim, 2, dtype=torch.float32, device=device) / dim))
         freqs *= freq_scaling
@@ -28,7 +28,7 @@
 
 
 def apply_rope(x: Tensor, rot: Tensor) -> tuple[Tensor, Tensor]:
-    with torch.amp.autocast(device_type='cuda', enabled=False):
+    with torch.amp.autocast(device_type='mps', enabled=False):
         _x = x.float()
         _x = _x.view(*_x.shape[:-1], -1, 1, 2)
         x_out = rot[..., 0] * _x[..., 0] + rot[..., 1] * _x[..., 1]
diff -uNr ComfyUI.orig/custom_nodes/comfyui-mmaudio/mmaudio/ext/synchformer/synchformer.py ComfyUI/custom_nodes/comfyui-mmaudio/mmaudio/ext/synchformer/synchformer.py
--- ComfyUI.orig/custom_nodes/comfyui-mmaudio/mmaudio/ext/synchformer/synchformer.py	2025-04-09 16:03:44.260102465 +0900
+++ ComfyUI/custom_nodes/comfyui-mmaudio/mmaudio/ext/synchformer/synchformer.py	2025-04-09 16:07:24.293063519 +0900
@@ -42,11 +42,11 @@
 
 
 if __name__ == "__main__":
-    model = Synchformer().cuda().eval()
+    model = Synchformer().to("mps").eval()
     sd = torch.load('./ext_weights/synchformer_state_dict.pth', weights_only=True)
     model.load_state_dict(sd)
 
-    vid = torch.randn(2, 7, 16, 3, 224, 224).cuda()
+    vid = torch.randn(2, 7, 16, 3, 224, 224).to("mps")
     features = model.extract_vfeats(vid, for_loop=False).detach().cpu()
     print(features.shape)
 
diff -uNr ComfyUI.orig/custom_nodes/comfyui-mmaudio/mmaudio/model/embeddings.py ComfyUI/custom_nodes/comfyui-mmaudio/mmaudio/model/embeddings.py
--- ComfyUI.orig/custom_nodes/comfyui-mmaudio/mmaudio/model/embeddings.py	2025-04-09 16:03:44.260521501 +0900
+++ ComfyUI/custom_nodes/comfyui-mmaudio/mmaudio/model/embeddings.py	2025-04-09 16:04:58.788137786 +0900
@@ -20,7 +20,7 @@
         self.max_period = max_period
         assert dim % 2 == 0, 'dim must be even.'
 
-        with torch.autocast('cuda', enabled=False):
+        with torch.autocast('mps', enabled=False):
             self.freqs = nn.Buffer(
                 1.0 / (10000**(torch.arange(0, frequency_embedding_size, 2, dtype=torch.float32) /
                                frequency_embedding_size)),
EOF

osascript -e 'display dialog "インストールが完了しました。" with title "完了通知" with text buttons {"OK"} with icon 1'
