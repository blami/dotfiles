# ~/.profile.d/java.sh: Java environment

# Debian/Ubuntu
if [ -d /usr/lib/jvm/default-java ]; then
	JAVA_HOME=/usr/lib/jvm/default-java ; export JAVA_HOME
fi
