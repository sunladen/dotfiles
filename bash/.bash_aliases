alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias vi='nvim'
alias vim='nvim'

alias python='python3'
alias pip='pip3'

ssh-ecls-cls-dev() { ssh ecls@apau28pubapp251.wkap.int; }
ssh-ecls-cls-tst() { ssh ecls@apau28pubapp253.wkap.int; }
ssh-ecls-cls-prd() { ssh ecls@apau28pubapp201.wkap.int; }

ssh-intranet-cls-dev() { ssh intranet@apau28pubapp251.wkap.int; }
ssh-intranet-cls-tst() { ssh intranet@apau28pubapp253.wkap.int; }
ssh-intranet-cls-prd() { ssh intranet@apau28pubapp201.wkap.int; }

ssh-intranet-ngp-dev() { ssh intranet@apau28pubapp252.wkap.int; }
ssh-intranet-new-dev() { ssh intranet@zauaed1pubapp01.wkap.int; }
ssh-intranet-ngp-tst() { ssh intranet@zauaetpubapp02.wkap.int; }
ssh-intranet-ngp-prd() { ssh intranet@zauaed1pubapp01.wkap.int; }

ssh-scarmody-ngp-dev() { ssh scarmody@apau28pubapp252.wkap.int; }
ssh-scarmody-new-dev() { ssh scarmody@zauaed1pubapp01.wkap.int; }
ssh-scarmody-ngp-tst() { ssh scarmody@zauaetpubapp02.wkap.int; }
ssh-scarmody-ngp-prd() { ssh scarmody@zauaed1pubapp01.wkap.int; }

ssh-scarmody-newsagent() { ssh scarmody@apvthau28444.wkap.int; }

update-apt-auto-upgrade-remove-clean() { sudo -- sh -c 'apt update; apt upgrade -y; apt dist-upgrade -y; apt autoremove -y; apt autoclean -y'; }
