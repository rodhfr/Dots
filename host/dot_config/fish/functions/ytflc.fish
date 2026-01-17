function ytflc
    # Initialize defaults
    set URL ""
    set DEST "$HOME/Music"
    set SUBFOLDER ""

    # Parse arguments
    set i 1
    while test $i -le (count $argv)
        switch $argv[$i]
            case --dir_name -d
                # Take next argument as subfolder name
                set SUBFOLDER $argv[(math $i + 1)]
                set i (math $i + 1) # skip the subfolder argument
            case '*'
                # If URL not set yet, treat this as URL
                if test -z "$URL"
                    set URL $argv[$i]
                else
                    echo "Unknown argument: $argv[$i]"
                    return 1
                end
        end
        set i (math $i + 1)
    end

    # Check URL
    if test -z "$URL"
        echo "Usage: ytflac <URL> [--dir_name NAME | -d NAME]"
        echo "Default Destination: $DEST"
        return 1
    end

    # Append subfolder if provided
    if test -n "$SUBFOLDER"
        set DEST "$DEST/$SUBFOLDER"
    end

    # Make sure destination exists
    if not test -d "$DEST"
        mkdir -p "$DEST"
    end

    # Download audio as FLAC
    yt-dlp -P "$DEST" -x --audio-format flac "$URL"

    echo
    echo "Download complete. Press Enter to exit..."
    notify-send "YouTube FLAC Download" "✅Download completed in $DEST"
    echo
    exit
    #read
end
