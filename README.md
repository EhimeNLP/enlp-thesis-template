# 修論と卒論用のlatexテンプレート管理用リポジトリ

本テンプレートは, 言語処理学会論文誌の公式 LaTeX テンプレートをもとに, 一部改変を加えたものです.
原版の詳細は以下を参照してください.

- 会誌「自然言語処理」原稿執筆案内：https://www.anlp.jp/guide/guideline.html
- 原版
  - クラスファイル：`jnlp_3.8.cls`
  - スタイルファイル：`jnlpbbl_2.2.sty`
  - BibTeX スタイルファイル：`jnlpbbl_1.7.bst`

> [!WARNING]
> **[2025/11/21] 対応しているLaTeXエンジンは, pLaTeXとupLaTeX, LuaLaTeXのみです.**  

## インストール

### Local

`l3build` を使用して, `TEXMFHOME` に追加してください.

```bash
git clone https://github.com/EhimeNLP/graduation_thesis_tex_template.git
cd graduation_thesis_tex_template
l3build install
```

### Overleaf

[Releases](https://github.com/EhimeNLP/graduation_thesis_tex_template/releases)から最新バージョンの `enlp-template.zip` を取得して, Overleafのプロジェクトに配置してください.

## 使用方法

使用方法については, [ユーザ向けドキュメント](https://github.com/EhimeNLP/enlp-latex/blob/main/docs/documentation.pdf)を参照してください.
