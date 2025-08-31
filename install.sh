CONFIG_DIR="$HOME/.config"
SOURCES_PATH="$CONFIG_DIR/sources"
NVIM_STAGE_NAME="nvim-stage"

MANAGED_CONFIG="nvim"
MANAGED_SOURCES="neovim.sh"

mkdir -p "$CONFIG_DIR"

deleteConfig () {
    for config in "$1"; do
        rm -r "$CONFIG_DIR/$config" 2>/dev/null
    done
}

deleteSources () {
    for source in "$1"; do
        rm "$SOURCES_PATH/$source" 2>/dev/null
    done
}

uninstall () {
    deleteConfig "$MANAGED_CONFIG"
    deleteSources "$MANAGED_SOURCES"
    unlink_stage_config 2>/dev/null
}

wipe_config () {
    deleteConfig "$MANAGED_CONFIG"
}

stow_config () {
    if [[ $1 == "-S" ]]; then
        wipe_config
    fi
    stow -v -t "$CONFIG_DIR" $1 config
}

cp_config () {
    wipe_config
    cp -r "config/." "$CONFIG_DIR"
}

link_stage_config () {
    mkdir -p "$SOURCES_PATH"
    cp -r "sources/." "$SOURCES_PATH"
    ln -sf "$(pwd)/config/nvim" "$CONFIG_DIR/$NVIM_STAGE_NAME"
}

unlink_stage_config () {
    mkdir -p "$SOURCES_PATH"
    rm -r "$CONFIG_DIR/$NVIM_STAGE_NAME"
    deleteSources "neovim.sh"
}

select option in "Stow into .config" "Stow delete" "Stow neovim core" "Stow neovim full" "Link neovim-stage" "Unlink neovim-stage" "Cp into .config" "Delete nvim config" "Cp neovim core" "Cp neovim full" "Uninstall" "Quit"
do
    case "$option" in

        "Stow into .config")
            stow_config -S
            ;;

        "Stow delete")
            stow_config -D
            ;;

        "Stow neovim core")
	        git checkout core
            stow_config -S 
            ;;

        "Stow neovim full")
	        git checkout main
            stow_config -S 
            ;;

        "Cp into .config")
            cp_config
            ;;

        "Delete nvim config")
            wipe_config
            ;;

        "Cp neovim core")
            current_branch="$(git branch --show-current)"
            git checkout core
            cp_config
            git checkout "$current_branch"
            ;;

        "Cp neovim full")
            current_branch="$(git branch --show-current)"
            git checkout main
            cp_config
            git checkout "$current_branch"
            ;;

        "Link neovim-stage")
            link_stage_config
            ;;

        "Unlink neovim-stage")
            unlink_stage_config
            ;;

        "Uninstall")
            uninstall
            ;;

        "Quit")
            exit 0
            ;;

        esac
done

