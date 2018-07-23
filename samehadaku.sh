#!/usr/bin/env bash
#Samehadaku Link Grabber
#Code by: @laztname <- find me on telegram :3
#Remove a credit doesn't make you look like coder --Nayeon xD

clear
echo 1 > thispage.tmp

getsearch() {
  trap "ctrlc" 2
  if [ ! -e search.tmp ]
   then
   read -p "Your Keyword : " cari
  else
   printf ""
  fi
  echo $cari > search.tmp
  echo "Searching for $cari"
  wget -q -nv --header="Accept: text/html" -U "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:61.0) Gecko/20100101 Firefox/61.0" https://samehadaku.tv/page/$(cat thispage.tmp)/?s=$(cat search.tmp) -O page-$(cat thispage.tmp).tmp
  gettitlelink
}

getpage() {
  trap "ctrlc" 2
  echo "Get Page $(cat thispage.tmp)"
  wget -q -nv --header="Accept: text/html" -U "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:61.0) Gecko/20100101 Firefox/61.0" https://samehadaku.tv/page/$(cat thispage.tmp) -O page-$(cat thispage.tmp).tmp
  gettitlelink
}

gettitlelink() {
  cat page-$(cat thispage.tmp).tmp | grep -E "<h3 class=\"post-title\">.*</h3>" | grep -o "\"[^\"]*\"" | grep -o "[^\"]*" | grep -vwE "post-title" >> list.tmp
  separate
}

separate() {
  trap "ctrlc" 2
  echo "Separating"
  cat list.tmp | grep -e '[A-Z]' >> listjudul.tmp
  cat list.tmp | grep -e '^[a-z]' >> listurl.tmp
  rm list.tmp
  sleep 0.5
  listtitle
}

listtitle() {
  trap "ctrlc" 2
  clear
  banner
  cat listjudul.tmp | grep -n "Subtitle"
  selectitem
}

selectitem() {
  trap "ctrlc" 2
  read -p "Select number or [n]ext page [p]revious page [b]ack to main menu : " judul
  if [ $judul == "n" ]
   then 
   clear
   banner
   echo $(expr $(cat thispage.tmp) + 1) > thispage.tmp
   rm listjudul.tmp listurl.tmp
    if [ ! -e search.tmp ]
     then
     getpage
    else
     getsearch
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
    rm listurl.tmp listjudul.tmp search.tmp page-*.tmp
    utama
  else
    clear
    banner
    awk -v i=$judul 'NR==i {print $1}' listurl.tmp >> get.tmp
    echo "Get Selected Item"
    wget -q -nv --header="Accept: text/html" -U "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:61.0) Gecko/20100101 Firefox/61.0" $(cat get.tmp) -O download.tmp
    rm get.tmp
    cat download.tmp | grep -o "\"[^\"]*\"" | grep -o "[^\"]*" | grep -e tetew -e siotong -e coeg > njir.tmp
    rm download.tmp
    checklist
  fi
}

checklist() {
  trap "ctrlc" 2
  if [ $(wc -l njir.tmp | awk '{ print $1 }') == 78 ]
   then
   listtuju
  elif [ $(wc -l njir.tmp | awk '{ print $1 }') == 68 ]
   then
   listlapan
  elif [ $(wc -l njir.tmp | awk '{ print $1 }') == 60 ]
   then
   listnol
  else
   tmp
   echo "Incomplete link list from samehadaku.tv"
   echo "It seems you should get a link manually"
   echo "I'm Sorry... Exiting......"
   exit 2
  fi
}
getquality1() {
  trap "ctrlc" 2
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
   else
     echo $(expr $(cat select.tmp) + 18) > select.tmp
   fi
}
getquality2() {
  trap "ctrlc" 2
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
   else
     echo $(expr $(cat select.tmp) + 21) > select.tmp
   fi
}

getqualitygp() {
  trap "ctrlc" 2
  read -p "Select Quality : " quality
   if [ $quality == "1" ]
     then
     echo $(expr $(cat select.tmp) + 0) > select.tmp
   else [ $quality == "2" ]
     echo $(expr $(cat select.tmp) + 6) > select.tmp
   fi
}

gethost1() {
  trap "ctrlc" 2
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
   else
     echo $(expr $(cat select.tmp) + 5) > select.tmp
   fi
}
gethost2() {
  trap "ctrlc" 2
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

listlapan() {
  trap "ctrlc" 2
  start=1
  echo "[1]MKV [2]MP4 [3]3GP"
  read -p "Select File Type : " file
    if [ $file == "1" ]
     then
     echo $(expr $start + 0) > select.tmp
     echo "[1]360p [2]480p [3]720p [4]1080p"
     getquality2
     echo "[1]UF [2]CU [3]ZS1 [4]GD [5]ZS2 [6]SC [7]MU"
     gethost2
    elif [ $file == "2" ]
     then
     echo $(expr $start + 28) > select.tmp
     echo "[1]360p [2]480p [3]MP4HD [4]FullHD"
     getquality
     echo "[1]UF [2]CU [3]ZS1 [4]GD [5]ZS2 [6]SC [7]MU"
     gethost1
    else
     echo $(expr $start + 56) > select.tmp
     echo "[1]MP4 [2]3GP"
     getqualitygp
     echo "[1]UF [2]CU [3]GD [4]ZS [5]SC [6]MU"
     gethost1
    fi
  awk -v i=$(cat select.tmp) 'NR==i {print $1}' njir.tmp > select.tmp
  getlink
}

listnol() {
  trap "ctrlc" 2
  start=1
  echo "[1]MKV [2]MP4 [3]3GP"
  read -p "Select File Type : " file
    if [ $file == "1" ]
     then
     echo $(expr $start + 0) > select.tmp  
     echo "[1]360p [2]480p [3]720p [4]1080p"
     getquality1   
     echo "[1]UF [2]CU [3]GD [4]ZS [5]SC [6]MU"
     gethost1 
    elif [ $file == "2" ]
     then
     echo $(expr $start + 24) > select.tmp
     echo "[1] 360p [2]480p [3]MP4HD [4]FullHD"
     getquality1
     echo "[1]UF [2]CU [3]GD [4]ZS [5]SC [6]MU"
     gethost1 
    else
     echo $(expr $start + 48) > select.tmp
     echo "[1]MP4 [2]3GP"
     getquality1
     echo "[1]UF [2]CU [3]GD [4]ZS [5]SC [6]MU"
     gethost1     
    fi
  awk -v i=$(cat select.tmp) 'NR==i {print $1}' njir.tmp > select.tmp
  getlink
}

listtuju() {
  trap "ctrlc" 2
  start=1
  echo "[1]MKV [2]MP4 [3]x265 [4]3GP"
  read -p "Select File Type : " file
    if [ $file == "1" ]
     then
     echo $(expr $start + 0) > select.tmp  
     echo "[1]360p [2]480p [3]720p [4]1080p"
     getquality1   
     echo "[1]UF [2]CU [3]GD [4]ZS [5]SC [6]MU"
     gethost1 
    elif [ $file == "2" ]
     then
     echo $(expr $start + 24) > select.tmp
     echo "[1]360p [2]480p [3]MP4HD [4]FullHD"
     getquality1
     echo "[1]UF [2]CU [3]GD [4]ZS [5]SC [6]MU"
     gethost1
    elif [ $file == "3" ]
     then
     echo $(expr $start + 48) > select.tmp
     echo "[1]480p [3]720p [4]1080p"
     getquality1
     echo "[1]UF [2]CU [3]GD [4]ZS [5]SC [6]MU"
     gethost1
    else
     echo $(expr $start + 66) > select.tmp
     echo "[1]MP4 [2]3GP"
     getquality1
     echo "[1]UF [2]CU [3]GD [4]ZS [5]SC [6]MU"
     gethost1     
    fi
  awk -v i=$(cat select.tmp) 'NR==i {print $1}' njir.tmp > select.tmp
  getlink
}

getlink() {
  trap "ctrlc" 2
  clear
  banner
  echo "Generating your link"
  wget -q -nv --header="Accept: text/html" -U "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:61.0) Gecko/20100101 Firefox/61.0" $(cat select.tmp) -O tetew.tmp
  cat tetew.tmp | grep -E "<div class=\"download-link\".*</div>" | grep -o "[^\"]*" | grep -o aH.* > base.tmp
  wget -q -nv --header="Accept: text/html" -U "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:61.0) Gecko/20100101 Firefox/61.0" $(cat base.tmp | base64 -d) -O greget.tmp
  res= echo "here is your download link" $(cat greget.tmp | grep -E "<div class=\"download-link\".*</div>" | grep -o aHR.*= | grep -o "[^\"]*" | grep -o aH.* | base64 -d)
  printf "$res\n"
  again
}

again() {
  trap "ctrlc" 2
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
  trap "ctrlc" 2
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
  clear
  banner
  printf "clearing all temporally files this action will delete *.tmp\n"
  rm *.tmp
  sleep 1
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

utama