# 适用于小米ax3000t的云编译openwrt固件及刷入教程和刷回官方教程

**可以通过修改config文件自定义固件**

理论上是可以编译出任何支持的机型和任何配置的固件的

如果需要添加一些lede默认没有的插件可以通过修改工作流文件来实现，既通过修改云编译工作流文件来把需要的插件源码git来就可以编译出这些插件了（比如新版的argon主题和ddns-go）

**请看README的时候不要使用浏览器的网页翻译，会导致README的排版错误。**

**如果您使用的是发布在[Releases](https://github.com/zc360/Xiaomi-ax3000t-openwrt/releases)里的固件，那么应该是不会出现刷不上去和用不了等奇奇怪怪的问题的，如果您使用的是你您自己修改配置文件通过云编译出的固件我只能够确保固件能编译出来，而能不能正常刷入和使用是无法保证的。**

**关于使用uboot刷入openwrt的说明：7月8日及之前版本的固件刷入时uboot选择第三项qwrt，8月4日及以后版本的固件刷入时uboot选择第二项，7月8日及以前的版本的固件升级8月4日及以后版本的固件时请先在`备份/升级`选项中备份配置文件，然后再到uboot里去升级，选择第二个选项，升级后再到`备份/升级`里恢复之前的配置文件。**

## 修改说明

### 相对lede默认配置而言修改的部分（仓库里适用与小米ax3000t的config文件）

1.添加ipv6支持

2.添加了Argon主题配置插件 `luci-app-argon-config`

3.将主题改为`Argon`（如果固件是7月8日及之前版本请手动到[Argon的GitHub仓库下载并安装](https://github.com/jerrykuku/luci-theme-argon/releases)）

4.添加了`zram`内存压缩插件（如果固件是7月8日及之前的版本请手动到软件包里安装`zram-swap`插件才能正常运行）

5.删去了默认的Ddns，添加了[Ddns-go](https://github.com/sirpdboy/luci-app-ddns-go)（8月4日版本及以后才有）

### 编译工作流文件修改

1.修复原版云编译 `set-output` 错误

2.删除不必要的文件防止出现磁盘空间不足的问题

3.添加了检测服务器配置的一步

4.添加了Ddnsgo和新版Argon主题的源码（修改工作流文件让编译时把源码git下来）

**编译完成会报错出现红×，这不影响，固件会正常编译出来**

# 使用方法

## 使用方法一（如果设备是小米ax3000t）

直接到[Releases](https://github.com/zc360/Xiaomi-ax3000t-openwrt/releases)中下载已经编译好的固件，刷squashfs-sysupgrade格式的就可以，不行就先刷initramfs-kernel然后再到后台去升级为squashfs-sysupgrade格式的固件。

## 使用方法二（不修改config文件的话编译的是ax3000t的固件）

自己云编译

<details>
<summary><b>&nbsp;查看如何使用</b></summary>

1：先fork这个仓库

2：到自己fork的仓库后的点击 `Actions`

3：点击 `Build OpenWrt` 下的 `Run workflow` 即可开始编译

4：等待编译完成后再次进入 `Actions` 点击刚刚完成的一次编译

5：点击编译完成的固件即可下载
</details>

## 修复配置文件（config文件）说明

自定义固件配置，将config文件的内容复制到仓库里的config文件里

生成config文件详细教程请到[lede的仓库查看](https://github.com/coolsnowwolf/lede)

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

4. 命令行输入 `make menuconfig` 选择配置，选好配置后保存，文件名自定义为xxx.config（xxx是自定义的）

   ```bash
   make defconfig
   ./scripts/diffconfig.sh > seed.config
   ```

5. 命令行输入 `cat xxx.config` 查看这个文件，也可以用文本编辑器打开

6. 复制 xxx.config 文件内所有内容到 configs 目录对应文件中覆盖就可以了

   **如果看不懂编译界面可以参考 YouTube 视频：[软路由固件 OpenWrt 编译界面设置](https://www.youtube.com/watch?v=jEE_J6-4E3Y&list=WL&index=7)**
</details>


# 其他重要部分

1.默认的登录ip是 `192.168.1.1`

2.默认登录密码是 `password`

3.云编译的时候不能使用 `ssh` ，会导致编译失败！！！

# [小米ax3000t解锁ssh以及刷入教程](https://github.com/zc360/Xiaomi-ax3000t-openwrt/blob/main/Flash-document.md)

# [刷回小米官方固件](https://github.com/zc360/Xiaomi-ax3000t-openwrt/blob/main/BackXiaomi.md)

# 感谢[P3TERX](https://github.com/P3TERX/Actions-OpenWrt)和[haiibo](https://github.com/haiibo/OpenWrt)的源码



