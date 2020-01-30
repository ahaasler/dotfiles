if [ -d "/usr/lib/jvm/jetbrains-jre" ]; then
	export IDEA_JDK=/usr/lib/jvm/jetbrains-jre
fi

# Fix idea on sway
export _JAVA_AWT_WM_NONREPARENTING=1
