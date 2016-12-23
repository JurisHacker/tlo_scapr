curl "http://www.capitol.state.tx.us/Search/TextSearchResults.aspx?CP=1&LegSess=85R&House=True&Senate=True&TypeB=True&TypeR=False&TypeJR=True&TypeCR=False&VerInt=True&VerHCR=True&VerEng=True&VerSCR=True&VerEnr=True&DocTypeB=True&DocTypeFN=False&DocTypeBA=False&DocTypeAM=False&Srch=simple&All=&Any=cyber*+cyber&Exact=&Exclude=&Custom=" | grep DocViewer > `date "+%Y%m%d"`.txt


cat `date "+%Y%m%d.txt"` | awk 'BEGIN { FS = "[R,\)]"} ; {print $5}' > today.out

diff yesterday.out today.out 

cp today.out yesterday.out
