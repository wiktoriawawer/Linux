# Author           : Wiktoria Wawer 185583
# Created On       : 10.05.23
# Last Modified By : Wiktoria Wawer 185583
# Last Modified On : 10.05.23
# Version          : wersja
#
# Description      :
# Opis
#

#width=`zenity --scale --text="Wybór szerokości obrazu" --min-value=1 --max-value=10 --value=3`
#heigth=`zenity --scale --text="Wybór wykości obrazu" --min-value=1 --max-value=10 --value=2`
#plik=`zenity --file-selection --title="Select a File"`
#display $plik

# wstepne ustalowne wymirary
width=10
heigth=20
plik="image.png"

# odczytanie z pliku wymiaru obrazka w pixelach
size=$(identify -format "%wx%h" $plik)
pixwidth=$(identify -format "%w" $plik)
pixheight=$(identify -format "%h" $plik)

#utworzenie obrazka o takim samym wymiarze 
convert -size $size xc:white out.png



pixw=$(($pixwidth/$width))
pixh=$(($pixheight/$heigth))

counterh=0
counterw=0
while [ $counterh -lt $heigth ]
do 
    counterw=0
    while [ $counterw -lt $width ]
    do 
        #nazwa obrazka to zmienna w okreslajaca pozycje 
        #tworznie fragmentow obrazka 
        w=$pixw'x'$pixh'+'$(($pixw*$counterw))'+'$(($pixh*$counterh))
        #echo $w
        convert $plik -crop $w $w.png

        #tworzenie histogramu dla fragmentu obrazka
        convert $w.png -format %c histogram:info:-| cut -d '#' -f1 > $w.txt

        #licznie sredniej dla RGB
        #zapisanie ilosci danego koloru 
        num=$(grep -oE '[0-9,]*:' $w.txt | tr -d ':' )
        #odczytanie wartosci dla kazego koloru RGB 
        red=$(grep -oE '\([0-9]+' $w.txt | tr -d '(' )
        green=$(grep -oE ',[0-9]+,' $w.txt | tr -d ',' )
        blue=$(grep -oE '[0-9]+\)' $w.txt | tr -d ')' )
        sumred=0
        sumgreen=0
        sumblue=0
        sum=0

        readarray -t red_array <<< "$red"
        readarray -t green_array <<< "$green"
        readarray -t blue_array <<< "$blue"
        readarray -t num_array <<< "$num"

        for ((i=0; i<${#red_array[@]}; i++)); do
            
            sum=$(( $sum + ${num_array[i]} ))
            sumgreen=$(( $sumgreen + ${green_array[i]} * ${num_array[i]} ))
            sumblue=$(( $sumblue + ${blue_array[i]} * ${num_array[i]} ))
            sumred=$(( $sumred + ${red_array[i]} * ${num_array[i]} ))

        done
        

        #type="rectangle "$(($pixw*$counterw))","$(($pixh*$counterh))","$pixw","$pixh
        type="rectangle "$(($pixw*$counterw))","$(($pixh*$counterh))","$(($pixw*$counterw+$pixw))","$(($pixh*$counterh+$pixh))
        #type="rectangle 10,10,100,100"               
        rgbcol="rgb("$(( $sumred / $sum))","$(( $sumgreen / $sum))","$(( $sumblue / $sum))")"
        
        echo $type      
        echo $rgbcol
        convert out.png -fill "$rgbcol" -draw "$type" out.png
        #convert out.png -fill 'rgb(105,55,255)' -draw 'rectangle 10,10,100,100' out.png

        ((counterw++))
    done 
    ((counterh++))    
done