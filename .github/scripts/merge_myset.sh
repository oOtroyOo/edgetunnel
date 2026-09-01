#!/usr/bin/env bash
# 从 cmliu/edgetunnel 上游拉取, 切换到上游 main, 再将 myset 合并到上游之上.
# 只做本地操作, 不提交不推送; 部署内容为合并后的工作区文件.
set -euo pipefail

echo "==> configure git identity (runner default is empty)"
git config user.name "github-actions[bot]"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"

echo "==> add upstream remote"
git remote add upstream https://github.com/cmliu/edgetunnel.git

echo "==> fetch upstream main"
git fetch upstream main

echo "==> switch to upstream main as base"
git checkout -b merged upstream/main

echo "==> merge myset onto upstream (ours=upstream, theirs=myset; keep myset on conflict)"
git merge -X theirs myset

echo "==> recent commits: hash / author / datetime / subject"
git log --pretty=format:'%h  %an  %ad  %s' --date=format:'%Y-%m-%d %H:%M:%S' -10
