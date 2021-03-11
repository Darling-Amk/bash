#!/bin/sh


# Дополнительные свойства для текта:
BOLD='\033[1m'       #  ${BOLD}      # жирный шрифт (интенсивный цвет)
DBOLD='\033[2m'      #  ${DBOLD}    # полу яркий цвет (тёмно-серый, независимо от цвета)
NBOLD='\033[22m'      #  ${NBOLD}    # установить нормальную интенсивность
UNDERLINE='\033[4m'     #  ${UNDERLINE}  # подчеркивание
NUNDERLINE='\033[4m'     #  ${NUNDERLINE}  # отменить подчеркивание
BLINK='\033[5m'       #  ${BLINK}    # мигающий
NBLINK='\033[5m'       #  ${NBLINK}    # отменить мигание
INVERSE='\033[7m'     #  ${INVERSE}    # реверсия (знаки приобретают цвет фона, а фон -- цвет знаков)
NINVERSE='\033[7m'     #  ${NINVERSE}    # отменить реверсию
BREAK='\033[m'       #  ${BREAK}    # все атрибуты по умолчанию
NORMAL='\033[0m'      #  ${NORMAL}    # все атрибуты по умолчанию

# Цвет текста:
BLACK='\033[0;30m'     #  ${BLACK}    # чёрный цвет знаков
RED='\033[0;31m'       #  ${RED}      # красный цвет знаков
GREEN='\033[0;32m'     #  ${GREEN}    # зелёный цвет знаков
YELLOW='\033[0;33m'     #  ${YELLOW}    # желтый цвет знаков
BLUE='\033[0;34m'       #  ${BLUE}      # синий цвет знаков
MAGENTA='\033[0;35m'     #  ${MAGENTA}    # фиолетовый цвет знаков
CYAN='\033[0;36m'       #  ${CYAN}      # цвет морской волны знаков
GRAY='\033[0;37m'       #  ${GRAY}      # серый цвет знаков

# Цветом текста (жирным) (bold) :
DEF='\033[0;39m'       #  ${DEF}
DGRAY='\033[1;30m'     #  ${DGRAY}
LRED='\033[1;31m'       #  ${LRED}
LGREEN='\033[1;32m'     #  ${LGREEN}
LYELLOW='\033[1;33m'     #  ${LYELLOW}
LBLUE='\033[1;34m'     #  ${LBLUE}
LMAGENTA='\033[1;35m'   #  ${LMAGENTA}
LCYAN='\033[1;36m'     #  ${LCYAN}
WHITE='\033[1;37m'     #  ${WHITE}

# Цвет фона
BGBLACK='\033[40m'     #  ${BGBLACK}
BGRED='\033[41m'       #  ${BGRED}
BGGREEN='\033[42m'     #  ${BGGREEN}
BGBROWN='\033[43m'     #  ${BGBROWN}
BGBLUE='\033[44m'     #  ${BGBLUE}
BGMAGENTA='\033[45m'     #  ${BGMAGENTA}
BGCYAN='\033[46m'     #  ${BGCYAN}
BGGRAY='\033[47m'     #  ${BGGRAY}
BGDEF='\033[49m'      #  ${BGDEF}
#======================= Константы  =======================

# Размеры массивов
size_h=20
size_w=20

# Стартовая позиция
pos_x=5
pos_y=5

# Для яблочков
count=0
flag_count=0
f_x=-1
f_y=-1

# Двумерный массив для карты
declare -A arr
for((i=0; i<$size_h; i++))
do
    for((j=0; j<$size_w; j++))
    do
	if (($i == $size_h-1 || $i==0 || $j==0 || j == $size_w-1))
	then
	    arr[${i},${j}]="##"
	else
	    arr[${i},${j}]="__"
	fi
    done
done
#====================Кjycnfyn=====================

# Основной цикл
while true
do
    #Появление яблок
    if(($flag_count==0 && 1))
    then
	f_x=$((1 + $RANDOM % (size_w-2)))
	f_y=$((1 + $RANDOM % (size_h-2)))
	#echo $f_y $f_x
	flag_count=1
    fi

#Старые коардинаты сохраняем
last_x=$pos_x
last_y=$pos_y


#======================= Управление =======================
   
read -n1 Keypress
case "$Keypress" in
#=======================
$'q') # Если key = quit
    echo -n $USER score:  $count >> o.txt
    date >> o.txt
    echo " "
    exit
;;

$'a')
    pos_x=$(($pos_x-1))
;;

$'d') 
    pos_x=$(($pos_x+1))
;;

$'w')      
     pos_y=$(($pos_y-1))
;;

$'s')
     pos_y=$(($pos_y+1))
     ;;
$'-')
     count=$(($count-1))
;;
$'+')
     count=$(($count+1))
;;


esac
#==================== Конец Управление ====================





#Ограничения
if (($pos_x <= 0 || $pos_x >= $size_w-1))
then
  pos_x=$last_x  
fi

if (($pos_y <= 0 || $pos_y >= $size_h-1))
then
  pos_y=$last_y  
fi
#Конец ограничений


if(($pos_x==$f_x && $pos_y==$f_y && $flag_count==1))
then
    count=$(($count+1))
    flag_count=0
fi
clear

if(($flag_count))
then
     arr[${f_y},${f_x}]="%%"
fi


 arr[${last_y},${last_x}]="__"

 arr[${pos_y},${pos_x}]="@@"
#===================== Печать массива =====================
for((i=0; i<$size_h; i++))
do
    for((j=0; j<$size_w; j++))
    do
	if [ "${arr[$i,$j]}" == "##" ];then
	    echo -en "${BGGRAY}${arr[$i,$j]}"	    
	elif [ "${arr[$i,$j]}" == "@@" ] ; then
	     echo -en "${BGRED}${arr[$i,$j]}"

        elif [ "${arr[$i,$j]}" == "00" ] ; then
             echo -en "${RED}${BGRED}${arr[$i,$j]}${GRAY}"


	elif [ "${arr[$i,$j]}" == "%%" ]
             then
                 echo -en "${BGGREEN}${arr[$i,$j]}"
	else	    
	    echo -en "${BGBLACK}${BLACK}${arr[$i,$j]}${GRAY}"
	fi
    done
    echo ""
done
    echo -e "${BGBLACK} ${RED}Коардинаты: ${BLUE}" $pos_x $pos_y "${YELLOW}Счет: " $count
#==========================================================
tput sgr0 
done
