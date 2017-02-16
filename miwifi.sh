#!/bin/sh
clear

echo "*********************************************************"
echo "*                    SS配置脚本                         *"
echo "*                                                       *"
echo "*          安装前请关闭小米路由器自带VPN功能            *"
echo "*                                                       *"
echo "*         支持路由型号：mini | r1d | r2d | r3           *"
echo "*                                                       *"
echo "*             购买SS帐号咨询群：206055051               *"
echo "*                                                       *"
echo "*********************************************************"


## Check The Router Hardware Model
Hardware_ID=$(cat /proc/xiaoqiang/model)

if [ $Hardware_ID = R2D ] || [ $Hardware_ID = R1D ];then

	get_char(){
		SAVEDSTTY=`stty -g`
		stty -echo
		stty cbreak
		dd if=/dev/tty bs=1 count=1 2> /dev/null
		stty -raw
		stty echo
		stty $SAVEDSTTY
	}
echo -ne "\33[?25l\33[5m\033[41;37m您的路由型号为R1D/R2D 请按回车键进行安装配置！\033[0m"
    char=`get_char`

clear

echo "#############################################################"
echo "#                                                           #"
echo "#       Please input your shadowsocks configuration         #"
echo -e "#                 \033[31m终止安装请按Ctrl+C键\033[0m                      #"
echo "#                                                           #"
echo "#############################################################"
echo ""
echo -e "\033[?25h"

read -p "请输入节点地址: " serverip
echo ""
echo "---------------------------"
echo -e "节点地址 = \033[31m$serverip\033[0m"
echo "---------------------------"
echo ""

while true
do
read -p "请输入连接端口: " serverport
    [ -z "$serverport" ]
    expr $serverport + 0 &>/dev/null
    if [ $? -eq 0 ]; then
        if [ $serverport -ge 1 ] && [ $serverport -le 65535 ]; then
            echo ""
            echo "---------------------------"
            echo -e "连接端口 = \033[31m$serverport\033[0m"
            echo "---------------------------"
            echo ""
            break
        else
            echo -e "\033[31m错误:端口范围为:1-65535\033[0m"
        fi
    else
        echo -e "\033[31m错误:端口范围为:1-65535\033[0m"
    fi
done

read -p "请输入连接密码: " shadowsockspwd
echo ""
echo "---------------------------"
echo -e "连接密码 = \033[31m$shadowsockspwd\033[0m"
echo "---------------------------"
echo ""

read -p "请输入加密方式: " method
echo ""
echo "---------------------------"
echo -e "加密方式 = \033[31m$method\033[0m"
echo "---------------------------"
echo ""

cat > /etc/shadowsocks.json<<-EOF
{
  "server":"${serverip}",
  "server_port":${serverport},
  "local_address":"127.0.0.1",
  "local_port":1081,
  "password":"${shadowsockspwd}",
  "timeout":600,
  "method":"${method}"
}
EOF

wget ftp://joerv.gicp.net/miwifi/r2d/shadowsocks_miwifi.tar.gz -P /tmp/
echo -e "|\033[32m***************\033[0m| \033[31m30%\033[0m"
killall ss-redir &> /dev/null
rm -rf /etc/dnsmasq.d/*
rm -rf /tmp/etc/dnsmasq.d/*
rm -rf /data/usr/sbin/ss-redir
cd /
tar zxf /tmp/shadowsocks_miwifi.tar.gz
rm -rf /tmp/shadowsocks_miwifi.tar.gz
echo -e "|\033[32m******************************\033[0m| \033[31m60%\033[0m"
/etc/init.d/ss enable
/etc/init.d/ss restart
echo -e "|\033[32m**************************************************\033[0m| \033[31m100%\033[0m"
echo ""
echo ""
echo ""
echo -e "\033[41;37mShadowsocks安装并启动完成!\033[0m"

elif [ $Hardware_ID = R1CM ] || [ $Hardware_ID = R3 ];then

echo -ne "\33[?25l\33[5m\033[41;37m您的路由型号为MINI/R3 请按回车键进行安装配置！\033[0m"
read MINI

clear

echo "#############################################################"
echo "#                                                           #"
echo "#       Please input your shadowsocks configuration         #"
echo -e "#                 \033[31m终止安装请按Ctrl+C键\033[0m                      #"
echo "#                                                           #"
echo "#############################################################"
echo ""
echo -e "\033[?25h"

read -p "请输入节点地址: " serverip
echo ""
echo "---------------------------"
echo -e "节点地址 = \033[31m$serverip\033[0m"
echo "---------------------------"
echo ""

while true
do
read -p "请输入连接端口: " serverport
    [ -z "$serverport" ]
    expr $serverport + 0 &>/dev/null
    if [ $? -eq 0 ]; then
        if [ $serverport -ge 1 ] && [ $serverport -le 65535 ]; then
            echo ""
            echo "---------------------------"
            echo -e "连接端口 = \033[31m$serverport\033[0m"
            echo "---------------------------"
            echo ""
            break
        else
            echo -e "\033[31m错误:端口范围为:1-65535\033[0m"
        fi
    else
        echo -e "\033[31m错误:端口范围为:1-65535\033[0m"
    fi
done

read -p "请输入连接密码: " shadowsockspwd
echo ""
echo "---------------------------"
echo -e "连接密码 = \033[31m$shadowsockspwd\033[0m"
echo "---------------------------"
echo ""

read -p "请输入加密方式: " method
echo ""
echo "---------------------------"
echo -e "加密方式 = \033[31m$method\033[0m"
echo "---------------------------"
echo ""

cat > /etc/shadowsocks.json<<-EOF
{
  "server":"${serverip}",
  "server_port":${serverport},
  "local_address":"127.0.0.1",
  "local_port":1081,
  "password":"${shadowsockspwd}",
  "timeout":600,
  "method":"${method}"
}
EOF

wget ftp://joerv.gicp.net/miwifi/r3/shadowsocks_r3.tar.gz -P /tmp/
echo -e "|\033[32m***************\033[0m| \033[31m30%\033[0m"
killall ss-redir &> /dev/null
rm -rf /etc/dnsmasq.d/*
rm -rf /tmp/etc/dnsmasq.d/*
rm -rf /data/usr/sbin/ss-redir
cd /
tar zxf /tmp/shadowsocks_r3.tar.gz
rm -rf /tmp/shadowsocks_r3.tar.gz
echo -e "|\033[32m******************************\033[0m| \033[31m60%\033[0m"
/etc/init.d/ss enable
/etc/init.d/ss restart
echo -e "|\033[32m**************************************************\033[0m| \033[31m100%\033[0m"
echo ""
echo ""
echo ""
echo -e "\033[41;37mShadowsocks安装并启动完成!\033[0m"

else
echo -e "\033[41;37m错误:暂不支持此型号!\033[0m"
fi

