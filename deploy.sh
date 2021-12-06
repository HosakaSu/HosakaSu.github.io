#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

initDist(){
  # echo $1 > base.js
  npm run build
  cd docs/.vuepress/dist
}

initDist "module.exports = '/HosakaSu.github.io/'"

# deploy to github
if [ -z "$GITHUB_TOKEN" ]; then
  msg='deploy'
  githubUrl=git@github.com:HosakaSu/HosakaSu.github.io.git
else
  msg='来自github actions的自动部署'
  githubUrl=https://HosakaSu:${GITHUB_TOKEN}@github.com/HosakaSu.github.io.git
  git config --global user.name "HosakaSu"
  git config --global user.email "liucjseu@outlook.com"
fi

initGit(){
  git init
  git add -A
  git commit -m "${msg}"
}
initGit
# git push -f $githubUrl master # 推送到github
git push -f git@github.com:HosakaSu/HosakaSu.github.io.git master:gh-pages

cd -
rm -rf docs/.vuepress/dist

