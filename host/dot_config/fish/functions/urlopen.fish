function urlopen
    for file in $argv
        while read -l url
            test -n "$url"; or continue
            setsid xdg-open $url >/dev/null 2>&1 &
        end <$file
    end
end
