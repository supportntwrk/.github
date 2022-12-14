#!/bin/bash/
set -x

ECR_PREFIX="498031324058.dkr.ecr.us-east-1.amazonaws.com"
DOCKERFILE_LIST="incorrect-ecr-docker-files.txt"

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

# opening file to see which docker files and under which branch it has been filtered
cat incorrect-ecr-docker-files.txt

if [[ -s ${DOCKERFILE_LIST} ]]; then
  echo "ERROR: Following docker file(s) doesn't contain organization certified ECR address."
  cat ${DOCKERFILE_LIST}
  exit 1
fi

