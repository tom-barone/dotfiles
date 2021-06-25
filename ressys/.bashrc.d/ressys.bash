# shellcheck source=/dev/null

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
alias start-office-vpn='sudo /etc/init.d/vpnclient start'
alias stop-office-vpn='sudo /etc/init.d/vpnclient stop'

## Functions
### Goto repo
# TODO: add these to rs-go-typical if they are that useful
function rs-go-falcon() {
    echo "Going to falcon repo and setting proper env."
    echo cd /ressys/reporting-www-gopath/src/bitbucket.org/resolutionsystems/falcon/
    cd /ressys/reporting-www-gopath/src/bitbucket.org/resolutionsystems/falcon/ || exit
}

function rs-go-maxmine-www-tests() {
    echo "Going to maxmine-www-tests repo and setting proper env."
    echo cd /ressys/reporting-www-gopath/src/bitbucket.org/resolutionsystems/maxmine-www-tests/
    cd /ressys/reporting-www-gopath/src/bitbucket.org/resolutionsystems/maxmine-www-tests/ || exit
}

### Get minesite configuration
function get-minesite-config() {
    # Usage: get-minesite-config <minesite_id>
    curl --silent -u "$(MMResCreds)" https://python-dashboard.max-mine.com/central-resources-api/minesiteconfigurations | jq -r '.minesiteconfigurations[] | select(.MinesiteId=="'$1'")'
}

### Get minesite results bucket
function get-minesite-bucket() {
    # usage: get-minesite-bucket <minesite_id>
    get-minesite-config "$1" | jq -r '.ResultsBucketAWSARN' | grep -o "mm.*$"
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
    #local dpVersion=20200929-v8.12-f5.36
    local dpVersion=20210223-v8.14-f5.38
    #local dpVersion=mgc-integration-testing-03

    local bucket=$(get-minesite-bucket "$1")
    #local uploader=ressys-www-uploader-2.8.2-f5.32.0.linux
    #local uploader=ressys-www-uploader-9.9.9+DevProductivity-429ffcbe.linux
    #local uploader=ressys-www-uploader-2.8.3-f5.33.0.linux
    #local uploader=ressys-www-uploader-2.8.3-f5.33.0.linux
    #local uploader=ressys-www-uploader-2.9.1-f5.34.1.linux
    #local uploader=ressys-www-uploader-2.9.2-f5.35.1.linux
    #local uploader=ressys-www-uploader-2.9.3-f5.35.2.linux
    #local uploader=ressys-www-uploader-2.10.1-f5.36.1.linux
    local uploader=ressys-www-uploader-2.11.1-f5.38.linux

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

### QGIS functions

# Load qgis map for a minesite
function qgismap() {
    # usage: qgismap <minesite_id>
    
    # Set the .qgs file so when used with xdg-open, it'll open it in QGIS
    xdg-mime default org.qgis.qgis.desktop application/x-qgis-project

    # Open the QGIS file
    nohup xdg-open "/ressys/data-processing-configuration/utilities/qgis/$1.qgz" </dev/null >/dev/null 2>&1 &
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
    # usage: get-loads-and-dumps <minesite_id>

    # Store current directory for later
    cwd=$(pwd)

    # Remove old loads and dumps files
    rm -rf "$HOME/Documents/QGIS/$1"
    mkdir -p "$HOME/Documents/QGIS/$1"

    # Run the analysis container to retrieve loads, dumps and locuses
    docker run --name loads_and_dumps_1 -v ~:/root qgis-helper:latest -m "$1" --shift "$(yesterday-id)0,$(yesterday-id)1" -o "/root/Documents/QGIS/$1/yesterday_activity" -t -d -l
    docker run --name loads_and_dumps_2 -v ~:/root qgis-helper:latest -m "$1" --shift "$(last-week-id)0,$(yesterday-id)1" -o "/root/Documents/QGIS/$1/last_week_activity" -t -d -l
    docker run --name loads_and_dumps_3 -v ~:/root qgis-helper:latest -m "$1" --shift "$(last-month-id)0,$(yesterday-id)1" -o "/root/Documents/QGIS/$1/last_month_activity" -t -d -l

    # Wait for all containers to finish
    docker wait loads_and_dumps_1
    docker wait loads_and_dumps_2
    docker wait loads_and_dumps_3

    # Remove all containers
    docker rm loads_and_dumps_1
    docker rm loads_and_dumps_2
    docker rm loads_and_dumps_3

    # Remove root permsissions from the files
    sudo chown -R "$USER:" "$HOME/Documents/QGIS/$1"

    # Rename the output files so they have no dates. This means that QGIS won't complain
    # when running the script with the latest data
    #   rename(Dumps_202102210-202102211.csv, Dumps.csv)
    #   rename(Loads_202102210-202102211.csv, Loads.csv)
    #   rename(WKTLocuses_202102210-202102211.csv, WKTLocuses.csv)
    for dir in $HOME/Documents/QGIS/$1/*; do
        cd "$dir" || exit 1
        for file in *; do
            rename 's/[\d\-\_]//g' "$file"
            for i in Dumps Loads WKTLocuses; do
                sed -i -e "/$i/s/[0-9]*//g" ./*.vrt
                sed -i -e "/$i/s/\_//g" ./*.vrt
                sed -i -e "/$i/s/\-//g" ./*.vrt
            done
        done
    done

    # Restore the directory from before running the script
    cd "$cwd" || return
}

function check-map-features() {
    # usage: check-map-features <minesite_id>
    minesite_id=$1

    cd /ressys/data-processing-configuration/utilities || exit

    echo "Running clean_geojson.py..."
    pipenv run python clean_geojson.py --map-features "../$minesite_id/map-features/v001/mapFeatures.geojson" --out-file "../$minesite_id/map-features/v001/mapFeatures.geojson"
    echo "Running check_for_overlapping_regions.py..."
    pipenv run python check_for_overlapping_regions.py "../$minesite_id/map-features/v001/mapFeatures.geojson"
    echo "Running validate_v1_features.py..."
    pipenv run python validate_v1_features.py --map-features "../$minesite_id/map-features/v001/mapFeatures.geojson"

    cd - || exit
}
