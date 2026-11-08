#!/bin/sh

fail() {
    printf '%s\n' "$1" >&2
    exit 1
}

install_enlp() {
    set -eu

    scope=TEXMFHOME
    case ${1-} in
        ''|--texmfhome) ;;
        --texmflocal) scope=TEXMFLOCAL ;;
        -h|--help)
            printf '%s\n' 'Usage: sh install.sh [--texmfhome|--texmflocal]'
            return
            ;;
        *) fail "Unknown option: $1" ;;
    esac
    [ "$#" -le 1 ] || fail 'Specify at most one installation scope.'

    if command -v kpsewhich >/dev/null 2>&1 &&
        texmf=$(kpsewhich -var-value="$scope") && [ -n "$texmf" ]; then
        set --
        if [ "$scope" = TEXMFLOCAL ]; then
            mktexlsr_path=$(command -v mktexlsr) || fail 'mktexlsr is required for TEXMFLOCAL.'
            set -- "$mktexlsr_path" "$texmf"
        fi
    elif miktex_path=$(command -v miktex) && command -v initexmf >/dev/null 2>&1; then
        report=$(initexmf --report)
        if [ "$scope" = TEXMFLOCAL ]; then
            texmf=$(printf '%s\n' "$report" | sed -n 's/^CommonInstall: //p')
            set -- "$miktex_path" --admin fndb refresh
        else
            texmf=$(printf '%s\n' "$report" | sed -n 's/^UserInstall: //p')
            set -- "$miktex_path" fndb refresh
        fi
    else
        fail 'TeX Live or MiKTeX is required.'
    fi
    case $texmf in
        *:*|*[{}]*) fail "Expected one TEXMF directory, got: $texmf" ;;
        /*) ;;
        *) fail "Could not determine an absolute TEXMF directory: $texmf" ;;
    esac

    workdir=$(mktemp -d "${TMPDIR:-/tmp}/enlp.XXXXXX")
    trap 'rm -rf "$workdir"' 0
    trap 'exit 1' HUP INT TERM
    curl -fsSL https://github.com/EhimeNLP/enlp-thesis-template/archive/refs/heads/main.tar.gz \
        -o "$workdir/source.tar.gz"
    tar -xzf "$workdir/source.tar.gz" -C "$workdir" --strip-components=1
    src="$workdir/src"

    for file in "$src"/*.cls "$src"/*.sty "$src"/*.bbx "$src"/*.cbx "$src"/*.bst; do
        [ -f "$file" ] || fail "Missing package file: $file"
    done
    admin=
    if [ "$scope" = TEXMFLOCAL ] && [ "$(id -u)" -ne 0 ]; then
        admin=1
    fi
    tex_dir="$texmf/tex/latex/enlp"
    bst_dir="$texmf/bibtex/bst/enlp"
    ${admin:+sudo} mkdir -p "$tex_dir" "$bst_dir"
    ${admin:+sudo} cp "$src"/*.cls "$src"/*.sty "$src"/*.bbx "$src"/*.cbx "$tex_dir/"
    ${admin:+sudo} cp "$src"/*.bst "$bst_dir/"
    if [ "$#" -gt 0 ]; then
        ${admin:+sudo} "$@"
    fi
    printf 'Installed enlp in %s\n' "$texmf"
}

install_enlp "$@"
