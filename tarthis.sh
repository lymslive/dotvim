#! /bin/bash
# pack dotvim config
# exclude plugins and others in .gitignore

# cd ~/.vim
# tar -zcf dotfile.tgz vimrc start/ colors/ ftplugin/

name=dotvim
exclude=--exclude-vcs\ --exclude-backups
exclude=$exclude\ --exclude-from='.gitignore'
exclude=$exclude\ --exclude='*.tgz'

echo tar czf ${name}.tgz ${exclude} '*'
tar czf ${name}.tgz ${exclude} *

# test
# tar -ztvf dotfile.tgz

# unpack to other machine
# cd ~/.vim
# tar -zxvf dotfile.tgz
