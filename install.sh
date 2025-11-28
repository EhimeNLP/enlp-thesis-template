#!/bin/bash

TOML_FILE="package.toml"
INSTALL_SCOPE="local"

while [[ $# -gt 0 ]]; do
    case "$1" in
        --texmflocal)
            INSTALL_SCOPE="local"
            shift
            ;;
        --texmfhome)
            INSTALL_SCOPE="home"
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [--texmflocal|--texmfhome]"
            echo "  --texmflocal   Install into TEXMFLOCAL (requires sudo, default)"
            echo "  --texmfhome    Install into TEXMFHOME (user local tree)"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

get_value_from_toml() {
  local key="$1"
  grep "$key" "$TOML_FILE" | sed -E 's/.*= "(.*)"/\1/' | tr -d '\r'
}

get_files_from_toml() {
  grep "entrypoints" "$TOML_FILE" | sed -E 's/.*= \[(.*)\]/\1/' | tr -d '\r' | sed 's/"//g' | tr ',' '\n' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//'
}

detect_tex_distribution() {
    if command -v tlmgr > /dev/null 2>&1; then
        TEX_DISTRO="texlive"
    elif command -v miktex > /dev/null 2>&1; then
        TEX_DISTRO="miktex"
    else
        echo "No supported TeX distribution found"
        exit 1
    fi
}

get_texmf_path() {
    case "$TEX_DISTRO" in
        "texlive")
            if [ "$INSTALL_SCOPE" = "home" ]; then
                TEXMF_PATH=$(kpsewhich -var-value=TEXMFHOME)
            else
                TEXMF_PATH=$(kpsewhich -var-value=TEXMFLOCAL)
            fi
            ;;
        "miktex")
            TEXMF_PATH=$(miktex-console --get-settings | grep 'CommonInstall')
            ;;
    esac
}

get_install_subdir() {
    local file="$1"
    local ext="${file##*.}"
    
    case "$ext" in
        sty|cls|ltx)
            echo "tex/latex/$PACKAGE_NAME"
            ;;
        bst)
            echo "bibtex/bst/$PACKAGE_NAME"
            ;;
        bib)
            echo "bibtex/bib/$PACKAGE_NAME"
            ;;
        *)
            echo "tex/latex/$PACKAGE_NAME"
            ;;
    esac
}

install_package_files() {
    local files_installed=0
    
    while IFS= read -r file; do
        [ -z "$file" ] && continue
        
        if [ ! -f "$file" ]; then
            echo "Warning: File '$file' not found, skipping..."
            continue
        fi
        
        local subdir=$(get_install_subdir "$file")
        local install_dir="$TEXMF_PATH/$subdir"
        
        if [ ! -d "$install_dir" ]; then
            if [ "$INSTALL_SCOPE" = "home" ]; then
                mkdir -p "$install_dir"
            else
                sudo mkdir -p "$install_dir"
            fi
        fi
        
        if [ "$INSTALL_SCOPE" = "home" ]; then
            cp "$file" "$install_dir"
        else
            sudo cp "$file" "$install_dir"
        fi
        
        echo "Installed: $file -> $install_dir"
        files_installed=$((files_installed + 1))
    done < <(get_files_from_toml)
    
    if [ $files_installed -eq 0 ]; then
        echo "Error: No files were installed"
        exit 1
    fi
    
    case "$TEX_DISTRO" in
        "texlive")
            if [ "$INSTALL_SCOPE" = "home" ]; then
                echo "Installed to TEXMFHOME ($TEXMF_PATH). No mktexlsr needed."
                echo "Package $PACKAGE_NAME version $PACKAGE_VERSION installed successfully! ($files_installed files)"
            else
                MK_TEXLSR_PATH=$(which mktexlsr)
                if [ -z "$MK_TEXLSR_PATH" ]; then
                    echo "mktexlsr not found or not executable."
                    exit 1
                fi
                if [ -x "$MK_TEXLSR_PATH" ]; then
                    sudo "$MK_TEXLSR_PATH"
                    echo "Package $PACKAGE_NAME version $PACKAGE_VERSION installed successfully! ($files_installed files)"
                else
                    echo "mktexlsr not found or not executable."
                    exit 1
                fi
            fi
            ;;
        "miktex")
            sudo PATH=$PATH miktex-console --update-fndb
            if [ $? -eq 0 ]; then
                echo "Package $PACKAGE_NAME version $PACKAGE_VERSION installed successfully! ($files_installed files)"
            else
                echo "Failed to update MiKTeX file database."
                exit 1
            fi
            ;;
    esac
}

main() {
    PACKAGE_NAME=$(get_value_from_toml "name")
    PACKAGE_VERSION=$(get_value_from_toml "version")
    detect_tex_distribution
    get_texmf_path
    install_package_files
}

main