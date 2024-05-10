CONFIG_DIR="$HOME/.config"

mkdir -p "$CONFIG_DIR"

select option in "Stow into .config" "Stow delete" "Restow" "Stow neovim core" "Stow neovim full" "Quit"
do
    case "$option" in

        "Stow into .config")
            stow -v -t "$CONFIG_DIR" -S config
            break 
            ;;

        "Stow delete")
            stow -v -t "$CONFIG_DIR" -D config
            break 
            ;;

        "Restow")
            stow -v -t "$CONFIG_DIR" -R config
            break 
            ;;

        "Stow neovim core")
            current_branch="$(git branch --show-current)"

            stow -v -t "$CONFIG_DIR" -R config
	        git checkout core
            stow -v -t "$CONFIG_DIR" -S config
            break 
            ;;

        "Stow neovim full")
            current_branch="$(git branch --show-current)"

            stow -v -t "$CONFIG_DIR" -R config
	        git checkout main
            stow -v -t "$CONFIG_DIR" -S config
            break 
            ;;

        "Quit")
            break 
            exit 0
            ;;

        *)
            echo "Invalid option."
            ;;

        esac
done

