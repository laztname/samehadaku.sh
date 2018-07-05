#!/bin/bash
#Samehadaku Link Grabber
#Code by: laztname
#Remove a credit doesn't make you look like coder --Nayeon xD
#set default page
clear
echo 1 > thispage.tmp
getpage() {
  echo "Getting Page $(cat thispage.tmp)"
  wget -q -nv --header="Accept: text/html" -U "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:61.0) Gecko/20100101 Firefox/61.0" https://samehadaku.tv/page/$(cat thispage.tmp) -O page-$(cat thispage.tmp).tmp
}

gettitlelink() {
  cat page-$(cat thispage.tmp).tmp | grep -E "<h3 class=\"post-title\">.*</h3>" | grep -o "\"[^\"]*\"" | grep -o "[^\"]*" | grep -vwE "post-title" >> list.tmp
}

separate() {
  cat list.tmp | grep -e '[A-Z]' >> listjudul.tmp
  cat list.tmp | grep -e '^[a-z]' >> listurl.tmp
  rm list.tmp
}

listtitle() {
  clear
  banner
  cat listjudul.tmp | grep -n "ndonesia"
}

selectitem() {
  read -p "Select number or [n]ext page [p]revious page : " judul
  if [ $judul == "n" ]
   then 
   clear
   banner
   echo $(expr $(cat thispage.tmp) + 1) > thispage.tmp
   rm listjudul.tmp listurl.tmp
   getpage
   gettitlelink
   separate
   listtitle
   selectitem
  elif [ $judul == "p" ]
   then
   clear
   banner
   echo $(expr $(cat thispage.tmp) - 1) > thispage.tmp
   rm listjudul.tmp listurl.tmp
   gettitlelink
   separate
   listtitle
   selectitem
  else
    clear
    banner
    awk -v i=$judul 'NR==i {print $1}' listurl.tmp >> get.tmp
    echo "Getting Selected Item"
    wget -q -nv --header="Accept: text/html" -U "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:61.0) Gecko/20100101 Firefox/61.0" $(cat get.tmp) -O download.tmp
    echo "Listing link"
    rm get.tmp
    cat download.tmp | grep -o "\"[^\"]*\"" | grep -o "[^\"]*" | grep tetew.info > njir.tmp
    rm download.tmp
  fi
}

selectuser() {
  start=1
  echo "[1] MKV [2] MP4 [3]3GP"
  read -p "Select File Type : " file
    if [ $file == "1" ]
     then
     echo $(expr $start + 0) > select.tmp
    elif [ $file == "2" ]
     then
     echo $(expr $start + 24) > select.tmp
    else
     echo $(expr $start + 48) > select.tmp
    fi

  echo "[1] 360p [2] 480p [3]720p [4]1080p"
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

  echo "[1]UF [2]CU [3]GD [4]ZS [5]SC [6]MU"
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
  awk -v i=$(cat select.tmp) 'NR==i {print $1}' njir.tmp > select.tmp
}

getlink() {
  wget -q -nv --header="Accept: text/html" -U "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:61.0) Gecko/20100101 Firefox/61.0" $(cat select.tmp) -O tetew.tmp
  cat tetew.tmp | grep -E "<div class=\"download-link\".*</div>" | grep -o "[^\"]*" | grep -o aH.* > base.tmp
  wget -q -nv --header="Accept: text/html" -U "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:61.0) Gecko/20100101 Firefox/61.0" $(cat base.tmp | base64 -d) -O greget.tmp
  clear
  banner
  res= echo "here is your download link" $(cat greget.tmp | grep -E "<div class=\"download-link\".*</div>" | grep -o aHR.*= | grep -o "[^\"]*" | grep -o aH.* | base64 -d)
  printf "$res\n"
  #rm select.tmp
}

again() {
  read -p "[c]hange hosting [e]xit : " again
  if [ $again == "c" ]
   then
   selectuser
   getlink
   again
  else
   tmp
  fi
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

banner
getpage
gettitlelink
separate
listtitle
selectitem
selectuser
getlink
again