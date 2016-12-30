# phpcs
alias phpcs.symfony2="phpcs --config-set default_standard Symfony2"
alias phpcs.PSR2="phpcs --config-set default_standard PSR2"
alias phpcs.PSR1="phpcs --config-set default_standard PSR1"

# php
function php.restart {
    currentversion="`php -r \"echo str_replace('.', '', substr(phpversion(), 0, 3));\"`"
    brew services restart php$currentversion
}

function php.switch {
    if [ $# -ne 1 ]; then
    	echo "Usage: php.switch [phpversion]"
        echo "Eg: php.switch 70"
    	exit 1
    fi

    currentversion="`php -r \"echo str_replace('.', '', substr(phpversion(), 0, 3));\"`"
    newversion="$1"

    shortOld="`php -r \"echo substr(phpversion(), 0, 1);\"`"
    shortNew="`php -r \"echo substr('$1', 0, 1);\"`"

    brew list php$newversion 2> /dev/null > /dev/null

    if [ $? -eq 0 ]; then
    	echo "PHP version $newversion found"

    	echo "Unlinking old binaries..."
    	brew unlink php$currentversion 2> /dev/null > /dev/null

    	echo "Linking new binaries..."
    	brew link php$newversion

    	brew services stop php$currentversion 2> /dev/null > /dev/null
    	brew services start php$newversion

    	echo "Done."
    else
    	echo "PHP version $newversion was not found."
    	exit 1
    fi
}
