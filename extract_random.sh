#!/bin/sh
#Extract random line from file respecting order
#Refer to http://unix.stackexchange.com/questions/29709/randomly-draw-a-certain-number-of-lines-from-a-data-file

show_help () {
  echo "extract.sh -v -m [NUMLINES] -f [REMAININGS] -s [EXTRACTS] [SOURCES]"
  echo "extract.sh -v -m 1000 -f /tmp/out2 -s /tmp/out1 /home/logs/apache2/access.log"
}

if [ $# -eq 0 ]
then
  show_help
  exit 1
fi  

verbose=0
numlines=0
notExtracted="/dev/null"
extracted="/dev/null"

while getopts "hvm:f:s:" opt; do
  case "$opt" in
    h)
      show_help
      exit 0
      ;;
    v)
      verbose=1
      ;;
    m)
      numlines=$OPTARG
      ;;
    f)
      extracted=$OPTARG
      ;;
    s)
      notExtracted=$OPTARG
      ;;
  esac
done

shift $((OPTIND-1))

if [ -z $@ ]
then
  show_help
  exit 1
fi

if [ ! -f $@ ]
then
  echo "File do not exists "$@
  exit 1
fi

awk -v m=$numlines -v N=$(wc -l < $@) -v out1=$extracted -v out2=$notExtracted  'BEGIN{ srand()
         do{ lnb = 1 + int(rand()*N)
             if ( !(lnb in R) ) {
                 R[lnb] = 1
                 ct++ }
         } while (ct<m)
  } { if (R[NR]==1) print > out1 
      else          print > out2       
  }' $@
