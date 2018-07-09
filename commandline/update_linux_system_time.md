# Run timedatectl 

```bash
$timedatectl

      Local time: 一 2018-07-09 17:24:01 CST
  Universal time: 一 2018-07-09 09:24:01 UTC
        RTC time: 一 2018-07-09 09:24:01
       Time zone: Asia/Shanghai (CST, +0800)
 Network time on: yes 
NTP synchronized: yes
 RTC in local TZ: no
```

# Upate date with `date` command

```bash
  $ sudo date date -s "20080401 12:00:01"
  
  2018年 06月 01日 星期五 13:58:00 CST
```

But if we run `date` again, the system date has not yet changed.

```bash
$date
2018年 07月 09日 星期一 17:28:54 CST
```

To have `date -s` work, we should turn off `ntp(network time protocol)`.

```bash
$ timedatectl set-ntp off
```

Then run `timedatectl` again, we will see the network time has been down.

```bash
  $ timedatectl  
  
      Local time: 一 2018-07-09 18:31:23 CST
  Universal time: 一 2018-07-09 10:31:23 UTC
        RTC time: 一 2018-07-09 10:31:23
       Time zone: Asia/Shanghai (CST, +0800)
 Network time on: no
NTP synchronized: yes
 RTC in local TZ: no
```

After that, we try set system time with `date` again, and we can see the `date` works now.

```bash
$ sudo date -s "20080401 12:00:01"
2008年 04月 01日 星期二 12:00:01 CST

$ date
2008年 04月 01日 星期二 12:00:46 CST
```
