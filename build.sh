#!/bin/bash

menuItems="About News Samples"

# inputfiles
mdFiles=`find . -name '*.md'`

# bulid all files
for mdFile in $mdFiles; do

    dir=`dirname $mdFile`
    base=`basename $mdFile .md`
    html=$dir/$base.html

    echo "" > $html
    cat include/header0.inc >> $html
    # add title
    echo $base | sed "s/_/ /g" >> $html
    cat include/header1.inc >> $html

    echo "--------------------------------------------"
    echo "mdFile $mdFile"
    # build menu
    for menuItem in $menuItems; do
	isCurrentFile=`echo $menuItems | grep $base | wc -l`
	echo -n '<li' >> $html
	if [ -z $isCurrentFile ] ; then
	    echo -n '' >> $html
	else
	    echo -n ' id="selected"' >> $html
	fi
	echo -n '><a href="' >> $html
	echo -n $menuItem.html >> $html
	echo -n '">' >> $html
	echo -n $menuItem >> $html
	echo -n '</a></li>' >> $html
    done
    cat include/header2.inc >> $html
    # build header

    pandoc $mdFile -o tmp.html
    cat tmp.html >> $html
    rm tmp.html

    cat include/footer.inc >> $html

done

cp About.html index.html

