#!/usr/bin/env sh
#
# Determine the Java command to use to start the JVM.
if [ -n "$JAVA_HOME" ] ; then
    if [ -x "$JAVA_HOME/bin/java" ] ; then
        jvm=$JAVA_HOME/bin/java
    else
        echo "ERROR: JAVA_HOME is set to an invalid directory: $JAVA_HOME"
        echo ""
        echo "Please set the JAVA_HOME environment variable in your environment to match the"
        echo "location of your Java installation."
        exit 1
    fi
else
    if [ -x "/usr/lib/jvm/default-java/bin/java" ] ; then
        jvm="/usr/lib/jvm/default-java/bin/java"
    elif [ -x "/usr/lib/jvm/java/bin/java" ] ; then
        jvm="/usr/lib/jvm/java/bin/java"
    else
        echo "ERROR: JAVA_HOME is not set and no system Java was found in your PATH"
        echo ""
        echo "Please install a JVM in your system and/or set the JAVA_HOME environment variable"
        exit 1
    fi
fi

# For Cywgin, ensure paths are in windows format
if [ "$OSTYPE" = "msys" ]; then
    MSYS=true
fi

if [ -n "$MSYS" ] && [ "$MSYSTEM_CHOST" = "MINGW32" ]; then
    wrappersJarSrc="`cygpath --path --mixed --windows 'C:\Users\username\.gradle\wrapper\dists\gradle-x.x-all\xyzzy\gradle-x.x-bin.zip'"
else
    wrappersJarSrc="`dirname \"$0\"`/../gradle/wrapper/gradle-wrapper.jar"
fi
classpath=org.gradle.wrapper.GradleWrapperMain
source="$jvm"
args=("-classpath" "\"$wrappersJarSrc\"" "-Dgradle.version=\"x.x\" org.gradle.wrapper.GradleWrapperMain \"$@\"")
exec "$source" "$args"
exit 1
