alias mcp='mvn clean package'
alias mcprpn='mcp -Drpm.phase=none'
alias mci='mvn clean install'
alias mcin='mci -N'
alias mdt='mvn dependency:tree'
alias msr='mvn spring-boot:run'
alias msbi='mvn spring-boot:build-image'
alias mvs='mvn versions:set -DgenerateBackupPoms=false'
# upfolderpoms alias inspired by mikeLundquist on https://unix.stackexchange.com/a/624847 with fixes for zsh (second level folders) based on Dennis Williamson on https://superuser.com/a/86353
alias upfolderpoms='eval find ./$(printf "{"; for x in {1..10} ; do printf -v spaces "%*s" $x ""; printf ",%s" ${spaces// /../}; done; printf "}") -maxdepth 1 -name pom.xml'
alias poms='upfolderpoms | xargs readlink -f'
alias mpp='upfolderpoms | tail -n 1'
alias mpv='mvn -q -Dexec.executable="echo" -Dexec.args="\${project.version}" --non-recursive org.codehaus.mojo:exec-maven-plugin:1.3.1:exec'
hash xmllint 2>/dev/null && alias mpv="xmllint --xpath '//*[local-name()=\"project\"]/*[local-name()=\"version\"]/text()' \$(mpp) | xargs echo"
