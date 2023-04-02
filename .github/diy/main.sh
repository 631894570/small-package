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

#svn export https://github.com/coolsnowwolf/luci/trunk/libs/luci-lib-ipkg

#git_sparse_clone master "https://github.com/coolsnowwolf/packages" "leanpack" net/miniupnpd net/mwan3 \
#net/amule net/baidupcs-web multimedia/gmediarender net/go-aliyundrive-webdav \
#net/qBittorrent-static net/qBittorrent libs/qtbase libs/qttools libs/rblibtorrent \
#net/uugamebooster net/verysync net/dnsforwarder net/nps net/tcpping


exit 0

