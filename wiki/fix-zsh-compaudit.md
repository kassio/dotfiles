# Ignore insecure directories and continue

```
PATH=$PATH:/bin:/usr/bin:/sbin:/usr/sbin
compaudit | /usr/bin/xargs sudo chmod g-w
```
