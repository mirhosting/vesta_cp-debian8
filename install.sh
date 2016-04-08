< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-8} > pass.txt;
pass=$(cat pass.txt);
echo $pass;
