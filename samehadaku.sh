#!/usr/bin/env bash
#Samehadaku Link Grabber
#Code by: @laztname <- find me on telegram :3
#Remove a credit doesn't make you look like coder --Nayeon xD

clear
echo "Clearing cache (delete *.tmp)"
sleep 0.5
rm *.tmp
echo 1 > thispage.tmp

getsearch() {
  if [ ! -e search.tmp ]
    then
    read -p "Your Keyword : " cari
  else
    printf ""
  fi
echo $cari > search.tmp
echo "Searching for $cari"
wget -q -nv --header="Accept: text/html" -U "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:61.0) Gecko/20100101 Firefox/61.0" "https://samehadaku.tv/page/$(cat thispage.tmp)/?s=$(cat search.tmp)" -O page-$(cat thispage.tmp).tmp
gettitlelink
}

getpage() {
echo "Get Page $(cat thispage.tmp)"
wget -q -nv --header="Accept: text/html" -U "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:61.0) Gecko/20100101 Firefox/61.0" https://samehadaku.tv/page/$(cat thispage.tmp) -O page-$(cat thispage.tmp).tmp
gettitlelink
}

gettitlelink() {
cat page-$(cat thispage.tmp).tmp | grep -E "<h3 class=\"post-title\">.*</h3>" | grep -o "\"[^\"]*\"" | grep -o "[^\"]*" | grep -vwE "post-title" >> list.tmp
separate
}

separate() {
echo "Separating"
cat list.tmp | grep -e '[A-Z]' | grep Sub > listjudul.tmp
cat list.tmp | grep -e '^[a-z]' | grep sub > listurl.tmp
rm list.tmp
sleep 0.5
listtitle
}

listtitle() {
clear
banner
echo "You're on page $(cat thispage.tmp)"
cat listjudul.tmp | grep -n "Episode"
selectitem
}

selectitem() {
read -p "Select number or [n]ext page [p]revious page [b]ack to main menu : " judul
  if [ $judul == "n" ]
    then 
    clear
    banner
    echo $(expr $(cat thispage.tmp) + 1) > thispage.tmp
    rm listjudul.tmp listurl.tmp
      if [ -e page-$(cat thispage.tmp).tmp ]
        then
          gettitlelink
        else
        if [ ! -e search.tmp ]
          then
          getpage
        else
          getsearch
        fi
      fi
    gettitlelink
  elif [ $judul == "p" ]
    then
    clear
    banner
    echo $(expr $(cat thispage.tmp) - 1) > thispage.tmp
    rm listjudul.tmp listurl.tmp
    gettitlelink
  elif [ $judul == "b" ]
    then
    echo 1  > thispage.tmp
    rm listurl.tmp listjudul.tmp search.tmp page-*.tmp
    utama
  else
    clear
    banner
    awk -v i=$judul 'NR==i {print $1}' listurl.tmp > get.tmp
    echo "Get Selected Item"
    wget -q -nv --header="Accept: text/html" -U "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:61.0) Gecko/20100101 Firefox/61.0" $(cat get.tmp) -O download.tmp
    cat download.tmp | grep -o "\"[^\"]*\"" | grep -o "[^\"]*" | grep -e tetew -e siotong -e coeg > njir.tmp
    rm download.tmp
    checklist
  fi
}

checklist() {
  if [ $(wc -l njir.tmp | awk '{ print $1 }') == 86 ]
    then
    listdelnam
  elif [ $(wc -l njir.tmp | awk '{ print $1 }') == 82 ]
    then
    listpandua
  elif [ $(wc -l njir.tmp | awk '{ print $1 }') == 80 ]
    then
    # exit
    listpanpul
  elif [ $(wc -l njir.tmp | awk '{ print $1 }') == 78 ]
    then
    listtupan
  elif [ $(wc -l njir.tmp | awk '{ print $1 }') == 68 ]
    then
    listnampan
  elif [ $(wc -l njir.tmp | awk '{ print $1 }') == 66 ]
    then
    listnamnam
  elif [ $(wc -l njir.tmp | awk '{ print $1 }') == 60 ]
    then
    listnampul
  else
    echo "Incomplete link list from samehadaku.tv"
    echo "It seems you should get a link manually, here is the link"
    cat get.tmp
    echo "I'm Sorry... Exiting......"
    tmp
    exit 2
  fi
}

getquality1() {
read -p "Select Quality : " quality
  if [ $quality == "1" ]
    then
    echo $(expr $(cat select.tmp) + 0) > select.tmp
  elif [ $quality == "2" ]
    then
    echo $(expr $(cat select.tmp) + 6) > select.tmp
  elif [ $quality == "3" ]
    then
    echo $(expr $(cat select.tmp) + 12) > select.tmp
  elif [ $quality == "4" ]
    then
    echo $(expr $(cat select.tmp) + 18) > select.tmp
  else
    echo "Invalid input"
    tmp
    exit 2
  fi
}

getquality2() {
read -p "Select Quality : " quality
  if [ $quality == "1" ]
    then
    echo $(expr $(cat select.tmp) + 0) > select.tmp
  elif [ $quality == "2" ]
    then
    echo $(expr $(cat select.tmp) + 7) > select.tmp
  elif [ $quality == "3" ]
    then
    echo $(expr $(cat select.tmp) + 14) > select.tmp
  elif [ $quality == "4" ]
    then
    echo $(expr $(cat select.tmp) + 21) > select.tmp
  else
    echo "Invalid input"
    tmp
    exit 2
  fi
}

gethost() {
read -p "Select Hosting : " host
  if [ $host == "1" ]
    then
    echo $(expr $(cat select.tmp) + 0) > select.tmp
  elif [ $host == "2" ]
    then
    echo $(expr $(cat select.tmp) + 1) > select.tmp
  elif [ $host == "3" ]
    then
    echo $(expr $(cat select.tmp) + 2) > select.tmp
  elif [ $host == "4" ]
    then
    echo $(expr $(cat select.tmp) + 3) > select.tmp
  elif [ $host == "5" ]
    then
    echo $(expr $(cat select.tmp) + 4) > select.tmp
  elif [ $host == "6" ]
    then
    echo $(expr $(cat select.tmp) + 5) > select.tmp
  else
    echo $(expr $(cat select.tmp) + 6) > select.tmp
  fi
}

listpanpul() {
start=1
echo "[1]MKV [2]MP4 [3]x265 [4]3GP"
read -p "Select File Type : " file
  if [ $file == "1" ]
    then
    echo $(expr $start + 0) > select.tmp
    echo "[1]360p [2]480p [3]720p [4]1080p"
    getquality2
      if [[ $(cat select.tmp) -lt 8 ]]
        then
        echo "[1]UF [2]CU [3]ZS1 [4]GD [5]ZS2 [6]RC [7]MU"
      else
        echo "[1]UF [2]CU [3]GD [4]ZS [5]RC [6]MU"
      fi
        if [[ $quality == 3 ]]; then
          expr $(cat select.tmp) - 1 > select.tmp
        fi
    gethost
  elif [ $file == "2" ]
    then
    echo $(expr $start + 25) > select.tmp
    echo "[1]360p [2]480p [3]MP4HD [4]FullHD"
    getquality2
      if [[ $(cat select.tmp) -lt 32 ]]
        then
        echo "[1]UF [2]CU [3]ZS1 [4]GD [5]ZS2 [6]SC [7]MU"  
      else
        echo "[1]UF [2]CU [3]GD [4]ZS [5]SC [6]MU"
        if [[ $quality == 3 ]]; then
          expr $(cat select.tmp) - 1 > select.tmp
        fi
      fi
    gethost
  elif [ $file == "3" ]
    then
    echo $(expr $start + 44) > select.tmp
    echo "[1]480p [2]720p [3]1080p"
    getquality1
    echo "[1]UF [2]CU [3]GD [4]ZS [5]SC [6]MU"
    gethost
  else
    echo $(expr $start + 32) > select.tmp
    echo "[1]MP4 [2]3GP"
    getquality1
    echo "[1]UF [2]CU [3]GD [4]ZS [5]SC [6]MU"
    gethost
  fi
getlink
}

listnamnam() {
start=1
echo "[1]MKV [2]MP4 [3]x265"
read -p "Select File Type : " file
  if [ $file == "1" ]
    then
    echo $(expr $start + 0) > select.tmp
    echo "[1]360p [2]480p [3]720p [4]1080p"
    getquality1
    echo "[1]UF [2]CU [3]GD [4]ZS [5]RC [6]MU"
    gethost
  elif [ $file == "2" ]
    then
    echo $(expr $start + 24) > select.tmp
    echo "[1]360p [2]480p [3]MP4HD [4]FullHD"
    getquality1
    echo "[1]UF [2]CU [3]GD [4]ZS [5]RC [6]MU"
    gethost
  else
    echo $(expr $start + 48) > select.tmp
    echo "[1]480p [2]720p [3]1080p"
    getquality1
    echo "[1]UF [2]CU [3]GD [4]ZS [5]RC [6]MU"
    gethost
  fi
getlink
}

listnampan() {
start=1
echo "[1]MKV [2]MP4 [3]3GP"
read -p "Select File Type : " file
  if [ $file == "1" ]
    then
    echo $(expr $start + 0) > select.tmp
    echo "[1]360p [2]480p [3]720p [4]1080p"
    getquality2
    echo "[1]UF [2]CU [3]ZS1 [4]GD [5]ZS2 [6]SC [7]MU"
    gethost
  elif [ $file == "2" ]
    then
    echo $(expr $start + 28) > select.tmp
    echo "[1]360p [2]480p [3]MP4HD [4]FullHD"
    getquality2
    echo "[1]UF [2]CU [3]ZS1 [4]GD [5]ZS2 [6]SC [7]MU"
    gethost
  else
    echo $(expr $start + 56) > select.tmp
    echo "[1]MP4 [2]3GP"
    getquality1
    echo "[1]UF [2]CU [3]GD [4]ZS [5]SC [6]MU"
    gethost
  fi
getlink
}

listnampul() {
start=1
echo "[1]MKV [2]MP4 [3]3GP"
read -p "Select File Type : " file
  if [ $file == "1" ]
    then
    echo $(expr $start + 0) > select.tmp  
    echo "[1]360p [2]480p [3]720p [4]1080p"
    getquality1   
    echo "[1]UF [2]CU [3]GD [4]ZS [5]SC [6]MU"
    gethost 
  elif [ $file == "2" ]
    then
    echo $(expr $start + 24) > select.tmp
    echo "[1] 360p [2]480p [3]MP4HD [4]FullHD"
    getquality1
    echo "[1]UF [2]CU [3]GD [4]ZS [5]SC [6]MU"
    gethost 
  else
    echo $(expr $start + 48) > select.tmp
    echo "[1]MP4 [2]3GP"
    getquality1
    echo "[1]UF [2]CU [3]GD [4]ZS [5]SC [6]MU"
    gethost     
  fi
getlink
}

listtupan() {
start=1
echo "[1]MKV [2]MP4 [3]x265 [4]3GP"
read -p "Select File Type : " file
  if [ $file == "1" ]
    then
    echo $(expr $start + 0) > select.tmp  
    echo "[1]360p [2]480p [3]720p [4]1080p"
    getquality1   
    echo "[1]UF [2]CU [3]GD [4]ZS [5]SC [6]MU"
    gethost 
  elif [ $file == "2" ]
    then
    echo $(expr $start + 24) > select.tmp
    echo "[1]360p [2]480p [3]MP4HD [4]FullHD"
    getquality1
    echo "[1]UF [2]CU [3]GD [4]ZS [5]SC [6]MU"
    gethost
  elif [ $file == "3" ]
    then
    echo $(expr $start + 48) > select.tmp
    echo "[1]480p [2]720p [3]1080p"
    getquality1
    echo "[1]UF [2]CU [3]GD [4]ZS [5]SC [6]MU"
    gethost
  else
    echo $(expr $start + 66) > select.tmp
    echo "[1]MP4 [2]3GP"
    getquality1
    echo "[1]UF [2]CU [3]GD [4]ZS [5]SC [6]MU"
    gethost     
  fi
getlink
}

listdelnam() {
start=1
echo "[1]MKV [2]MP4 [3]x265 [4]3GP"
read -p "Select File Type : " file
  if [ $file == "1" ]
    then
    echo $(expr $start + 0) > select.tmp
    echo "[1]360p [2]480p [3]720p [4]1080p"
    getquality2
    echo "[1]UF [2]CU [3]ZS1 [4]GD [5]ZS2 [6]SC [7]MU"
    gethost
  elif [ $file == "2" ]
    then
    echo $(expr $start + 28) > select.tmp
    echo "[1]360p [2]480p [3]MP4HD [4]FullHD"
    getquality2
    echo "[1]UF [2]CU [3]ZS1 [4]GD [5]ZS2 [6]SC [7]MU"
    gethost
  elif [ $file == "3" ]
    then
    echo $(expr $start + 56) > select.tmp
    echo "[1]480p [2]720p [3]1080p"
    getquality1
    echo "[1]UF [2]CU [3]GD [4]ZS [5]SC [6]MU"
    gethost
  else
    echo $(expr $start + 74) > select.tmp
    echo "[1]MP4 [2]3GP"
    getquality1
    echo "[1]UF [2]CU [3]GD [4]ZS [5]SC [6]MU"
    gethost
  fi
getlink
}

listpandua() {
start=1
echo "[1]MKV [2]MP4 [3]x265 [4]3GP"
read -p "Select File Type : " file
  if [ $file == "1" ]
    then
    echo $(expr $start + 0) > select.tmp
    echo "[1]360p [2]480p [3]720p [4]1080p"
    getquality2
      if [[ $(cat select.tmp) -lt 14 ]]
        then
        echo "[1]UF [2]CU [3]ZS1 [4]GD [5]ZS2 [6]SC [7]MU"  
      else
        echo "[1]UF [2]CU [3]GD [4]ZS [5]SC [6]MU"
      fi
        if [[ $quality == 4 ]]; then
          expr $(cat select.tmp) - 1 > select.tmp
        fi
    gethost
  elif [ $file == "2" ]
    then
    echo $(expr $start + 26) > select.tmp
    echo "[1]360p [2]480p [3]MP4HD [4]FullHD"
    getquality2
      if [[ $(cat select.tmp) -lt 40 ]]
        then
        echo "[1]UF [2]CU [3]ZS1 [4]GD [5]ZS2 [6]SC [7]MU"  
      else
        echo "[1]UF [2]CU [3]GD [4]ZS [5]SC [6]MU"
      fi
        if [[ $quality == 4 ]]; then
          expr $(cat select.tmp) - 1 > select.tmp
        fi
    gethost
  elif [ $file == "3" ]
    then
    echo $(expr $start + 52) > select.tmp
    echo "[1]480p [2]720p [3]1080p"
    getquality1
    echo "[1]UF [2]CU [3]GD [4]ZS [5]SC [6]MU"
    gethost
  else
    echo $(expr $start + 70) > select.tmp
    echo "[1]MP4 [2]3GP"
    getquality1
    echo "[1]UF [2]CU [3]GD [4]ZS [5]SC [6]MU"
    gethost
  fi
getlink
}

getlink() {
clear
banner
awk -v i=$(cat select.tmp) 'NR==i {print $1}' njir.tmp > select.tmp
echo "Generating your link"
wget -q -nv --header="Accept: text/html" -U "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:61.0) Gecko/20100101 Firefox/61.0" $(cat select.tmp) -O tetew.tmp
cat tetew.tmp | grep -E "<div class=\"download-link\".*</div>" | grep -o "[^\"]*" | grep -o aH.* > base.tmp
wget -q -nv --header="Accept: text/html" -U "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:61.0) Gecko/20100101 Firefox/61.0" $(cat base.tmp | base64 -d) -O greget.tmp
link=$(cat greget.tmp | grep -E "<div class=\"download-link\".*</div>" | grep -o aHR.*= | grep -o "[^\"]*" | grep -o aH.* | base64 -d)
echo $link > link.tmp
if grep -q drive.google "link.tmp"; then
  printf "here is your download link $link\n"
  read -p "Google Drive detected, wanna download direct here ? [y]es [n]o : " dwnlod
  if [[ $dwnlod = "y" ]]; then
    download
    if grep -q "Quota exceeded" "$FILENAME"; then
    	rm $FILENAME && \
    	echo "Google Drive Limited (Quota Exceeded)" && \
    	echo "You can't download via Google Drive, try another hosting"
    fi
  fi
else
  printf "here is your download link $link\n" 
fi
again
}

download() {
FILEID=$(curl -s -I $(cat link.tmp) | grep -oP '(?<=location: ).*')
FILEID="$(echo $FILEID | sed -n 's#.*\https\:\/\/drive\.google\.com/file/d/\([^.]*\)\/view.*#\1#;p')"; # get file id in url xxxx/d/fileid/view
FILENAME="$(wget -q -O - "https://drive.google.com/file/d/$FILEID/view" | sed -n -e 's!.*<title>\(.*\)\ \-\ Google\ Drive</title>.*!\1!p')"; # get file name
# first wget check need confirm or not (limit)
wget -q --show-progress --save-cookies /tmp/cookies.txt --no-check-certificate "https://docs.google.com/uc?export=download&id=$FILEID" -O $FILENAME
if grep -q "Virus scan" $FILENAME ; then
  wget -q --show-progress --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(cat $FILENAME | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=$FILEID" -c -O "$FILENAME" && rm -rf /tmp/cookies.txt;
fi
echo "file $FILENAME has been downloaded"
}

again() {
read -p "[c]hange hosting or filetype or [e]xit or [m]ain menu : " again
  if [ $again == "c" ]
    then
    checklist
    getlink
    again
  elif [ $again == "e" ]
    then
    tmp
    exit 2
  elif [ $again == "m" ]
    then
    rm *.tmp
    echo "1" > thispage.tmp
    utama
  else
    tmp
    echo "Invalid input"
    echo "Exiting"
    exit 2
  fi
}

utama() {
clear
banner
echo "[1]List Index  [2]Search with keywords"
read -p "Select 1 or 2 : " utama
  if [ $utama == "1" ]
    then
    getpage
  elif [ $utama == "2" ]
    then
    getsearch
  else
    echo "wrong input. exiting"
    tmp
    exit 2
  fi
}

ctrlc() {
clear
banner
echo "Ctrl-C caught...performing clean up"
sleep 0.5
tmp
exit 2
}

tmp() {
printf "\nclearing all temporally files this action will delete *.tmp\n"
printf "Thank You\n"
rm *.tmp
sleep 0.3
}

banner() {
printf "
 _ _.._ _  _ |_  _. _| _.|      _|_  
_>(_|| | |(/_| |(_|(_|(_||<|_|o_>| |
====================================
created with love by laztname\n
"
sleep 0.5
}

trap "ctrlc" 2
utama
