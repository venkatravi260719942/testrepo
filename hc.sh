#!/bin/bash

# Assign Jenkins URL and API token based on the selected controller from the parameter
case "$CONTROLLER" in
    "cont1")
        JENKINS_URL="https://jenkins-cont1.example.com"
        API_TOKEN="token_for_cont1"
        ;;
    "cont2")
        JENKINS_URL="https://jenkins-cont2.example.com"
        API_TOKEN="token_for_cont2"
        ;;
    "cont3")
        JENKINS_URL="https://jenkins-cont3.example.com"
        API_TOKEN="token_for_cont3"
        ;;
    *)
        echo "Invalid controller selected!"
        exit 1
        ;;
esac

# Username (same for all controllers)
USERNAME="svc-jenkinsadmin"

# Mapping job display names to actual Jenkins job paths
declare -A JOB_MAPPING
JOB_MAPPING["artifactory connection"]="hc_folder/artifactory.job"
JOB_MAPPING["freestyle https git clone test"]="hc_folder/freestylehttpsclone.job"
JOB_MAPPING["freestyle ssh git clone test"]="hc_folder/freestylesshclone.job"

# Loop through selected jobs and trigger each one
for JOB in $JOB_NAME; do
    ACTUAL_JOB_PATH=${JOB_MAPPING["$JOB"]}

    if [ -z "$ACTUAL_JOB_PATH" ]; then
        echo "Warning: No mapping found for job '$JOB'. Skipping..."
        continue
    fi

    TRIGGER_URL="${JENKINS_URL}/job/${ACTUAL_JOB_PATH}/build"
    
    echo "Triggering job: $JOB on $CONTROLLER ($JENKINS_URL)"
    echo "Actual Jenkins Job Path: $ACTUAL_JOB_PATH"

    curl -X POST "$TRIGGER_URL" --user "$USERNAME:$API_TOKEN"

    if [ $? -eq 0 ]; then
        echo "Successfully triggered: $JOB"
    else
        echo "Failed to trigger: $JOB"
    fi
done
