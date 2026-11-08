# 学位論文LaTeXテンプレート

本テンプレートは, [jlreq](https://github.com/abenori/jlreq)をベースとする愛媛大学自然言語処理研究室の学位論文テンプレートです.

## インストール

### macOS / Linux

```sh
curl -fsSL https://raw.githubusercontent.com/EhimeNLP/enlp-thesis-template/main/scripts/install.sh | sh
```

システム全体にインストールする場合は, 末尾を `| sh -s -- --texmflocal` に変えてください. 

### Windows

PowerShellで以下を実行してください. 

```powershell
& ([scriptblock]::Create((curl.exe -fsSL https://raw.githubusercontent.com/EhimeNLP/enlp-thesis-template/main/scripts/install.ps1 | Out-String)))
```

システム全体にインストールする場合は, 管理者権限で起動したPowerShellでコマンド末尾に `-System` を付けてください. 

### Overleaf

[Releases](https://github.com/EhimeNLP/enlp-thesis-template/releases)から最新バージョンの `enlp-thesis-template-v*.zip` を取得して, Overleafのプロジェクトに配置してください.

## 使用方法

使用方法については, [ユーザ向けドキュメント](https://github.com/EhimeNLP/enlp-thesis-template/blob/main/docs/documentation.pdf)を参照してください.

## Issues

バグ報告や機能リクエストは[Issues](https://github.com/EhimeNLP/enlp-thesis-template/issues)からお願いします.

## License

See [LICENSE](LICENSE) for the BSD 2-Clause license and [Third-Party Notices](THIRD_PARTY_NOTICES.md) for third-party attribution and license terms.
