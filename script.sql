-- 1. Bảng Vai Trò (Role)
CREATE TABLE VaiTro (
    ID_VaiTro INT PRIMARY KEY IDENTITY(1,1),
    TenVaiTro NVARCHAR(50) NOT NULL,
    MieuTa NVARCHAR(MAX) NULL,
    TrangThai NVARCHAR(20) NOT NULL DEFAULT 'Active',
    NgayTao DATETIME NOT NULL DEFAULT GETDATE()
);

-- 2. Bảng Tài Khoản Người Dùng (User Account)
CREATE TABLE TaiKhoan (
    ID_TaiKhoan INT PRIMARY KEY IDENTITY(1,1),
    Email NVARCHAR(100) NOT NULL UNIQUE,
    MatKhau NVARCHAR(255) NOT NULL,
    ID_VaiTro INT NOT NULL,
    UserType NVARCHAR(20) NOT NULL,
    TrangThai NVARCHAR(20) NOT NULL DEFAULT 'Active',
    SoDienThoai NVARCHAR(15) NULL,
    NgayTao DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (ID_VaiTro) REFERENCES VaiTro(ID_VaiTro)
);

-- 3. Bảng Học Sinh (Student)
CREATE TABLE HocSinh (
    ID_HocSinh INT PRIMARY KEY IDENTITY(1,1),
    ID_TaiKhoan INT UNIQUE NOT NULL,
    HoTen NVARCHAR(100) NOT NULL,
    NgaySinh DATE NULL,
    GioiTinh NVARCHAR(3) NULL,
    DiaChi NVARCHAR(255) NULL,
    SDT_PhuHuynh NVARCHAR(15) NULL,
	ID_LopHoc INT Unique NOT NULL,
    TruongHoc NVARCHAR(255) NULL,
    GhiChu NVARCHAR(MAX) NULL,
    TrangThai NVARCHAR(20) NOT NULL DEFAULT 'Active',
    NgayTao DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (ID_TaiKhoan) REFERENCES TaiKhoan(ID_TaiKhoan)
);

-- 4. Bảng Phụ Huynh (Parent)
CREATE TABLE PhuHuynh (
    ID_PhuHuynh INT PRIMARY KEY IDENTITY(1,1),
    ID_TaiKhoan INT UNIQUE NOT NULL,
    HoTen NVARCHAR(100) NOT NULL,
    SDT NVARCHAR(15) NULL,
    Email NVARCHAR(100) NULL,
    DiaChi NVARCHAR(255) NULL,
    GhiChu NVARCHAR(MAX) NULL,
    TrangThai NVARCHAR(20) NOT NULL DEFAULT 'Active',
    NgayTao DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (ID_TaiKhoan) REFERENCES TaiKhoan(ID_TaiKhoan)
);

-- 5. Mối quan hệ Học Sinh - Phụ Huynh (Many-to-Many)
CREATE TABLE HocSinh_PhuHuynh (
    ID_HocSinh INT NOT NULL,
    ID_PhuHuynh INT NOT NULL,
    PRIMARY KEY (ID_HocSinh, ID_PhuHuynh),
    FOREIGN KEY (ID_HocSinh) REFERENCES HocSinh(ID_HocSinh) ON DELETE CASCADE,
    FOREIGN KEY (ID_PhuHuynh) REFERENCES PhuHuynh(ID_PhuHuynh) ON DELETE CASCADE
);

-- 6. Bảng Giáo Viên (Teacher)
CREATE TABLE GiaoVien (
    ID_GiaoVien INT PRIMARY KEY IDENTITY(1,1),
    ID_TaiKhoan INT UNIQUE NOT NULL,
    HoTen NVARCHAR(100) NOT NULL,
    ChuyenMon NVARCHAR(100) NULL,
    SDT NVARCHAR(15) NULL,
	ID_LopHoc INT Unique NOT NULL,
    TruongGiangDay NVARCHAR(255) NULL,
    Luong DECIMAL(10,2) NULL,
    GhiChu NVARCHAR(MAX) NULL,
    TrangThai NVARCHAR(20) NOT NULL DEFAULT 'Active',
    NgayTao DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (ID_TaiKhoan) REFERENCES TaiKhoan(ID_TaiKhoan)
);

-- 7. Bảng Khóa Học (Course)
CREATE TABLE KhoaHoc (
    ID_KhoaHoc INT PRIMARY KEY IDENTITY(1,1),
    TenKhoaHoc NVARCHAR(100) NOT NULL,
    MoTa NVARCHAR(MAX) NULL,
    HocPhi DECIMAL(10,2) NULL,
    ThoiGianBatDau DATE NULL,
    SiSo INT NULL,
    ThoiGianKetThuc DATE NULL,
    GhiChu NVARCHAR(MAX) NULL,
    TrangThai NVARCHAR(20) NOT NULL DEFAULT 'Active',
    NgayTao DATETIME NOT NULL DEFAULT GETDATE()
);

-- 8. Quan hệ Giáo viên - Khóa học (Many-to-Many)
CREATE TABLE GiaoVien_KhoaHoc (
    ID_GiaoVien INT NOT NULL,
    ID_KhoaHoc INT NOT NULL,
    PRIMARY KEY (ID_GiaoVien, ID_KhoaHoc),
    FOREIGN KEY (ID_GiaoVien) REFERENCES GiaoVien(ID_GiaoVien) ON DELETE CASCADE,
    FOREIGN KEY (ID_KhoaHoc) REFERENCES KhoaHoc(ID_KhoaHoc) ON DELETE CASCADE
);

-- 9. Bảng Lớp Học (Class)
CREATE TABLE LopHoc (
    ID_LopHoc INT PRIMARY KEY IDENTITY(6,1),
    ID_KhoaHoc INT NOT NULL,
    ThoiGianHoc NVARCHAR(50) NULL,
    GhiChu NVARCHAR(MAX) NULL,
    TrangThai NVARCHAR(20) NOT NULL DEFAULT 'Active',
    NgayTao DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (ID_KhoaHoc) REFERENCES KhoaHoc(ID_KhoaHoc) ON DELETE CASCADE
);

-- 10. Học sinh - Lớp học (Many-to-Many)
CREATE TABLE HocSinh_LopHoc (
    ID_HocSinh INT NOT NULL,
    ID_LopHoc INT NOT NULL,
    NgayBatDau DATE NULL,
    TrangThai NVARCHAR(50) NULL,
    PRIMARY KEY (ID_HocSinh, ID_LopHoc),
    FOREIGN KEY (ID_HocSinh) REFERENCES HocSinh(ID_HocSinh) ON DELETE CASCADE,
    FOREIGN KEY (ID_LopHoc) REFERENCES LopHoc(ID_LopHoc) ON DELETE CASCADE
);

-- 11. Đăng ký khóa học (Student Course Registration)
CREATE TABLE DangKyKhoaHoc (
    ID_HocSinh INT NOT NULL,
    ID_KhoaHoc INT NOT NULL,
    NgayDangKy DATE NOT NULL DEFAULT GETDATE(),
    TinhTrangHocPhi NVARCHAR(50) NULL,
    PRIMARY KEY (ID_HocSinh, ID_KhoaHoc),
    FOREIGN KEY (ID_HocSinh) REFERENCES HocSinh(ID_HocSinh) ON DELETE CASCADE,
    FOREIGN KEY (ID_KhoaHoc) REFERENCES KhoaHoc(ID_KhoaHoc) ON DELETE CASCADE
);

-- 12. Bảng điểm (Scores)
CREATE TABLE Diem (
    ID_Diem INT PRIMARY KEY IDENTITY(1,1),
    ID_HocSinh INT NOT NULL,
    ID_KhoaHoc INT NOT NULL,
    DiemKiemTra DECIMAL(5,2) NULL,
    DiemBaiTap DECIMAL(5,2) NULL,
    DiemGiuaKy DECIMAL(5,2) NULL,
    DiemCuoiKy DECIMAL(5,2) NULL,
    DiemTongKet DECIMAL(5,2) NULL,
    ThoiGianCapNhat DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (ID_HocSinh) REFERENCES HocSinh(ID_HocSinh) ON DELETE CASCADE,
    FOREIGN KEY (ID_KhoaHoc) REFERENCES KhoaHoc(ID_KhoaHoc) ON DELETE CASCADE
);

-- 13. Bảng học phí (Tuition Fees)
CREATE TABLE HocPhi (
    ID_HocPhi INT PRIMARY KEY IDENTITY(1,1),
    ID_HocSinh INT NOT NULL,
    Lop NVARCHAR(50) NULL,
    MonHoc NVARCHAR(50) NULL,
    SoTien DECIMAL(10,2) NOT NULL,
    PhuongThucThanhToan NVARCHAR(50) NULL,
    TinhTrangThanhToan NVARCHAR(50) NULL,
    NgayThanhToan DATE NULL,
    GhiChu NVARCHAR(MAX) NULL,
    FOREIGN KEY (ID_HocSinh) REFERENCES HocSinh(ID_HocSinh) ON DELETE CASCADE
);

-- 14. Tài liệu do giáo viên upload (Uploaded Materials)
CREATE TABLE UploadMaterials (
    ID_Material INT PRIMARY KEY IDENTITY(1,1),
    ID_GiaoVien INT NOT NULL,
    ID_KhoaHoc INT NOT NULL,
    TenTaiLieu NVARCHAR(100) NOT NULL,
    LoaiTaiLieu NVARCHAR(50) NULL,
    DuongDan NVARCHAR(255) NOT NULL,
    NgayTao DATE NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (ID_GiaoVien) REFERENCES GiaoVien(ID_GiaoVien) ON DELETE CASCADE,
    FOREIGN KEY (ID_KhoaHoc) REFERENCES KhoaHoc(ID_KhoaHoc) ON DELETE CASCADE
);

-- 15. Bài tập do giáo viên tạo (Homework)
CREATE TABLE CreateHomework (
    ID_BaiTap INT PRIMARY KEY IDENTITY(1,1),
    ID_GiaoVien INT NOT NULL,
    ID_KhoaHoc INT NOT NULL,
    TenBaiTap NVARCHAR(100) NOT NULL,
    MoTa NVARCHAR(MAX) NULL,
    NgayTao DATE NOT NULL DEFAULT GETDATE(),
    Deadline DATE NULL,
    FOREIGN KEY (ID_GiaoVien) REFERENCES GiaoVien(ID_GiaoVien) ON DELETE CASCADE,
    FOREIGN KEY (ID_KhoaHoc) REFERENCES KhoaHoc(ID_KhoaHoc) ON DELETE CASCADE
);


-- 16. Điểm danh học sinh (Attendance)
CREATE TABLE DiemDanh (
    ID_DiemDanh INT PRIMARY KEY IDENTITY(1,1),
    ID_HocSinh INT NOT NULL,
    ID_KhoaHoc INT NOT NULL,
    NgayHoc DATE NOT NULL,
    TrangThai NVARCHAR(50) NULL,
    LyDoVang NVARCHAR(MAX) NULL,
    FOREIGN KEY (ID_HocSinh) REFERENCES HocSinh(ID_HocSinh) ON DELETE CASCADE,
    FOREIGN KEY (ID_KhoaHoc) REFERENCES KhoaHoc(ID_KhoaHoc) ON DELETE CASCADE
);

-- 17. Nhật ký hoạt động người dùng (User Logs)
CREATE TABLE UserLogs (
    ID_Log INT PRIMARY KEY IDENTITY(1,1),
    ID_TaiKhoan INT NOT NULL,
    HanhDong NVARCHAR(255) NOT NULL,
    ThoiGian DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (ID_TaiKhoan) REFERENCES TaiKhoan(ID_TaiKhoan) ON DELETE CASCADE
);

-- 18. Thông báo cho người dùng (Notifications)
CREATE TABLE Notification (
    ID_ThongBao INT PRIMARY KEY IDENTITY(1,1),
    ID_TaiKhoan INT NOT NULL,
    NoiDung NVARCHAR(MAX) NULL,
    ThoiGian DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (ID_TaiKhoan) REFERENCES TaiKhoan(ID_TaiKhoan) ON DELETE CASCADE
);

-- 19. Lịch học (Schedule)
CREATE TABLE Schedule (
    ID_Schedule INT PRIMARY KEY IDENTITY(1,1),
    ID_KhoaHoc INT NOT NULL,
    NgayHoc DATE NOT NULL,
    GioHoc NVARCHAR(50) NULL,
    GhiChu NVARCHAR(MAX) NULL,
    FOREIGN KEY (ID_KhoaHoc) REFERENCES KhoaHoc(ID_KhoaHoc) ON DELETE CASCADE
);
