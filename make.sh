#! /bin/sh

# Step one: sh make.sh
# Step two: Enter your user name

set -e
set -u 

read -p 'Username: ' uservar
psql \
	-X \
	-U $uservar \
	-d cs425\
	-f ./cs425project_sql/ddl.sql\
	-f ./cs425project_sql/insert.sql
psql cs425