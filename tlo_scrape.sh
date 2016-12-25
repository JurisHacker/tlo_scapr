curl "http://www.capitol.state.tx.us/Search/TextSearchResults.aspx?CP=1&LegSess=85R&House=True&Senate=True&TypeB=True&TypeR=False&TypeJR=True&TypeCR=False&VerInt=True&VerHCR=True&VerEng=True&VerSCR=True&VerEnr=True&DocTypeB=True&DocTypeFN=False&DocTypeBA=False&DocTypeAM=False&Srch=simple&All=&Any=cyber*+cyber+privacy+"information+security"&Exact=&Exclude=&Custom=" | grep DocViewer > `date "+%Y%m%d"`.txt


cat `date "+%Y%m%d.txt"` | awk 'BEGIN { FS = "[)<]"} ; {print $3}' > today.out

diff yesterday.out today.out > diff.txt

# Email my the diff
echo "  " > email.txt
echo `cat diff.txt` >> email.txt
echo "." >> email.txt
cat email.txt | mail -s "TLO diff" add1@domain.com add2@domain2.com


cp today.out yesterday.out
