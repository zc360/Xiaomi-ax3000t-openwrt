# 适用于小米ax3000t的openwrt固件

## 修改说明

### 默认固件配置修改
1.删除了部分插件 

2.有带xray的ssrplus科学上网 

3.添加ipv6支持 

4.添加了argon主题 

### 编译工作流文件修改

1.修复原版云编译set-output错误

6.删除不必要的文件防止出现磁盘空间不足的问题

7.添加了检测服务器配置的一步

## 使用方法

### 使用方法一

直接到Releases中下载已经编译好的固件

### 使用方法二

1：先fork这个仓库

2：到自己fork的仓库后的点击`Actions`

3：点击`Build OpenWrt`下的`Run workflow`即可开始编译

4：等待编译完成后再次进入`Actions`点击刚刚完成的一次编译

5：点击编译完成的固件即可下载

### 使用方法三

自定义固件配置，将config文件上传到仓库里
<details>
<summary><b>&nbsp;查看如何生成config文件</b></summary>

1. 首先装好 Linux 系统，推荐 Debian 11 或 Ubuntu LTS

2. 安装编译依赖环境

   ```bash
   sudo apt update -y
   sudo apt full-upgrade -y
   sudo apt install -y ack antlr3 asciidoc autoconf automake autopoint binutils bison build-essential \
   bzip2 ccache cmake cpio curl device-tree-compiler fastjar flex gawk gettext gcc-multilib g++-multilib \
   git gperf haveged help2man intltool libc6-dev-i386 libelf-dev libglib2.0-dev libgmp3-dev libltdl-dev \
   libmpc-dev libmpfr-dev libncurses5-dev libncursesw5-dev libreadline-dev libssl-dev libtool lrzsz \
   mkisofs msmtp nano ninja-build p7zip p7zip-full patch pkgconf python2.7 python3 python3-pyelftools \
   libpython3-dev qemu-utils rsync scons squashfs-tools subversion swig texinfo uglifyjs upx-ucl unzip \
   vim wget xmlto xxd zlib1g-dev
   ```

3. 下载源代码，更新 feeds 并安装到本地

   ```bash
   git clone https://github.com/coolsnowwolf/lede
   cd lede
   ./scripts/feeds update -a
   ./scripts/feeds install -a
   ```

4. 复制 diy-script.sh 文件内所有内容到命令行，添加自定义插件和自定义设置

5. 命令行输入 `make menuconfig` 选择配置，选好配置后导出差异部分到 seed.config 文件

   ```bash
   make defconfig
   ./scripts/diffconfig.sh > seed.config
   ```

7. 命令行输入 `cat seed.config` 查看这个文件，也可以用文本编辑器打开

8. 复制 seed.config 文件内所有内容到 configs 目录对应文件中覆盖就可以了

   **如果看不懂编译界面可以参考 YouTube 视频：[软路由固件 OpenWrt 编译界面设置](https://www.youtube.com/watch?v=jEE_J6-4E3Y&list=WL&index=7)**
</details>

## 其他

1.默认的登录ip是`192.168.1.1`

2.默认登录密码是`password`

3.不能使用ssh，会导致编译失败！！！

# 刷入教程
## 一、软件准备

### 1. 所需设备：一台电脑；一台小米AX3000T路由器。

### 2. 所需软件：MobaXterm或其他终端软件，cmd。

### 3. 初始密码计算：`https://miwifi.dev/ssh`

### 4. 路由器的stok：打开路由器的web端管理界面，输入管理员密码，从上方地址栏即可获得stok。

例如，管理界面地址为：

`http://192.168.31.1/cgi-bin/luci/;stok=030b24d39b1a4a549aa12dac23c52313/web/home#router`
    则`stok=030b24d39b1a4a549aa12dac23c52313`，也即stok为`030b24d39b1a4a549aa12dac23c52313`。

### 注：每次路由器重启，stok值都会改变。


## 二、获取ssh权限

### 1. 打开cmd。

### 2. 在cmd中输入指令1：

`curl -X POST http://192.168.31.1/cgi-bin/luci/;stok=token/api/misystem/arn_switch -d "open=1&model=1&level=%0Anvram%20set%20ssh_en%3D1%0A"`

其中，将stok=token中的token替换成路由器的stok。

例如，我的stok为`030b24d39b1a4a549aa12dac23c52313`，则应输入到cmd的指令为：

`curl -X POST http://192.168.31.1/cgi-bin/luci/;stok=030b24d39b1a4a549aa12dac23c52313/api/misystem/arn_switch -d "open=1&model=1&level=%0Anvram%20set%20ssh_en%3D1%0A"`

### 3. 在cmd中输入指令2：

`curl -X POST http://192.168.31.1/cgi-bin/luci/;stok=token/api/misystem/arn_switch -d "open=1&model=1&level=%0Anvram%20commit%0A"`
    其中，将`stok=token`中的`token`替换成路由器的`stok`。

### 4. 在cmd中输入指令3：

`curl -X POST http://192.168.31.1/cgi-bin/luci/;stok=token/api/misystem/arn_switch -d "open=1&model=1&level=%0Ased%20-i%20's%2Fchannel%3D.*%2Fchannel%3D%22debug%22%2Fg'%20%2Fetc%2Finit.d%2Fdropbear%0A"`

其中，将`stok=token`中的`token`替换成路由器的`stok`。

### 5. 在cmd中输入指令4：

`curl -X POST http://192.168.31.1/cgi-bin/luci/;stok=token/api/misystem/arn_switch -d "open=1&model=1&level=%0A%2Fetc%2Finit.d%2Fdropbear%20start%0A"`

其中，将`stok=token`中的`token`替换成路由器的`stok`。

### 6.通过MobaXterm连接路由器的ssh,ip:`192.168.31.1`

## 三,刷入uboot [uboot固件下载](https://wwk.lanzouo.com/iL71O1nk1p3e)

### 1.用MobaXterm将uboot文件上传到路由器的`/tmp`文件夹

### 2.输入`cd /tmp`命令进入`/tmp`目录。

### 3.输入`mtd write mt7981_xiaomi_ax3000t-u-boot.fip FIP`命令以进行刷机操作。

### 4.路由器断电后，用针按住 reset 不放，再接上电源，等待 10s 左右松开，电脑用网线和路由器的网口1连接，电脑在网络设置里将以太网ipv4设置为静态。IP地址：`192.168.1.2`，子网掩码：`255.255.255.0`，浏览器打开`192.168.1.1`访问uboot后台。

### 5.进入uboot后台刷入固件，如果失败或设备进不了系统就再刷一次，这个要多试几次,我也刷了好几次才成功。

# 感谢[P3TERX](https://github.com/P3TERX/Actions-OpenWrt)和[haiibo](https://github.com/haiibo/OpenWrt)的源码
