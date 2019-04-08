[![CircleCI](https://circleci.com/gh/bitkey-platform/bkp-ci.svg?style=svg)](https://circleci.com/gh/bitkey-platform/bkp-ci)
[![](https://images.microbadger.com/badges/image/bitkeyplatform/bkp-ci.svg)](https://microbadger.com/images/bitkeyplatform/bkp-ci "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/bitkeyplatform/bkp-ci.svg)](https://microbadger.com/images/bitkeyplatform/bkp-ci "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/commit/bitkeyplatform/bkp-ci.svg)](https://microbadger.com/images/bitkeyplatform/bkp-ci "Get your own commit badge on microbadger.com")

# bkp-ci

bkp teamのciで利用する共通のdocker image.

# リリース手順

1. 修正して、masterへmerge
2. githubのタブ「release」から、masterをbaseにして、versionを指定して、release.
3. ciが実行されて、dockerhubへのpushがsuccessしたら、release完了。
