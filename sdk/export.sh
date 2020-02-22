# Initialize SDKMAN variables, init script has not been processed in git.
export SDKMAN_VERSION="5.7.4+362"
export SDKMAN_SERVICE="https://api.sdkman.io/1"
export SDKMAN_CANDIDATES_API="https://api.sdkman.io/2"
export SDKMAN_DIR="$HOME/.sdkman"

# Source sdkman module scripts.
# -----------------------------
# Author: Marco Vermeulen <vermeulen.mp@gmail.com>
# Modifications: Adrian Haasler <dev@adrianhaasler.com>
# - Use link type instead of normal file in find command
# License: Apache (licenses/sdkman-sdkman-cli) and MIT (LICENSE) for modifications
for f in $(find "${SDKMAN_DIR}/src/" -type l -name 'sdkman-*' -exec basename {} \;); do
	source "${SDKMAN_DIR}/src/${f}"
done

# Source extension files prefixed with 'sdkman-' and found in the ext/ folder
# Use this if extensions are written with the functional approach and want
# to use functions in the main sdkman script.
# ---------------------------------------------------------------------------
# Author: Marco Vermeulen <vermeulen.mp@gmail.com>
# Modifications: Adrian Haasler <dev@adrianhaasler.com>
# - Use link type instead of normal file in find command
# License: Apache (licenses/sdkman-sdkman-cli) and MIT (LICENSE) for modifications
for f in $(find "${SDKMAN_DIR}/ext/" -type l -name 'sdkman-*' -exec basename {} \;); do
	source "${SDKMAN_DIR}/ext/${f}"
done
unset f

# Load SDKMAN
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
