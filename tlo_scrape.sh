#!/usr/pkg/bin/bash
# This is just a simple script to search bills of the 85th Texas legislative session for "cyber, cyber*, privacy, and "information security"".

# change to the working directory (since this is running as a cron job
cd ~/scripts/tlo/tlo_scrapr/

# grab the bulk info, grep for the terms we want (the link to the bill, bill number, Author, and Caption) dropping other extraneous stuff
curl "http://www.capitol.state.tx.us/Search/TextSearchResults.aspx?CP=1&LegSess=85R&House=True&Senate=True&TypeB=True&TypeR=False&TypeJR=True&TypeCR=False&VerInt=True&VerHCR=True&VerEng=True&VerSCR=True&VerEnr=True&DocTypeB=True&DocTypeFN=False&DocTypeBA=False&DocTypeAM=False&Srch=simple&All=&Any=cyber*+cyber+privacy+"information+security"&Exact=&Exclude=&Custom=" | grep -E 'DocViewer|Author|Caption' | grep -v 'style' | sed 's/\<\/span\>//' > `date "+%Y%m%d"`.txt

# Move some files around, then add the necessary prefix, so the emailed links will work
cp `date "+%Y%m%d"`.txt input.txt
sed -i.bak -e 's|a href="DocViewer.aspx|a href="http://www.capitol.state.tx.us/Search/DocViewer.aspx|g' input.txt
cp input.txt today.out

# Diff what we found yesterday with today
diff yesterday.out today.out > diff.txt

# Email me the diff
echo "  " > email.txt
echo "<html><head><title>New Bills</title></head><body>" >> email.txt # need to build out the html email
echo `cat diff.txt` >> email.txt # pump the diff into the email
echo "<//body><//html>" >> email.txt # close out the html
echo "." >> email.txt
cat email.txt | mail -s"$(echo -e "TLO diff\nContent-Type: text/html")" user1@domain.com user2@domain.com # email two users the html email

# Make the 'yesterday' file for tomorrow.
cp today.out yesterday.out
