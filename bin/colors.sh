for((i=0; i <= 256; i++)); do
  printf "$(tput setaf $i)%03d " $i;
  [ $(($(($i+1)) % 9)) -eq 0 ] && echo "";
done;

echo "";
