#set -x
#!/bin/bash/

ECR_PREFIX="498031324058.dkr.ecr.us-east-1.amazonaws.com"

for path in $(find . -iname "*dockerfile*" -exec ls -l {} \;  |  awk '{print $NF}')
do
  ecr=$(grep -i FROM ${path} | awk '{print $2}' | awk -F"/" '{print $1}')
 if [[ ${ecr} != ${ECR_PREFIX} ]] ; then
    echo "ERROR: you are using incorrect ECR address"
    else
    echo "You can merge your PR against your base branch"
 fi
done
