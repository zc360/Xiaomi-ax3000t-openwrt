# 适用于小米ax3000t的openwrt固件

## 修改说明

1.删除了部分插件 

2.有带xray的ssrplus科学上网 

3.添加ipv6支持 

4.添加了argon主题 

5.通过修改编译文件修复原版自编译导致set-output错误

6.修改编译文件设置删除不必要的文件防止出现磁盘空间不足的问题

7.在编译文件中添加了检测服务器配置的一步

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
