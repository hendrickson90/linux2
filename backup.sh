#!/bin/bash
if [ $# = 0 ]
 then
  echo "Must provide an argument, use -h or --help for information"
  exit 1
fi
while [ ! $# -eq 0 ]
do
	case "$1" in
		--help | -h)
			echo "-c	option shows the number of files and directories in the backup sub directory in your home directory, and the amount of bytes they consume."
			echo " "
			echo "-l	option lists files and directories of the backup sub directory in your home directory, just like ls"
			echo " "			
			;;
		-l)
			if [ ! -d ~/backup ] ; then
				echo "backup folder missing"
			else
				echo $(ls ~/backup)
			fi
			
			;;
		-c)
			if [ ! -d ~/backup ] ; then
				echo "backup folder missing"
			else
				value_of_the_ls=$(ls -1q ~/backup | wc -l)
				echo "Number of files and directories in the backup folder: ${value_of_the_ls}"
				size_of_Dir=$(du -sh ~/backup | awk '{print $1}')
				echo "Size of backup folder: ${size_of_Dir}"
			fi
			;;
		*)


			if [ -e $1 ]
			then

				if [ ! -d ~/backup ] ; then
					echo "backup folder missing"
					if ! mkdir -p ~/backup 2>/dev/null; then
						echo "cant make back up folder check permissions and contact sys admin"
						exit
					else
						echo "backup folder created"
					fi		
				fi

				if ! cp $1 ~/backup
					then echo "could not coppy files check permissions and contact sys admin"
					exit
				else
					echo "${1} now backed up!!!"
				fi								
			else
			    echo "${1} is not a know comand or valid file"
			fi
		
			;;
	esac
	shift
done

exit
