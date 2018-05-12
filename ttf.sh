: '
██████╗  █████╗ ██████╗ ███████╗ █████╗ ██████╗  █████╗ ██████╗  ██████╗ 
██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗╚════██╗██╔══██╗╚════██╗██╔═████╗
██████╔╝███████║██████╔╝███████╗███████║ █████╔╝╚█████╔╝ █████╔╝██║██╔██║
██╔═══╝ ██╔══██║██╔══██╗╚════██║██╔══██║██╔═══╝ ██╔══██╗██╔═══╝ ████╔╝██║
██║     ██║  ██║██║  ██║███████║██║  ██║███████╗╚█████╔╝███████╗╚██████╔╝
╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝ ╚════╝ ╚══════╝ ╚═════╝ 
'
IFS=$'\n'
read -p "Select program mode :
1 - Find time of the entered folder
2 - Find time of the entered folder and all subfolders
" mode
read -p "Enter directory:" dir
if [ $mode == "1" ];then
	dirlist=$dir
fi
if [ $mode == "2" ];then
	dirlist=`ls -1 -d $dir/*`
fi
realtotaldur=0
for folder in $dirlist;do
	cd $folder
	list=`ls -1`
	totaldur=0
	for file in $list;do
		filedur=`ffprobe -v quiet -show_entries format=duration -of csv="p=0" "$file" | sed 's/\..*//g'`
		totaldur=$((totaldur+filedur))
done
realtotaldur=$((realtotaldur+totaldur))
done
echo "$((realtotaldur/60)) Minutes"
