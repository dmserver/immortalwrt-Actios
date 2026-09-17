#!/bin/bash
# 设置环境变量，确保使用UTF-8编码
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
int_gw=$1
	ping -c 1 cn.bing.com > /dev/null 2>&1
    if [ $? -eq 0 ];then
			current=`date "+%Y-%m-%d %H:%M:%S"`
    	    echo ${current}" 网络正常" 
        else
        	sleep 30s
			ping -c 1 baidu.com > /dev/null 2>&1
            if [ $? -eq 0 ];then
    	            current=`date "+%Y-%m-%d %H:%M:%S"`
					echo ${current}" 网络正常" 
                else
        	       sleep 30s
				   ping -c 1 223.5.5.5 > /dev/null 2>&1
                    if [ $? -eq 0 ];then
    	                    current=`date "+%Y-%m-%d %H:%M:%S"`
							echo ${current}" 网络正常" 
                        else
            	            sleep 30s
							ping -c 1 119.29.29.29 > /dev/null 2>&1
							if [ $? -eq 0 ];then
									current=`date "+%Y-%m-%d %H:%M:%S"`
									echo ${current}" 网络正常" 
								else
									sleep 30s
									ping -c 1 180.76.76.76 > /dev/null 2>&1
									if [ $? -eq 0 ];then
											current=`date "+%Y-%m-%d %H:%M:%S"`
											echo ${current}" 网络正常" 
										else
											sleep 30s
											ping -c 1 ${int_gw} > /dev/null 2>&1
											if [ $? -eq 0 ];then
													current=`date "+%Y-%m-%d %H:%M:%S"`
													echo ${current}" 网络正常" 
												else
													current=`date "+%Y-%m-%d %H:%M:%S"`
													echo ${current}" 网络异常，稍后重启设备" 
													sleep 30s
													reboot
											fi
									fi
							fi
                    fi
            fi
    fi