export qnak=aroRRNOX0hnzrAxDv4G1I76a1Ygr18zGsg0D7kJn
export qnsk=vnFMDUjInrTPwtQPW7CfQ0WQNIrgz0l9uMFYDGtu

echo '{ 
  "src_dir": "./www", 
  "bucket": "zjy1", 
  "overwrite": true, 
  "rescan_local": true 
}' > qiniuuploadconfig.json

rm -rf ~/.qshell
qshell account ${qnak} ${qnsk}
qshell qupload 5 qiniuuploadconfig.json
# export deployUrl=`qshell domains zjy1 | head -n1`
export deployUrl=oyf8dh209.bkt.clouddn.com
rm -rf ./httpUrlList.txt
cd www && /bin/find . -maxdepth 1 -type f | sed "s/^\(\.\)\(.*$\)/http:\/\/${deployUrl}\2/" >> ../httpUrlList.txt
cd ..

cd www && /bin/find . -maxdepth 1 -type d | grep -v \"^.\$\"  | sed "s/^\(\.\)\(.*$\)/http:\/\/${deployUrl}\2\//" >> ../httpUrlList.txt
cd ..

cat ./httpUrlList.txt

qshell cdnrefresh httpUrlList.txt
echo http://${deployUrl}/index.html