#set -x
#!/bin/bash/

find . -iname "*dockerfile*" -print -exec grep "FROM" {} \; | awk '{print $2}' >> ${GITHUB_WORKSPACE}/.github/output.txt
