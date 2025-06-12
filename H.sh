#!/data/data/com.termux/files/usr/bin/bash

echo "🛠️ Đang cập nhật gói..."
pkg update -y && pkg upgrade -y

echo "🐍 Đang cài Python và pip..."
pkg install -y python

echo "📦 Đang nâng cấp pip..."
pip install --upgrade pip

echo "📁 Tạo môi trường ảo (agstudio-env)..."
python -m venv agstudio-env
source agstudio-env/bin/activate

echo "⬇️ Đang cài AutoGen Studio..."
pip install "autogenstudio[ui]"

echo "✅ Cài đặt hoàn tất!"
echo "🚀 Khởi chạy AutoGen Studio bằng lệnh:"
echo ""
echo "source agstudio-env/bin/activate && autogenstudio ui --port 8081"
echo ""
echo "🌐 Sau đó mở trình duyệt và truy cập http://localhost:8081"
