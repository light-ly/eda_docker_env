#!/bin/bash

# 输出文件
output_file="user_cmd.txt"

# 清空输出文件内容
> "$output_file"

# 获取所有组并生成 groupadd 命令
getent group | while IFS=: read -r group_name group_pass group_id group_members; do
    echo "groupadd -g $group_id $group_name" >> "$output_file"
done

# 获取所有用户并生成 useradd 命令
getent passwd | while IFS=: read -r username password uid gid full_name home shell; do
    # 获取用户所属组的名字
    group_name=$(getent group "$gid" | cut -d: -f1)
    
    # 如果该用户没有登录 shell（例如系统用户），则忽略该用户
    if [[ "$shell" == "/sbin/nologin" || "$shell" == "/bin/false" ]]; then
        continue
    fi
    
    # 输出 useradd 命令
    echo "useradd -u $uid -g $gid -G $group_name -d $home -s $shell $username" >> "$output_file"
done

echo "用户和组创建命令已保存到 $output_file"

