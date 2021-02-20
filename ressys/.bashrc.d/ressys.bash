############
#  RESSYS  #
############
source /ressys/deployment-commons/assets/etc_profile.d/rs-switch-aws-cli-profile.sh
source /ressys/deployment-commons/assets/etc_profile.d/rs-go-typical-functions.sh
source /ressys/deployment-commons/assets/etc_profile.d/mm-credential-functions.sh
source /ressys/analysis/etc/bashrc

# GoLang
#export GOROOT=$HOME/.go
export PATH=$PATH:$GOROOT/bin

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export IN_DOCKER_SSH_FOLDER_FOR_BITBUCKET_CLONING=~/.ssh/bitbucket-ro-clone-folder/

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
nvm use default --silent

###############
#  SHORTCUTS  #
###############
## Aliases
alias rs='cd /ressys/reporting-www-gopath/src/bitbucket.org/resolutionsystems'
alias rsr='rs-go-reporting_www'
alias rsf='rs-go-falcon'
alias rsu='rs-go-uploader'
alias rst='rs-go-maxmine-www-tests'
alias rss='cd /ressys/reporting-www-gopath/src/bitbucket.org/resolutionsystems/ressys-python-selenium'
alias rst='rs-go-maxmine-www-tests'
alias rsd='cd /ressys/deployment-commons'
alias go-generate='cd App/; GOPATH=/ressys/reporting-www-gopath/; go generate; cd ..'
alias qgismap=qgismap

## Functions
### Goto repo
# TODO: add these to rs-go-typical if they are that useful
function rs-go-falcon() {
    echo "Going to falcon repo and setting proper env."
    echo cd /ressys/reporting-www-gopath/src/bitbucket.org/resolutionsystems/falcon/
    cd /ressys/reporting-www-gopath/src/bitbucket.org/resolutionsystems/falcon/
}

function rs-go-maxmine-www-tests() {
    echo "Going to maxmine-www-tests repo and setting proper env."
    echo cd /ressys/reporting-www-gopath/src/bitbucket.org/resolutionsystems/maxmine-www-tests/
    cd /ressys/reporting-www-gopath/src/bitbucket.org/resolutionsystems/maxmine-www-tests/
}

### Get minesite configuration
function get-minesite-config() {
    # Usage: get-minesite-config <minesite_id>
    curl --silent -u $(MMResCreds) https://python-dashboard.max-mine.com/central-resources-api/minesiteconfigurations | jq -r '.minesiteconfigurations[] | select(.MinesiteId=="'$1'")'
}

### Get minesite live dp version
function get-minesite-live-dp-version() {
    # Usage: get-minesite-config <minesite_id>
    curl --silent 'https://python-dashboard.max-mine.com/general-info/minesites-live-info' -H 'cookie: user-details="2|1:0|10:1563932462|12:user-details|44:InRvbS5iYXJvbmVAcmVzb2x1dGlvbi5zeXN0ZW1zIg==|9de32feb8a620c353986d043f4092d8f97e5fcb4a6bc45fe044ed3770e05a1e0"' | jq -r '."'$1'".currentDPChannelInfo.channelName'
}

### Get minesite results bucket
function get-minesite-bucket() {
    # usage: get-minesite-bucket <minesite_id>
    get-minesite-config $1 | jq -r '.ResultsBucketAWSARN' | grep -o "mm.*$"
}

### Upload latest minesite data
function upload-latest-minesite-data() {
    # usage: upload-latest-minesite-data <minesite_id> <host>

    rsu
    local username=apiuploader@resolution.systems
    local password=NDxWryPA
    #local dpVersion=jenkins-ci-end-to-end-294
    #local dpVersion=jenkins-ci-end-to-end-393
    #local dpVersion=20200204-v8.8-f5.32
    #local dpVersion=20200317-v8.9-f5.33
    #local dpVersion=20200512-v8.10-f5.34
    local dpVersion=20200929-v8.12-f5.36
    #local dpVersion=mgc-integration-testing-03

    local bucket=$(get-minesite-bucket $1)
    #local uploader=ressys-www-uploader-2.8.2-f5.32.0.linux
    #local uploader=ressys-www-uploader-9.9.9+DevProductivity-429ffcbe.linux
    #local uploader=ressys-www-uploader-2.8.3-f5.33.0.linux
    #local uploader=ressys-www-uploader-2.8.3-f5.33.0.linux
    #local uploader=ressys-www-uploader-2.9.1-f5.34.1.linux
    #local uploader=ressys-www-uploader-2.9.2-f5.35.1.linux
    #local uploader=ressys-www-uploader-2.9.3-f5.35.2.linux
    local uploader=ressys-www-uploader-2.10.1-f5.36.1.linux

    echo "AWS_REGION=ap-southeast-2 ./$uploader -username $username -password $password -dpVersion $dpVersion -api $2 -bucket $bucket -threads=100 "${@:3}""
    AWS_REGION=ap-southeast-2 ./$uploader -username $username -password $password -dpVersion $dpVersion -api $2 -bucket $bucket -threads=100 "${@:3}"

    cd -
}

### Show available uploader versions
function show-uploader-versions() {
    aws s3 ls s3://deployment-max-mine-com/binaries/www-uploader/
}

### Get uploader
function get-uploader() {
    # Usage: get-uploader ressys-www-uploader-2.7.2-f5.30.0.linux

    # Go to uploader folder
    rsu

    # Download and set proper permissions
    aws s3 cp s3://deployment-max-mine-com/binaries/www-uploader/$1 .
    chmod +x $1

    # Go back
    cd -
}

### Convert HRC report
function hrc-convert() {
    cd ~/Downloads
    convert -density 150 ~/Downloads/$1-2020_HaulRoadConditionReport.pdf -quality 90 -flatten ~/Downloads/$1-2020_HaulRoadConditionReport.png
    cd -
}

# Load Qgis Maps
function qgismap() {
    nohup xdg-open /ressys/data-processing-configuration/utilities/qgis/$1.qgz </dev/null >/dev/null 2>&1 &
}

function yesterday-id() {
    date -d "24 hours ago" +%Y%m%d
}

function last-week-id() {
    date -d "7 days ago" +%Y%m%d
}

function last-month-id() {
    date -d "1 month ago" +%Y%m%d
}

function get-loads-and-dumps() {
    rm -rf "$HOME/Documents/QGIS/$1"
    mkdir -p "$HOME/Documents/QGIS/$1"

    docker run --name loads_and_dumps_1 -v ~:/root qgis-helper:latest -m "$1" --shift "$(yesterday-id)0,$(yesterday-id)1" -o "/root/Documents/QGIS/$1/yesterday_activity" -t -d -l
    docker run --name loads_and_dumps_2 -v ~:/root qgis-helper:latest -m "$1" --shift "$(last-week-id)0,$(yesterday-id)1" -o "/root/Documents/QGIS/$1/last_week_activity" -t -d -l
    docker run --name loads_and_dumps_3 -v ~:/root qgis-helper:latest -m "$1" --shift "$(last-month-id)0,$(yesterday-id)1" -o "/root/Documents/QGIS/$1/last_month_activity" -t -d -l

    docker wait loads_and_dumps_1
    docker wait loads_and_dumps_2
    docker wait loads_and_dumps_3

    docker rm loads_and_dumps_1
    docker rm loads_and_dumps_2
    docker rm loads_and_dumps_3

    sudo chown -R "$USER:" "$HOME/Documents/QGIS/$1"
}
