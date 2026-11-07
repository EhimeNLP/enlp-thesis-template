# 学位論文LaTeXテンプレート

本テンプレートは, [jlreq](https://github.com/abenori/jlreq)をベースとする愛媛大学自然言語処理研究室の学位論文テンプレートです.

## インストール

### Local

まず, 本リポジトリをローカル環境にクローンしてください.

```bash
git clone https://github.com/EhimeNLP/enlp-thesis-template.git
cd enlp-thesis-template
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

[Releases](https://github.com/EhimeNLP/enlp-thesis-template/releases)から最新バージョンの `enlp-thesis-template-v*.zip` を取得して, Overleafのプロジェクトに配置してください.

## 使用方法

使用方法については, [ユーザ向けドキュメント](https://github.com/EhimeNLP/enlp-thesis-template/blob/main/docs/documentation.pdf)を参照してください.

## Issues

バグ報告や機能リクエストは[Issues](https://github.com/EhimeNLP/enlp-thesis-template/issues)からお願いします.

## License

See [LICENSE](LICENSE) for the BSD 2-Clause license and [Third-Party Notices](THIRD_PARTY_NOTICES.md) for third-party attribution and license terms.
