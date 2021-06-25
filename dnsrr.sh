#!/bin/bash
function banner()
{
	if [ $# -eq 1 ]
	then
		echo "==========================================="
                echo -e "== \033[1;33mDNSrr\033[0m =================================="
                echo "==========================================="
                echo -e "== Twitter : \033[1;36m@A3h1nt\033[0m ======================"
                echo "==========================================="
                echo -e "== Attempting : \033[1;31m$1\033[0m     "
                echo "==========================================="
	else
		echo "==========================================="
                echo -e "== \033[1;33mDNSrr\033[0m =================================="
                echo "==========================================="
                echo -e "== Twitter : \033[1;36m@A3h1nt\033[0m ======================"
                echo "==========================================="
                echo -e "== Attempting : \033[1;31m$1\033[0m     "
                echo "==========================================="
		echo -e "== Wordlist : \033[1;32m$2\033[0m	         "
                echo "==========================================="
	fi
}

function zone_transfer()
{
	dig axfr @$1 $2 | sort -t 'I' -k2 -u
}

function forward_lookup_bruteforce()
{
	if [ $# -eq 1 ]
	then
		for i in $(cat list.txt);do host $i.$1;done | grep -v not | awk '{print $1 " : " $NF}'
	else
		for ip in $(cat $2);do host $ip.$1;done | grep -v not | awk '{print $1 " : " $NF}'
	fi
}

function reverse_lookup_bruteforce()
{
	ip=$(host $1 | awk '{print $NF}' | head -1 | cut -d '.' -f-3)
	if [[ $ip == *"NXDOMAIN"* ]]
	then
		echo "Invalid Domain Name!!!"
		exit
	fi
	for i in $(seq 1 255);do host $ip.$i;done | grep -v not | awk '{print $1 " : " $NF}' | sed 's/.in-addr.arpa/ /g'
}

function cache_snooping()
{
	for i in $(cat $2)
	do
		echo $i : `dig @$1 $i +norecurse | grep ANSWER | head -1 | awk -F , '{print $2}'`
	done
}

function xplain()
{
	case $1 in
		z)
			less xplain/zone_transfer.txt
		;;
		fb)
			less xplain/forward_lookup_bruteforce.txt
		;;
		rb)
			less xplain/reverse_lookup_bruteforce.txt
		;;
		cs)
			less xplain/cache_snooping.txt
		;;
		*)
			less xplain/thanks.txt
		;;
	esac
}

if [ $# -lt 1 ]
then
	echo "Use --help to see options"
	exit
fi


if [ $1 == --help ]
then
	echo "------------------- USAGE ------------------"
	echo "-z    : Attempt Zone Transfer"
	echo "	Syntax: ./dns.sh -z [Nameserver] [Domain Name]"
	echo "-fb   : Forward Lookup Bruteforce"
	echo "	Syntax: ./dns.sh [Domain Name]"
	echo "	Syntax: ./dns.sh [Domain Name] [Wordlist]"
	echo "-rb   : Reverse Lookup Bruteforce"
	echo "	Syntax: ./dns.sh [Domain Name]"
	echo "-cs   : Perform DNS Cache Snooping"
	echo "	Syntax: ./dns.sh [Name Server] [Wordlist]"
	echo "-x    : Explain A Particular Option"
	echo "	Syntax: ./dns.sh -x [Option_Name]"
	echo "------------------------------------------------"
	exit
fi


# Case statements
case $1 in

	# Zone Transfer
	-z)
	if [ $# -ne 3 ]
	then
		echo "Syntax Error !"
		exit
	fi
	# Calling the function
	banner "Zone Transfer"
	zone_transfer $2 $3
	;;

	# Forward Lookup Bruteforce
	-fb)
	if [ $# -lt 2 ]
	then
		echo "Syntax Error !"
	elif [ $# -eq 2 ]
	then
		# Calling the function
		banner "Forward Lookup Bruteforce" "list.txt"
		forward_lookup_bruteforce $2
	elif [ $# -eq 3 ]
	then
		# Calling the function
		banner "Forward Lookup Bruteforce" $3
		forward_lookup_bruteforce $2 $3
	else
		echo "Use f***1g --help"
	fi
	;;

        # Reverse Lookup Bruteforce
	-rb)
	if [ $# -ne 2 ]
	then
		echo "Syntax Error !"
		exit
	fi
	# Calling the function
	banner "Reverse Lookup Bruteforce"
	reverse_lookup_bruteforce $2
	;;

	# DNS Cache Snooping
	-cs)
	if [ $# -ne 3 ]
	then
		echo "Syntax Error !"
		exit
	fi
	# Calling the function
	banner "DNS Cache Snooping" $3
	cache_snooping $2 $3
	;;

	# Explain Options
	-x)
	if [ $# -ne 2 ]
	then
		echo "What to explain !!!"
		exit
	fi
	# Calling the function
	xplain $2
	;;

	# If i don't understand something
	*)
	echo "Invalid option or argument !!"
	;;
esac

