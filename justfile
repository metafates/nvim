fmt:
	stylua **/*.lua

download-spell:
	curl -f -L https://ftp.nluug.nl/pub/vim/runtime/spell/ru.utf-8.sug -o ./spell/ru.utf-8.sug --create-dirs
	curl -f -L https://ftp.nluug.nl/pub/vim/runtime/spell/ru.utf-8.spl -o ./spell/ru.utf-8.spl --create-dirs
