#set -x
#!/bin/bash/

ECR_PREFIX="498031324058.dkr.ecr.us-east-1.amazonaws.com"
DOCKERFILE_LIST="incorrect-ecr-docker-files.txt"

env

> ${DOCKERFILE_LIST}

for path in $(find . -iname "*dockerfile*" -exec ls -l {} \;  |  awk '{print $NF}')
do
  ecr=$(grep -i FROM ${path} | awk '{print $2}' | awk -F"/" '{print $1}')

  if [[ ${ecr} != ${ECR_PREFIX} ]] ; then
    echo "WARN: ${path} dockerfile doesn't contain organization specific ECR address"
    echo ${path} >> ./${DOCKERFILE_LIST}
  else
    echo "INFO: You can merge your PR against your base branch"
  fi
done

if [[ -s ${DOCKERFILE_LIST} ]]; then
  echo "ERROR: Following docker file(s) doesn't contain organization certified ECR address."
  cat ${DOCKERFILE_LIST}
  exit 1
fi


for path in $(find . -iname "*dockerfile*" -exec ls -l {} \;  |  awk '{print $NF}'); do
  [[ $(grep FROM ./Dockerfile | awk '{print $2}' | awk -F"/" '{print $1}') == "498031324058.dkr.ecr.us-east-1.amazonaws.com" ]] || exit
