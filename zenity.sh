#!/bin/bash
CMD="find"
name=""
numer=0
katalog=""
rozmiar=""
typ=""
zawartosc=""
ctime=""
nazwakomenda=""
katalogkomenda=""
rozmiarkomenda=""
typkomenda=""
zawartosckomenda=""
ctimekomenda=""

koniec=1
while [[ $koniec -ne 8 ]]; do
menu=("Nazwa: $name " "Katalog: $katalog" "Typ: $typ" "Rozmiar:$rozmiar " "Zawartość: $zawartosc"  "Data utworzona (dni): $ctime " "Wyszukaj" "Koniec" )
    numer=`zenity --list --column=Menu "${menu[@]}" --height 350`


    case "$numer" in
        "${menu[0]}" )
            name=`zenity --entry --title "Wyszukiwanie" --text "Wpisz nazwe pliku"`
            nazwakomenda=" -name '$name' "
            ;;
        "${menu[1]}" )
            katalog=`zenity --entry --title "Wyszukiwanie" --text  "Wpisz katalog "`
            katalogkomenda=" \\$katalog"
            ;;
        "${menu[2]}" )
            typ=`zenity --entry --title "Wyszukiwanie" --text "Wpisz typ pliku "`
            typkomenda=" -type $typ"
            ;;

        "${menu[3]}" )
            rozmiar=`zenity --entry --title "Wyszukiwanie" --text  "Wpisz rozmiar pliku "`	
            rozmiarkomenda="-size $rozmiar"
            ;;

        "${menu[4]}" )
            zawartosc=`zenity --entry --title "Wyszukiwanie" --text "Wpisz zawartosc pliku"`
            zawartosckomenda="-exec $zawartosc"
            ;;
        "${menu[5]}" )
            ctime=`zenity --entry --title "Wyszukiwanie" --text "Wpisz date utworzenia pliku"`
            ctimekomenda="-ctime  -$ctime"  
            ;;

        "${menu[6]}" )
            komenda=" $CMD $katalogkomenda  $nazwakomenda $rozmiarkomenda $typkomenda $zawartosckomenda $ctimekomenda"
            $komenda | zenity --text-info –height 200 –title "lista plików"
            ;;

        "${menu[7]}" )
            koniec=8
            ;;
    esac
done



