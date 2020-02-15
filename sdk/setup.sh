SDKMAN_DIR="$HOME/.sdkman"

# Remove legacy link
[ -L "$SDKMAN_DIR" ] \
	&& unlink "$SDKMAN_DIR" \
	&& install_dotfiles "$DOTFILES_HOME/sdk/.sdkman/" \
	&& mv "$DOTFILES_HOME/sdk/.sdkman/archives" "$SDKMAN_DIR/" \
	&& mv "$DOTFILES_HOME/sdk/.sdkman/candidates" "$SDKMAN_DIR/" \
	&& mv "$DOTFILES_HOME/sdk/.sdkman/ext" "$SDKMAN_DIR/" \
	&& mv "$DOTFILES_HOME/sdk/.sdkman/tmp" "$SDKMAN_DIR/" \
	&& mv "$DOTFILES_HOME/sdk/.sdkman/var" "$SDKMAN_DIR/"


# Initialize dirs
mkdir -p $SDKMAN_DIR/archives
mkdir -p $SDKMAN_DIR/candidates
mkdir -p $SDKMAN_DIR/ext
mkdir -p $SDKMAN_DIR/tmp
mkdir -p $SDKMAN_DIR/var

# Initialize SDKMAN files
touch $SDKMAN_DIR/var/candidates
