alias mcp='mvn clean package'
alias mci='mvn clean install'
alias mcin='mci -N'
alias mpv='mvn -q -Dexec.executable="echo" -Dexec.args="\${project.version}" --non-recursive org.codehaus.mojo:exec-maven-plugin:1.3.1:exec'
