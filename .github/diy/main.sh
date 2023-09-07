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
git clone --depth 1 https://github.com/kenzok8/openwrt-packages
git clone --depth 1 https://github.com/kenzok8/small
mv openwrt-packages/* ./
mv small/* ./
rm -rf openwrt-packages small
git clone --depth 1 https://github.com/animegasan/luci-app-quickstart luci-app-quickstart
svn export https://github.com/linkease/nas-packages/trunk/network/services/quickstart quickstart

exit 0

