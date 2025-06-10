#!/bin/bash

# Cập nhật danh sách gói
echo "Đang cập nhật danh sách gói Termux..."
pkg update -y
pkg upgrade -y # Nên chạy cả upgrade để đảm bảo các gói hiện tại được cập nhật

# Cài đặt các công cụ thư viện
echo "Đang cài đặt các công cụ: git, curl, python..."
pkg install -y git curl python

echo "tiếp theo tôi sẽ cấp quyền."
chmod +x termux_install_tools.sh echo 'hoàn thành xong'
