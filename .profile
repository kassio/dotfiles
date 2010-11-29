export JAVA_HOME=/usr/lib/jvm/java-6-sun/jre
export PATH="$HOME/.gem/ruby/1.8/bin:$PATH"
export PATH="$HOME/uteis/bin:$PATH"

if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

