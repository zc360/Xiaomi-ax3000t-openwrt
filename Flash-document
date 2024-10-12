# 刷入教程

## 一：软件准备

1. 所需设备：一台电脑；一台小米AX3000T路由器。

2. 所需软件：MobaXterm或其他终端软件，Windows命令提示符。

3. 初始密码计算： `https://miwifi.dev/ssh`

4. 路由器的 `stok` ：打开路由器的web端管理界面，输入管理员密码，从上方地址栏即可获得 `stok` 。

例如，管理界面地址为：

`http://192.168.31.1/cgi-bin/luci/;stok=030b24d39b1a4a549aa12dac23c52313/web/home#router`
    则 `stok=030b24d39b1a4a549aa12dac23c52313` ，也即 `stok` 为 `030b24d39b1a4a549aa12dac23c52313` 。

### 注：每次路由器重启， `stok` 值都会改变。


## 二：获取ssh权限

1. 打开cmd（Windows命令提示符）。

2. 在cmd中输入指令1：

`curl -X POST http://192.168.31.1/cgi-bin/luci/;stok=token/api/misystem/arn_switch -d "open=1&model=1&level=%0Anvram%20set%20ssh_en%3D1%0A"`

其中，将 `stok=token` 中的 `token` 替换成路由器的 `stok` 。

例如，我的 `stok` 为`030b24d39b1a4a549aa12dac23c52313`，则应输入到cmd的指令为：

`curl -X POST http://192.168.31.1/cgi-bin/luci/;stok=030b24d39b1a4a549aa12dac23c52313/api/misystem/arn_switch -d "open=1&model=1&level=%0Anvram%20set%20ssh_en%3D1%0A"`

3. 在cmd中输入指令2：

`curl -X POST http://192.168.31.1/cgi-bin/luci/;stok=token/api/misystem/arn_switch -d "open=1&model=1&level=%0Anvram%20commit%0A"`
    其中，将 `stok=token` 中的 `token` 替换成路由器的 `stok` 。

4. 在cmd中输入指令3：

`curl -X POST http://192.168.31.1/cgi-bin/luci/;stok=token/api/misystem/arn_switch -d "open=1&model=1&level=%0Ased%20-i%20's%2Fchannel%3D.*%2Fchannel%3D%22debug%22%2Fg'%20%2Fetc%2Finit.d%2Fdropbear%0A"`

其中，将 `stok=token` 中的 `token` 替换成路由器的 `stok` 。

5. 在cmd中输入指令4：

`curl -X POST http://192.168.31.1/cgi-bin/luci/;stok=token/api/misystem/arn_switch -d "open=1&model=1&level=%0A%2Fetc%2Finit.d%2Fdropbear%20start%0A"`

其中，将 `stok=token` 中的 `token` 替换成路由器的 `stok` 。

6.通过MobaXterm或其他ssh软件连接路由器的ssh，ip: `192.168.31.1`


## 三：刷入uboot [uboot固件下载](https://wwk.lanzouo.com/isDQD24feyxi)

1.用MobaXterm将uboot文件上传到路由器的 `/tmp` 文件夹

2.输入 `cd /tmp` 命令进入 `/tmp` 目录。

3.输入 `mtd write mt7981_xiaomi_ax3000t-u-boot.bin FIP` 命令以进行刷机操作。

4.路由器断电后，用针按住 reset 不放，再接上电源，等待 10s 左右松开，电脑用网线和路由器的网口1连接，电脑在网络设置里将以太网ipv4设置为静态。IP地址： `192.168.1.5` ，子网掩码： 
 `255.255.255.0` ，浏览器打开 `192.168.1.1` 访问uboot后台。

5.进入uboot后台刷入固件，刷openwrt的话分区就选 `qwrt`（7月8日及之前版本刷入时uboot选择第三项qwrt，8月4日及以后版本刷入时uboot选择第二项）,刷squashfs-sysupgrade格式的就可以，不行就先刷initramfs-kernel然后再到后台去升级为squashfs-sysupgrade格式的固件，如果失败或设备进不了系统就再刷一次，这个可能要多试几次,我也刷了几次才成功。
