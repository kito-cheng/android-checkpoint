#!/system/bin/sh

#/system/bin/app_process -Xzygote /system/bin --zygote --start-system-server

#exit

if [ $(ls /data/ckpt_*  | wc -l) -eq 2 ] ; 
then
  # The ckpt image exist, just restart
  if [ $(ls /data/ckpt_app_*  | wc -l) -eq 2 ] ;
  then
    # Rename ckpt_app_process_xxx-xxxx-xxx.dmtcp to
    # ckpt_zygote.dmtcp and ckpt_system_server.dmtcp
    ckpt=`ls /data/ckpt_app_* |head -1`
    mv $ckpt /data/ckpt_zygote.dmtcp
    ckpt=`ls /data/ckpt_app_* |head -1`
    mv $ckpt /data/ckpt_system_server.dmtcp
  fi
#  sleep 1
  /system/bin/dmtcp_restart /data/ckpt_zygote.dmtcp /data/ckpt_system_server.dmtcp

else
# Oop, no image exit, build image!
  /system/bin/dmtcp_checkpoint -n --no-gzip -c /data -t /data /system/bin/app_process -Xzygote /system/bin --zygote --start-system-server
fi

