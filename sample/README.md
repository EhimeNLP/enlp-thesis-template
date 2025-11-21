# サンプルドキュメント

## 実行方法

### 一括ビルド

```bash
make build
```

### 個別ターゲット

```bash
# 依存ファイルをコピー
make cp

# latexmkでsample.texをコンパイル
make compile

# 一時ファイルを削除
make clean

# 依存ファイルを削除
make reset
```
