alias mcp='mvn clean package'
alias mci='mvn clean install'
alias mcin='mci -N'
alias mdt='mvn dependency:tree'
alias msr='mvn spring-boot:run'
alias msbi='mvn spring-boot:build-image'
alias mvs='mvn versions:set -DgenerateBackupPoms=false'
alias mpv='mvn -q -Dexec.executable="echo" -Dexec.args="\${project.version}" --non-recursive org.codehaus.mojo:exec-maven-plugin:1.3.1:exec'
hash xmllint 2>/dev/null && alias mpv="xmllint --xpath '//*[local-name()=\"project\"]/*[local-name()=\"version\"]/text()' pom.xml | xargs echo"
