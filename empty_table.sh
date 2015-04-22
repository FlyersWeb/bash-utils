#!/bin/bash
MHOST="$1"
MUSER="$2"
MPASS="$3"
MDB="$4"
MCMD="$5"
 
# Detect paths
MYSQL=$(which mysql)
AWK=$(which awk)
GREP=$(which grep)
 
if [ $# -ne 5 ]
then
	echo "Usage: $0 {MySQL-Server-Host} {MySQL-User-Name} {MySQL-User-Password} {MySQL-Database-Name} {MySQL-Command}"
	echo "Execute command on all database tables"
	exit 1
fi
 
TABLES=$($MYSQL -u $MUSER -h $MHOST -p$MPASS $MDB -e 'show tables' | $AWK '{ print $1}' | $GREP -v '^Tables' )
 
for t in $TABLES
do
	echo "Executing $MCMD on $t table from $MDB database on host $MHOST..."
	$MYSQL -u $MUSER -h $MHOST -p$MPASS $MDB -e "SET FOREIGN_KEY_CHECKS = 0; $MCMD \`$t\`; SET FOREIGN_KEY_CHECKS = 1;"
done
