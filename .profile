export JAVA_HOME=/usr/lib/jvm/java-6-sun/jre
export PATH="$JAVA_HOME/bin:$HOME/Useful/bin:$PATH"

if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi
