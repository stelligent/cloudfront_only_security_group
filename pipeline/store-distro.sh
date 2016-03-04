#!/bin/bash -ex
set -o pipefail

git config --global user.email "build@build.com"
git config --global user.name "build"

current_version=$(ruby -e 'tags=`git tag -l v0\.0\.*`' \
                       -e 'p tags.lines.map { |tag| tag.sub(/v0.0./, "").chomp.to_i }.max')

if [[ ${current_version} == nil ]];
then
  new_version='0.0.1'
else
  new_version=0.0.$((current_version+1))
fi

sed -i "s/1.0.0-SNAPSHOT/${new_version}/g" pom.xml

mvn install

#on circle ci - head is ambiguous for reasons that i don't grok
#we haven't made the new tag and we can't if we are going to annotate
head=$(git log -n 1 --oneline | awk '{print $1}')

echo "Remember! You need to start your commit messages with #x, where x is the issue number your commit resolves."

if [[ ${current_version} == nil ]];
then
  log_rev_range=${head}
else
  log_rev_range="v0.0.${current_version}..${head}"
fi

issues=$(git log ${log_rev_range} --oneline | awk '{print $2}' | grep '^#' | uniq)

git tag -a v${new_version} -m "Issues with commits, not necessarily closed: ${issues}"

git push --tags

output_jar_name=cloudfront-only-security-group-${new_version}.jar

upload_result=$(aws s3api put-object --bucket stelligent-binary-artifact-repo \
                                     --key ${output_jar_name} \
                                     --body target/${output_jar_name})

echo upload_result=${upload_result}