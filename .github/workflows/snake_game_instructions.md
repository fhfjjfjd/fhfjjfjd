# Hướng Dẫn Chạy Trò Chơi Rắn Săn Mồi (Snake Game)

## 1. Giới thiệu
Trò chơi rắn săn mồi là một trò chơi cổ điển được phát triển bằng Python sử dụng thư viện `curses` để hiển thị giao diện đồ họa trong terminal.

## 2. Yêu cầu hệ thống
- Python 3.6 trở lên
- Hệ điều hành: Linux, macOS hoặc Windows (với WSL hoặc terminal hỗ trợ curses)

## 3. Cách chạy trò chơi

### Phương pháp 1: Chạy trực tiếp từ terminal
1. Mở terminal hoặc command prompt
2. Di chuyển đến thư mục chứa file `snake_game.py`
3. Chạy lệnh:
   ```bash
   python snake_game.py
   ```

### Phương pháp 2: Chạy với quyền thực thi
1. Đảm bảo file có quyền thực thi:
   ```bash
   chmod +x snake_game.py
   ```
2. Chạy bằng lệnh:
   ```bash
   ./snake_game.py
   ```

## 4. Điều khiển trò chơi
- Sử dụng các phím mũi tên (Up, Down, Left, Right) để điều khiển con rắn
- Nhấn 'q' để thoát trò chơi bất kỳ lúc nào
- Tránh va chạm với tường và thân rắn

## 5. Cách chơi
- Mục tiêu là điều khiển con rắn ăn các điểm thức ăn (food) để tăng độ dài
- Mỗi lần ăn thức ăn, điểm số sẽ tăng lên
- Trò chơi kết thúc khi rắn va chạm với tường hoặc chính thân của nó

## 6. Giao diện
- Rắn được biểu thị bằng các ký tự '#'
- Thức ăn được biểu thị bằng ký tự '*'
- Điểm số được hiển thị ở góc trên bên phải
- Bảng tin tức trò chơi được hiển thị ở góc dưới màn hình

## 7. Chế độ AI (nếu có)
- Nếu trò chơi hỗ trợ chế độ AI, có thể kích hoạt bằng cách thêm tham số '--ai' khi chạy:
  ```bash
  python snake_game.py --ai
  ```

## 8. Gỡ lỗi
- Nếu gặp lỗi liên quan đến curses, hãy đảm bảo rằng bạn đang sử dụng terminal hỗ trợ đồ họa curses
- Trên Windows, bạn có thể cần cài đặt gói Windows Curses: `pip install windows-curses`

## 9. Tùy chỉnh
- Có thể thay đổi tốc độ trò chơi, kích thước bảng hoặc các tham số khác bằng cách chỉnh sửa file cấu hình hoặc tham số dòng lệnh (nếu được hỗ trợ)