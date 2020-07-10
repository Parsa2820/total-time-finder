IFS=$'\n'
dir=`zenity --file-selection --title "TTF - Choose a directory" --window-icon=icon.png --directory`
cd $dir
list=`ls -1 *.{webm,mkv,vob,mov,avi,mp4,m4v,m4p,3gp,flv,mp3,flac,m4a} 2> /dev/null`
totaldur=0
for file in $list;do
	filedur=`ffprobe -v quiet -show_entries format=duration -of csv="p=0" "$file" | sed 's/\..*//g'`
	totaldur=$((totaldur+filedur))
done
result="$((totaldur/60)) Minutes"
zenity --info --title "TTF - Result" --window-icon=icon.png --text "$result Minutes"
