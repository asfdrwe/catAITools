# Apple Silicon Mac 生成AI活用ガイド
この文書は生成 AI 初心者向けに Apple Silicon Mac で画像生成 AI・音楽生成 AI・動画生成 AI・音声生成 AIと大規模言語モデルと視覚言語モデルによる言語 AI の
活用について解説します。

こちらで作成した[catAITools](https://github.com/asfdrwe/catAITools/) を活用することで、
コマンドに不慣れな方でも問題ないように GUI でのインストールや操作を可能としています。
また、高速化 LoRA を活用するなど M4 Mac mini で実用性のある速度で生成可能と
なるよう調整してあります。

使用ソフトは次の 4 つです。 

- [ComfyUI (画像生成・音楽生成・動画生成)](https://www.comfy.org)
- [Style Bert VITS2 (音声合成)](https://github.com/litagin02/Style-Bert-VITS2)
- [koboldcpp (大規模言語モデル活用)](https://github.com/LostRuins/koboldcpp)
- [llama.cpp (大規模言語モデル活用)](https://github.com/ggml-org/llama.cpp)

すべてオープンソースソフトです。
また、この文書で推奨するモデルもフリーのものなので、
無料で活用することができます。

動作確認は 2025/4/18 に最小構成の M4 Mac mini (メモリ16GB、SSD 256GB)と macOS 15.4 Sequoia で行っています。

おそらくそれ以外の Apple Silicon Mac でもメモリを 16GB 以上搭載している機種
なら動くと思いますが、メモリが 8GB では動かないと思います。

ComfyUI のワークフローは Windows でも Linux でも動くはずなのでそちらでもご活用ください。

## 著作権

Copyright (C) 2025 asfdrwe

この文書は [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/deed.ja) でライセンスします。

![CC BY 4.0](assets/by.png)
