# Image to run generic cron tasks.  
  
## Included packages/software  
    dcron  
    curl   
    wget  
    rsync  
    ca-certificates  

## Crond
Image is designed to run crontabs as root.  This means that your cron tab file needs to be placed in specific locations  

crontab file (root, contains run-parts schedules):  
    /etc/crontabs/root  
  
run-parts files:  
    /etc/periodic/15min/  
    /etc/periodic/hourly/  
    /etc/periodic/daily/  
    /etc/periodic/weekly/  
    /etc/periodic/monthly/  
  
run-parts files are basically sh files without the extension.  Here are some tips when making these files:  
  Make sure the script is executable (chmod a+x [scriptname])  
  Make sure the first line of the script is: #!/bin/sh  
  The file name cannot have an extension!  
  
  ## Example Run Command
  ```
  docker run -d  \
  --name my-crond \
  --restart="unless-stopped" \
  --mount type=bind,source=/etc/localtime,target=/etc/localtime,readonly \
  --mount type=bind,source=./myscript,target="/etc/periodic/15min/myscript",readonly \
  wolfereign/crond:latest
  ```
  
  The above command will bind mount a run-parts script/file to the containers directory that gets run every 15 minutes.
  
  ## Example Script (myscript)
  ```
  #!/bin/sh
  echo "hello world!" >> /root/myscript.log
  ```
