# dotfiles

Dotfiles for moi

## Installing YCMD

```
cd YouCompleteMe/third_party/ycmd/third_party/go/src/golang.org/x/tools/cmd/gopls
go build
cd YouCompleteMe
python3 install.py --all
```


# TODO

fix these errors on the bash
```
bash: /home/tomb/.local/bin/virtualenvwrapper.sh: No such file or directory
bash: /ressys/deployment-commons/assets/etc_profile.d/rs-switch-aws-cli-profile.sh: No such file or directory
bash: /ressys/deployment-commons/assets/etc_profile.d/rs-go-typical-functions.sh: No such file or directory
bash: /ressys/deployment-commons/assets/etc_profile.d/mm-credential-functions.sh: No such file or directory
```

do it by splitting up dotfiles to topics https://github.com/michaelmior/dotfiles


```
RESSYS=true ./symlink.sh
```
