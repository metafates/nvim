fmt:
    stylua **/*.lua

download-spell:
    curl -f -L https://github.com/danakt/russian-words/raw/refs/heads/master/russian.txt -o ./spell/ru.txt --create-dirs
    iconv -f WINDOWS-1251 -t UTF-8 ./spell/ru.txt > ./spell/ru.utf-8.txt

    nvim --headless \
      -u NONE \
      -c "mkspell! \
    		./spell/ru \
    		./spell/ru.utf-8.txt" \
      -c qa

    curl https://raw.githubusercontent.com/abbrcode/abbreviations-in-code/refs/heads/main/data/abbrs/.json \
    	| jq .[].abbrs.[].abbr -r > ./spell/en-extra.txt

    nvim --headless \
      -u NONE \
      -c "mkspell! \
    		./spell/en-extra \
    		./spell/en-extra.txt" \
      -c qa

    rm ./spell/*.txt
