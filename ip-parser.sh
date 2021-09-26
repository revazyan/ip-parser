!/bin/bash
check_ip () {
ipaddr=$(ip a | grep -o 'inet [0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+' | grep -o [0-9].*)
num=0
for ip in $ipaddr
do
num=$((num+1))
echo " $num $ip" >>results.txt
done
}

check_int () {
interfaces=$(ls /sys/class/net/)
for int in $interfaces
do
sed -i "s/ $num /$int /" results.txt
num=$((num-1))

done
}

check_ip
check_int


if [ $# == 0 ]
then
cat results.txt && >results.txt

else

for i in $*
do
grep -q "$i " results.txt
if [ $? == 0 ]
then
cat results.txt | grep $i
else
echo "$i - interface not found"
fi
done
>results.txt
fi
