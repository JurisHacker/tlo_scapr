#!/usr/pkg/bin/bash

cd ~/scripts/tlo/tlo_scrapr/

curl "http://www.capitol.state.tx.us/Search/TextSearchResults.aspx?CP=1&LegSess=85R&House=True&Senate=True&TypeB=True&TypeR=False&TypeJR=True&TypeCR=False&VerInt=True&VerHCR=True&VerEng=True&VerSCR=True&VerEnr=True&DocTypeB=True&DocTypeFN=False&DocTypeBA=False&DocTypeAM=False&Srch=simple&All=&Any=cyber*+cyber+privacy+"information+security"&Exact=&Exclude=&Custom=" | grep -E 'DocViewer|Author|Caption' | grep -v 'style' | sed 's/\<\/span\>//' > `date "+%Y%m%d"`.txt

cp `date "+%Y%m%d"`.txt input.txt
sed -i.bak -e 's|a href="DocViewer.aspx|a href="http://www.capitol.state.tx.us/Search/DocViewer.aspx|g' input.txt
cp input.txt today.out

diff yesterday.out today.out > diff.txt

# Email me the diff
echo "  " > email.txt
echo "<html><head><title>New Bills</title></head><body>" >> email.txt
echo `cat diff.txt` >> email.txt
echo "<//body><//html>" >> email.txt
echo "." >> email.txt
cat email.txt | mail -s"$(echo -e "TLO diff\nContent-Type: text/html")" user1@domain.com user2@domain.com


cp today.out yesterday.out
