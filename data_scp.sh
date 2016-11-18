#!/bin/bash

#Package copy
source ./general_bash_lib.sh
source ./tag.conf

#Sub module
## print_help
print_help(){
    echo "usage: $(basename $0) -s <Remote src hostname> [-f <filename>] [-p <nondefault path >] [-d] [-h]"
    echo "usage: $(basename $0) -s PC2"
}
src_path=""
dry_run=0
file_name=""

while getopts :s:p:f:dh OPT; do
    case $OPT in
        s)
            host_name="$OPTARG"
            ;;
        p)
            src_path="$OPTARG"
            ;;
        f)
            file_name="$OPTARG"
            ;;
        d)
            dry_run=1
            ;;
        h)
            print_help
            exit 0
            ;;
        *)
            print_help
            exit 2
    esac
done
shift `expr $OPTIND - 1`
OPTIND=1

## Remote Args
case $host_name in
  "PC0" ) ## class A 10.0.0.0～10.255.255.255 （10.0.0.0/8）
  			hostuser="root" 
  			hostip="10.1.1.2"
  			;;
  "PC1" )
  			hostuser="user" 
  			hostip="192.168.1.1"
  			;;
  "PC2" )
  			hostuser="user" 
  			hostip="192.168.1.2"
  			;;
esac

if [ -z $src_path ]; then
	src_path=${DIST_PATH}
	echo "->Remote PATH default:${src_path}"
fi

if [ -z $file_name ]; then
	file_name="*.*"
	echo "->Remote Copy File default:${file_name}"
fi

## Dry run
if [ $dry_run -eq 1 ]; then
    echo "->Remeote Check(Dry run)"
    if [ `ssh ${hostuser}@${hostip} "ls ${src_path}/${file_name} >& /dev/null; echo \$? "` -eq 0 ]; then
		echo "->Alive ${hostip}:${src_path}"
	fi
else

    echo "*** Remote Path  :"${DIST_PATH}
    if [ -d ${DIST_PATH} ] ;
    then

	cd ${DIST_PATH}
	echo `pwd`
	scp  ${hostuser}@${hostip}:${src_path}/${file_name} .
	if [ $? -eq 0 ]; then
	  echo "->Succeess files"
	  chmod 777 ${file_name}
	  ls -la ${file_name} 
	fi
    fi
fi
