# dotfiles

Dotfiles for moi

## TODO
Add a check for computer serial number or MAC address so can automatically do:
```
export RESSYS=true
```

## Installing YCMD

```
cd YouCompleteMe/third_party/ycmd/third_party/go/src/golang.org/x/tools/cmd/gopls
go build
cd YouCompleteMe
python3 install.py --all
```

Do this on work ressys computer

```
export RESSYS=true
./install.sh
```

To initialise gcloud SDK

```
~/google-cloud-sdk/bin/gcloud init
```
