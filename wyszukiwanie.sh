
CMD="find"
nazwa=""
numer=0
katalog=""
rozmiar=""
typ=""
zawartosc=""
while [[ $numer -ne 8 ]]; do
	echo "1. Nazwa: $nazwa"
	echo "2.Katalog: $katalog "
	echo "3.Rozmiar: $rozmiar "
	echo "4 Typ: $typ  "
	echo "5. "
	echo "6. Zawartosc: $zawartosc"
	echo "7. Szukaj"
	echo "8. Koniec"
	read numer 
	if [[ $numer -eq 1 ]];then
	       echo "podaj nazwe: "     
		read nazwa
	elif [[  $numer -eq 2 ]];then
		echo "podaj katalog:  "
		read katalog
	elif [[  $numer -eq 3 ]];then
		echo "podaj rozmiar:  "
		read rozmiar
	elif [[  $numer -eq 4 ]];then 
		echo "podaj typ:  "
		read typ	
	elif [[ $numer -eq 5 ]];then
		echo "5"
	elif [[  $numer -eq 6 ]];then
		echo "podaj zawartosc:  "
		read zawartosc
	elif [[  $numer -eq 7 ]];then
		echo "7"
		if [[ nazwa != "" ]];then
			komenda=" $CMD -name \"$nazwa\""
			echo $komenda
		fi 
	elif [[  $numer -eq 8 ]];then
		numer=8
	fi 
done

