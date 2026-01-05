# 学位論文LaTeXテンプレート

本テンプレートは, 言語処理学会論文誌の公式 LaTeX テンプレートをベースとした, 愛媛大学自然言語処理研究室の学位論文テンプレートです. 
原版の詳細は以下を参照してください.

- 会誌「自然言語処理」原稿執筆案内：https://www.anlp.jp/guide/guideline.html
- 原版
  - クラスファイル：`jnlp_3.8.cls`
  - スタイルファイル：`jnlpbbl_2.2.sty`
  - BibTeX スタイルファイル：`jnlpbbl_1.7.bst`

## インストール

### Local

まず, 本リポジトリをローカル環境にクローンしてください.

```bash
git clone https://github.com/EhimeNLP/nlp-lab-thesis-template.git
cd nlp-lab-thesis-template
```

#### Windows / macOS / Linux

`l3build` を使用して, `TEXMFHOME` に追加してください.

```bash
l3build install
```

#### Windows

バッチファイルを使用して, `TEXMFLOCAL` または `TEXMFHOME` に追加してください.

```bash
install [--texmflocal|--texmfhome]
```

- `--texmflocal`: `TEXMFLOCAL` に追加 (default)
- `--texmfhome`: `TEXMFHOME` に追加

#### macOS / Linux

シェルスクリプトを使用して, `TEXMFLOCAL` または `TEXMFHOME` に追加してください.  
ただし, 実行権限の付与が必要です. また, `TEXMFLOCAL` に追加する場合は, 管理者権限が必要です. 

```bash
chmod +x install.sh
./install.sh [--texmflocal|--texmfhome]
```

- `--texmflocal`: `TEXMFLOCAL` に追加 (default)
- `--texmfhome`: `TEXMFHOME` に追加

### Overleaf

[Releases](https://github.com/EhimeNLP/graduation_thesis_tex_template/releases)から最新バージョンの `enlp-template-v*.zip` を取得して, Overleafのプロジェクトに配置してください.

## 使用方法

使用方法については, [ユーザ向けドキュメント](https://github.com/EhimeNLP/graduation_thesis_tex_template/blob/main/docs/documentation.pdf)を参照してください.

## Issues

バグ報告や機能リクエストは[Issues](https://github.com/EhimeNLP/graduation_thesis_tex_template/issues)からお願いします.