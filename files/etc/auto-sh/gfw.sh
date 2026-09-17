#!/bin/bash

filename=$(basename "$0" .sh | tr -d '\n')
echo "当前脚本缓存: $filename"
mkdir -p /tmp/smartdns-conf/domain
mkdir -p /tmp/smartdns-conf/tmp
#中国域名列表
DOMAIN_LIST_ARR=("https://raw.githubusercontent.com/zxlhhyccc/smartdns-list-scripts/refs/heads/master/proxy-domain-list.conf")

#GITHUB代理加速
GITHUB_PROXY=("" "https://v6.gh-proxy.org/" "https://hk.gh-proxy.org/" "https://cdn.gh-proxy.org/" "https://edgeone.gh-proxy.org/" "https://ghfast.top/")


write_domain_host(){
	progress=()
	progress_i=0
    echo "" > /tmp/smartdns-conf/tmp/${filename}.txt
	for DOMAIN in ${DOMAIN_LIST_ARR[@]}; do
        ((progress_i++))
		for (( i=0; i<${#GITHUB_PROXY[@]}; i++ )); 
			do
				GITHUB=${GITHUB_PROXY[i]}
				cd /
				DOMAIN_LIST=`curl -k -s -L -m 60 "${GITHUB}${DOMAIN}"`
				ProcNumber=`echo -e "${DOMAIN_LIST}" | grep "youtube.com" | grep -v grep|wc -l`
				if [ $ProcNumber -ge 10 ]; then
					echo -e "${DOMAIN_LIST}" >> /tmp/smartdns-conf/tmp/${filename}.txt
					echo "YES---"${GITHUB}${DOMAIN}
					progress[progress_i]="YES"
					break
				else
					progress="false"
					echo "NO---"${GITHUB}${DOMAIN}
					progress[progress_i]="NO"
				fi
			done
    done
	if echo "${progress[@]}" | grep -qw "NO"; then
        echo "域名分组更新失败"
    else
        echo "域名信息更新完成"
        sed -i '/^#/d' /tmp/smartdns-conf/tmp/${filename}.txt
		#sed "s/^full://g;/^regexp:.*$/d;s/^/nameserver \//g;s/$/\/world/g" -i /tmp/smartdns-conf/tmp/${filename}.txt
		#sed -i '/nameserver \/\//d' /tmp/smartdns-conf/tmp/${filename}.txt
		sed -i '/\/\//d' /tmp/smartdns-conf/tmp/${filename}.txt
		cat /tmp/smartdns-conf/tmp/${filename}.txt > /etc/smartdns/domain-set/${filename}.conf
    fi
}

write_domain_host
