#!/bin/bash
function git_clone() {
  git clone --depth 1 $1 $2 || true
 }
function git_sparse_clone() {
  branch="$1" rurl="$2" localdir="$3" && shift 3
  git clone -b $branch --depth 1 --filter=blob:none --sparse $rurl $localdir
  cd $localdir
  git sparse-checkout init --cone
  git sparse-checkout set $@
  mv -n $@ ../
  cd ..
  rm -rf $localdir
  }
function mvdir() {
mv -n `find $1/* -maxdepth 0 -type d` ./
rm -rf $1
}
rm -rf *
git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config
git clone --depth 1 https://github.com/jerrykuku/luci-app-vssr
git clone --depth 1 https://github.com/gngpp/luci-theme-design
git clone --depth 1 https://github.com/gngpp/luci-app-design-config
git clone --depth 1 https://github.com/sirpdboy/luci-app-netdata
git clone --depth 1 https://github.com/honwen/luci-app-aliddns
git clone --depth 1 https://github.com/jerrykuku/lua-maxminddb
git clone --depth 1 https://github.com/linkease/istore && mv -n istore/luci/* ./; rm -rf istore

git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall2 passwall2 && mv -n passwall2/luci-app-passwall2 ./;rm -rf passwall2
git clone --depth 1 -b luci https://github.com/xiaorouji/openwrt-passwall passwall && mv -n passwall/luci-app-passwall ./;rm -rf passwall
git clone --depth 1 -b packages https://github.com/xiaorouji/openwrt-passwall openwrt-passwall && mv -n openwrt-passwall/* ./;rm -rf openwrt-passwall

svn export https://github.com/coolsnowwolf/luci/trunk/libs/luci-lib-ipkg
svn export https://github.com/linkease/istore-ui/trunk/app-store-ui
svn export https://github.com/immortalwrt/luci/trunk/applications/luci-app-nps
svn export https://github.com/immortalwrt/luci/trunk/applications/luci-app-usb-printer
svn export https://github.com/immortalwrt/packages/trunk/net/nps
svn export https://github.com/immortalwrt/packages/trunk/utils/upx
sed -i \
-e 's?include \.\./\.\./\(lang\|devel\)?include $(TOPDIR)/feeds/packages/\1?' \
-e 's?2. Clash For OpenWRT?3. Applications?' \
-e 's?\.\./\.\./luci.mk?$(TOPDIR)/feeds/luci/luci.mk?' \
-e 's/ca-certificates/ca-bundle/' \
*/Makefile
mv -n openwrt-passwall/* ./ ; rm -Rf openwrt-passwall
mv -n openwrt-package/* ./ ; rm -Rf openwrt-package
sed -i 's/luci-lib-ipkg/luci-base/g' luci-app-store/Makefile
sed -i 's/("iStore"), 31/("应用商店"), 61/g' luci-app-store/luasrc/controller/store.lua
sed -i 's/\(+luci-compat\)/\1 +luci-theme-argon/' luci-app-argon-config/Makefile
sed -i 's/\(+luci-compat\)/\1 +luci-theme-design/' luci-app-design-config/Makefile

#svn export https://github.com/coolsnowwolf/luci/trunk/libs/luci-lib-ipkg

#git_sparse_clone master "https://github.com/coolsnowwolf/packages" "leanpack" net/miniupnpd net/mwan3 \
#net/amule net/baidupcs-web multimedia/gmediarender net/go-aliyundrive-webdav \
#net/qBittorrent-static net/qBittorrent libs/qtbase libs/qttools libs/rblibtorrent \
#net/uugamebooster net/verysync net/dnsforwarder net/nps net/tcpping


exit 0

