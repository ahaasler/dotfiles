if [ -d "/usr/lib/jvm/jetbrains-jre" ]; then
	export IDEA_JDK=/usr/lib/jvm/jetbrains-jre
	export PHPSTORM_JDK=/usr/lib/jvm/jetbrains-jre
	export WEBIDE_JDK=/usr/lib/jvm/jetbrains-jre
	export PYCHARM_JDK=/usr/lib/jvm/jetbrains-jre
	export RUBYMINE_JDK=/usr/lib/jvm/jetbrains-jre
	export CL_JDK=/usr/lib/jvm/jetbrains-jre
	export DATAGRIP_JDK=/usr/lib/jvm/jetbrains-jre
	export GOLAND_JDK=/usr/lib/jvm/jetbrains-jre
	export STUDIO_JDK=/usr/lib/jvm/jetbrains-jre
fi

if [ -d "/usr/lib/jvm/jre-jetbrains" ]; then
	export IDEA_JDK=/usr/lib/jvm/jre-jetbrains
	export PHPSTORM_JDK=/usr/lib/jvm/jre-jetbrains
	export WEBIDE_JDK=/usr/lib/jvm/jre-jetbrains
	export PYCHARM_JDK=/usr/lib/jvm/jre-jetbrains
	export RUBYMINE_JDK=/usr/lib/jvm/jre-jetbrains
	export CL_JDK=/usr/lib/jvm/jre-jetbrains
	export DATAGRIP_JDK=/usr/lib/jvm/jre-jetbrains
	export GOLAND_JDK=/usr/lib/jvm/jre-jetbrains
	export STUDIO_JDK=/usr/lib/jvm/jre-jetbrains
fi

if [ -d "/usr/lib/jvm/jdk-jetbrains" ]; then
	export IDEA_JDK=/usr/lib/jvm/jdk-jetbrains
	export PHPSTORM_JDK=/usr/lib/jvm/jdk-jetbrains
	export WEBIDE_JDK=/usr/lib/jvm/jdk-jetbrains
	export PYCHARM_JDK=/usr/lib/jvm/jdk-jetbrains
	export RUBYMINE_JDK=/usr/lib/jvm/jdk-jetbrains
	export CL_JDK=/usr/lib/jvm/jdk-jetbrains
	export DATAGRIP_JDK=/usr/lib/jvm/jdk-jetbrains
	export GOLAND_JDK=/usr/lib/jvm/jdk-jetbrains
	export STUDIO_JDK=/usr/lib/jvm/jdk-jetbrains
fi

# Fix jetbrains on sway
export _JAVA_AWT_WM_NONREPARENTING=1
