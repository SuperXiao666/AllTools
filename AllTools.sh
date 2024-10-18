#!/bin/bash
# shellcheck disable=SC2162
# shellcheck disable=SC2161
# shellcheck disable=SC2002
# shellcheck disable=SC2053
# shellcheck disable=SC2046
#Copyright Xiao
#Author GuanChunXiao
#Version 1.0
#Date 2024
LANG=en_US.UTF-8
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
#plain='\033[0m'
function TcFlow()
{
	while true
	do
		echo -e "$yellow===========Copyright==========---强烈建议使用管理员权限使用---============Xiao================="
		echo -e "$yellow============Date===========||||||接口流量检测脚本||||||=================2024=================="
		echo
		echo -e "$red	  	  请输入$green【0】退出程序【1】显示所有接口【2】iftop监控
			【3】ifstat监控【4】nethogs监控【5】nload监控
			【6】iptraf-ng【7】安装iftop|ifstat|nethogs|nload|iptraf-ng
				
			$yellow【8】|||||||||=====进入限速模块=====|||||||||"
		echo
		echo -e "$green======================================Version1.0==============================================" 
		echo
		read -t 360 -p '请输入数字【0】【1】【2】【3】【4】【5】【6】【7】【8】进行选择：' num
		echo
		case $num in
		"2")
			echo '使用iftop命令查看'
			read -t 240 -p '请输入你的接口名称：' ethx
			echo
			iftop -i "$ethx" -P -B -n
		;;
		"3")
			echo '使用ifstat命令查看'
			read -t 240 -p '请输入你的接口名称：' ethx
			echo
			ifstat -i "$ethx" || ifstat "$ethx"
		;;
		"4")
			echo '使用nethogs命令'
			nethogs
			echo
		;;
		"5")
			echo '使用nload命令查看'
			read -t 240 -p '请输入你的接口名称：' ethx
			echo
			nload Devices "$ethx"
			echo
		;;
		"6")
			echo '使用iptraf-ng命令查看'
			echo
			read -t 360 -p '【1】查看接口流量【2】查看各端口流量：' choose1
			echo
			if [ "$choose1" -eq 1 ]
			then
				read -t 240 -p '请输入你的接口名称：' ethx
				echo
				iptraf-ng -i "$ethx"
			elif [ "$choose1" -eq 2 ]
			then
				read -t 240 -p '请输入你的接口名称：' ethx
				echo
				iptraf-ng -s "$ethx"
			else
				echo '你的输入有误！请输入1 or 2'
				echo
			fi
			echo
		;;
		"1")
			echo '=============IP接口显示=============='
			echo
			ip a | cut -d " " -f 1,2 | more
			echo
		;;
		"0")
			echo '欢迎下次使用！'
			echo
			break
		;;
		"7")
			echo '安装iftop......'
			sudo yum install iftop -y || sudo apt-get install iftop -y
			echo
			echo 'iftop安装成功！'
			echo
			echo '开始安装ifstat......'
			echo
			sudo yum install iftop -y ||  sudo apt-get install ifstat -y
			echo
			echo 'ifstat安装成功！'
			echo
			echo '开始安装nethogs......'
			echo
			sudo yum install nethogs -y || sudo apt-get install nethogs -y
			echo
			echo 'nethogs安装成功！'
			echo
			echo '开始安装nload......'
			echo
			sudo yum install nload -y ||  sudo apt-get install nload -y
			echo
			echo 'nload安装成功！'
			echo
			echo '开始安装iptraf-ng......'
			echo
			sudo yum install iptraf-ng -y || sudo apt-get install iptraf-ng -y
			echo
			echo 'iptraf-ng安装成功！'
			echo
		;;
		"8")
			while true
			do
				echo -e "$yellow============================================TC接口限速=============================================="
				echo
				echo -e "$green				【0】退出限速程序【1】查看现有的队列
				【2】查看现有的分类【3】清除原有的规则
				【4】安装限速工具使用【5】查看简洁限速队列
				【6】查看限速服务状态【7】重启限速服务进程
				 ========||||【8】进行限速模块=||||========
				 ======||||【9】限速配置查看修改=||||======
				 ======||||【10】查看服务配置文件=|||======
				 ======||||【11】停止限速服务进程=|||======
				 ======||||【12】启动限速服务进程=|||======
				 ======||||【13】检查限速服务文件=|||======
				 ======||||【14】修改进程服务文件=|||======"
				echo
				echo '===================================================================================================='
				echo
				read -p '请输入你的选择【0】【1】【2】【3】【4】【5】【6】【7】【8】【9】【10~14】：' choose2
				echo
				case $choose2 in
				"0")
				echo '欢迎你下次使用限速板块！'
				echo
				break
				;;
				"1")
					read -p '请输入你要查看的网卡(如ethxxx)：' ethXX
					echo
					echo '=================================================================================='
					tc -s qdisc ls dev "$ethXX"
					echo
					echo '=================================================================================='
					echo
				;;
				"2")
					read -p '请输入你要查看的网卡(如ethxxx)：' ethXX
					echo
					echo '=================================================================================='
					tc -s class ls dev "$ethXX"
					echo
					echo '=================================================================================='
					echo
				;;
				"3")
					read -p '请输入你要清除的网卡(如ethxxx)：' ethXX
					echo
					echo '=================================================================================='
					cd /root/wondershaper/ || exit
					./wondershaper -c -a "$ethXX"
					echo
					echo 'wondershaper规则清理完成!!!'
					echo
					tc qdisc del dev "$ethXX" root
					echo
					echo 'TC队列规则清理完成!!!'
					echo
					echo '=================================================================================='
					echo
				;;
				"8")
					read -p '请输入你要限速的网卡接口：' ethXXX
					echo
					read -p '请输入你要限制的上行带宽(1024=1M、10240=10M)输入如1024：' uploads
					echo
					read -p '请输入你要限制的下行带宽(1024=1M、10240=10M)输入如1024：' downloads
					echo
					cd /root/wondershaper/ || exit
					./wondershaper -a "$ethXXX" -u "$uploads" -d "$downloads"
					echo
					echo '限速success!!!'
					echo
					echo '是否查看限速规则'
					echo
					read -p '请输入yes or no：' starts
					echo
					if [[ $starts == yes || $starts == y ]]
					then
						read -p '请输入你要查看的接口：' ethXXXX
						echo
						cd /root/wondershaper/ || exit
						./wondershaper -s -a "$ethXXXX"
						echo
					fi
					echo '是否启动wondershaper服务'
					echo
					read -p '请输入yes or no：' service1
					echo
					if [[ $service1 == yes || $service1 == y ]]
					then
						echo '开始启动服务......'
						sudo systemctl start wondershaper.service || sudo service wondershaper start
						echo '启动服务success！！！'
						echo
						sleep 3
						echo '开始清除服务缓存......'
						sudo systemctl daemon-reload || sudo service damon-reload reload
						echo '服务缓存清理success！！！'
						echo
					fi
				;;
				"5")
					echo '========================================================================================'
					echo
					read -p '请输入你的网卡接口：' ethX
					echo
					tc class ls dev "$ethX"
					echo
					echo '========================================================================================'
				;;
				"6")
					echo -e "$yellow=============================active正常================================================="
					sudo systemctl status wondershaper
					echo -e "$yellow========================================================================================"
				;;
				"7")
					echo -e "$$yellow===================================重启服务==============================================="
					systemctl daemon-reload
					sudo systemctl restart wondershaper || service wondershaper restart
					echo '服务重启success！！！'
					echo 
					echo -e "$yellow===================================重启服务==============================================="
				;;
				"4")
					echo -e "$yellow===================================安装服务================================================"
                    echo
					echo '正在安装wondershaper tools......'
					echo
					sudo yum install git -y || sudo apt-get install git -y
					sleep 3
					cd /root/ || exit
					echo
					echo '下载wondershaper源码'
					git clone https://github.com/magnific0/wondershaper.git
					sleep 3
					echo
					echo '下载success!!!'
					echo
					cd /root/wondershaper/ || exit
					sleep 3
					echo '查看当前位置'
					pwd
					sleep 3
					echo 'start make......'
					echo
					cd /root/wondershaper/ || exit
					sleep 2
					sudo make install
					echo
					echo 'make success！！！'
					echo
					cp -r  /usr/local/sbin/wondershaper  /usr/sbin/wondershaper
					cp -r  /usr/sbin/wondershaper /usr/local/sbin/wondershaper
					echo '开始设置开机自启动'
					sudo systemctl enable --now wondershaper.service
					echo
					echo '设置成功！！！'
					echo
					echo -e "$yellow=========================================================================================="
				;;
				"9")
					echo -e "$yellow=======================================查看限速文件========================================="
					echo '||||||||||查看限速接口||||||||||'
					cat /etc/systemd/wondershaper.conf | grep IFACE
					echo '||||||||||查看上行速度||||||||||'
					cat /etc/systemd/wondershaper.conf | grep USPEED
					echo '||||||||||查看下行速度||||||||||'
					cat /etc/systemd/wondershaper.conf | grep DSPEED
					echo -e "$yellow=========================================================================================="
					echo
					echo '是否修改配置文件?'
					read -p '请输入yes or y进入修改页面：' files
					echo
					if [[ $files == yes || $files == y ]]
					then
						vim /etc/systemd/wondershaper.conf
						echo
						echo '修改完成！！！'
						echo
					fi
				;;
				"10")
					echo -e "$yellow================================service配置文件==========================================="
					cat /usr/local/lib/systemd/system/wondershaper.service
					echo
					echo -e "$yellow================================service配置文件==========================================="
				;;
				"11")
					echo -e "$yellow===================================停止限速服务==========================================="
					systemctl daemon-reload
					sudo systemctl stop wondershaper || service wondershaper stop
					echo
					echo '停止限速服务success！！！'
					echo
					echo -e "$yellow===================================停止限速服务==========================================="
				;;
				"12")
					echo -e "$yellow===================================启动限速服务==========================================="
					systemctl daemon-reload
					sudo systemctl start wondershaper || service wondershaper start
					echo
					echo '启动限速服务success！！！'
					echo
					echo -e "$yellow===================================启动限速服务==========================================="
				;;
				"13")
					echo -e "$yellow===================================检查限速文件==========================================="
					echo
					if [ -f /usr/local/sbin/wondershaper ];then echo '程序文件存在';else echo '程序文件不存在！';fi
					echo
					echo
					if [ -f /usr/local/lib/systemd/system/wondershaper.service ];then echo '服务文件存在';else echo '服务文件不存在！';fi
					echo
					echo
					if [ -f /etc/systemd/wondershaper.conf ];then echo '配置文件存在';else echo '配置文件不存在！';fi
					echo
					echo -e "$yellow===================================检查限速文件==========================================="
				;;
				"14")
					echo -e "$yellow===================================修改进程服务文件==========================================="
					echo
					if [ -f /usr/local/lib/systemd/system/wondershaper.service ];then echo '服务文件存在';else echo '服务文件不存在！';fi
					echo
					read -p '请输入yes or y进行修改：' choose3
					echo
					if [[ $choose3 == yes || $choose3 == y ]]
					then
						echo
						echo '进入修改页面'
						echo
						vi /usr/local/lib/systemd/system/wondershaper.service
						echo
						echo '修改完成！！！'
						echo
					fi
					echo -e "$yellow===================================修改进程服务文件==========================================="
				;;
				*)
				echo -e "$red你的输入有误！请重新输入0、1、2、3、4、5、6、7、8、9、10、11、12、13、14"
				echo
				;;
				esac
			done
		;;
		*)
			echo -e "$red你的输入有误！请重新输入0、1、2、3、4、5、6、7、8"
			echo
		;;
		esac
	done
}
function VirtualTunnel()
{
    while [ 1 ]
    do
        echo -e "$yellow========================欢迎进入PPTP and L2TP自动化安装脚本==========================="
        echo
        echo -e "$red请输入：0、1、2、3、4、5、6、7、8、9、10、11、12、13、14、15、16、17、18、19、20"
        echo
        echo -e "$green【1】检查主机是否支持PPTP or L2TP,是否开启TUN 【2】安装PPTP and L2TP服务"
        echo -e "$green【3】进入L2TP配置板块    【4】进入PPTP配置板块"
        echo -e "$green【5】添加新用户          【6】查看PPTP/L2TP状态"
        echo -e "$green【7】查看所有用户        【8】查看接口信息"
        echo
        echo -e "$green【9】查看路由    【10】ping IP   【11】traceroute IP"
        echo
        echo -e "$green【12】关闭/打开L2TP服务   【13】关闭/打开PPTP服务  【14】查看防火墙状态"
        echo
        echo -e "$green【15】重载L2TP服务   【16】重载PPTP服务  【17】重载L2TP+PPTP服务"
        echo
        echo -e "$green【18】重启L2TP服务   【19】重启PPTP服务  【20】重启L2TP+PPTP服务"
        echo
        echo -e "$green【21】查看L2TP-Server详细日志信息   【22】查看PPTP-Server详细日志信息"
        echo
        echo -e "$green【23】|||Ubunut--开启L2TP(UDP/1701)和PPTP端口(TCP/1723)--Ubunut|||"
        echo
        echo -e "$red=============================||||||【0】退出程序||||||==============================="
        echo
        echo -e "$yellow===================================================================================="
        echo
        read -p '请输入你的选择【0】【1】【2】【3】【4】【5】【6】【7】【8】【9】【10~20】：' choose1
        echo
        echo "你的选择是$choose1"
        echo
        if [ "$choose1" -eq 1 ]
        then
            modprobe ppp-compress-18 && echo yes
            echo
            cat /dev/net/tun
            echo
            cat /dev/ppp
            echo
        elif [ "$choose1" -eq 2 ]
        then
            echo
            echo '正在安装L2TP中......'
            yum install -y epel-release || yum apt install -y epel-release
            yum install -y xl2tpd libreswan lsof || apt install -y xl2tpd libreswan lsof
            echo
            echo 'L2TP安装success'
            echo
            echo '正在安装PPTP中......'
            yum install -y ppp pptpd net-tools || apt install -y ppp pptpd net-tools
            yum install -y epel-release || apt install -y epel-release
            echo
            echo 'PPTP安装success'
            echo
            echo '全部安装完成！！！'
        elif [ "$choose1" -eq 3 ]
        then
            echo -e "$yellow===============================欢迎进入L2TP配置板块======================================================"
            echo
            echo -e "$green使用说明：1.请设置你要分配的IP地址池(如local ip range = 192.168.1.128-192.168.1.254)"
            echo -e "$green使用说明：2.请设置你的本地IP(如local ip 192.168.1.130)："
            echo -e "$green使用说明：3.请设置你的监听端口(如port = 1701)："
            echo -e "$green使用说明：4.请设置你的握手认证协议(如require chap = yes、refuse pap = yes、require authentication = yes)："
            echo -e "$green使用说明：5.请设置你的VPN名称(如name = L2TPVPN)："
            echo -e "$green使用说明：6.请打开你的debug方便排错(如ppp debug = yes)："
            echo -e "$green使用说明：7.请配置L2TP服务端认证文件地址(如pppoptfile = /etc/ppp/options.xl2tpd)："
            echo -e "$green使用说明：8.请开启你的VPN名称(如length bit = yes)："
            echo
            echo -e "$yellow======================================================================================================="
            echo
            echo '开始配置L2TP地址池和本地IP中......'
            echo
            read -p '是否进入配置界面,请输入yes or y(n不配置)：' set1
            echo
            if [[ $set1 == yes || $set1 == y ]];then vi /etc/xl2tpd/xl2tpd.conf || vim /etc/xl2tpd/xl2tpd.conf;fi
            echo
            echo 'L2TP地址池和本地IP设置成功!!!'
            echo
            echo
            echo -e "$green使用说明：1.请设置你要分配的DNS(如ms-dns 8.8.8.8)"
            echo -e "$green使用说明：2.请设置你的MTU and MRU(如MTU 1410 MRU 1410)也可以不设默认："
            echo -e "$green使用说明：3.请设置你的握手认证和授权方式"
            echo -e "$green           require-pap"
            echo -e "$green           refuse-chap"
            echo -e "$green           refuse-mschap"
            echo -e "$green           refuse-mschap-v2"
            echo -e "$green           persist"
            echo -e "$green           maxfail 0"
            echo -e "$green           lcp-echo-interval 30"
            echo -e "$green           lcp-echo-failure 4"
            echo
            echo -e "$green使用说明：4.认证可能失败的参数,需要排查debug日志!"
            echo -e "$green           refuse-pap"
            echo -e "$green           require-chap"
            echo -e "$green           ms-dns 8.8.8.8"
            echo -e "$green           crtscts"
            echo -e "$green           hide-password"
            echo -e "$green           lcp-echo-interval 30"
            echo -e "$green           lcp-echo-failure 4"
            echo
            echo -e "$yellow=================================================================================="
            echo
            echo '正在配置DNS和MTU and MRU中......'
            echo
            read -p '是否进入配置界面,请输入yes or y(n不配置)：' set2
            if [[ $set2 == yes || $set2 == y ]];then vi /etc/ppp/options.xl2tpd || nano /etc/ppp/options.xl2tpd;fi
            DirConf=$(dirname /etc/ppp/options.xl2tpd)
            BSConf=$(basename /etc/ppp/options.xl2tpd)
            echo
            echo 'DNS和MTU、MRU设置成功！！！'
            echo 
            echo '开始检查ing......'
            echo
            cat "$DirConf"/"$BSConf" | grep ms-dns
            cat "$DirConf"/"$BSConf" | grep mtu
            cat "$DirConf"/"$BSConf" | grep mru
            sleep 4
            echo
            echo -e "$yellow======================开始设置用户名密码==========================="
            echo
            echo '使用说明：1.username * password ip'
            echo '使用说明：2.如：user1 * 123456 192.168.88.88'
            echo
            echo -e "$yellow=================================================================="
            echo
            read -p '是否进入配置界面,请输入yes or y(n不配置)：' set3
            echo
            if [[ $set3 == yes || $set3 == y ]];then vi /etc/ppp/chap-secrets || nano /etc/ppp/chap-secrets;fi
            echo
            echo '用户添加成功！！！'
            echo
            sleep 3
            echo '检查IP转发是否开启......'
            echo
            cat /etc/sysctl.conf | grep ip_forward
            echo
            sleep 3
            read -p '是否修改IP转发文件,请输入(yes or y)进入配置页面：' conf1
            echo
            if [[ $conf1 == yes || $conf1 == y ]];then vi /etc/sysctl.conf || nano /etc/sysctl.conf;fi
            echo
            echo '修改完成！！！'
            echo
            echo '正在开启IP转发......'
            echo
            sysctl -p
            echo
            sleep 3
            echo '开启完成！！！'
            echo
            echo '重启xl2tpd服务......'
            echo
            service xl2tpd restart || systemctl restart xl2tpd
            echo
            sleep 3
            echo '重启完成！！！'
            echo
            echo '开始查看L2TP状态......'
            echo
            service xl2tpd status || systemctl status xl2tpd
            echo
            echo 'success'
            echo
            sleep 4
            echo '开始自动配置开机自动启用......'
            echo
            systemctl enable xl2tpd
            echo
            sleep 3
            echo '开机启动配置完成！！！'
            echo
            sleep 3
            echo -e "$yellow============================"
            echo '恭喜你！L2TP已全部配置完成!!!'
            echo -e "$yellow============================"
            echo
        elif [ "$choose1" -eq 4 ]
        then
            echo -e "$yellow=======================欢迎进入PPTP配置板块========================="
            echo
            echo -e "$green使用说明：1.请设置你要分配的IP地址池(如192.168.1.128-192.168.1.254)"
            echo -e "$green使用说明：2.请设置你的本地IP(如192.168.1.130)："
            echo
            echo -e "$yellow=================================================================="
            echo
            echo
            echo '正在配置PPTP地址池和本地IP中......'
            echo
            read -p '是否进入配置界面,请输入yes or y(n不配置)：' set4
            echo
            if [[ $set4 == yes || $set4 == y ]];then vi /etc/pptpd.conf || nano /etc/pptpd.conf;fi
            echo
            echo 'PPTP地址池和本地IP设置成功!!!'
            echo
            echo '正在配置DNS中......'
            echo
            echo -e "$green使用说明：1.请设置你要分配的DNS(如ms-dns 8.8.8.8)"
            echo
            echo '=================================================================='
            echo
            echo '正在配置DNS中......'
            echo
            read -p '是否进入配置界面,请输入yes or y(n不配置)：' set5
            echo
            if [[ $set5 == yes || $set5 == y ]];then vi /etc/ppp/options.pptpd || nano /etc/ppp/options.pptpd;fi
            echo
            echo 'DNS设置成功！！！'
            echo 
            echo '检查ing......'
            echo
            cat /etc/ppp/options.pptpd | grep ms-dns
            sleep 4
            echo
            echo -e "$yellow=========================开始设置用户名密码========================="
            echo
            echo -e "$green使用说明：1.username * password ip"
            echo -e "$green使用说明：2.如：user1 * 123456 192.168.88.88"
            echo
            echo -e "$yellow=================================================================="
            echo
            read -p '是否进入配置界面,请输入yes or y(n不配置)：' set6
            echo
            if [[ $set6 == yes || $set6 == y ]];then vi /etc/ppp/chap-secrets || nano /etc/ppp/chap-secrets;fi
            echo
            echo '用户添加成功！！！'
            echo
            echo '开始查看IP转发......'
            echo
            cat /etc/sysctl.conf | grep ip_forward
            echo
            sleep 3
            read -p '是否修改IP转发文件,请输入(yes or y)进入配置页面：' conf2
            echo
            if [[ $conf2 == yes || $conf2 == y ]];then vi /etc/sysctl.conf || nano /etc/sysctl.conf;fi
            echo
            echo '正在自动开启IP转发......'
            echo
            sysctl -p
            echo
            sleep 3
            echo '开启完成！！！'
            echo
            echo '重启pptpd服务......'
            echo
            service pptpd restart || systemctl restart pptpd
            echo
            sleep 2
            echo '重启完成！！！'
            echo
            echo '开始查看PPTP状态......'
            echo
            service pptpd status || systemctl status pptpd
            echo
            echo 'success!!!'
            echo
            sleep 4
            echo '开始自动配置开机自动启用......'
            echo
            systemctl enable pptpd
            echo
            sleep 3
            echo '开机启动配置完成！！！'
            echo
            echo -e "$yellow============================"
            echo -e "$green恭喜你！PPTP已全部配置完成"
            echo -e "$yellow============================"
            echo
        elif [ "$choose1" -eq 5 ]
        then
            echo '添加新用户ing......'
            echo
            echo -e "$yellow=========================使用说明书========================="
            echo
            echo -e "$green使用说明：1.username * password ip"
            echo -e "$green使用说明：2.如：user1 * 123456 192.168.88.88"
            echo
            echo -e "$yellow==========================================================="
            echo
            echo
            read -p '是否进入配置界面,请输入yes or y(n不配置)：' set7
            echo
            if [[ $set7 == yes || $set7 == y ]];then vi /etc/ppp/chap-secrets || nano /etc/ppp/chap-secrets;fi
            echo
            echo '新用户添加成功！！！'
            echo
            read -p '是否重启PPTP服务(yes or y)：' rst1
            echo
            if [[ $rst1 == yes || $rst1 == y ]]
            then
                echo '正在重启PPTP服务......'
                echo
                service pptpd restart || systemctl restart pptpd
                echo
            fi
            sleep 2
            echo 'PPTP重启完成！！！'
            echo
            read -p '是否重启L2TP服务(yes or y)：' rst2
            echo
            if [[ $rst2 == yes || $rst2 == y ]]
            then
                echo '正在重启L2TP服务......'
                echo
                service xl2tpd restart || systemctl restart xl2tpd
                echo
            fi
            sleep 2
            echo 'L2TP重启完成！！！'
            echo
        elif [ "$choose1" -eq 6 ]
        then
            echo -e "$yellow========================================L2TP========================================="
            echo
            echo '开始查看L2TP状态......'
            echo
            service xl2tpd status || systemctl status xl2tpd
            echo
            echo -e "$yellow========================================L2TP========================================="
            echo
            echo -e "$yellow========================================PPTP========================================="
            echo
            echo '开始查看PPTP状态......'
            echo
            service pptpd status || systemctl status pptpd
            echo
            echo -e "$yellow========================================PPTP========================================="
            echo
            sleep 6
        elif [ "$choose1" -eq 7 ]
        then
            echo -e "$yellow==========================查看用户============================="
            echo
            more /etc/ppp/chap-secrets
            echo
            echo -e "$yellow==========================查看用户============================="
            echo
        elif [ "$choose1" -eq 8 ]
        then
            echo -e "$yellow==========================查看接口============================="
            echo
            ip a | more
            echo
            echo -e "$yellow==========================查看接口============================="
            echo
        elif [ "$choose1" -eq 9 ]
        then
            echo -e "$yellow====================================查看路由======================================="
            echo
            route -n | more
            echo
            echo -e "$yellow====================================查看路由======================================="
            echo
        elif [ "$choose1" -eq 10 ]
        then
            echo -e "$yellow============================PING IP==============================="
            echo
            read -p '请输入你要ping的IP地址：' ping1
            echo
            ping "$ping1" -c 5
            echo
            echo -e "$yellow============================PING IP==============================="
            sleep 3
            echo
        elif [ "$choose1" -eq 11 ]
        then
            echo -e "$yellow================================TRACEROUTE==================================="
            echo
            read -p '请输入你要追踪的IP地址：' mtr1
            traceroute "$mtr1" || mtr "$mtr1"
            echo
            echo -e "$yellow================================TRACEROUTE==================================="
            sleep 5
            echo
        elif [ "$choose1" -eq 12 ]
        then
            echo -e "$yellow=============================START/STOP L2TP SERVER================================"
            debubun=/etc/init.d/xl2tpd
            echo
            read -p '请输入【1】打开【2】关闭：' onf1
            echo
            if [ "$onf1" -eq 1 ]
            then
                systemctl start xl2tpd || service xl2tpd start
                echo
                $debubun start
                echo
                echo 'L2TP START SUCCESS!!!'
            elif [ "$onf1" -eq 2 ]
            then
                systemctl stop xl2tpd || service xl2tpd stop
                echo
                $debubun stop
                echo
                echo 'L2TP STOP SUCCESS!!!'
            else
                echo '你的输入有误！请输入1 or 2'
                echo
            fi
            echo
            echo -e "$yellow=============================START/STOP L2TP SERVER================================"
            sleep 3
            echo
        elif [ "$choose1" -eq 13 ]
        then
            echo -e "$yellow=============================START/STOP PPTP SERVER================================"
            debubunp=/etc/init.d/pptpd
            echo
            read -p '请输入【1】打开【2】关闭：' onf2
            echo
            if [ "$onf2" -eq 1 ]
            then
                systemctl start pptpd || service pptpd start
                echo
                $debubunp start
                echo 'PPTP START SUCCESS!!!'
                echo
            elif [ "$onf2" -eq 2 ]
            then 
                systemctl stop pptpd || service pptpd stop
                echo
                $debubunp stop
                echo
                echo 'PPTP STOP SUCCESS!!!'
                echo
            else
                echo '你的输入有误！请输入1 or 2'
                echo
            fi
            echo
            echo -e "$yellow=============================START/STOP PPTP SERVER================================"
            sleep 3
            echo
        elif [ "$choose1" -eq 14 ]
        then
            echo -e "$yellow=============================FIREWALL STATUS================================="
            echo
            echo '开始查看firewalld状态......'
            echo
            systemctl status firewalld || service firewalld status
            echo
            read -p '是否修改firewalld状态,请输入yes or y进入配置页面：' walls
            if [[ $walls == y || $walls == yes ]]
            then
                echo
                read -p '是否关闭firewalld服务,请输入yes or y关闭：' fires
                echo
                if [[ $fires == y || $fires == yes ]];then systemctl stop firewalld || service firewalld stop;fi
            fi
            echo
            echo 'firewalld关闭完成！！！'
            echo
            firetables=/etc/sysconfig/iptables
            echo '开始查看iptables状态......'
            echo
            systemctl status iptables || service iptables status
            echo
            echo '正在检查iptables配置文件是否存在......'
            echo
            if [ -f $firetables ]
            then
                echo
                read -p '是否查看iptables配置,请输入yes or y查看配置：' tables
                echo
                if [[ $tables == y || $tables == yes ]];then more /etc/sysconfig/iptables;fi
                echo
                read -p '是否修改iptables配置,请输入yes or y进行修改：' configs
                echo
                if [[ $configs == y || $configs == yes ]];then vi /etc/sysconfig/iptables || nano /etc/sysconfig/iptables;fi
                echo
                echo '修改完成！！！'
                echo
            else
                echo
                echo '配置文件不存在,请检查iptables配置！！！'
                echo
            fi
            echo
            echo -e "$yellow=============================FIREWALL STATUS================================="
            sleep 3
            echo
        elif [ "$choose1" -eq 15 ]
        then
            echo -e "$yellow=============================RELOAD XL2TP SERVER================================"
            debubun=/etc/init.d/xl2tpd
            echo
            systemctl reload xl2tpd || service xl2tpd reload
            echo
            $debubun force-reload || $debubun reload
            echo
            echo 'SUCCESS!!!'
            echo
            echo -e "$yellow=============================RELOAD XL2TP SERVER================================"
            sleep 3
            echo
        elif [ "$choose1" -eq 16 ]
        then
            echo -e "$yellow=============================RELOAD PPTP SERVER====================================="
            debubunp=/etc/init.d/pptpd
            echo
            systemctl reload pptpd || service pptpd reload
            echo
            $debubunp force-reload || $debubunp reload
            echo
            echo 'SUCCESS!!!'
            echo
            echo -e "$yellow=============================RELOAD PPTP SERVER====================================="
            sleep 3
            echo
        elif [ "$choose1" -eq 17 ]
        then
            echo -e "$yellow=============================RELOAD L2TP AND PPTP SERVER================================"
            debubun=/etc/init.d/xl2tpd
            debubunp=/etc/init.d/pptpd
            echo
            systemctl reload xl2tpd || service xl2tpd reload
            echo
            systemctl reload pptpd || service pptpd reload
            echo
            $debubun force-reload || $debubun reload
            $debubunp force-reload || $debubunp reload
            echo
            echo 'SUCCESS!!!'
            echo
            echo -e "$yellow=============================RELOAD L2TP AND PPTP SERVER================================"
            sleep 3
            echo
        elif [ "$choose1" -eq 18 ]
        then
            echo -e "$yellow=============================RESTART L2TP SERVER================================"
            debubun=/etc/init.d/xl2tpd
            echo
            systemctl restart xl2tpd || service xl2tpd restart
            echo
            $debubun restart
            echo
            echo 'SUCCESS!!!'
            echo
            echo -e "$yellow=============================RESTART L2TP SERVER================================"
            sleep 3
            echo
        elif [ "$choose1" -eq 19 ]
        then
            echo -e "$yellow=============================RESTART PPTP SERVER================================"
            debubunp=/etc/init.d/pptpd
            echo
            systemctl restart pptpd || service pptpd restart
            echo
            $debubunp restart
            echo
            echo 'SUCCESS!!!'
            echo
            echo -e "$yellow=============================RESTART PPTP SERVER================================"
            sleep 3
            echo
        elif [ "$choose1" -eq 20 ]
        then
            echo -e "$yellow=============================RESTART L2TP AND PPTP SERVER================================"
            debubun=/etc/init.d/xl2tpd
            debubunp=/etc/init.d/pptpd
            echo
            systemctl restart xl2tpd || service xl2tpd restart
            echo
            systemctl restart pptpd || service pptpd restart
            echo
            $debubun restart
            $debubunp restart
            echo
            echo 'SUCCESS!!!'
            echo
            echo -e "$yellow=============================RESTART L2TP AND PPTP SERVER================================"
            sleep 3
            echo
        elif [ "$choose1" -eq 21 ]
        then
            echo -e "$yellow=================================|||L2TP-Server-Debug-Log-Info|||================================="
            echo 
            journalctl -u xl2tpd.service --no-pager | more
            echo
            echo -e "$yellow=================================|||L2TP-Server-Debug-Log-Info|||================================="
        elif [ "$choose1" -eq 22 ]
        then
            echo -e "$yellow=================================|||PPTP-Server-Debug-Log-Info|||================================="
            echo 
            journalctl -u pptpd.service --no-pager | more
            echo
            echo -e "$yellow=================================|||PPTP-Server-Debug-Log-Info|||================================="
        elif [ "$choose1" -eq 23 ]
        then
            echo -e "$yellow=========Ubuntu==================|||Enable-TCP-UDP-Port-Config|||================Ubuntu=========="
            echo
            read -p '请输入你要开启的端口和协议L2TP(UDP1701)OR-PPTP(TCP1723)(输入格式：1701/udp)：' SetPort
            echo
            ufw allow "$SetPort"
            echo
            echo '端口开启Success!!!'
            echo
            echo -e "$yellow========Ubuntu===================|||Enable-TCP-UDP-Port-Config|||================Ubuntu==========="
        elif [ "$choose1" -eq 0 ]
        then
            echo -e "$green'欢迎下次使用！！！"
            echo
            break
        else
            echo
            echo -e "$red你的输入有误，请输入0、1、2、3、4、5、6、7、8、9、10、11、12、13、14、15、16、17、18、19、20、21、22、23"
            echo
        fi
    done
}
function Systems()
{
    while [ 1 ]
    do
        echo -e "$yellow'================================欢迎进入系统板块================================="
        echo
        echo -e "$green【1】查看主机DNS  【2】查看主机名 【3】查看硬盘空间   【4】查看内存空间"
        echo
        echo -e "$green【5】添加/删除用户组 【6】添加/删除新用户 【7】查看当前登录的用户列表"
        echo
        echo -e "$green【8】修改用户所在组 【9】查询执行文件位置 【10】查看时间/日期"
        echo
        echo -e "$red===========================|||【0】退出系统板块|||==============================="
        echo
        echo -e "$yellow================================================================================"
        echo
        read -p '请输入你的选择【0】【1】【2】【3】【4】【5】【6】【7】【8】【9】【10】：' choose1
        echo
        if [ "$choose1" -eq "1" ]
        then
            echo -e "$yellow==============================DNS================================"
            echo
            DNSHOME=/etc/resolv.conf
            echo '============当前主机DNS============'
            cat /etc/resolv.conf | more
            echo '=================================='
            echo
            read -p '是否修改本机DNS,请输入yes or y进行修改：' dns1
            echo
            if [[ $dns1 == y || $dns1 == yes ]]
            then
                vi $DNSHOME || nano $DNSHOME
                echo
                echo '修改完成!!!'
                echo
                read -p '是否重启网络服务立即生效,请输入yes or y进行重启：' netdns
                echo
                if [[ $netdns == y || $netdns == yes ]];then systemctl restart network || service network restart;fi
                echo
                echo '网络重启SUCCESS,DNS已生效!!!'
                echo
            fi
            echo
            echo -e "$yellow==============================DNS================================"
            echo
        elif [ "$choose1" -eq "2" ]
        then
            echo -e "$yellow=======================HOSTNAME======================"
            echo
            echo '=====主机当前HOSTNAME====='
            hostname
            echo '========================='
            echo
            read -p '是否修改本机hostname,请输入yes or y进行修改：' name1
            echo
            if [[ $name1 == y || $name1 == yes ]]
            then
                read -p '请输入你要修改的名字：' names
                echo
                hostnamectl set-hostname "$names"
                echo '修改SUCCESS!!!'
                echo
                read -p '是否需要检查hostname配置,请输入yes or y进入检查：' check1
                echo
                if [[ $check1 == y || $check1 == yes ]]
                then
                    echo '========请仔细核对========'
                    cat /etc/hostname
                    echo '========================='
                    echo
                    read -p '确认无误,是否重启网络服务使其生效,请输入yes or y进行重启：' net1
                    echo
                    if [[ $net1 == y || $net1 == yes ]]
                    then
                        systemctl restart network || service network restart
                        echo '网络服务重启SUCCESS!!!'
                        echo
                    fi
                fi
            fi
            echo
            echo -e "$yellow====================================================="
            echo
            elif [ "$choose1" -eq "3" ]
            then
                echo -e "$yellow===========================查看硬盘占用情况========================="
                echo
                df  -lh
                echo
                echo -e "$yellow==================================================================="
                echo
            elif [ "$choose1" -eq "4" ]
            then
                echo -e "$yellow===========================查看内存占用情况========================="
                echo
                free -mh
                echo
                echo -e "$yellow==================================================================="
                echo
            elif [ "$choose1" -eq "0" ]
            then
                echo '欢迎您下次进入系统板块！'
                echo
                break
            elif [ "$choose1" -eq "5" ]
            then
                while true
                do
                    echo -e "$yellow==============添加/删除用户组==============="
                    echo
                    echo '【0】退出 【1】添加用户组 【2】删除用户组'
                    echo
                    read -p '请输入你的选择【0】【1】【2】：' chooseGroup
                    echo
                    if [ "$chooseGroup" == "1" ]
                    then
                        read -p '请输入你要添加的用户组名称：' groupUser1
                        echo
                        groupadd "$groupUser1"
                        echo '用户组添加成功！'
                        echo
                        read -p '是否检查用户组(y or yes)查看：' checks
                        echo
                        if [[ "$checks" == "y" || "$checks" == "yes" ]]
                        then
                            cat /etc/group | grep "$groupUser1"
                            echo
                        fi
                    elif [ "$chooseGroup" == "2" ]
                    then
                    read -p '请输入你要删除的用户组名称：' groupUser2
                        echo
                        groupdel "$groupUser2"
                        echo '用户组删除成功！'
                        echo
                    elif [ "$chooseGroup" == "0" ]
                    then
                        echo '欢迎下次使用！'
                        echo
                        break
                    else
                        echo '你的输入有误,请输入0、1、2'
                        echo
                    fi
                    echo -e "$yellow==============添加/删除用户组==============="
                done
            elif [ "$choose1" -eq "6" ]
            then
                while true
                do
                    echo -e "$yellow==============添加/删除用户==============="
                    echo
                    echo '【0】退出 【1】添加新用户 【2】删除用户'
                    echo
                    read -p '请输入你的选择【0】【1】【2】：' chooseUser
                    echo
                    if [ "$chooseUser" == "1" ]
                    then
                        read -p '请输入你要添加的用户名称：' userName
                        echo
                        read -p '请输入你要添加的用户组：' groupName
                        echo
                        sudo useradd -m -g "$groupName" "$userName"
                        echo '新用户添加成功(并自动创建家目录)！'
                        echo
                        sudo passwd "$userName"
                        echo
                        echo '密码添加成功！'
                        echo
                    elif [ "$chooseUser" == "2" ]
                    then
                        read -p '请输入你要删除的用户名称：' delName
                        echo
                        read -p '【1】只删除用户【2】同时删除用户和其家目录：' delHome
                        echo
                        if [ "$delHome" == "1" ]
                        then
                            sudo userdel "$delName"
                            echo '用户删除成功！'
                            echo
                        elif [ "$delHome" == "2" ]
                        then
                            sudo userdel -r "$delName"
                            echo '用户删除成功(并自动删除家目录)！'
                            echo
                        else
                            echo '你的输入有误,请输入1、2'
                            echo
                        fi
                    elif [ "$chooseUser" == "0" ]
                    then
                        echo '欢迎下次使用！'
                        echo
                        break
                    else
                        echo '你的输入有误,请输入1、2'
                        echo
                    fi 
                    echo -e "$yellow==============添加/删除用户==============="
                done
            elif [ "$choose1" -eq "7" ]
            then
                echo -e "$yellow=====================用户列表====================="
                echo
                who
                echo
                echo -e "$yellow=====================用户列表====================="
            elif [ "$choose1" -eq "8" ]
            then
                while true
                do
                    echo -e "$yellow====================修改用户组===================="
                    echo
                    echo '【1】修改用户主组 【2】修改用户附加组'
                    echo '【3】修改用户登录shell(由dush-->bash)'
                    echo
                    echo '-------------【0】退出-------------'
                    echo
                    read -p '请输入你的选择【0】【1】【2】【3】：' reGroup
                    echo
                    if [ "$reGroup" == "1" ]
                    then
                        echo '=======修改用户的主组======='
                        echo
                        read -p '请输入修改后的组名：' newGroup1
                        echo
                        read -p '请输入你的用户名：' locName1
                        echo
                        sudo usermod -g "$newGroup1" "$locName1"
                        echo '修改成功！' 
                        echo
                        echo '=======修改用户的主组======='
                    elif [ "$reGroup" == "2" ]
                    then
                        echo '=======修改用户的附加组======='
                        echo
                        read -p '请输入附加组名(如sudo)：' newGroup2
                        echo
                        read -p '请输入你的用户名：' locName2
                        echo
                        sudo usermod -G "$newGroup2" "$locName2"
                        echo '附加组修改成功！' 
                        echo
                        echo '=======修改用户的附加组======='
                    elif [ "$reGroup" == "3" ]
                    then
                        echo '==============bash=============='
                        echo
                        sudo usermod -s /bin/bash
                        echo '修改成功！'
                        echo
                        echo '==============bash=============='
                    elif [ "$reGroup" == "0" ]
                    then
                        echo '欢迎你的下次使用！'
                        echo
                        break
                    else
                        echo
                    fi
                    echo
                    echo -e "$yellow====================修改用户组===================="
                done
            elif [ "$choose1" -eq "9" ]
            then
               echo -e "$yellow===========file-bin============"
                echo
                read -p '请输入你的命令(如ls)：' comm
                echo
                which "$comm"
                echo
                echo -e "$yellow===========file-bin============"
            elif [ "$choose1" -eq "10" ]
            then
                while true
                do
                    echo -e "$yellow==================Time-Date==================="
                    echo
                    echo '【0】退出 【1】时间 【2】日期'
                    echo
                    read -p '请输入你的选择：' num1
                    echo
                    if [ "$num1" == "1" ]
                    then
                        date +"%F %T"
                        echo
                    elif [ "$num1" == "2" ]
                    then
                        cal -y
                        echo
                    elif [ "$num1" == "0" ]
                    then
                        echo '欢迎你的下次使用！'
                        echo
                        break
                    else
                        echo '你的输入有误！请输入1、2'
                        echo
                    fi
                    echo
                    echo -e "$yellow==================Time-Date==================="
                done
            else
                echo -e "$red您的输入有误！请输入0、1、2、3、4、5、6、7、8、9、10"
                echo
            fi
    done
}
function Tunnel()
{
    while [ 1 ]
    do
        echo -e "$yellow================================欢迎进入路由和隧道板块================================="
        echo
        echo -e "$green【1】查看当前路由 【2】添加路由 【3】添加永久路由   【4】添加定时任务   【5】建立GRE隧道"
        echo
        echo -e "$green【6】ping IP  【7】traceroute IP  【8】检查/修改防火墙    【9】重启网络服务"
        echo
        echo -e "$green【10】重载防火墙  【11】重启防火墙    【12】查看防火墙状态    【13】查看所有接口信息"
        echo
        echo -e "$green【14】关闭GRE Tunnel  【15】打开GRE Tunnel    【16】删除GRE Tunnel    【17】删除路由"
        echo
        echo -e "$red===========================|||【0】退出路由和隧道板块|||==============================="
        echo
        echo -e "$yellow======================================================================================"
        echo
        read -p '请输入你的选择【0】【1】【2】【3】【4】【5】【6】【7】【8】【9】【10~17】：' choose1
        echo
        case $choose1 in
        "0")
            echo '欢迎您下次使用路由和隧道板块！'
            echo
            break
        ;;
        "1")
            echo -e "$yellow===================================LOCAL ROUTE===================================="
            route -n || ip route
            echo
            echo -e "$yellow===================================LOCAL ROUTE===================================="
        ;;
        "2")
            echo -e "$yellow====================================ADD ROUTE====================================="
            echo
            read -p '请输入你要添加的网段或IP(如192.168.X.X/X)：' networks
            echo
            read -p '请输入对端的IP地址或网关地址(如192.168.X.X)：' remoteIP
            echo
            ip route add "$networks" via "$remoteIP"
            echo
            echo '路由添加SUCCESS!!!'
            echo
            echo -e "$yellow====================================ADD ROUTE====================================="
            echo
        ;;
        "3")
            echo -e "$yellow==============================================添加永久路由==============================================="
            echo
            read -p '请选择你的系统【1】ubuntu/debian【2】centos/redhat：' choose2
            echo
            if [ "$choose2" -eq 1 ]
            then
                echo
                echo -e "$yellow==========================================Ubuntu/debian......================================================"
                echo -e "$green------------------------------------------------||使用说明书||------------------------------------------------"
                echo -e "$green============================================================================================================="
                echo -e "$green                    auto eth0   # 根据需要更改为正确的网络接口名称
                    iface eth0 inet static    # 同样地，根据需要更改为正确的网络接口类型
                    address <IP_ADDRESS>      # 设置静态IP地址
                    netmask <NETMASK>         # 设置子网掩码
                    gateway <GATEWAY_IP>       # 设置默认网关
                    dns-nameservers <DNS_SERVERS>     # 设置DNS服务器
                    post-up route add -net <DESTINATION_NETWORK> gw <NEXT_HOP_IP> dev eth0   # 添加静态路由"
                echo
                echo -e "$yellow============================================================================================================="
                echo
                echo -e "$yellow==========================================Ubuntu/debian......================================================"
                echo
                touch /etc/network/interfaces
                read -p '是否进入永久静态路由配置界面,请输入yes or y进入界面：' uconfig
                echo
                if [[ $uconfig == y || $uconfig == yes ]]
                then
                    ROUTEHOME=/etc/network/interfaces
                    vi $ROUTEHOME || nano $ROUTEHOME
                    echo
                    echo '永久路由添加完毕！！！'
                    echo
                    read -p '是否需要检查,请输入yes or y进行检查：' check2
                    echo
                    if [[ $check2 == y || $check2 == yes ]];then cat $ROUTEHOME | more;fi
                    echo
                    read -p '是否重启网络服务进行生效测试,请输入yes or y进行重启：' rst2
                    echo
                    if [[ $rst2 == y || $rst2 == yes ]];then service networking restart || systemctl restart networking;fi
                    echo
                    echo '网络服务重启完成,请自行查看路由是否生效'
                    echo
                    echo -e "$yellow========================================================================================================="
                fi
                echo
            elif [ "$choose2" -eq 2 ]
            then
                echo -e "$yellow===========================centos/redhat......=============================="
                echo
                read -p '请输入你要添加路由的网卡接口名称：' netnames
                echo
                touch /etc/sysconfig/network-scripts/route-"$netnames"
                echo -e "$yellow============================================================================"
                echo -e "$green使用说明(如下图所示)："
                echo -e "$green                      10.15.150.0/24 via 192.168.11.2 dev eth0
                      10.25.250.0/24 via 192.168.11.2 dev eth0
                      173.241.113.99 via 192.168.1.1 dev eth0"
                echo -e "$yellow============================================================================"
                echo
                echo -e "$yellow===========================centos/redhat......=============================="
                echo
                read -p '是否进入永久路由配置页面,请输入yes or y进入配置：' looproute
                echo
                if [[ $looproute == y || $looproute == yes ]];then vi /etc/sysconfig/network-scripts/route-"$netnames" || nano /etc/sysconfig/network-scripts/route-"$netnames";fi
                echo
                echo '永久路由添加完毕！！！'
                echo
                read -p '是否重启网络服务进行生效测试,请输入yes or y进行重启：' rst3
                    echo
                    if [[ $rst3 == y || $rst3 == yes ]];then service network restart || systemctl restart network;fi
                    echo
                    echo '网络服务重启完成,请自行查看路由是否生效'
                    echo
                echo -e "$yellow============================================================================"
            echo
            echo -e "$yellow==============================================添加永久路由==============================================="
            echo
            else
                echo -e "$red你的输入有误,请输入0、1、2"
                echo
            fi
        ;;
        "4")
            echo -e "$yellow=======================添加定时任务==========================="
            echo -e "$green使用说明："
            echo -e "$green*/1 **** ping 1.1.1.1 -c 4 >/dev/null (隔1分钟ping这个地址4次)"
            crontab -e
            echo
            echo '定时任务添加完成！'
            echo
            echo -e "$yellow=======================添加定时任务==========================="
        ;;
        "5")
            echo -e "$yellow======================创建GRE Tunnel========================="
            echo
            echo '自动加载GRE模块......'
            echo
            modprobe ip_gre
            echo 
            echo '查看GRE模块'
            echo
            lsmod | grep gre
            echo
            echo '开始创建GRE Tunnel......'
            echo
            read -p '请输入你的GRE隧道名称：' grename
            echo
            echo "你输入的隧道名称是$grename"
            echo
            read -p '请输入本地的公网IP地址：' localIP
            echo
            echo "你输入的本地公网IP是$localIP"
            echo
            read -p '请输入对端的公网IP地址：' remoteIP
            echo
            echo "你输入的对端公网IP是$remoteIP"
            echo
            echo '开始添加GRE Tunnel......'
            echo
            ip tunnel add "$grename" mode gre remote "$remoteIP" local "$localIP" ttl 255
            echo
            echo 'GRE Tunnel添加完成！！！'
            echo
            echo '开始添加内网IP......'
            echo
            read -p '请输入你的本地内网IP：' localIP2
            echo
            echo "你输入的内网IP是$localIP2"
            echo
            read -p '请输入对端的内网IP：' remoteIP2
            echo
            echo "你输入的对端内网IP是$remoteIP2"
            echo
            ip addr add "$localIP2" peer "$remoteIP2" dev "$grename"
            echo
            echo 'GRE Tunnel内网IP添加完成！！！'
            echo
            echo -e "$yellow======================创建GRE Tunnel========================="
        ;;
        "6")
            echo -e "$yellow============================PING IP==============================="
            echo
            read -p '请输入你要ping的IP地址：' ping1
            echo
            ping "$ping1" -c 5
            echo
            echo -e "$yellow============================PING IP==============================="
            sleep 3
            echo
        ;;
        "7")
            echo -e "$yellow================================TRACEROUTE==================================="
            echo
            read -p '请输入你要追踪的IP地址：' mtr1
            traceroute "$mtr1" || mtr "$mtr1"
            echo
            echo -e "$yellow================================TRACEROUTE==================================="
            sleep 5
            echo
        ;;
        "8")
            echo -e "$yellow=============================FIREWALL STATUS================================="
            echo
            echo '开始查看firewalld状态......'
            echo
            systemctl status firewalld || service firewalld status
            echo
            read -p '是否修改firewalld状态,请输入yes or y进入配置页面：' walls
            if [[ $walls == y || $walls == yes ]]
            then
                echo
                read -p '是否关闭firewalld服务,请输入yes or y关闭：' fires
                echo
                if [[ $fires == y || $fires == yes ]];then systemctl stop firewalld || service firewalld stop;fi
            fi
            echo
            echo 'firewalld关闭完成！！！'
            echo
            firetables=/etc/sysconfig/iptables
            echo '开始查看iptables状态......'
            echo
            systemctl status iptables || service iptables status
            echo
            echo '正在检查iptables配置文件是否存在......'
            echo
            if [ -f $firetables ]
            then
                echo
                read -p '是否查看iptables配置,请输入yes or y查看配置：' tables
                echo
                if [[ $tables == y || $tables == yes ]];then more /etc/sysconfig/iptables;fi
                echo
                read -p '是否修改iptables配置,请输入yes or y进行修改：' configs
                echo
                if [[ $configs == y || $configs == yes ]];then vi /etc/sysconfig/iptables || nano /etc/sysconfig/iptables;fi
                echo
                echo '修改完成！！！'
                echo
            else
                echo
                echo '配置文件不存在,请检查iptables配置！！！'
                echo
            fi
            echo
            echo -e "$yellow=============================FIREWALL STATUS================================="
            sleep 3
            echo
        ;;
        "9")
            echo -e "$yellow============================RESTART NETWORK=================================="
            echo
            service networking restart || systemctl restart networking
            service network restart || systemctl restart network
            echo
            echo -e "$yellow============================RESTART NETWORK=================================="
            echo
        ;;
        "10")
            echo -e "$yellow============================RELOAD IPTABLES=================================="
            echo
            systemctl reload iptables || service iptables reload
            echo
            echo -e "$yellow============================RELOAD IPTABLES=================================="
            echo
        ;;
        "11")
            echo -e "$yellow============================RESTART IPTABLES=================================="
            echo
            systemctl restart iptables || service iptables restart
            echo
            echo -e "$yellow============================RESTART IPTABLES=================================="
            echo
        ;;
        "12")
            echo -e "$yellow============================STATUS IPTABLES=================================="
            echo
            systemctl status iptables || service iptables status
            echo
            echo -e "$yellow============================STATUS IPTABLES=================================="
            echo
        ;;
        "13")
            echo -e "$yellow============================IP-ETH-INFO=================================="
            echo
            ip a | more
            echo
            echo -e "$yellow============================IP-ETH-INFO=================================="
            echo
        ;;
        "14")
            echo -e "$yellow============================STOP GRE Tunnel=================================="
            echo
            read -p '请输入GRE接口名称：' grenames
            echo
            ip link set "$grenames" down
            echo
            echo 'GRE Tunnel关闭SUCCESS!!!'
            echo
            echo -e "$yellow============================STOP GRE Tunnel=================================="
            echo
        ;;
        "15")
            echo -e "$yellow============================START GRE Tunnel=================================="
            echo
            read -p '请输入GRE接口名称：' grenames
            echo
            ip link set "$grenames" up
            echo
            echo 'GRE Tunnel开启SUCCESS!!!'
            echo
            echo -e "$yellow============================START GRE Tunnel=================================="
            echo
        ;;
         "16")
            echo -e "$yellow============================DEL GRE Tunnel=================================="
            echo
            read -p '请输入GRE接口名称：' grenames
            echo
            ip tunnel del "$grenames"
            echo
            echo 'GRE Tunnel删除SUCCESS!!!'
            echo
            echo -e "$yellow============================DEL GRE Tunnel=================================="
            echo
        ;;
        "17")
            echo -e "$yellow====================================DEL ROUTE====================================="
            echo
            read -p '请输入你要删除的网段或IP(如192.168.X.X/X)：' networks
            echo
            read -p '请输入你要删除的对端的IP地址或网关地址(如192.168.X.X)：' remoteIP
            echo
            ip route del "$networks" via "$remoteIP"
            echo
            echo '路由删除SUCCESS,请自行查看!!!'
            echo
            echo -e "$yellow====================================DEL ROUTE====================================="
            echo
        ;;
        *)
            echo -e "$red你的输入有误！请输入0、1、2、3、4、5、6、7、8、9、10~17"
            echo
        ;;
        esac
    done
}
function Package(){
    while true
    do
        echo -e "$yellow===============================解压缩板块================================"
        echo
        echo -e "$red【0】退出板块 $green【1】打包/解包 【2】压缩/解压"
        echo
        read -p '请输入你的选择【0】【1】【2】：' choose1
        echo
        echo "你的选择是$choose1"
        echo
        if [ "$choose1" == "1" ]
        then
            while true
            do
                echo -e "$yellow========================打包/解包========================="
                echo
                echo -e "$red【0】退出 $green【1】打包 【2】解包"
                echo
                read -p '请输入你的选择【0】【1】【2】：' choose2
                echo
                if [ "$choose2" == "1" ]
                then
                    echo -e "$yellow==============打包================"
                    echo
                    read -p '请输入打包的文件名(xxx.tar)：' pgName
                    echo
                    read -p '是否查看要打包的文件(输入y or yes)：' chooseLook
                    echo
                    if [[ "$chooseLook" == "y" || "$chooseLook" == "yes" ]]
                    then
                        read -p '请输入你要查看的文件路径(如/home/xxx)：' filePath
                        echo
                        ls -l "$filePath"
                        echo
                    fi
                    read -p '请输入要打包文件(单个/多个用空格或者*.xxx匹配)：' pgFile
                    echo
                    cd "$filePath" || exit
                    tar -cvf "$pgName" "$pgFile"
                    echo
                    echo '打包完成！！！'
                    echo
                    echo -e "$yellow==============打包================"
                elif [ "$choose2" == "2" ]
                then
                    echo -e "$yellow==============解包================"
                    echo
                    read -p '是否查看要解包的文件(输入y or yes)：' chooseLook2
                    echo
                    if [[ "$chooseLook2" == "y" || "$chooseLook2" == "yes" ]]
                    then
                        read -p '请输入你要查看的文件路径(如/home/xxx)：' filePath
                        echo
                        ls -l "$filePath"
                        echo
                    fi
                    echo
                    read -p '请输入解包的文件名(xxx.tar)：' solName
                    echo
                    read -p '是否指定特定目录进行解包(输入y or yes)：' dirMenu
                    echo
                    if [[ "$dirMenu" == "y" || "$dirMenu" == "yes" ]]
                    then
                        read -p '请输入你要指定的目录(需存在)：' pgDir
                        echo
                        cd "$filePath" || exit
                        tar -xvf "$solName" -C "$pgDir"
                        echo
                        echo '指定目录解包成功！！！'
                        echo
                    fi
                    tar -xvf "$solName" 
                    echo
                    echo '解包完成！！！'
                    echo
                    echo -e "$yellow==============解包================"
                echo
                elif [ "$choose2" == "0" ]
                then
                    echo '欢迎下次使用！'
                    echo
                    break
                else
                    echo '你的输入有误！请输入0、1、2'
                    echo
                fi
                echo -e "$yellow========================打包/解包========================="
            done
        elif [ "$choose1" == "2" ]
        then
            while true
            do
                echo -e "$yellow========================压缩/解压==========================="
                echo
                echo '【0】退出 【1】压缩 【2】解压'
                echo
                read -p '请输入你的选择【0】【1】【2】：' choose3
                echo
                if [ "$choose3" == "1" ]
                then
                    while true
                    do
                        echo -e "$yellow==========================压缩============================"
                        echo
                        echo '【0】退出压缩板块 【1】使用gzip压缩 【2】使用bzip2压缩'
                        echo
                        read -p '请输入你的选择【0】【1】【2】：' chooseys
                        echo
                        if [ "$chooseys" == "1" ]
                        then
                            echo -e "$yellow=======================gzip========================="
                            echo
                            read -p '请输入压缩后的文件名(xxx.tar.gz)：' cpName1
                            echo
                            read -p '是否查看要压缩的文件(输入y or yes)：' chooseLook3
                            echo
                            if [[ "$chooseLook3" == "y" || "$chooseLook3" == "yes" ]]
                            then
                                read -p '请输入你要查看的文件路径(如/home/xxx)：' filePath
                                echo
                                ls -l "$filePath"
                                echo
                            fi
                            echo
                            read -p '请输入要压缩的文件(单个/多个用空格或者*.xxx匹配)：' cpFile1
                            echo
                            cd "$filePath" || exit
                            tar -zcvf "$cpName1" "$cpFile1"
                            echo
                            echo 'gzip压缩成功！！！'
                            echo
                            echo -e "$yellow=======================gzip========================="
                        elif [ "$chooseys" == "2" ]
                        then
                            echo -e "$yellow=======================bzip2========================="
                            echo
                            read -p '请输入压缩后的文件名(xxx.tar.bz2)：' cpName2
                            echo
                            read -p '是否查看要压缩的文件(输入y or yes)：' chooseLook4
                            echo
                            if [[ "$chooseLook4" == "y" || "$chooseLook4" == "yes" ]]
                            then
                                read -p '请输入你要查看的文件路径(如/home/xxx)：' filePath
                                echo
                                ls -l "$filePath"
                                echo
                            fi
                            echo
                            read -p '请输入要压缩的文件(单个/多个用空格或者*.xxx匹配)：' cpFile2
                            echo
                            cd "$filePath" || exit
                            tar -jcvf "$cpName2" "$cpFile2"
                            echo
                            echo 'bzip2压缩成功！！！'
                            echo
                            echo -e "$yellow=======================bzip2========================="
                        elif [ "$chooseys" == "0" ]
                        then
                            echo '欢迎下次使用！'
                            echo
                            break
                        else
                            echo '你的输入有误！请输入0、1、2'
                            echo
                        fi
                        echo
                        echo -e "$yellow==========================压缩============================"
                    done
                elif [ "$choose3" == "2" ]
                then
                    while true
                    do
                        echo -e "$yellow============================解压==============================="
                        echo
                        echo '【0】退出解压板块 【1】使用gzip解压 【2】使用bzip2解压'
                        echo
                        read -p '请输入你的选择【0】【1】【2】：' choosejy
                        echo
                        if [ "$choosejy" == "1" ]
                        then
                            echo -e "$yellow=======================gzip========================="
                            echo
                            read -p '是否查看要解压的文件(输入y or yes)：' chooseLook5
                            echo
                            if [[ "$chooseLook5" == "y" || "$chooseLook5" == "yes" ]]
                            then
                                read -p '请输入你要查看的文件路径(如/home/xxx)：' filePath
                                echo
                                ls -l "$filePath"
                                echo
                            fi
                            echo
                            read -p '请输入要解压的文件名(xxx.tar.gz)：' dpName
                            echo
                            read -p '是否指定特定目录进行解包(输入y or yes)：' chooseMe
                            echo
                            if [[ "$chooseMe" == "y" || "$chooseMe" == "yes" ]]
                            then
                                read -p '请输入特定的目录路径(要存在)：' dirMenus
                                echo
                                cd "$filePath" || exit
                                tar -zxvf "$dpName" -C "$dirMenus"
                                echo
                                echo 'gzip特定目录解压成功！！！'
                                echo
                            fi
                            cd "$filePath" || exit
                            tar -zxvf "$dpName"
                            echo
                            echo 'gzip解压成功！！！'
                            echo
                            echo -e "$yellow=======================gzip========================="
                        elif [ "$choosejy" == "2" ]
                        then
                            echo -e "$yellow=======================bzip2========================="
                            echo
                            read -p '是否查看要解压的文件(输入y or yes)：' chooseLook6
                            echo
                            if [[ "$chooseLook6" == "y" || "$chooseLook6" == "yes" ]]
                            then
                                read -p '请输入你要查看的文件路径(如/home/xxx)：' filePath
                                echo
                                ls -l "$filePath"
                                echo
                            fi
                            echo
                            read -p '请输入要解压的文件名(xxx.tar.bz2)：' dpName2
                            echo
                            read -p '是否指定特定目录进行解包(输入y or yes)：' chooseMe2
                            echo
                            if [[ "$chooseMe2" == "y" || "$chooseMe2" == "yes" ]]
                            then
                                read -p '请输入特定的目录路径(要存在)：' dirMenus2
                                echo
                                cd "$filePath" || exit
                                tar -jxvf "$dpName2" -C "$dirMenus2"
                                echo
                                echo 'bzip2特定目录解压成功！！！'
                                echo
                            fi
                            cd "$filePath" || exit
                            tar -jxvf "$dpName"
                            echo
                            echo 'bzip2解压成功！！！'
                            echo
                            echo -e "$yellow=======================bzip2========================="
                        elif [ "$choosejy" == "0" ]
                        then
                            echo '欢迎下次使用！'
                            echo
                            break
                        else
                            echo '你的输入有误！请输入0、1、2'
                            echo
                        fi
                        echo
                        echo
                        echo -e "$yellow============================解压==============================="
                    done
                echo
                elif [ "$choose3" == "0" ]
                then
                    echo '欢迎下次使用！'
                    echo
                    break
                else
                    echo '你的输入有误！请输入0、1、2'
                    echo
                fi
                echo -e "$yellow========================压缩/解压==========================="
            done
        elif [ "$choose1" == "0" ]
        then
            echo '期待你的下次光临！'
            echo
            break
        else
            echo -e "$red你的输入有误！请重新输入0、1、2"
            echo
        fi
        echo
        echo -e "$yellow===============================解压缩板块================================"
    done
}

function wireShark(){
    while [ 1 ]
    do
        echo -e "$yellow===============================CapturePackets============================"
        echo
        echo -e "$red------------------------|||【0】退出抓包板块|||---------------------------"
        echo
        echo -e "$green【1】抓指定端口的包 【2】抓取包并保存到文件 【3】抓源IP和目标IP为指定IP的包"
        echo
        echo -e "$green【4】显示所有input或output的HTTP请求和响应的包 【5】捕获并显示指定数量的数据包"
        echo
        echo -e "$green------------------------|||【8】安装抓包工具|||---------------------------"
        echo
        read -p '请输入你的选择【0】【1】【2】【3】【4】【5】【8】：' choose
        echo
        case $choose in
        "8")
            echo '正在安装抓包工具......'
            echo
            yum install tcpdump -y || apt-get install tcpdump -y
            echo
            echo '安装成功！！！'
            echo
        ;;
        "1")
            while true
            do
                echo -e "$green===========================Package============================"
                echo
                echo '【0】退出 【1】TCP抓包 【2】UDP抓包 【3】TCP+UDP抓包'
                echo
                read -p '请输入你的选择【0】【1】【2】：' chooseTU
                echo
                if [ "$chooseTU" == "1" ]
                then
                    echo -e "$green==========================TCP-Package========================="
                    echo
                    read -p '是否查看你的接口(y or yes)：' choose
                    echo
                    if [[ "$choose" == y || "$choose" == "yes" ]]
                    then
                        ip a | more || ifconfig | more
                        echo
                    fi
                    read -p '请输入你的接口：' eths
                    echo
                    read -p '请输入你的端口：' ports
                    echo
                    read -p '是否以ASCII格式显示(y or yes)：' choose
                    echo
                    if [[ "$choose" == "y" || "$choose" == "yes" ]]
                    then
                        sudo tcpdump -i "$eths" tcp port "$ports" -A
                        echo
                    fi
                    echo
                    sudo tcpdump -i "$eths" tcp port "$ports"
                    echo
                    echo -e "$green==========================TCP-Package========================="
                elif [ "$chooseTU" == "2" ]
                then
                    echo -e "$green==========================UDP-Package========================="
                    echo
                    read -p '是否查看你的接口(y or yes)：' choose
                    echo
                    if [[ "$choose" == y || "$choose" == "yes" ]]
                    then
                        ip a | more || ifconfig | more
                        echo
                    fi
                    read -p '请输入你的接口：' eths
                    echo
                    read -p '请输入你的端口：' ports
                    echo
                    read -p '是否以ASCII格式显示(y or yes)：' choose
                    echo
                    if [[ "$choose" == "y" || "$choose" == "yes" ]]
                    then
                        sudo tcpdump -i "$eths" udp port "$ports" -A
                        echo
                    fi
                    echo
                    sudo tcpdump -i "$eths" udp port "$ports"
                    echo
                    echo
                    echo -e "$green==========================UDP-Package========================="
                elif [ "$chooseTU" == "3" ]
                then
                    echo -e "$green==========================TCP/UDP-Package========================="
                    echo
                    read -p '是否查看你的接口(y or yes)：' choose
                    echo
                    if [[ "$choose" == y || "$choose" == "yes" ]]
                    then
                        ip a | more || ifconfig | more
                        echo
                    fi
                    read -p '请输入你的接口：' eths
                    echo
                    read -p '请输入你的端口：' ports
                    echo
                    read -p '是否以ASCII格式显示(y or yes)：' choose
                    echo
                    if [[ "$choose" == "y" || "$choose" == "yes" ]]
                    then
                        sudo tcpdump -i "$eths" port "$ports" -A
                        echo
                    fi
                    echo
                    sudo tcpdump -i "$eths" port "$ports"
                    echo
                    echo
                    echo -e "$green==========================TCP/UDP-Package========================="
                elif [ "$chooseTU" == "0" ]
                then
                    echo '欢迎下次使用！'
                    echo
                    break
                else
                    echo '你的输入有误！请输入0、1、2、3'
                    echo
                fi
                echo
                echo -e "$green===========================Package============================"
            done
        ;;
        "2")
            while true
            do
                echo -e "$yellow==================================Package=================================="
                echo
                echo -e "$red【0】退出 $green【1】抓取数据包并保存到本地文件(pcap文件)"
                echo
                read -p '请输入你的选择【0】【1】：' chooseTU
                echo
                if [ "$chooseTU" == "1" ]
                then
                    echo -e "$yellow==========================TCP/UDP-Package========================="
                    echo
                    read -p '是否查看你的接口(y or yes)：' choose
                    echo
                    if [[ "$choose" == y || "$choose" == "yes" ]]
                    then
                        ip a | more || ifconfig | more
                        echo
                    fi
                    read -p '请输入你的接口：' eths
                    echo
                    read -p '请输入你的指定网络IP/IP段(如192.168.X.X/X)：' IPS
                    echo
                    read -p '是否修改输出后的文件名称(默认network_traffic.pcap)(y or yes)：' choose
                    echo
                    if [[ "$choose" == "y" || "$choose" == "yes" ]]
                    then
                        read -p '请输入输出后的文件名称(xxx.pacp)：' pcaps
                        echo
                        echo '修改成功！！！'
                        echo
                        echo 'Start抓包......'
                        echo
                        sudo tcpdump -i "$eths" net "$IPS" -w "$pcaps"
                        echo
                    fi
                    echo
                    sudo tcpdump -i "$eths" net "$IPS" -w network_traffic.pcap
                    echo
                    echo -e "$yellow==========================TCP/UDP-Package========================="
                elif [ "$chooseTU" == "0" ]
                then
                    echo '欢迎下次使用！'
                    echo
                    break
                else
                    echo '你的输入有误！请输入0、1'
                    echo
                fi
                echo
                echo -e "$yellow=================================Package=================================="
            done
        ;;
        "3")
            while true
            do
                echo -e "$yellow==================================Package=================================="
                echo
                echo '【0】退出 【1】抓仅显示源地址和目标地址为指定IP的数据包'
                echo
                read -p '请输入你的选择【0】【1】：' chooseTU
                echo
                if [ "$chooseTU" == "1" ]
                then
                    echo -e "$yellow==========================TCP/UDP-Package========================="
                    echo
                    read -p '是否查看你的接口(y or yes)：' choose
                    echo
                    if [[ "$choose" == y || "$choose" == "yes" ]]
                    then
                        ip a | more || ifconfig | more
                        echo
                    fi
                    read -p '请输入你的接口：' eths
                    echo
                    read -p '请输入你的源IP(如192.168.X.X)：' srcIP
                    echo
                    read -p '请输入你的目的IP(如192.168.X.X)：' dstIP
                    echo
                    echo 'Start抓包......'
                    echo
                    sudo tcpdump -i "$eths" src "$srcIP" and dst "$dstIP"
                    echo
                    echo -e "$yellow==========================TCP/UDP-Package========================="
                elif [ "$chooseTU" == "0" ]
                then
                    echo '欢迎下次使用！'
                    echo
                    break
                else
                    echo '你的输入有误！请输入0、1'
                    echo
                fi
                echo
                echo -e "$yellow=================================Package=================================="
            done
        ;;
        "4")
            while true
            do
                echo -e "$yellow==================================Package=================================="
                echo
                echo '【0】退出 【1】抓所有传入或传出的HTTP请求和响应数据包'
                echo
                read -p '请输入你的选择【0】【1】：' chooseTU
                echo
                if [ "$chooseTU" == "1" ]
                then
                    echo -e "$yellow==========================TCP/UDP-Package========================="
                    echo
                    read -p '是否查看你的接口(y or yes)：' choose
                    echo
                    if [[ "$choose" == y || "$choose" == "yes" ]]
                    then
                        ip a | more || ifconfig | more
                        echo
                    fi
                    read -p '请输入你的接口：' eths
                    echo
                    echo 'Start抓包......'
                    echo
                    sudo tcpdump -i "$eths" -A 'tcp[((tcp[12:1] & 0xf0) >> 2):4] = 0x47455420 or tcp[((tcp[12:1] & 0xf0) >> 2):4] = 0x48545450'
                    echo
                    echo -e "$yellow==========================TCP/UDP-Package========================="
                elif [ "$chooseTU" == "0" ]
                then
                    echo '欢迎下次使用！'
                    echo
                    break
                else
                    echo '你的输入有误！请输入0、1'
                    echo
                fi
                echo
                echo -e "$yellow=================================Package=================================="
            done
        ;;
        "5")
            while true
            do
                echo -e "$yellow==================================Package=================================="
                echo
                echo '【0】退出 【1】捕获并显示指定数量的数据包'
                echo
                read -p '请输入你的选择【0】【1】：' chooseTU
                echo
                if [ "$chooseTU" == "1" ]
                then
                    echo -e "$yellow==========================TCP/UDP-Package========================="
                    echo
                    read -p '是否查看你的接口(y or yes)：' choose
                    echo
                    if [[ "$choose" == y || "$choose" == "yes" ]]
                    then
                        ip a | more || ifconfig | more
                        echo
                    fi
                    read -p '请输入你的接口：' eths
                    echo
                    read -p '请输入抓取的数据包数量：' countNum
                    echo
                    echo 'Start抓包......'
                    echo
                    sudo tcpdump -i "$eths" -c "$countNum"
                    echo
                    echo -e "$yellow==========================TCP/UDP-Package========================="
                elif [ "$chooseTU" == "0" ]
                then
                    echo '欢迎下次使用！'
                    echo
                    break
                else
                    echo '你的输入有误！请输入0、1'
                    echo
                fi
                echo
                echo -e "$yellow=================================Package=================================="
            done
        ;;
        "0")
            echo '欢迎下次使用！'
            echo
            break
        ;;
        *)
            echo -e "$red你的输入有误！请输入0、1、2、3、4、5、8"
            echo
        ;;
        esac
        echo
        echo -e "$yellow===============================CapturePackets============================"
    done
}

function IPINFO()
{
    while true
    do
        echo -e "$yellow=================================||IP-INFO||=================================="
        echo
        echo -e "$green【1】查询本机国内公网IP(显示IP) 【2】查询本机国内公网IP(详细IP信息)"
        echo -e "$green【3】查询本机海外公网IP(显示IP) 【4】查询本机海外公网IP(详细IP信息)"
        echo
        echo -e "$red--------------------------|||【0】退出IP-INFO板块|||-------------------------"
        echo
        echo -e "$yellow=================================||IP-INFO||=================================="
        echo
        read -p '请输入你的选择【0】【1】【2】【3】【4】：' choose
        echo
        case $choose in
        "1")
            echo -e "$yellow=======================||CN-IP-INFO-Simple||========================="
            echo 
            curl myip.ipip.net || curl ipinfo.io
            echo
            echo -e "$yellow=======================||CN-IP-INFO-Simple||========================="
        ;;
        "2")
            echo -e "$yellow=======================||CN-IP-INFO||========================="
            echo 
            curl cip.cc || curl ipinfo.io
            echo
            echo -e "$yellow=======================||CN-IP-INFO||========================="
        ;;
        "3")
            echo -e "$yellow=======================||Abroad-IP-INFO-Simple||========================="
            echo 
            curl ifconfig.me || curl ipinfo.io
            echo
            echo -e "$yellow=======================||Abroad-IP-INFO-Simple||========================="
        ;;
        "4")
            echo -e "$yellow=======================||Abroad-IP-INFO||========================="
            echo 
            curl 
            curl ipinfo.io || curl cip.cc
            echo
            echo -e "$yellow=======================||Abroad-IP-INFO||========================="
        ;;
        "0")
            echo '欢迎下次使用！'
            echo
            break
        ;;
        *)
            echo -e "$red你的输入有误！请输入0、1、2、3、4"
            echo
        ;;
        esac
        echo
        echo -e "$yellow=================================||IP-INFO||=================================="
    done
}


function WireGuard()
{
while true
do
    echo -e "$yellow=============================wireguard================================"
    echo
    echo -e "$red【0】退出wireguard板块 $green【1】进入安装配置板块"
    echo
    echo -e "$yellow=============================wireguard================================"
    echo 
    read -p '请输入你的选择【0】【1】：' choose
    echo
    if [ "$choose" == "0" ]
    then
        echo '欢迎下次使用！'
        echo 
        break
    elif [ "$choose" == "1" ]
    then
        echo
# https://github.com/Nyr/wireguard-install
#
# Copyright (c) 2020 Nyr. Released under the MIT License.

# Detect Debian users running the script with "sh" instead of bash
if readlink /proc/$$/exe | grep -q "dash"; then
	echo '安装程序需要使用"bash"而不是"sh"运行!!!'
fi

# Discard stdin. Needed when running from an one-liner which includes a newline
# shellcheck disable=SC2162
read -N 999999 -t 0.001

# Detect OS
# $os_version variables aren't always in use, but are kept here for convenience
if grep -qs "ubuntu" /etc/os-release; then
	os="ubuntu"
	os_version=$(grep 'VERSION_ID' /etc/os-release | cut -d '"' -f 2 | tr -d '.')
elif [[ -e /etc/debian_version ]]; then
	os="debian"
	os_version=$(grep -oE '[0-9]+' /etc/debian_version | head -1)
elif [[ -e /etc/almalinux-release || -e /etc/rocky-release || -e /etc/centos-release ]]; then
	os="centos"
	os_version=$(grep -shoE '[0-9]+' /etc/almalinux-release /etc/rocky-release /etc/centos-release | head -1)
elif [[ -e /etc/fedora-release ]]; then
	os="fedora"
	os_version=$(grep -oE '[0-9]+' /etc/fedora-release | head -1)
else
	echo
	echo '此安装程序似乎正在不受支持的发行版上运行!支持的发行版有Ubuntu、Debian、AlmaLinux、Rocky Linux、CentOS和Fedora'
	echo
fi

if [[ "$os" == "ubuntu" && "$os_version" -lt 2204 ]]; then
	echo
	echo '使用此安装程序需要Ubuntu 22.04或更高版本，此版本的Ubuntu太旧，不受支持！'
	echo
	exit
fi

if [[ "$os" == "debian" ]]; then
	if grep -q '/sid' /etc/debian_version; then
		echo
		echo '此安装程序不支持Debian测试和Debian不稳定'
		echo
	fi
	if [[ "$os_version" -lt 11 ]]; then
		echo
		echo '使用此安装程序需要Debian 11或更高版本,此版本的Debian太旧，不受支持!'
		echo
	fi
fi

if [[ "$os" == "centos" && "$os_version" -lt 9 ]]; then
	os_name=$(sed 's/ release.*//' /etc/almalinux-release /etc/rocky-release /etc/centos-release 2>/dev/null | head -1)
	echo "$os_name 使用此安装程序需要centos9或更高版本.
此版本的 $os_name 太旧不受支持！"
fi

# Detect environments where $PATH does not include the sbin directories
if ! grep -q sbin <<< "$PATH"; then
	# shellcheck disable=SC2016
	echo '$PATH 不包括sbin,请尝试使用"su-"而不是"su".'
fi

# Detect if BoringTun (userspace WireGuard) needs to be used
if ! systemd-detect-virt -cq; then
	# Not running inside a container
	use_boringtun="0"
elif grep -q '^wireguard ' /proc/modules; then
	# Running inside a container, but the wireguard kernel module is available
	use_boringtun="0"
else
	# Running inside a container and the wireguard kernel module is not available
	use_boringtun="1"
fi

if [[ "$EUID" -ne 0 ]]; then
	echo '此安装程序需要以超级用户权限运行！'
fi

if [[ "$use_boringtun" -eq 1 ]]; then
	if [ "$(uname -m)" != "x86_64" ]; then
		echo
		echo "在没有wireguard内核模块的容器化系统中，此安装程序仅支持x86_64架构,系统运行在 $(uname -m) 并且不受支持!"
		echo
	fi
	# TUN device is required to use BoringTun
	if [[ ! -e /dev/net/tun ]] || ! ( exec 7<>/dev/net/tun ) 2>/dev/null; then
		echo
		echo "系统没有可用的TUN设备,运行此安装程序之前需要启用TUN。"
		echo
	fi
fi

new_client_dns () {
	echo "为客户端选择DNS服务器:"
	echo "   1) 当前系统解析器"
	echo "   2) Google"
	echo "   3) 1.1.1.1"
	echo "   4) OpenDNS"
	echo "   5) Quad9"
	echo "   6) AdGuard"
	# shellcheck disable=SC2162
	read -p "请输入你的选择 [1]: " dns
	echo
	until [[ -z "$dns" || "$dns" =~ ^[1-6]$ ]]; do
		echo "$dns: 你的输入有误！请输入1、2、3、4、5、6"
		echo
		# shellcheck disable=SC2162
		read -p "请重新输入你的选择 [1]: " dns
		echo
	done
		# DNS
	case "$dns" in
		1|"")
			# Locate the proper resolv.conf
			# Needed for systems running systemd-resolved
			if grep '^nameserver' "/etc/resolv.conf" | grep -qv '127.0.0.53' ; then
				resolv_conf="/etc/resolv.conf"
			else
				resolv_conf="/run/systemd/resolve/resolv.conf"
			fi
			# Extract nameservers and provide them in the required format
			dns=$(grep -v '^#\|^;' "$resolv_conf" | grep '^nameserver' | grep -v '127.0.0.53' | grep -oE '[0-9]{1,3}(\.[0-9]{1,3}){3}' | xargs | sed -e 's/ /, /g')
		;;
		2)
			dns="8.8.8.8, 8.8.4.4"
		;;
		3)
			dns="1.1.1.1, 1.0.0.1"
		;;
		4)
			dns="208.67.222.222, 208.67.220.220"
		;;
		5)
			dns="9.9.9.9, 149.112.112.112"
		;;
		6)
			dns="94.140.14.14, 94.140.15.15"
		;;
	esac
}

new_client_setup () {
	# Given a list of the assigned internal IPv4 addresses, obtain the lowest still
	# available octet. Important to start looking at 2, because 1 is our gateway.
	octet=2
	while grep AllowedIPs /etc/wireguard/wg0.conf | cut -d "." -f 4 | cut -d "/" -f 1 | grep -q "^$octet$"; do
		(( octet++ ))
	done
	# Don't break the WireGuard configuration in case the address space is full
	if [[ "$octet" -eq 255 ]]; then
		echo "已配置253个客户端,WireGuard内部子网已满！"
        echo
	fi
	key=$(wg genkey)
	psk=$(wg genpsk)
	# Configure client in the server
	# shellcheck disable=SC2094
	cat << EOF >> /etc/wireguard/wg0.conf
# BEGIN_PEER $client
[Peer]
PublicKey = $(wg pubkey <<< "$key")
PresharedKey = $psk
AllowedIPs = 10.7.0.$octet/32$(grep -q 'fddd:2c4:2c4:2c4::1' /etc/wireguard/wg0.conf && echo ", fddd:2c4:2c4:2c4::$octet/128")
# END_PEER $client
EOF
	# Create client configuration
	cat << EOF > ~/"$client".conf
[Interface]
Address = 10.7.0.$octet/24$(grep -q 'fddd:2c4:2c4:2c4::1' /etc/wireguard/wg0.conf && echo ", fddd:2c4:2c4:2c4::$octet/64")
DNS = $dns
PrivateKey = $key

[Peer]
PublicKey = $(grep PrivateKey /etc/wireguard/wg0.conf | cut -d " " -f 3 | wg pubkey)
PresharedKey = $psk
AllowedIPs = 0.0.0.0/0, ::/0
Endpoint = $(grep '^# ENDPOINT' /etc/wireguard/wg0.conf | cut -d " " -f 3):$(grep ListenPort /etc/wireguard/wg0.conf | cut -d " " -f 3)
PersistentKeepalive = 25
EOF
}

if [[ ! -e /etc/wireguard/wg0.conf ]]; then
	# Detect some Debian minimal setups where neither wget nor curl are installed
	if ! hash wget 2>/dev/null && ! hash curl 2>/dev/null; then
		echo
		echo "使用此安装程序需要Wget!"
		echo
		read -n1 -r -p "按任意键安装Wget并继续..."
		echo
		apt-get update
		apt-get install -y wget
	fi
	clear
	echo '欢迎来到WireGuard安装程序！'
	echo
	# If system has a single IPv4, it is selected automatically. Else, ask the user
	if [[ $(ip -4 addr | grep inet | grep -vEc '127(\.[0-9]{1,3}){3}') -eq 1 ]]; then
		ip=$(ip -4 addr | grep inet | grep -vE '127(\.[0-9]{1,3}){3}' | cut -d '/' -f 1 | grep -oE '[0-9]{1,3}(\.[0-9]{1,3}){3}')
	else
		number_of_ip=$(ip -4 addr | grep inet | grep -vEc '127(\.[0-9]{1,3}){3}')
		echo
		echo "你要使用哪个IPv4地址？"
		echo
		ip -4 addr | grep inet | grep -vE '127(\.[0-9]{1,3}){3}' | cut -d '/' -f 1 | grep -oE '[0-9]{1,3}(\.[0-9]{1,3}){3}' | nl -s ') '
		echo
		# shellcheck disable=SC2162
		read -p "请输入你本地的IP地址 [1]: " ip_number
		echo
		until [[ -z "$ip_number" || "$ip_number" =~ ^[0-9]+$ && "$ip_number" -le "$number_of_ip" ]]; do
			echo "$ip_number: 你输入的IP地址无效！"
			echo
			# shellcheck disable=SC2162
			read -p "请重新输入你本地的IP地址 [1]: " ip_number
			echo
		done
		[[ -z "$ip_number" ]] && ip_number="1"
		ip=$(ip -4 addr | grep inet | grep -vE '127(\.[0-9]{1,3}){3}' | cut -d '/' -f 1 | grep -oE '[0-9]{1,3}(\.[0-9]{1,3}){3}' | sed -n "$ip_number"p)
	fi
	# If $ip is a private IP address, the server must be behind NAT
	if echo "$ip" | grep -qE '^(10\.|172\.1[6789]\.|172\.2[0-9]\.|172\.3[01]\.|192\.168)'; then
		echo
		echo "此服务器位于NAT之后,你的公共IPv4地址或主机名是什么？"
		echo
		# Get public IP and sanitize with grep
		get_public_ip=$(grep -m 1 -oE '^[0-9]{1,3}(\.[0-9]{1,3}){3}$' <<< "$(wget -T 10 -t 1 -4qO- "http://ip1.dynupdate.no-ip.com/" || curl -m 10 -4Ls "http://ip1.dynupdate.no-ip.com/")")
		echo
		# shellcheck disable=SC2162
		read -p "你的公网IP地址 OR 主机HOSTNAME [$get_public_ip]: " public_ip
		echo
		# If the checkip service is unavailable and user didn't provide input, ask again
		until [[ -n "$get_public_ip" || -n "$public_ip" ]]; do
			echo
			echo "输入无效！"
			echo
			# shellcheck disable=SC2162
			read -p "请重新输入你的公网IP地址 OR 主机HOSTNAME: " public_ip
			echo
		done
		[[ -z "$public_ip" ]] && public_ip="$get_public_ip"
	fi
	# If system has a single IPv6, it is selected automatically
	if [[ $(ip -6 addr | grep -c 'inet6 [23]') -eq 1 ]]; then
		ip6=$(ip -6 addr | grep 'inet6 [23]' | cut -d '/' -f 1 | grep -oE '([0-9a-fA-F]{0,4}:){1,7}[0-9a-fA-F]{0,4}')
	fi
	# If system has multiple IPv6, ask the user to select one
	if [[ $(ip -6 addr | grep -c 'inet6 [23]') -gt 1 ]]; then
		number_of_ip6=$(ip -6 addr | grep -c 'inet6 [23]')
		echo
		echo "需要使用哪个IPv6地址？"
		echo
		ip -6 addr | grep 'inet6 [23]' | cut -d '/' -f 1 | grep -oE '([0-9a-fA-F]{0,4}:){1,7}[0-9a-fA-F]{0,4}' | nl -s ') '
		echo
		# shellcheck disable=SC2162
		read -p "请输入你的IPV6地址 [1]: " ip6_number
		echo
		until [[ -z "$ip6_number" || "$ip6_number" =~ ^[0-9]+$ && "$ip6_number" -le "$number_of_ip6" ]]; do
			echo "$ip6_number: 输入地址无效！"
			echo
			# shellcheck disable=SC2162
			read -p "请重新输入你本地的IPV6地址 [1]: " ip6_number
		done
		[[ -z "$ip6_number" ]] && ip6_number="1"
		ip6=$(ip -6 addr | grep 'inet6 [23]' | cut -d '/' -f 1 | grep -oE '([0-9a-fA-F]{0,4}:){1,7}[0-9a-fA-F]{0,4}' | sed -n "$ip6_number"p)
	fi
	echo
	echo "你的WireGuard需要监听哪个端口？"
	echo
	read -p "请输入你wireguard监听的端口号 [51820]: " port
	echo
	until [[ -z "$port" || "$port" =~ ^[0-9]+$ && "$port" -le 65535 ]]; do
		echo "$port: 输入的端口无效！"
		echo
		# shellcheck disable=SC2162
		read -p "请重新输入你wireguard监听的端口号 [51820]: " port
		echo
	done
	[[ -z "$port" ]] && port="51820"
	echo
	echo "输入你第一个客户端的名称:"
	echo
	# shellcheck disable=SC2162
	read -p "客户端名称 [client]: " unsanitized_client
	echo
	# Allow a limited lenght and set of characters to avoid conflicts
	# shellcheck disable=SC2001
	client=$(sed 's/[^0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-]/_/g' <<< "$unsanitized_client" | cut -c-15)
	[[ -z "$client" ]] && client="client"
	echo
	new_client_dns
	# Set up automatic updates for BoringTun if the user is fine with that
	if [[ "$use_boringtun" -eq 1 ]]; then
		echo
		echo "将安装BoringTun以在系统中设置WireGuard......"
		echo
		# shellcheck disable=SC2162
		read -p "是否让BoringTun启用自动更新？ [Y/n]: " boringtun_updates
		echo
		until [[ "$boringtun_updates" =~ ^[yYnN]*$ ]]; do
			echo "$remove: 你的输入无效！"
			# shellcheck disable=SC2162
			read -p "是否让BoringTun启用自动更新？ [Y/n]: " boringtun_updates
			echo
		done
		[[ -z "$boringtun_updates" ]] && boringtun_updates="y"
		if [[ "$boringtun_updates" =~ ^[yY]$ ]]; then
			if [[ "$os" == "centos" || "$os" == "fedora" ]]; then
				cron="cronie"
			elif [[ "$os" == "debian" || "$os" == "ubuntu" ]]; then
				cron="cron"
			fi
		fi
	fi
	echo
	echo "WireGuard安装已准备就绪!"
	echo
	# Install a firewall if firewalld or iptables are not already available
	if ! systemctl is-active --quiet firewalld.service && ! hash iptables 2>/dev/null; then
		if [[ "$os" == "centos" || "$os" == "fedora" ]]; then
			firewall="firewalld"
			# We don't want to silently enable firewalld, so we give a subtle warning
			# If the user continues, firewalld will be installed and enabled during setup
			echo "firewalld, which is required to manage routing tables, will also be installed."
		elif [[ "$os" == "debian" || "$os" == "ubuntu" ]]; then
			# iptables is way less invasive than firewalld so no warning is given
			firewall="iptables"
		fi
	fi
	read -n1 -r -p "按任意键继续..."
	echo
	# Install WireGuard
	# If BoringTun is not required, set up with the WireGuard kernel module
	if [[ "$use_boringtun" -eq 0 ]]; then
		if [[ "$os" == "ubuntu" ]]; then
			# Ubuntu
			apt-get update
			apt-get install -y wireguard qrencode "$firewall"
		elif [[ "$os" == "debian" ]]; then
			# Debian
			apt-get update
			apt-get install -y wireguard qrencode "$firewall"
		elif [[ "$os" == "centos" ]]; then
			# CentOS
			dnf install -y epel-release
			dnf install -y wireguard-tools qrencode "$firewall"
		elif [[ "$os" == "fedora" ]]; then
			# Fedora
			dnf install -y wireguard-tools qrencode "$firewall"
			mkdir -p /etc/wireguard/
		fi
	# Else, BoringTun needs to be used
	else
		# Install required packages
		if [[ "$os" == "ubuntu" ]]; then
			# Ubuntu
			apt-get update
			apt-get install -y qrencode ca-certificates "$cron" "$firewall"
			apt-get install -y wireguard-tools --no-install-recommends
		elif [[ "$os" == "debian" ]]; then
			# Debian
			apt-get update
			apt-get install -y qrencode ca-certificates "$cron" "$firewall"
			apt-get install -y wireguard-tools --no-install-recommends
		elif [[ "$os" == "centos" ]]; then
			# CentOS
			dnf install -y epel-release
			dnf install -y wireguard-tools qrencode ca-certificates tar "$cron" "$firewall"
		elif [[ "$os" == "fedora" ]]; then
			# Fedora
			dnf install -y wireguard-tools qrencode ca-certificates tar "$cron" "$firewall"
			mkdir -p /etc/wireguard/
		fi
		# Grab the BoringTun binary using wget or curl and extract into the right place.
		# Don't use this service elsewhere without permission! Contact me before you do!
		{ wget -qO- https://wg.nyr.be/1/latest/download 2>/dev/null || curl -sL https://wg.nyr.be/1/latest/download ; } | tar xz -C /usr/local/sbin/ --wildcards 'boringtun-*/boringtun' --strip-components 1
		# Configure wg-quick to use BoringTun
		mkdir /etc/systemd/system/wg-quick@wg0.service.d/ 2>/dev/null
		echo "[Service]
Environment=WG_QUICK_USERSPACE_IMPLEMENTATION=boringtun
Environment=WG_SUDO=1" > /etc/systemd/system/wg-quick@wg0.service.d/boringtun.conf
		if [[ -n "$cron" ]] && [[ "$os" == "centos" || "$os" == "fedora" ]]; then
			systemctl enable --now crond.service
		fi
	fi
	# If firewalld was just installed, enable it
	if [[ "$firewall" == "firewalld" ]]; then
		systemctl enable --now firewalld.service
	fi
	# Generate wg0.conf
	cat << EOF > /etc/wireguard/wg0.conf
# Do not alter the commented lines
# They are used by wireguard-install
# ENDPOINT $([[ -n "$public_ip" ]] && echo "$public_ip" || echo "$ip")

[Interface]
Address = 10.7.0.1/24$([[ -n "$ip6" ]] && echo ", fddd:2c4:2c4:2c4::1/64")
PrivateKey = $(wg genkey)
ListenPort = $port

EOF
	chmod 600 /etc/wireguard/wg0.conf
	# Enable net.ipv4.ip_forward for the system
	echo 'net.ipv4.ip_forward=1' > /etc/sysctl.d/99-wireguard-forward.conf
	# Enable without waiting for a reboot or service restart
	echo 1 > /proc/sys/net/ipv4/ip_forward
	if [[ -n "$ip6" ]]; then
		# Enable net.ipv6.conf.all.forwarding for the system
		echo "net.ipv6.conf.all.forwarding=1" >> /etc/sysctl.d/99-wireguard-forward.conf
		# Enable without waiting for a reboot or service restart
		echo 1 > /proc/sys/net/ipv6/conf/all/forwarding
	fi
	if systemctl is-active --quiet firewalld.service; then
		# Using both permanent and not permanent rules to avoid a firewalld
		# reload.
		firewall-cmd --add-port="$port"/udp
		firewall-cmd --zone=trusted --add-source=10.7.0.0/24
		firewall-cmd --permanent --add-port="$port"/udp
		firewall-cmd --permanent --zone=trusted --add-source=10.7.0.0/24
		# Set NAT for the VPN subnet
		firewall-cmd --direct --add-rule ipv4 nat POSTROUTING 0 -s 10.7.0.0/24 ! -d 10.7.0.0/24 -j SNAT --to "$ip"
		firewall-cmd --permanent --direct --add-rule ipv4 nat POSTROUTING 0 -s 10.7.0.0/24 ! -d 10.7.0.0/24 -j SNAT --to "$ip"
		if [[ -n "$ip6" ]]; then
			firewall-cmd --zone=trusted --add-source=fddd:2c4:2c4:2c4::/64
			firewall-cmd --permanent --zone=trusted --add-source=fddd:2c4:2c4:2c4::/64
			firewall-cmd --direct --add-rule ipv6 nat POSTROUTING 0 -s fddd:2c4:2c4:2c4::/64 ! -d fddd:2c4:2c4:2c4::/64 -j SNAT --to "$ip6"
			firewall-cmd --permanent --direct --add-rule ipv6 nat POSTROUTING 0 -s fddd:2c4:2c4:2c4::/64 ! -d fddd:2c4:2c4:2c4::/64 -j SNAT --to "$ip6"
		fi
	else
		# Create a service to set up persistent iptables rules
		iptables_path=$(command -v iptables)
		ip6tables_path=$(command -v ip6tables)
		# nf_tables is not available as standard in OVZ kernels. So use iptables-legacy
		# if we are in OVZ, with a nf_tables backend and iptables-legacy is available.
		if [[ $(systemd-detect-virt) == "openvz" ]] && readlink -f "$(command -v iptables)" | grep -q "nft" && hash iptables-legacy 2>/dev/null; then
			iptables_path=$(command -v iptables-legacy)
			ip6tables_path=$(command -v ip6tables-legacy)
		fi
		echo "[Unit]
Before=network.target
[Service]
Type=oneshot
ExecStart=$iptables_path -t nat -A POSTROUTING -s 10.7.0.0/24 ! -d 10.7.0.0/24 -j SNAT --to $ip
ExecStart=$iptables_path -I INPUT -p udp --dport $port -j ACCEPT
ExecStart=$iptables_path -I FORWARD -s 10.7.0.0/24 -j ACCEPT
ExecStart=$iptables_path -I FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
ExecStop=$iptables_path -t nat -D POSTROUTING -s 10.7.0.0/24 ! -d 10.7.0.0/24 -j SNAT --to $ip
ExecStop=$iptables_path -D INPUT -p udp --dport $port -j ACCEPT
ExecStop=$iptables_path -D FORWARD -s 10.7.0.0/24 -j ACCEPT
ExecStop=$iptables_path -D FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT" > /etc/systemd/system/wg-iptables.service
		if [[ -n "$ip6" ]]; then
			echo "ExecStart=$ip6tables_path -t nat -A POSTROUTING -s fddd:2c4:2c4:2c4::/64 ! -d fddd:2c4:2c4:2c4::/64 -j SNAT --to $ip6
ExecStart=$ip6tables_path -I FORWARD -s fddd:2c4:2c4:2c4::/64 -j ACCEPT
ExecStart=$ip6tables_path -I FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
ExecStop=$ip6tables_path -t nat -D POSTROUTING -s fddd:2c4:2c4:2c4::/64 ! -d fddd:2c4:2c4:2c4::/64 -j SNAT --to $ip6
ExecStop=$ip6tables_path -D FORWARD -s fddd:2c4:2c4:2c4::/64 -j ACCEPT
ExecStop=$ip6tables_path -D FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT" >> /etc/systemd/system/wg-iptables.service
		fi
		echo "RemainAfterExit=yes
[Install]
WantedBy=multi-user.target" >> /etc/systemd/system/wg-iptables.service
		systemctl enable --now wg-iptables.service
	fi
	# Generates the custom client.conf
	new_client_setup
	# Enable and start the wg-quick service
	systemctl enable --now wg-quick@wg0.service
	# Set up automatic updates for BoringTun if the user wanted to
	if [[ "$boringtun_updates" =~ ^[yY]$ ]]; then
		# Deploy upgrade script
		cat << 'EOF' > /usr/local/sbin/boringtun-upgrade
#!/bin/bash
latest=$(wget -qO- https://wg.nyr.be/1/latest 2>/dev/null || curl -sL https://wg.nyr.be/1/latest 2>/dev/null)
# If server did not provide an appropriate response, exit
if ! head -1 <<< "$latest" | grep -qiE "^boringtun.+[0-9]+\.[0-9]+.*$"; then
	echo "更新服务器不可用!"
fi
current=$(/usr/local/sbin/boringtun -V)
if [[ "$current" != "$latest" ]]; then
	download="https://wg.nyr.be/1/latest/download"
	xdir=$(mktemp -d)
	# If download and extraction are successful, upgrade the boringtun binary
	if { wget -qO- "$download" 2>/dev/null || curl -sL "$download" ; } | tar xz -C "$xdir" --wildcards "boringtun-*/boringtun" --strip-components 1; then
		systemctl stop wg-quick@wg0.service
		rm -f /usr/local/sbin/boringtun
		mv "$xdir"/boringtun /usr/local/sbin/boringtun
		systemctl start wg-quick@wg0.service
		echo "Succesfully updated to $(/usr/local/sbin/boringtun -V)"
	else
		echo "boringtun update failed"
	fi
	rm -rf "$xdir"
else
	echo "$current is up to date"
fi
EOF
		chmod +x /usr/local/sbin/boringtun-upgrade
		# Add cron job to run the updater daily at a random time between 3:00 and 5:59
		# shellcheck disable=SC2004
		{ crontab -l 2>/dev/null; echo "$(( $RANDOM % 60 )) $(( $RANDOM % 3 + 3 )) * * * /usr/local/sbin/boringtun-upgrade &>/dev/null" ; } | crontab -
	fi
	echo
	qrencode -t ANSI256UTF8 < ~/"$client.conf"
	echo -e '\xE2\x86\x91 这是一个包含客户端配置的二维码！'
	echo
	echo "完成!"
	echo
	echo "客户端配置在中可用:" ~/"$client.conf"
	echo
	echo "再次运行此脚本可以添加新客户端！"
	echo
else
	clear
	echo "WireGuard已安装!"
	echo
	echo "选择一个选项:"
	echo "   1) 添加新客户端"
	echo "   2) 删除现有客户端"
	echo "   3) 删除WireGuard"
	echo "   4) 退出"
	# shellcheck disable=SC2162
	read -p "请输入你的选择: " option
	until [[ "$option" =~ ^[1-4]$ ]]; do
		echo "$option: 你的选择无效！"
		echo
		# shellcheck disable=SC2162
		read -p "请重新输入你的选择: " option
		echo
	done
	case "$option" in
		1)
			echo
			echo "客户名称:"
			echo
			# shellcheck disable=SC2162
			read -p "请输入客户名称: " unsanitized_client
			echo
			# Allow a limited lenght and set of characters to avoid conflicts
			# shellcheck disable=SC2001
			client=$(sed 's/[^0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-]/_/g' <<< "$unsanitized_client" | cut -c-15)
			while [[ -z "$client" ]] || grep -q "^# BEGIN_PEER $client$" /etc/wireguard/wg0.conf; do
				echo "$client: invalid name."
				# shellcheck disable=SC2162
				read -p "请重新输入客户名称: " unsanitized_client
				echo
				# shellcheck disable=SC2001
				client=$(sed 's/[^0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-]/_/g' <<< "$unsanitized_client" | cut -c-15)
			done
			echo
			new_client_dns
			new_client_setup
			# Append new client configuration to the WireGuard interface
			wg addconf wg0 <(sed -n "/^# BEGIN_PEER $client/,/^# END_PEER $client/p" /etc/wireguard/wg0.conf)
			echo
			qrencode -t ANSI256UTF8 < ~/"$client.conf"
			echo -e '\xE2\x86\x91 That is a QR code containing your client configuration.'
			echo
			echo "$client added. Configuration available in:" ~/"$client.conf"
		;;
		2)
			# This option could be documented a bit better and maybe even be simplified
			# ...but what can I say, I want some sleep too
			number_of_clients=$(grep -c '^# BEGIN_PEER' /etc/wireguard/wg0.conf)
			if [[ "$number_of_clients" = 0 ]]; then
				echo
				echo "没有找到现有客户！"
			fi
			echo
			echo "选择要删除的客户端："
			echo
			grep '^# BEGIN_PEER' /etc/wireguard/wg0.conf | cut -d ' ' -f 3 | nl -s ') '
			echo
			# shellcheck disable=SC2162
			read -p "Client: " client_number
			echo
			until [[ "$client_number" =~ ^[0-9]+$ && "$client_number" -le "$number_of_clients" ]]; do
				echo "$client_number: 输入无效"
				echo
				# shellcheck disable=SC2162
				read -p "请重新输入Client: " client_number
			done
			client=$(grep '^# BEGIN_PEER' /etc/wireguard/wg0.conf | cut -d ' ' -f 3 | sed -n "$client_number"p)
			echo
			read -p "Confirm $client removal? [y/N]: " remove
			until [[ "$remove" =~ ^[yYnN]*$ ]]; do
				echo "$remove: invalid selection."
				# shellcheck disable=SC2162
				read -p "确认 $client 删除? [y/N]: " remove
				echo
			done
			if [[ "$remove" =~ ^[yY]$ ]]; then
				# The following is the right way to avoid disrupting other active connections:
				# Remove from the live interface
				wg set wg0 peer "$(sed -n "/^# BEGIN_PEER $client$/,\$p" /etc/wireguard/wg0.conf | grep -m 1 PublicKey | cut -d " " -f 3)" remove
				# Remove from the configuration file
				sed -i "/^# BEGIN_PEER $client$/,/^# END_PEER $client$/d" /etc/wireguard/wg0.conf
				echo
				echo "$client removed!"
			else
				echo
				echo "$client removal 中止!"
			fi
		;;
		3)
			echo
			# shellcheck disable=SC2162
			read -p "确认移除WireGuard? [y/N]: " remove
			echo
			until [[ "$remove" =~ ^[yYnN]*$ ]]; do
				echo "$remove: 输入无效！"
				echo
				# shellcheck disable=SC2162
				read -p "确认移除WireGuard? [y/N]: " remove
				echo
			done
			if [[ "$remove" =~ ^[yY]$ ]]; then
				port=$(grep '^ListenPort' /etc/wireguard/wg0.conf | cut -d " " -f 3)
				if systemctl is-active --quiet firewalld.service; then
					ip=$(firewall-cmd --direct --get-rules ipv4 nat POSTROUTING | grep '\-s 10.7.0.0/24 '"'"'!'"'"' -d 10.7.0.0/24' | grep -oE '[^ ]+$')
					# Using both permanent and not permanent rules to avoid a firewalld reload.
					firewall-cmd --remove-port="$port"/udp
					firewall-cmd --zone=trusted --remove-source=10.7.0.0/24
					firewall-cmd --permanent --remove-port="$port"/udp
					firewall-cmd --permanent --zone=trusted --remove-source=10.7.0.0/24
					firewall-cmd --direct --remove-rule ipv4 nat POSTROUTING 0 -s 10.7.0.0/24 ! -d 10.7.0.0/24 -j SNAT --to "$ip"
					firewall-cmd --permanent --direct --remove-rule ipv4 nat POSTROUTING 0 -s 10.7.0.0/24 ! -d 10.7.0.0/24 -j SNAT --to "$ip"
					if grep -qs 'fddd:2c4:2c4:2c4::1/64' /etc/wireguard/wg0.conf; then
						ip6=$(firewall-cmd --direct --get-rules ipv6 nat POSTROUTING | grep '\-s fddd:2c4:2c4:2c4::/64 '"'"'!'"'"' -d fddd:2c4:2c4:2c4::/64' | grep -oE '[^ ]+$')
						firewall-cmd --zone=trusted --remove-source=fddd:2c4:2c4:2c4::/64
						firewall-cmd --permanent --zone=trusted --remove-source=fddd:2c4:2c4:2c4::/64
						firewall-cmd --direct --remove-rule ipv6 nat POSTROUTING 0 -s fddd:2c4:2c4:2c4::/64 ! -d fddd:2c4:2c4:2c4::/64 -j SNAT --to "$ip6"
						firewall-cmd --permanent --direct --remove-rule ipv6 nat POSTROUTING 0 -s fddd:2c4:2c4:2c4::/64 ! -d fddd:2c4:2c4:2c4::/64 -j SNAT --to "$ip6"
					fi
				else
					systemctl disable --now wg-iptables.service
					rm -f /etc/systemd/system/wg-iptables.service
				fi
				systemctl disable --now wg-quick@wg0.service
				rm -f /etc/systemd/system/wg-quick@wg0.service.d/boringtun.conf
				rm -f /etc/sysctl.d/99-wireguard-forward.conf
				# Different stuff was installed depending on whether BoringTun was used or not
				if [[ "$use_boringtun" -eq 0 ]]; then
					if [[ "$os" == "ubuntu" ]]; then
						# Ubuntu
						rm -rf /etc/wireguard/
						apt-get remove --purge -y wireguard wireguard-tools
					elif [[ "$os" == "debian" ]]; then
						# Debian
						rm -rf /etc/wireguard/
						apt-get remove --purge -y wireguard wireguard-tools
					elif [[ "$os" == "centos" ]]; then
						# CentOS
						dnf remove -y wireguard-tools
						rm -rf /etc/wireguard/
					elif [[ "$os" == "fedora" ]]; then
						# Fedora
						dnf remove -y wireguard-tools
						rm -rf /etc/wireguard/
					fi
				else
					{ crontab -l 2>/dev/null | grep -v '/usr/local/sbin/boringtun-upgrade' ; } | crontab -
					if [[ "$os" == "ubuntu" ]]; then
						# Ubuntu
						rm -rf /etc/wireguard/
						apt-get remove --purge -y wireguard-tools
					elif [[ "$os" == "debian" ]]; then
						# Debian
						rm -rf /etc/wireguard/
						apt-get remove --purge -y wireguard-tools
					elif [[ "$os" == "centos" ]]; then
						# CentOS
						dnf remove -y wireguard-tools
						rm -rf /etc/wireguard/
					elif [[ "$os" == "fedora" ]]; then
						# Fedora
						dnf remove -y wireguard-tools
						rm -rf /etc/wireguard/
					fi
					rm -f /usr/local/sbin/boringtun /usr/local/sbin/boringtun-upgrade
				fi
				echo
				echo "WireGuard removed!"
			else
				echo
				echo "WireGuard removal aborted!"
			fi
		;;
		4)
			break
		;;
	esac
fi    
    else
        echo '你的输入有误！请输入0、1'
        echo
    fi
done
}

function Xiao()
{   
    if [ $(whoami) != "root" ];then
        echo '请使用root权限执行脚本！'
        exit 1;
    fi
    loghome=/var/log/access.log
    datetime=$(date +"%F %T")
    access="ACCESS"
    noaccess="NO ACCESS"
    arr_name=(zhansan lisi wangwu zhaosi dadaguai)
    readonly loghome
    readonly access
    readonly noaccess
    readonly arr_name
    while read -p 'your name(输入0退出)：' names
    do
        echo
        echo "您输入的是：$names"
        echo
	    if [[ $names == ${arr_name[0]} || $names == ${arr_name[1]} || $names == ${arr_name[2]} || $names == ${arr_name[3]} || $names == ${arr_name[4]} ]]
	    then
            echo
            echo -e "$yellow可以访问，访问信息已经录入！"
            echo
            if [ "$names" == "${arr_name[0]}" ]
            then
                echo -e "$yellow欢迎你！张三！"
                echo
            elif [ "$names" == "${arr_name[1]}" ]
            then
                echo -e "$yellow欢迎你！李四！"
                echo
            elif [ "$names" == "${arr_name[2]}" ]
            then
                echo -e "$yellow欢迎你！王五"
            elif [ "$names" == "${arr_name[3]}" ]
            then
                echo -e "$yellow欢迎你！zhaosi！"
                echo
            elif [ "$names" == "${arr_name[4]}" ]
            then
                echo -e "$yellow欢迎你！大大怪将军！"
                echo
            else
                echo '非法闯入！'
                echo
            fi
            echo "$datetime|||$names|||$access">>$loghome
            echo
            while true
            do
                echo -e "$yellow======================================================================================="
                echo -e "$yellow===|||Author|||======================================================|||Xiao|||========"
                echo -e "$yellow-------------------------------|||欢迎进入综合自动化平台|||------------------------------"
                echo
                echo -e "$green请输入【1】进入限速板块   【2】进入PPTP/L2TP板块  【3】进入系统设置板块(如DNS|主机名|ROM|RAM)"
                echo
                echo -e "$green【4】添加路由和隧道板块 【5】打包解压缩板块 【6】抓包板块 【7】查出口IP 【8】wireguard板块"
                echo
                echo -e "$red=================================|||【0】退出自动化平台|||==============================="
                echo
                echo -e "$yellow===|||Date|||========================================================|||2024|||========="
                echo -e "$yellow=====================================Version1.0========================================="
                echo
                read -p '请输入你的选择【0】【1】【2】【3】【4】【5】【6】【7】【8】：' choose1
                echo
                echo "你的选择是$choose1"
                echo
                case $choose1 in
                "1")
                    echo 'wait......'
                    echo
                    TcFlow
                    echo
                ;;
                "2")
                    echo 'wait......'
                    echo
                    VirtualTunnel
                    echo
                ;;
                "3")
                    echo 'wait......'
                    echo
                    Systems
                    echo
                ;;
                "4")
                    echo 'wait......'
                    echo
                    Tunnel
                    echo
                ;;
                "5")
                    echo 'wait......'
                    echo
                    Package
                    echo
                ;;
                "6")
                    echo 'wait......'
                    echo
                    wireShark
                    echo
                ;;
                "7")
                    echo 'wait......'
                    echo
                    IPINFO
                    echo
                ;;
                "8")
                    echo 'wait......'
                    echo
                    WireGuard
                    echo
                ;;
                "0")
                    echo '客官走好，欢迎您下次使用自动化平台！'
                    echo
                    break
                ;;
                *)
                    echo -e "$red你的输入有误！请输入0、1、2、3、4、5、6、7、8"
                    echo
                ;;
                esac
            done
        elif [ "$names" == 0 ]
        then
            echo '期待您的下次光临！'
            echo
            break
        else
            echo
            echo '你无权访问，请通知管理员开通权限！！！'
            echo "$datetime|||$names|||$noaccess">>$loghome
            echo
	    fi
    done
}
Xiao
