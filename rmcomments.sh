#! /usr/bin/bash

if [ ! -f "$1" ]; then
    echo "文件不存在"
    exit 1
fi

file="$1"
ext="${file##*.}"

if [ "$ext" != "docx" ]; then
    echo "请选择docx文件"
    exit 1
fi   

zipfile="tmp_only_for_modify_docx.zip"
zipdir="tmp_only_for_modify_docx"
cp $1 $zipfile && unzip "$zipfile" -d "$zipdir" && rm $zipfile

workdir="$zipdir/word"
cd $workdir
ls -lia

workfile="document.xml"
#echo "修改前: \n"
#cat "$workfile"

sed -i 's/<w:comment[^\/]*\/>//g' "$workfile"

#echo "修改后: \n"
#cat "$workfile"

cd "../"
zip -r "../$file.bak.docx" *

cd ..
rm $zipdir -rf
