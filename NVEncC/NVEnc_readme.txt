---------------------------------------------------


	NVEnc.auo / NVEncC
	 by rigaya

---------------------------------------------------

NVEnc.auo は、
NVIDIAのNVEncを使用してエンコードを行うAviutlの出力プラグインです。
NVEncによるハードウェア高速エンコードを目指します。

【基本動作環境】
Windows 7,8,8.1,10 (x86/x64)
Aviutl 0.99g4 以降
NVEncが載ったハードウェア
  NVIDIA製 GPU GeForce Kepler世代以降 (GT/GTX 6xx 以降)
  ※GT 63x, 62x等はFermi世代のリネームであるため非対応なものがあります。
NVEnc 0.00 NVIDIA グラフィックドライバ 334.89以降
NVEnc 1.00 NVIDIA グラフィックドライバ 347.09以降
NVEnc 2.00 NVIDIA グラフィックドライバ 358   以降
NVEnc 2.08 NVIDIA グラフィックドライバ 368.69以降
NVEnc 3.02 NVIDIA グラフィックドライバ 369.30以降
NVEnc 3.08 NVIDIA グラフィックドライバ 378.66以降

【NVIDIA CORPORATION CUDA SAMPLES EULA のライセンス規定の準拠表記】
本プログラムは、NVIDA CUDA Samplesをベースに作成されています。
すなわちサンプルコードをベースとする派生プログラムであり、サンプルコードを含みます。
“This software contains source code provided by NVIDIA Corporation.”

【tinyxml2の使用表記】
本プログラムは、tinyxml2を内部で使用しています。
http://www.grinninglizard.com/tinyxml2/index.html

【NVEnc 使用にあたっての注意事項】
無保証です。自己責任で使用してください。
NVEncを使用したことによる、いかなる損害・トラブルについても責任を負いません。

【NVEnc 再配布(二次配布)について】
このファイル(NVEnc_readme.txt)と一緒に配布してください。念のため。
まあできればアーカイブまるごとで。

【NVEnc 使用方法 (簡易インストーラ使用)】
付属の簡易インストーラを使用する方法です。
手動で行う場合は、後述のNVEnc 使用方法 (手動)を御覧ください。

1. ダウンロードしたNVEnc_1.xx.zipを一度解凍します。

2. auo_setup.exeをダブルクリックし、実行します。
   基本的に自動で必要なもののダウンロード・インストールが行われます。

3. 途中でAviutl.exeのあるフォルダ場所を聞かれますので、
   右側のボタンをクリックしてAviutlのフォルダを指定してください。
   
4. インストールが完了しました、と出るのをお待ちください。


【NVEnc 使用方法 (手動)】
1. 
以下のものをインストールしてください。

Visual Studio 2015 の Visual C++ 再頒布可能パッケージ (x86) 
https://www.microsoft.com/ja-jp/download/details.aspx?id=48145

.NET Framework 4.5がインストールされていない場合、インストールしてください。
通常はWindows Updateでインストールされ、またCatalyst Control Centerでも使用されているため、
インストールの必要はありません。

.NET Framework 4.5 (x86)
http://download.microsoft.com/download/E/2/1/E21644B5-2DF2-47C2-91BD-63C560427900/NDP452-KB2901907-x86-x64-AllOS-ENU.exe

.NET Framework 4.5 (x86) 言語パック
http://download.microsoft.com/download/9/1/2/9125E189-97A4-4364-860C-09A0F96F6FB2/NDP452-KB2901907-x86-x64-AllOS-JPN.exe

2. 
NVEnc.NVEnc.ini、NVEnc_stgフォルダ をAviutlのpluginフォルダにコピーします。

3. 
Aviutlを起動し、「その他」>「出力プラグイン情報」にNVEncがあるか確かめます。
ここでNVEncの表示がない場合、1.で必要なものを忘れている、あるいは失敗したなどが考えられます。

4. 必要な実行ファイルを集めます。
   以下に実行ファイル名とダウンロード場所を列挙します。
   実行ファイルは32bit/64bitともに可です。
<主要エンコーダ・muxer>
 [qaac/refalac (AAC/ALACエンコーダ)]
 http://sites.google.com/site/qaacpage/
 
 [L-SMASH (mp4出力時に必要)]
 http://pop.4-bit.jp/
 
 [mkvmerge (mkv出力時に必要)]
 http://www.bunkus.org/videotools/mkvtoolnix/
 
<音声エンコーダ>
 [neroaacenc (AACエンコーダ)]
 http://www.nero.com/jpn/downloads-nerodigital-nero-aac-codec.php
 
 [FAW(fawcl) (FakeAACWave(偽装wav)解除)]
 http://2sen.dip.jp/cgi-bin/friioup/upload.cgi?search=FakeAacWav&sstart=0001&send=9999
 
 [faw2aac.auo (FakeAACWave(偽装wav)解除)]
 http://www.rutice.net/FAW2aac

 [qtaacenc   (AACエンコーダ, 要QuickTime)]
 http://tmkk.pv.land.to/qtaacenc/
 
 [ext_bs     (PVシリーズAAC抽出)]
 http://www.sakurachan.org/soft/mediatools/
 
 [lame       (mp3エンコーダ)]
 http://www.rarewares.org/mp3-lame-bundle.php
 
 [ffmpeg     (AC3エンコーダとして使用)]
 http://blog.k-tai-douga.com/
 
 [oggenc2    (ogg Vorbis, mkv専用)]
 http://www.rarewares.org/ogg-oggenc.php 
 
 [mp4alsrm23 (MPEG4 ALS (MPEG4 Audio Lossless Coding))]
 http://www.nue.tu-berlin.de/menue/forschung/projekte/beendete_projekte/mpeg-4_audio_lossless_coding_als/parameter/en/
 ※Reference Software のとこにある MPEG-4 ALS codec for Windows - mp4alsRM23.exe
 
5.
NVEncの設定画面を開き、各実行ファイルの場所を指定します。
あと適当に設定します。

6.
エンコード開始。気長に待ちます。


【iniファイルによる拡張】
NVEnc.iniを書き換えることにより、
音声エンコーダやmuxerのコマンドラインを変更できます。
また音声エンコーダを追加することもできます。

デフォルトの設定では不十分だと思った場合は、
iniファイルの音声やmuxerのコマンドラインを調整してみてください。


【ビルドについて】
ビルドにはVC++2015が必要です。

また、その他に以下のものも必要です。

CUDA 5.0 toolkit以降
http://developer.nvidia.com/cuda/cuda-toolkit

DirectX SDK
http://www.microsoft.com/en-us/download/details.aspx?id=6812
※VC++2010再頒布パッケージ(x86/x64)がすでに入っていると、インストールに失敗する場合があります。
  その場合は、VC++2010再頒布パッケージ(x86/x64)を一度アンインストールし、後でインストールし直すことでインストールできます。

Windows DDK
http://msdn.microsoft.com/ja-jp/windows/hardware/hh852365.aspx



コーディングが汚いとか言わないで。

【コンパイル環境】
VC++ 2015 Community


【検証環境 2014.03～】
Win7 x64
Intel Core i7 4770K + Asrock Z87 Extreme4
GeForce GTX 660
16GB 
NVIDIA グラフィックドライバ 335.23
NVIDIA グラフィックドライバ 347.09

【検証環境 2015.01～】
Win8.1 x64
Intel Core i7 5960X + ASUS X99 Deluxe
Geforce GTX 970
32GB RAM
NVIDIA グラフィックドライバ 347.25

【検証環境 2015.08～】
Win10 x64
Intel Core i7 5960X + ASUS X99 Deluxe
Geforce GTX 970
32GB RAM
NVIDIA グラフィックドライバ 353.62

【検証環境 2015.12～】
Win8.1 x64
Intel Core i3 4170 + Gigabyte Z97M-DS3H
Geforce GTX 970
8GB RAM
NVIDIA グラフィックドライバ 359.00

【検証環境 2015.12～】
Win10 x64
Intel Core i7 5960X + ASUS X99 Deluxe
Geforce GTX 960
32GB RAM
NVIDIA グラフィックドライバ 364.51


【検証環境 2016.07～】
Win10 x64
Intel Core i7 5960X + ASUS X99 Deluxe
Geforce GTX 1060
32GB 
NVIDIA グラフィックドライバ 368.81
NVIDIA グラフィックドライバ 372.70
NVIDIA グラフィックドライバ 375.95
NVIDIA グラフィックドライバ 382.33

【お断り】
今後の更新で設定ファイルの互換性がなくなるかもしれません。

【メモ】
2017.06.30 (3.14)
[共通]
・CPU使用率を低減。特に、HWデコーダ使用時のCPU使用率を大きく削減。
・CUDAのスケジューリングモードを指定するオプションを追加。(--cuda-schedule <string>)
  主に、GPUのタスク終了を待機する際のCPUの挙動を決める。デフォルトはsync。
  - auto  ... CUDAのドライバにモード決定を委ねる。
  - spin  ... 常にCPUを稼働させ、GPUタスクの終了を監視する。
              復帰のレイテンシが最小となり、最も高速だが、1コア分のCPU使用率を常に使用する。
  - yield ... 基本的にはspinと同じだが、他のスレッドがあればそちらに譲る。
  - sync  ... GPUタスクの終了まで、スレッドをスリープさせる。
              わずかに性能が落ちるかわりに、特にHWデコード使用時に、CPU使用率を大きく削減する。
・実行時のCUDAのバージョンをログに表示するように。

[NVEncC]
・helpの表示がおかしかった箇所を修正。
・エンコード終了時に進捗表示のゴミが残らないように。
・NVMLを使用してGPU使用率などの情報を取得するように。x64版のみ。

2017.06.24 (3.13)
[共通]
・バンディング低減フィルタを追加。
・パフォーマンス分析ができなくなっていたのを修正。

[NVEncC]
・--avcuvidを使用すると、--cropが正しく反映されない場合があったのを修正。

2017.06.19 (3.12)
[NVEnc.auo]
・NVEnc.auoで10bit深度、yuv444のエンコードができなくなっていたのを修正。

2017.06.18 (3.11)
[共通]
・より柔軟にSAR比の指定に対応。
・NVEncのrevision情報を表示するように。

[NVEncC]
・実行時に取得したデコーダの機能をもとに、デコードの可否を判定するように。
・avswにrgb読み込みを追加。
・avsw/y4m/vpyからのyuv422読み込みに対応(インタレは除く)。
・--audio-streamを使用した際に、条件によっては、再生できないファイルができてしまうのを修正。

2017.06.12 (3.10)
[NVEncC]
・y4m渡しが3.09でも壊れていたので修正。
・正常終了した場合でも、エラーコード上はエラーを返していることがあるのを修正。

2017.06.11 (3.09)
[NVEncC]
・高ビット深度をy4m渡しすると、絵が破綻するのを修正。

2017.06.10 (3.08)
[共通]
・NVENC SDKを8.0に更新。
・重み付きPフレームを有効にするオプションを追加。(--weightp)
・Windowsのビルドバージョンをログに表示するように。
・32で割りきれない高さの動画をインタレ保持エンコードできない場合があったのを修正。
・GPU-Zの"Video Engine Load"を集計できるように。

[NVEnc.auo]
・簡易インストーラを更新。
・QPの上限・下限・初期値の設定を追加。
・VBR品質目標の設定を追加。

[NVEncC]
・10bit HEVCのHWデコードに対応。
・ffmpegと関連ライブラリのdllを更新。
・HWデコード時の安定性を向上。
・--vbr-qualityを小数点指定に対応。
・aviファイルリーダーを追加。
・LTR Trust modeは今後非推奨となる予定のため、--enable-ltrオプションを削除。
・vpyリーダー使用時に、エンコードを中断しようとするとフリーズしてしまう問題を修正。
・字幕のコピーが正常に行われない場合があったのを修正。

2017.03.08 (3.07)
[共通]
・ログにいくつかのパラメータを追加。

[NVEnc.auo]
・プリセットを現状に合わせて調整。
・簡易インストーラを更新。

[NVEncC]
・H.264ではLTRが非対応であるとのことをhelpに明記。
・いくつかのオプションを追加。(--direct, --adapt-transform)
・NVENCのpresetを反映するオプションを追加。(--preset)

2017.02.05 (3.06)
※同梱のdll類も更新してください!
[NVEncC]
・HEVC/VP8/VP9のハードウェアデコードを追加。
・メモリリークを修正。
・使用しているCUDAのバージョン情報を表示。

2017.01.11 (3.05)
[共通]
・3.04のミスを修正。

2017.01.10 (3.04)
[共通]
・HEVCでもロスレス出力可能なように。

2017.01.09 (3.03)
[共通]
・NVENC SDKを7.1に更新。
・NVENC SDKを7.1に合わせてレート制御モードを整理。
  - CQP
  - VBR
  - VBRHQ (旧VBR2)
  - CBR
  - CBRHQ
・低解像度で--level 3などを指定してもエラー終了してしまう問題を解消。

[NVEncC]
・mkvを入力としたHEVCエンコードで、エンコード開始直後にフリーズしてしまうのを解消。

[NVEnc.auo]
・自動フィールドシフト使用時に、最後のフレームがdropであると1フレーム多く出力されてしまう問題を修正。
  これが原因で、timecodeとフレーム数が合わずmuxに失敗する問題があった。

2016.11.21 (3.02)
[共通]
・2.xxのnvcuvid利用時及び3.00以降のすべてのケースでインタレ保持エンコードが正常にできなくなっていたのを修正。

[NVEnc.auo]
・簡易インストーラを更新。

2016.10.11 (3.01)
[共通]
・CUDA 8.0正式版にコンパイラを変更。

[NVEncC]
・muxする際、プログレッシブエンコードなのにBFFのフラグが立っていた問題を修正。
・--audio-sourceが期待どおりに動作しない場合があったのを修正。

2016.09.18 (3.00)
[共通]
・さまざまなリサイズアルゴリズムを追加。(--vpp-resize)
・Knn(K nearest neighbor)ノイズ除去を追加。(--vpp-knn)
・正則化PMD法によるノイズ除去を追加。(--vpp-pmd)

[NVEncC]
・音声処理のエラー耐性を向上。
・avcuvid読み込み以外でもリサイズを可能に。
・avcuvid読み込み以外でもtrimを可能に。
・左cropが動作しないのを解消。
・透過性ロゴフィルタを追加。(--vpp-delogo)
・ガウシアンフィルタを追加(x64のみ)。(--vpp-gauss)

2016.08.07 (2.11)
[NVEncC]
・2.08から、vpp-deinterlaceが使用できなくなっていたのを修正。

2016.07.28 (2.10)
[共通]
・PascalのHEVC YUV444 10bitエンコードに対応。

[NVEncC]
・出力ビット深度を設定するオプションを追加。(--output-depth <int>)
・avsw/y4m/vpyリーダーからのyuv420高ビット深度の入力に対応。
・avsw/y4m/vpyリーダーからのyuv444(8bit,高ビット深度)の入力に対応。

[NVEnc.auo]
・afs使用時にHEVC 10bitエンコードができなかった問題を修正。
・進捗表示がされない問題を修正。

2016.07.22 (2.09)
[共通]
・--helpが壊れている問題を修正。
・fpsが正しく取得できていない場合のエラーを追加。
・HEVC 4:4:4に対応。
  profileでmain444を指定してください。

[NVEncC]
・10bitエンコードを追加 (HEVCのみ)。(--output-depth <int>)

[NVEnc.auo]
・10bitエンコードを追加 (HEVCのみ)。
  プロファイルで「main10」を指定してください。
  YC48から10bitへの直接変換を行います。

2016.07.19 (2.08)
[共通]
・NVENC SDK 7.0に対応
  NVIDIA グラフィックドライバ 368.69以降が必要
・SDK 7.0で追加された機能のオプションを追加。
  --lookahead <int> (0-32)
  --strict-gop (NVEncCのみ)
  --no-i-adapt (NVEncCのみ)
  --no-b-adapt (NVEncCのみ)
  --enable-ltr (NVEncCのみ)
  --aq-temporal
  --aq-strength <int> (0-15)
  --vbr-quality <int> (0-51)
・--avswを追加。
・複数の動画トラックがある際に、これを選択するオプションを追加。(--video-track, --video-streamid)
  --video-trackは最も解像度の高いトラックから1,2,3...、あるいは低い解像度から -1,-2,-3,...と選択する。
  --video-streamidは動画ストリームののstream idで指定する。
・入力ファイルのフォーマットを指定するオプションを追加。(--input-format)

2016.06.18 (2.07v2)
・簡易インストーラを更新。

2016.05.29 (2.07)
・Bluray出力が行えなくなっていたのを修正。
・ログが正常に表示されないものがあったのを修正。
・コマンドラインのオプション名が存在しない場合のエラーメッセージを改善。
・NVEnc.auoで中断できないのを修正。

2016.04.29 (2.06)
・avcuvid使用時にデコーダのモードを指定できるように。
  --avcuvid native (デフォルト)
  --avcuvid cuda
  なにも指定しないときはnative。

2016.04.20 (2.05v2)
・簡易インストーラを更新。

2016.04.15 (2.05)
[NVEncC]
・--audio-copyの際のエラー回避を追加。

2016.04.03 (2.04)
[NVEncC]
・qp-min, qp-max, qp-initなどが指定できなかった問題を修正。

2016.04.01 (2.03)
[NVEncC]
・入力ファイルにudpなどのプロトコルが指定されていたら、自動的にavcuvidリーダーを使用するように。
・音声関連ログの体裁改善とフィルタ情報の追加。
・音声フィルタリングを可能に。 (--audio-filter)
  ffmpegのdllを含めて更新してください。(ソースは QSVEnc_2.42_lgpl_dll_src.7z)
  音量変更の場合は、"--audio-filter volume=0.2"など。
  書式はffmpegの-afと同じ。いわゆるsimple filter (1 stream in 1 stream out) なら使用可能なはず。

2016.03.27 (2.02)
[NVEncC]
・エンコード速度が低い時のCPU使用率を大幅に低減。
・mux時に書き込む情報がQSVEncになっていたのを修正。
・HEVCのmuxが正常に行えないことがあるのを修正。
・avsync forcecfr + trimは併用できないので、エラー終了するように。
・dll更新。(ソースは QSVEnc_2.42_lgpl_dll_src.7z)

2016.03.24 (2.01)
[共通]
・MB per secのチェックを行わないようにした。
[NVEnc]
・簡易インストーラを更新。
[NVEncC]
・QSVEncからmux関連機能を追加する。
  --avcuvid-analyze
  --trim
  --seek
  -f, --format
  --audio-copy
  --audio-codec
  --audio-bitrate
  --audio-stream
  --audio-samplerate
  --audio-resampler
  --audio-file
  --audio-ignore-decode-error
  --audio-ignore-notrack-error
  --audio-source
  --chapter
  --chapter-copy
  --sub-copy
  -m, --mux-options
  --output-buf
  --output-thread
  --max-procfps
  あわせてffmpegのdllを追加。(ソースは QSVEnc_2.29_lgpl_dll_src.7z)
・リサイズが行われるときは、入力からのsar比の自動反映を行わないように。
・--levelの読み取りを柔軟に。
・コマンドライン読み取り時のエラー表示を改善。

2016.01.05 (2.00β4)
[NVEncC]
・DeviceIDを指定してエンコードできるように。(--device <int>)
・利用可能なGPUのDeviceIdを表示できるように。(--check-device)
・--check-hw, --check-featuresがdeviceIDを引数にとれるように。
  指定したdeviceIdをチェックする。省略した場合は"DeviceId:0"をチェック。

2015.12.31 (2.00β3v2)
[NVEncC]
・ffmpegのdllをSSE2ビルドに変更。
  ソースはQSVEnc_2.26_lgpl_dll_src.7zのものを流用。

2015.12.26 (2.00β3)
[NVEncC]
・--qp-init, --qp-max, --qp-minを追加。
・デバッグ用のメッセージを大量に追加。

2015.12.06 (2.00β2)
[NVEncC]
・NVENC SDK 6.0に対応
  NVIDIA グラフィックドライバ 358.xx 以降が必要
・NVIDIA CUVIDによるインターレース解除に対応。
  --vpp-deinterlace bob,adaptive
・help-enにoutput-resがなかったのを修正。
・avcuvidでは、下記がサポートされないので、エラーチェックを追加。
  lossless, high444, crop left
・HEVCエンコード時に色関連の設定が反映可能に。

2015.11.29 (2.00β1)
[NVEncC]
・NVIDIA CUVIDによるデコード・リサイズに対応。
  ソフトウェアデコードより高速。
  H.264 / MPEG1 / MPEG2 のデコードに対応。
  --avcuvid
  --output-res <int>x<int>
・ログファイルの出力に対応。
  --log <string>
  --log-level <string>
・ffmpegのdllはQSVEnc_2.22_lgpl_dll_src.7zのものを流用。
  
2015.11.08 (1.13v2)
[NVEncC]
・x64の実行ファイルが最新版になっていなかったので修正。

2015.11.06 (1.13)
[共通]
・VBR2モードを追加。--vbr2。SDKのいうところの2passVBR。
・AQを追加。

[NVEncC]
・y4mからsar情報を受け取れるように。
  特に指定がない場合に、y4mからの情報を使用する。

2015.11.02 (1.12)
[NVEnc]
・fdk-aac (ffmpeg)にもaudio delay cut用のパラメータをNVEnc.iniに追加。

[NVEncC]
・y4mでのyuv422/yuv444読み込みを追加。

2015.10.24 (1.11)
[共通]
・VC2015に移行。
・OSのバージョン情報取得を改善、Windows10に対応。
・NVEncのH.264/AVC high444 profileとロスレス出力に対応。
  QSVEnc
    YUV444出力…プロファイルをhigh444と指定する
    ロスレス出力…CQPでIフレーム、Bフレーム、PフレームのQP値を0にする。

  QSVEncC
    YUV444出力…--profile high444
    ロスレス出力…--lossless

2015.08.18 (1.10)
[共通]
・ハードウェア上限に達した場合のエラーメッセージを表示しようとすると落ちる問題を修正。

2015.07.13 (1.09)
[NVEnc]
・.NET Framework 4.5に移行。
・音声エンコードでフリーズする場合があったのを修正。

[NVEncC]
・特になし。

2015.04.29 (1.08)
[共通]
・環境によって例外:0xc0000096で落ちることがあるのを回避。
[NVEnc]
・音声エンコ前後にバッチ処理を行う機能を追加。
[NVEncC]
・64bit版にavsリーダーを追加。

2015.04.16 (1.07)
[NVEnc]
※要NVEnc.ini更新
・neroを使用すると途中でフリーズする問題を修正。
・いくつかの音声エンコーダの設定を追加。

2015.04.12 (1.06)
[共通]
・VBVバッファサイズを指定するオプションを追加。
・Bluray用出力を行うオプションを追加。
  Bluray用に出力する際には、必ず指定してください。

2015.04.05 (1.05)
[NVEncC]
・--check-featuresをNVENCのない環境で実行するとフリーズする問題を修正。

2015.03.15 (1.04)
[NVEncC]
・英語化が一部不完全だったのを修正。

2015.03.09 (1.03)
[共通]
・1.00からインタレ保持エンコードができていなかったのを修正。
・インタレ保持でtffかbffかを選択できるように。
[NVEncC]
・コンソールで問題が起こることがあるので、ログ表記等を英語化。

2015.02.27 (1.02)
[NVEncC]
・--inputと--outputが効いていなかったのを修正。

2015.02.14 (1.01)
[共通]
・SAR/DARを指定できるように。
[NVEnc]
・自動フィールドシフト使用時以外には、muxerでmuxを行うように。
  muxを一工程削減できる。
[NVEncC]
・--cropオプションを追加。
  LSMASHSourceでdr=trueを使用して高速化できる。
・読み込みでエラーになった際に、エラー情報を表示するように。
・初期化に失敗した際の処理を改善。
・vpyリーダーを追加。
・x64版を追加(avsリーダーは無効)
  
2015.01.24 (1.00)
[共通]
・エンコードログの表示に動きベクトル精度、CABAC、deblockを追加。
・GOP長のデフォルトを0:自動に。
・HEVCの参照距離が適切に設定されないのを修正。
・デフォルトパラメータを高品質よりに調整。
・プリセットを更新。
[NVEncC]
・colormatrix, colorprim, transferが正しく設定されないのを修正。
・短縮オプションの一部がヘルプにないのを修正。
・AVSリーダーでYUY2読み込みが正常に行われていなかったのを修正。

2015.01.24 (1.00 べ～た)
・NVEnc API v5.0に対応
  - HEVCエンコードに対応
・コマンドライン版 NVEncCを追加。
  - raw, y4m, avs読み込みに対応。
・x264guiEx 2.24までの更新を反映。
  - qaacについて、edtsにより音声ディレイのカットをする機能を追加
  - 音声エンコーダにfdkaacを追加
  - muxerのコマンドに--file-formatを追加。
  - flacの圧縮率を変更できるように
  - 音声やmuxerのログも出力できるように
  - 0秒時点にチャプターがないときは、ダミーのチャプターを追加するように。
    Apple形式のチャプター埋め込み時に最初のチャプターが時間指定を無視して0秒時点に振られてしまうのを回避。
  - ログにmuxer/音声エンコーダのバージョンを表示するように。
  - ログが文字化けすることがあるのを改善。
    また、文字コード判定コードのバグを修正。SJISと判定されやすくなっていた。
  - 音声エンコーダにopusencを追加。
  - nero形式のチャプターをUTF-8に変換すると、秒単位に切り捨てられてしまう問題を修正。
  - CPU使用率を表示。

2014.04.21 (0.03)
・nero形式のチャプターをUTF-8に変換してからmuxする機能を追加
・なおも99.9%で停止することがある問題を修正 

2014.04.13 (0.02)
・99.9%で停止してしまう問題を改善…できているかもしれない。

2014.04.05 (0.01)
・nvcuda.dllの存在しない環境で、「コンピューターにnvcuda.dllがないため、プログラムを開始できません。」と出る問題を解決

2014.03.28 (0.00)
・公開版

2014.03.20
製作開始
