#! /bin/sh

# Run below command to build database: 
# sh make.sh your-user-name your-database-name

set -e
set -u 

psql \
	-X \
	-U $1 \
	-d $2 \
	-f ./ddl.sql \
	-f ./insert.sql \
    -f ./function.sql \
    -f ./test.sql 

psql -U $1 -d $2
