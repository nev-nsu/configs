sed -i 's/user_pref("'$2'",.*);/user_pref("'$2'","'$3'");/' $1/user.js
grep -q $2 $1/user.js || echo "user_pref(\"$2\",\"$3\");" >> $1/user.js

