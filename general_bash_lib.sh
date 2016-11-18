#!/bin/bash

#Sub modules

# logging
LOGFILE=${0%.*}".log"

if [ -f ${LOGFILE} ] ;
then
	mv ${LOGFILE} ${LOGFILE}"_bak"
	rm -f ${LOGFILE}
fi
echo `date` > ${LOGFILE}
echo "new create log:"${LOGFILE}
exec 1> >(tee -a ${LOGFILE})
exec 2> >(tee -a ${LOGFILE} >&2)

# invoke
invoke(){
    echo "$@" >> ${LOGFILE}
    eval "$@"
}


# yes or no (number)
function yes_or_no_select(){
    PS3="Answer? "
    while true;do
        echo "Type 1 or 2."
        select answer in yes no;do
            case $answer in
                yes)
                    echo -e "tyeped yes.\n"
                    return 0
                    ;;
                no)
                    echo -e "tyeped no.\n"
                    return 1
                    ;;
                *)
                    echo -e "cannot understand your answer.\n"
                    ;;
            esac
        done
    done
}

# yes or no (char)
askYesOrNo() {
    while true ; do
        read -p "$1 [Y/n]?" answer
        case $answer in
            [yY] | [yY]es | YES )
                return 0;;
            [nN] | [nN]o | NO )
                return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}
