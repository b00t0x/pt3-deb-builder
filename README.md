# pt3-deb-builder
[chardev 版 PT3 ドライバ](https://github.com/m-tsudo/pt3) の deb パッケージをビルドするリポジトリ

このリポジトリ自体には deb 化に必要な資材しか含まれておらず、本家リポジトリからソースを pull してきてビルドします。  
日次で本家リポジトリをチェックし、更新があったら自動的に deb パッケージがアップロードされます（多分）。

## ダウンロード
[Releases](https://github.com/b00t0x/pt3-deb-builder/Releases) から  pt3-drv-dkms_x.y.z_all.deb をダウンロードしてください。

## インストール
```
sudo apt install ./pt3-drv-dkms_*.deb
```

### スクリプト用
```
deb_url=$(wget -qO - https://api.github.com/repos/b00t0x/pt3-deb-builder/releases/latest | grep browser_download_url.*deb | cut -d'"' -f4)
wget -qO ./pt3-drv-dkms.deb ${deb_url}
sudo apt install -y ./pt3-drv-dkms.deb
rm ./pt3-drv-dkms.deb
```

## アンインストール
```
sudo apt purge pt3-drv-dkms
```

## workflow
deb の作成方法は [tsukumijima/px4_drv](https://github.com/tsukumijima/px4_drv) を参考にしています。
* 以下のファイルを追加 ( `Copy files` )
  * [post_install.sh](./post_install.sh)
  * [post_remove.sh](./post_remove.sh)
  * [blacklist-dvb-pt3.conf](./blacklist-dvb-pt3.conf)
    * dvb ドライバがロードされないよう post_install.sh にて導入
* [dkms.conf](./dkms.conf) を修正 ( `Modify dkms.conf` )
  * [99-pt3.rules](https://github.com/m-tsudo/pt3/blob/master/etc/99-pt3.rules) の配置は post_install.sh で行うため、make のターゲットを `dkms` から `pt3_drv.ko` に変更
* プリセットの設定だと post_(install|remove).sh が 644 になってしまうので、対策した pt3_drv-dkms-mkdeb を配置 ( `Fix mkdeb` )
  * 参考: https://github.com/tsukumijima/px4_drv/commit/c6afab65efa4f58804d4d630da8cd2d853180abd
