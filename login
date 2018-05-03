#!/bin/bash

. "$(dirname "$0")"/base

USER=admin
PASS=password

N=0

rm -f $DIR/*.out
rm -f $DIR/*.html
rm -f $COOKIES_FILE
rm -f $DIR/hash.*
rm -f $DIR/login.xml
rm -f $DIR/logout.xml


get $URL_PREFIX/html/home.html
TOKEN=`grep csrf $DIR/$N_PRETTY.html |cut -d '"' -f 4|tail -n 1`

hash "$PASS"
KEY=`cat $DIR/hash.b64`

hash "$USER$KEY$TOKEN"
echo '<?xml version "1.0" encoding="UTF-8"?><request><Username>'$USER'</Username><Password>'$(cat $DIR/hash.b64)'</Password><password_type>4</password_type></request>' >$DIR/login.xml
post --body-file=$DIR/login.xml --header="__RequestVerificationToken:$TOKEN" $URL_PREFIX/api/user/login

OK=`grep -c '<response>OK</response>' $DIR/$N_PRETTY.html`
if [ $OK -lt 1 ]
then
  echo "error logging in" >&2
  cat $DIR/$N_PRETTY.html >&2
  echo >&2
  exit 1
fi

