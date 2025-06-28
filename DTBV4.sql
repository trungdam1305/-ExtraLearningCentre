
USE SWP 
GO

/****** Object:  Table [dbo].[VaiTro]    Script Date: 26/06/2025 23:16:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VaiTro](
    [ID_VaiTro] [int] IDENTITY(1,1) NOT NULL,
    [TenVaiTro] [nvarchar](50) NOT NULL,
    [MieuTa] [nvarchar](max) NULL,
    [TrangThai] [nvarchar](20) NOT NULL DEFAULT 'Active',
    [NgayTao] [datetime] NOT NULL DEFAULT GETDATE(),
    CONSTRAINT [PK_VaiTro] PRIMARY KEY CLUSTERED ([ID_VaiTro] ASC)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 26/06/2025 23:16:00 ******/
CREATE TABLE [dbo].[TaiKhoan](
    [ID_TaiKhoan] [int] IDENTITY(1,1) NOT NULL,
    [Email] [nvarchar](100) NOT NULL,
    [MatKhau] [nvarchar](255) NOT NULL,
    [ID_VaiTro] [int] NOT NULL,
    [UserType] [nvarchar](20) NOT NULL,
    [SoDienThoai] [nvarchar](15) NULL,
    [TrangThai] [nvarchar](20) NOT NULL DEFAULT 'Active',
    [NgayTao] [datetime] NOT NULL DEFAULT GETDATE(),
    CONSTRAINT [PK_TaiKhoan] PRIMARY KEY CLUSTERED ([ID_TaiKhoan] ASC),
    CONSTRAINT [UQ_TaiKhoan_Email] UNIQUE NONCLUSTERED ([Email] ASC),
    CONSTRAINT [FK_TaiKhoan_VaiTro] FOREIGN KEY ([ID_VaiTro]) REFERENCES [dbo].[VaiTro] ([ID_VaiTro])
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[TruongHoc]    Script Date: 26/06/2025 23:16:00 ******/
CREATE TABLE [dbo].[TruongHoc](
    [ID_TruongHoc] [int] IDENTITY(1,1) NOT NULL,
    [TenTruongHoc] [nvarchar](max) NOT NULL,
    [DiaChi] [nvarchar](max) NULL,
    CONSTRAINT [PK_TruongHoc] PRIMARY KEY CLUSTERED ([ID_TruongHoc] ASC)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[KhoiHoc]    Script Date: 26/06/2025 23:16:00 ******/
CREATE TABLE [dbo].[KhoiHoc](
    [ID_Khoi] [int] IDENTITY(1,1) NOT NULL,
    [TenKhoi] [nvarchar](50) NOT NULL,
    [Status_Khoi] [bit] NOT NULL DEFAULT 1,
    CONSTRAINT [PK_KhoiHoc] PRIMARY KEY CLUSTERED ([ID_Khoi] ASC)
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[PhongHoc]    Script Date: 26/06/2025 23:16:00 ******/
CREATE TABLE [dbo].[PhongHoc](
    [ID_PhongHoc] [int] IDENTITY(1,1) NOT NULL,
    [TenPhongHoc] [nvarchar](50) NOT NULL,
    [SucChua] [int] NOT NULL,
    [TrangThai] [nvarchar](20) NOT NULL DEFAULT 'Active',
    CONSTRAINT [PK_PhongHoc] PRIMARY KEY CLUSTERED ([ID_PhongHoc] ASC)
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[GiaoVien]    Script Date: 26/06/2025 23:16:00 ******/
CREATE TABLE [dbo].[GiaoVien](
    [ID_GiaoVien] [int] IDENTITY(1,1) NOT NULL,
    [ID_TaiKhoan] [int] NOT NULL,
    [HoTen] [nvarchar](100) NOT NULL,
    [ChuyenMon] [nvarchar](100) NULL,
    [SDT] [nvarchar](15) NULL,
    [ID_TruongHoc] [int] NOT NULL,
    [Luong] [decimal](10, 2) NULL,
    [IsHot] [int] NULL,
    [TrangThai] [nvarchar](20) NOT NULL DEFAULT 'Active',
    [NgayTao] [datetime] NOT NULL DEFAULT GETDATE(),
    [Avatar] [nvarchar](max) NULL,
    [BangCap] [nvarchar](50) NULL,
    [LopDangDayTrenTruong] [nvarchar](50) NULL,
    [TrangThaiDay] [nvarchar](20) NULL,
    CONSTRAINT [PK_GiaoVien] PRIMARY KEY CLUSTERED ([ID_GiaoVien] ASC),
    CONSTRAINT [UQ_GiaoVien_ID_TaiKhoan] UNIQUE NONCLUSTERED ([ID_TaiKhoan] ASC),
    CONSTRAINT [FK_GiaoVien_TaiKhoan] FOREIGN KEY ([ID_TaiKhoan]) REFERENCES [dbo].[TaiKhoan] ([ID_TaiKhoan]),
    CONSTRAINT [FK_GiaoVien_TruongHoc] FOREIGN KEY ([ID_TruongHoc]) REFERENCES [dbo].[TruongHoc] ([ID_TruongHoc])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[HocSinh]    Script Date: 26/06/2025 23:16:00 ******/
CREATE TABLE [dbo].[HocSinh](
    [ID_HocSinh] [int] IDENTITY(1,1) NOT NULL,
    [MaHocSinh] [nvarchar](20) NOT NULL,
    [ID_TaiKhoan] [int] NULL,
    [HoTen] [nvarchar](100) NOT NULL,
    [NgaySinh] [date] NULL,
    [GioiTinh] [nvarchar](3) NULL,
    [DiaChi] [nvarchar](255) NOT NULL,
    [SDT_PhuHuynh] [nvarchar](15) NOT NULL,
    [ID_TruongHoc] [int] NOT NULL,
    [GhiChu] [nvarchar](max) NULL,
    [TrangThai] [nvarchar](20) NOT NULL DEFAULT 'Active',
    [NgayTao] [datetime] NOT NULL DEFAULT GETDATE(),
    [LopDangHocTrenTruong] [nvarchar](50) NULL,
    [TrangThaiHoc] [nvarchar](20) NULL,
    [Avatar] [nvarchar](max) NULL,
    CONSTRAINT [PK_HocSinh] PRIMARY KEY CLUSTERED ([ID_HocSinh] ASC),
    CONSTRAINT [UQ_HocSinh_MaHocSinh] UNIQUE NONCLUSTERED ([MaHocSinh] ASC),
    CONSTRAINT [UQ_HocSinh_ID_TaiKhoan] UNIQUE NONCLUSTERED ([ID_TaiKhoan] ASC),
    CONSTRAINT [FK_HocSinh_TaiKhoan] FOREIGN KEY ([ID_TaiKhoan]) REFERENCES [dbo].[TaiKhoan] ([ID_TaiKhoan]),
    CONSTRAINT [FK_HocSinh_TruongHoc] FOREIGN KEY ([ID_TruongHoc]) REFERENCES [dbo].[TruongHoc] ([ID_TruongHoc])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[PhuHuynh]    Script Date: 26/06/2025 23:16:00 ******/
CREATE TABLE [dbo].[PhuHuynh](
    [ID_PhuHuynh] [int] IDENTITY(1,1) NOT NULL,
    [ID_TaiKhoan] [int] NULL,
    [HoTen] [nvarchar](100) NOT NULL,
    [SDT] [nvarchar](15) NULL,
    [Email] [nvarchar](100) NULL,
    [DiaChi] [nvarchar](255) NULL,
    [GhiChu] [nvarchar](max) NULL,
    [TrangThai] [nvarchar](20) NOT NULL DEFAULT 'Active',
    [NgayTao] [datetime] NOT NULL DEFAULT GETDATE(),
    CONSTRAINT [PK_PhuHuynh] PRIMARY KEY CLUSTERED ([ID_PhuHuynh] ASC),
    CONSTRAINT [UQ_PhuHuynh_ID_TaiKhoan] UNIQUE NONCLUSTERED ([ID_TaiKhoan] ASC),
    CONSTRAINT [FK_PhuHuynh_TaiKhoan] FOREIGN KEY ([ID_TaiKhoan]) REFERENCES [dbo].[TaiKhoan] ([ID_TaiKhoan])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[KhoaHoc]    Script Date: 26/06/2025 23:16:00 ******/
CREATE TABLE [dbo].[KhoaHoc](
    [ID_KhoaHoc] [int] IDENTITY(1,1) NOT NULL,
    [CourseCode] [nvarchar](20) NOT NULL,
    [TenKhoaHoc] [nvarchar](100) NOT NULL,
    [MoTa] [nvarchar](max) NULL,
    [ThoiGianBatDau] [date] NULL,
    [ThoiGianKetThuc] [date] NULL,
    [GhiChu] [nvarchar](max) NULL,
    [TrangThai] [nvarchar](20) NOT NULL DEFAULT 'Active',
    [NgayTao] [datetime] NOT NULL DEFAULT GETDATE(),
    [ID_Khoi] [int] NULL,
    [Image] [nvarchar](max) NULL,
    [Order] [int] NULL,
    CONSTRAINT [PK_KhoaHoc] PRIMARY KEY CLUSTERED ([ID_KhoaHoc] ASC),
    CONSTRAINT [UQ_KhoaHoc_CourseCode] UNIQUE NONCLUSTERED ([CourseCode] ASC),
    CONSTRAINT [FK_KhoaHoc_KhoiHoc] FOREIGN KEY ([ID_Khoi]) REFERENCES [dbo].[KhoiHoc] ([ID_Khoi])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[LopHoc]    Script Date: 26/06/2025 23:16:00 ******/
CREATE TABLE [dbo].[LopHoc](
    [ID_LopHoc] [int] IDENTITY(1,1) NOT NULL,
    [ClassCode] [nvarchar](20) NOT NULL,
    [TenLopHoc] [nvarchar](100) NOT NULL,
    [ID_KhoaHoc] [int] NULL,
    [SiSo] [int] NULL,
    [SiSoToiDa] [int] NULL,
    [SiSoToiThieu] [int] NULL,
    [ID_Schedule] [int] NULL,
    [ID_PhongHoc] [int] NULL,
    [GhiChu] [nvarchar](max) NULL,
    [TrangThai] [nvarchar](20) NOT NULL DEFAULT 'Active',
    [SoTien] [nvarchar](10) NULL,
    [NgayTao] [datetime] NOT NULL DEFAULT GETDATE(),
    [Image] [nvarchar](max) NULL,
    [Order] [int] NULL,
    CONSTRAINT [PK_LopHoc] PRIMARY KEY CLUSTERED ([ID_LopHoc] ASC),
    CONSTRAINT [UQ_LopHoc_ClassCode] UNIQUE NONCLUSTERED ([ClassCode] ASC),
    CONSTRAINT [FK_LopHoc_KhoaHoc] FOREIGN KEY ([ID_KhoaHoc]) REFERENCES [dbo].[KhoaHoc] ([ID_KhoaHoc]),
    CONSTRAINT [FK_LopHoc_PhongHoc] FOREIGN KEY ([ID_PhongHoc]) REFERENCES [dbo].[PhongHoc] ([ID_PhongHoc])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[SlotHoc]    Script Date: 26/06/2025 23:16:00 ******/
CREATE TABLE [dbo].[SlotHoc](
    [ID_SlotHoc] [int] IDENTITY(1,1) NOT NULL,
    [SlotThoiGian] [nvarchar](max) NOT NULL,
    CONSTRAINT [PK_SlotHoc] PRIMARY KEY CLUSTERED ([ID_SlotHoc] ASC)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[LichHoc]    Script Date: 26/06/2025 23:16:00 ******/
CREATE TABLE [dbo].[LichHoc](
    [ID_Schedule] [int] IDENTITY(1,1) NOT NULL,
    [NgayHoc] [date] NOT NULL,
    [ID_SlotHoc] [int] NOT NULL,
    [ID_LopHoc] [int] NULL,
    [ID_PhongHoc] [int] NULL,
    [GhiChu] [nvarchar](max) NULL,
    CONSTRAINT [PK_LichHoc] PRIMARY KEY CLUSTERED ([ID_Schedule] ASC),
    CONSTRAINT [FK_LichHoc_SlotHoc] FOREIGN KEY ([ID_SlotHoc]) REFERENCES [dbo].[SlotHoc] ([ID_SlotHoc]),
    CONSTRAINT [FK_LichHoc_LopHoc] FOREIGN KEY ([ID_LopHoc]) REFERENCES [dbo].[LopHoc] ([ID_LopHoc]),
    CONSTRAINT [FK_LichHoc_PhongHoc] FOREIGN KEY ([ID_PhongHoc]) REFERENCES [dbo].[PhongHoc] ([ID_PhongHoc])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[GiaoVien_LopHoc]    Script Date: 26/06/2025 23:16:00 ******/
CREATE TABLE [dbo].[GiaoVien_LopHoc](
    [ID_GiaoVien] [int] NOT NULL,
    [ID_LopHoc] [int] NOT NULL,
    CONSTRAINT [PK_GiaoVien_LopHoc] PRIMARY KEY CLUSTERED ([ID_GiaoVien] ASC, [ID_LopHoc] ASC),
    CONSTRAINT [FK_GiaoVien_LopHoc_GiaoVien] FOREIGN KEY ([ID_GiaoVien]) REFERENCES [dbo].[GiaoVien] ([ID_GiaoVien]),
    CONSTRAINT [FK_GiaoVien_LopHoc_LopHoc] FOREIGN KEY ([ID_LopHoc]) REFERENCES [dbo].[LopHoc] ([ID_LopHoc])
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[HocSinh_LopHoc]    Script Date: 26/06/2025 23:16:00 ******/
CREATE TABLE [dbo].[HocSinh_LopHoc](
    [ID_HSLopHoc] [int] IDENTITY(1,1) NOT NULL,
    [ID_LopHoc] [int] NULL,
    [ID_HocSinh] [int] NULL,
    [FeedBack] [nvarchar](max) NULL,
    [Status_FeedBack] [bit] NULL,
    CONSTRAINT [PK_HocSinh_LopHoc] PRIMARY KEY CLUSTERED ([ID_HSLopHoc] ASC),
    CONSTRAINT [FK_HocSinh_LopHoc_HocSinh] FOREIGN KEY ([ID_HocSinh]) REFERENCES [dbo].[HocSinh] ([ID_HocSinh]),
    CONSTRAINT [FK_HocSinh_LopHoc_LopHoc] FOREIGN KEY ([ID_LopHoc]) REFERENCES [dbo].[LopHoc] ([ID_LopHoc])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[DangKyLopHoc]    Script Date: 26/06/2025 23:16:00 ******/
CREATE TABLE [dbo].[DangKyLopHoc](
    [ID_HocSinh] [int] NOT NULL,
    [ID_LopHoc] [int] NOT NULL,
    [NgayDangKy] [date] NOT NULL DEFAULT GETDATE(),
    [TinhTrangHocPhi] [nvarchar](50) NULL,
    CONSTRAINT [PK_DangKyLopHoc] PRIMARY KEY CLUSTERED ([ID_HocSinh] ASC, [ID_LopHoc] ASC),
    CONSTRAINT [FK_DangKyLopHoc_HocSinh] FOREIGN KEY ([ID_HocSinh]) REFERENCES [dbo].[HocSinh] ([ID_HocSinh]),
    CONSTRAINT [FK_DangKyLopHoc_LopHoc] FOREIGN KEY ([ID_LopHoc]) REFERENCES [dbo].[LopHoc] ([ID_LopHoc])
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[HocPhi]    Script Date: 26/06/2025 23:16:00 ******/
CREATE TABLE [dbo].[HocPhi](
    [ID_HocPhi] [int] IDENTITY(1,1) NOT NULL,
    [ID_HocSinh] [int] NULL,
    [ID_LopHoc] [int] NULL,
    [MonHoc] [nvarchar](50) NULL,
    [PhuongThucThanhToan] [nvarchar](50) NULL,
    [TinhTrangThanhToan] [nvarchar](50) NULL,
    [NgayThanhToan] [date] NULL,
    [GhiChu] [nvarchar](max) NULL,
    CONSTRAINT [PK_HocPhi] PRIMARY KEY CLUSTERED ([ID_HocPhi] ASC),
    CONSTRAINT [FK_HocPhi_HocSinh] FOREIGN KEY ([ID_HocSinh]) REFERENCES [dbo].[HocSinh] ([ID_HocSinh]),
    CONSTRAINT [FK_HocPhi_LopHoc] FOREIGN KEY ([ID_LopHoc]) REFERENCES [dbo].[LopHoc] ([ID_LopHoc])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[ThongBao]    Script Date: 26/06/2025 23:16:00 ******/
CREATE TABLE [dbo].[ThongBao](
    [ID_ThongBao] [int] IDENTITY(1,1) NOT NULL,
    [ID_TaiKhoan] [int] NOT NULL,
    [NoiDung] [nvarchar](max) NULL,
    [ID_HocPhi] [int] NULL,
    [ThoiGian] [datetime] NOT NULL DEFAULT GETDATE(),
    CONSTRAINT [PK_ThongBao] PRIMARY KEY CLUSTERED ([ID_ThongBao] ASC),
    CONSTRAINT [FK_ThongBao_TaiKhoan] FOREIGN KEY ([ID_TaiKhoan]) REFERENCES [dbo].[TaiKhoan] ([ID_TaiKhoan]) ON DELETE CASCADE,
    CONSTRAINT [FK_ThongBao_HocPhi] FOREIGN KEY ([ID_HocPhi]) REFERENCES [dbo].[HocPhi] ([ID_HocPhi])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[TaoBaiTap]    Script Date: 26/06/2025 23:16:00 ******/
CREATE TABLE [dbo].[TaoBaiTap](
    [ID_BaiTap] [int] IDENTITY(1,1) NOT NULL,
    [ID_GiaoVien] [int] NULL,
    [TenBaiTap] [nvarchar](100) NOT NULL,
    [MoTa] [nvarchar](max) NULL,
    [NgayTao] [date] NOT NULL DEFAULT GETDATE(),
    [ID_LopHoc] [int] NULL,
    [Deadline] [date] NULL,
    CONSTRAINT [PK_TaoBaiTap] PRIMARY KEY CLUSTERED ([ID_BaiTap] ASC),
    CONSTRAINT [FK_TaoBaiTap_GiaoVien] FOREIGN KEY ([ID_GiaoVien]) REFERENCES [dbo].[GiaoVien] ([ID_GiaoVien]),
    CONSTRAINT [FK_TaoBaiTap_LopHoc] FOREIGN KEY ([ID_LopHoc]) REFERENCES [dbo].[LopHoc] ([ID_LopHoc])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[NopBaiTap]    Script Date: 26/06/2025 23:16:00 ******/
CREATE TABLE [dbo].[NopBaiTap](
    [ID_HocSinh] [int] NOT NULL,
    [ID_BaiTap] [int] NOT NULL,
    [TepNop] [nvarchar](255) NULL,
    [NgayNop] [date] NOT NULL DEFAULT GETDATE(),
    [Diem] [decimal](5, 2) NULL,
    [NhanXet] [nvarchar](max) NULL,
    CONSTRAINT [PK_NopBaiTap] PRIMARY KEY CLUSTERED ([ID_HocSinh] ASC, [ID_BaiTap] ASC),
    CONSTRAINT [FK_NopBaiTap_HocSinh] FOREIGN KEY ([ID_HocSinh]) REFERENCES [dbo].[HocSinh] ([ID_HocSinh]),
    CONSTRAINT [FK_NopBaiTap_TaoBaiTap] FOREIGN KEY ([ID_BaiTap]) REFERENCES [dbo].[TaoBaiTap] ([ID_BaiTap])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Diem]    Script Date: 26/06/2025 23:16:00 ******/
CREATE TABLE [dbo].[Diem](
    [ID_Diem] [int] IDENTITY(1,1) NOT NULL,
    [ID_HocSinh] [int] NULL,
    [ID_LopHoc] [int] NULL,
    [DiemKiemTra] [decimal](5, 2) NULL,
    [DiemBaiTap] [decimal](5, 2) NULL,
    [DiemGiuaKy] [decimal](5, 2) NULL,
    [DiemCuoiKy] [decimal](5, 2) NULL,
    [DiemTongKet] AS (((([DiemKiemTra]+[DiemBaiTap])+[DiemGiuaKy])+[DiemCuoiKy])/(4)) PERSISTED,
    [ThoiGianCapNhat] [datetime] NOT NULL DEFAULT GETDATE(),
    CONSTRAINT [PK_Diem] PRIMARY KEY CLUSTERED ([ID_Diem] ASC),
    CONSTRAINT [FK_Diem_HocSinh] FOREIGN KEY ([ID_HocSinh]) REFERENCES [dbo].[HocSinh] ([ID_HocSinh]),
    CONSTRAINT [FK_Diem_LopHoc] FOREIGN KEY ([ID_LopHoc]) REFERENCES [dbo].[LopHoc] ([ID_LopHoc])
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[DiemDanh]    Script Date: 26/06/2025 23:16:00 ******/
CREATE TABLE [dbo].[DiemDanh](
    [ID_DiemDanh] [int] IDENTITY(1,1) NOT NULL,
    [ID_HocSinh] [int] NULL,
    [ID_Schedule] [int] NULL,
    [TrangThai] [nvarchar](50) NULL,
    [LyDoVang] [nvarchar](max) NULL,
    CONSTRAINT [PK_DiemDanh] PRIMARY KEY CLUSTERED ([ID_DiemDanh] ASC),
    CONSTRAINT [FK_DiemDanh_HocSinh] FOREIGN KEY ([ID_HocSinh]) REFERENCES [dbo].[HocSinh] ([ID_HocSinh]),
    CONSTRAINT [FK_DiemDanh_LichHoc] FOREIGN KEY ([ID_Schedule]) REFERENCES [dbo].[LichHoc] ([ID_Schedule])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[PhanLoaiBlog]    Script Date: 26/06/2025 23:16:00 ******/
CREATE TABLE [dbo].[PhanLoaiBlog](
    [ID_PhanLoai] [int] IDENTITY(1,1) NOT NULL,
    [PhanLoai] [nvarchar](max) NULL,
    CONSTRAINT [PK_PhanLoaiBlog] PRIMARY KEY CLUSTERED ([ID_PhanLoai] ASC)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Blog]    Script Date: 26/06/2025 23:16:00 ******/
CREATE TABLE [dbo].[Blog](
    [ID_Blog] [int] IDENTITY(1,1) NOT NULL,
    [BlogTitle] [nvarchar](max) NULL,
    [BlogDescription] [nvarchar](max) NULL,
    [BlogDate] [date] NULL,
    [Image] [nvarchar](max) NULL,
    [ID_Khoi] [int] NULL,
    [ID_PhanLoai] [int] NULL,
    [KeyTag] [nvarchar](max) NULL,
    [Keyword] [nvarchar](max) NULL,
    CONSTRAINT [PK_Blog] PRIMARY KEY CLUSTERED ([ID_Blog] ASC),
    CONSTRAINT [FK_Blog_KhoiHoc] FOREIGN KEY ([ID_Khoi]) REFERENCES [dbo].[KhoiHoc] ([ID_Khoi]),
    CONSTRAINT [FK_Blog_PhanLoaiBlog] FOREIGN KEY ([ID_PhanLoai]) REFERENCES [dbo].[PhanLoaiBlog] ([ID_PhanLoai])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[DangTaiLieu]    Script Date: 26/06/2025 23:16:00 ******/
CREATE TABLE [dbo].[DangTaiLieu](
    [ID_Material] [int] IDENTITY(1,1) NOT NULL,
    [ID_GiaoVien] [int] NULL,
    [TenTaiLieu] [nvarchar](100) NOT NULL,
    [LoaiTaiLieu] [nvarchar](50) NULL,
    [DuongDan] [nvarchar](255) NULL,
    [NgayTao] [date] NOT NULL DEFAULT GETDATE(),
    [DanhMuc] [nvarchar](max) NULL,
    [GiaTien] [nvarchar](max) NULL,
    [Image] [nvarchar](max) NULL,
    CONSTRAINT [PK_DangTaiLieu] PRIMARY KEY CLUSTERED ([ID_Material] ASC),
    CONSTRAINT [FK_DangTaiLieu_GiaoVien] FOREIGN KEY ([ID_GiaoVien]) REFERENCES [dbo].[GiaoVien] ([ID_GiaoVien])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[HoTro]    Script Date: 26/06/2025 23:16:00 ******/
CREATE TABLE [dbo].[HoTro](
    [ID_HoTro] [int] IDENTITY(1,1) NOT NULL,
    [HoTen] [nvarchar](100) NULL,
    [TenHoTro] [nvarchar](100) NULL,
    [ThoiGian] [datetime] NULL,
    [MoTa] [nvarchar](255) NULL,
    [ID_TaiKhoan] [int] NULL,
    CONSTRAINT [PK_HoTro] PRIMARY KEY CLUSTERED ([ID_HoTro] ASC),
    CONSTRAINT [FK_HoTro_TaiKhoan] FOREIGN KEY ([ID_TaiKhoan]) REFERENCES [dbo].[TaiKhoan] ([ID_TaiKhoan])
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Slider]    Script Date: 26/06/2025 23:16:00 ******/
CREATE TABLE [dbo].[Slider](
    [ID_Slider] [int] IDENTITY(1,1) NOT NULL,
    [Title] [nvarchar](max) NULL,
    [Image] [nvarchar](max) NULL,
    [BackLink] [nvarchar](max) NULL,
    CONSTRAINT [PK_Slider] PRIMARY KEY CLUSTERED ([ID_Slider] ASC)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Admin]    Script Date: 26/06/2025 23:16:00 ******/
CREATE TABLE [dbo].[Admin](
    [ID_Admin] [int] IDENTITY(1,1) NOT NULL,
    [ID_TaiKhoan] [int] NOT NULL,
    [HoTen] [nvarchar](max) NULL,
    [Avatar] [nvarchar](max) NULL,
    CONSTRAINT [PK_Admin] PRIMARY KEY CLUSTERED ([ID_Admin] ASC),
    CONSTRAINT [FK_Admin_TaiKhoan] FOREIGN KEY ([ID_TaiKhoan]) REFERENCES [dbo].[TaiKhoan] ([ID_TaiKhoan])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Staff]    Script Date: 26/06/2025 23:16:00 ******/
CREATE TABLE [dbo].[Staff](
    [ID_Staff] [int] IDENTITY(1,1) NOT NULL,
    [ID_TaiKhoan] [int] NOT NULL,
    [HoTen] [nvarchar](max) NOT NULL,
    [Avatar] [nvarchar](max) NOT NULL,
    CONSTRAINT [PK_Staff] PRIMARY KEY CLUSTERED ([ID_Staff] ASC),
    CONSTRAINT [FK_Staff_TaiKhoan] FOREIGN KEY ([ID_TaiKhoan]) REFERENCES [dbo].[TaiKhoan] ([ID_TaiKhoan])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[UserLogs]    Script Date: 26/06/2025 23:16:00 ******/
CREATE TABLE [dbo].[UserLogs](
    [ID_Log] [int] IDENTITY(1,1) NOT NULL,
    [ID_TaiKhoan] [int] NULL,
    [HanhDong] [nvarchar](255) NULL,
    [ThoiGian] [datetime] NOT NULL DEFAULT GETDATE(),
    CONSTRAINT [PK_UserLogs] PRIMARY KEY CLUSTERED ([ID_Log] ASC),
    CONSTRAINT [FK_UserLogs_TaiKhoan] FOREIGN KEY ([ID_TaiKhoan]) REFERENCES [dbo].[TaiKhoan] ([ID_TaiKhoan])
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[HocSinh_PhuHuynh]    Script Date: 26/06/2025 23:16:00 ******/
CREATE TABLE [dbo].[HocSinh_PhuHuynh](
    [ID_HocSinh] [int] NOT NULL,
    [ID_PhuHuynh] [int] NOT NULL,
    CONSTRAINT [PK_HocSinh_PhuHuynh] PRIMARY KEY CLUSTERED ([ID_HocSinh] ASC, [ID_PhuHuynh] ASC),
    CONSTRAINT [FK_HocSinh_PhuHuynh_HocSinh] FOREIGN KEY ([ID_HocSinh]) REFERENCES [dbo].[HocSinh] ([ID_HocSinh]),
    CONSTRAINT [FK_HocSinh_PhuHuynh_PhuHuynh] FOREIGN KEY ([ID_PhuHuynh]) REFERENCES [dbo].[PhuHuynh] ([ID_PhuHuynh])
) ON [PRIMARY]
GO

/****** Trigger to ensure max 10 classes per time slot ******/
CREATE TRIGGER [dbo].[LimitClassesPerTimeSlot]
ON [dbo].[LichHoc]
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @NgayHoc date, @ID_SlotHoc int, @Count int
    
    SELECT @NgayHoc = NgayHoc, @ID_SlotHoc = ID_SlotHoc
    FROM inserted
    
    SELECT @Count = COUNT(*)
    FROM [dbo].[LichHoc]
    WHERE NgayHoc = @NgayHoc AND ID_SlotHoc = @ID_SlotHoc
    
    IF @Count > 10
    BEGIN
        RAISERROR ('Cannot schedule more than 10 classes in the same time slot.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

/****** Insert Data ******/

-- VaiTro
SET IDENTITY_INSERT [dbo].[VaiTro] ON 
INSERT [dbo].[VaiTro] ([ID_VaiTro], [TenVaiTro], [MieuTa], [TrangThai], [NgayTao]) VALUES 
(1, N'Admin', N'Quản trị hệ thống, có toàn quyền điều khiển', N'Active', CAST(N'2025-05-24T18:28:39.913' AS DateTime)),
(2, N'Staff', N'Nhân viên hỗ trợ, có quyền điều khiển hệ thống ở mức giới hạn', N'Active', CAST(N'2025-05-24T18:28:39.913' AS DateTime)),
(3, N'GiaoVien', N'Giáo viên giảng dạy, quản lý lớp học và học sinh', N'Active', CAST(N'2025-05-24T18:28:39.913' AS DateTime)),
(4, N'HocSinh', N'Học sinh tham gia các khóa học', N'Active', CAST(N'2025-05-24T18:28:39.913' AS DateTime)),
(5, N'PhuHuynh', N'Phụ huynh học sinh, theo dõi kết quả học tập', N'Active', CAST(N'2025-05-24T18:28:39.913' AS DateTime))
SET IDENTITY_INSERT [dbo].[VaiTro] OFF
GO

-- TaiKhoan (163 tài khoản: 1 Admin, 2 Staff, 10 GiaoVien, 100 HocSinh, 50 PhuHuynh)
SET IDENTITY_INSERT [dbo].[TaiKhoan] ON 
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES 
-- Admin
(1, N'admin1@example.com', N'adminpass1', 1, N'Admin', N'0123456789', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime)),
-- Staff
(2, N'staff1@example.com', N'staffpass1', 2, N'Staff', N'0123987654', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime)),
(3, N'staff2@example.com', N'staffpass2', 2, N'Staff', N'0123987655', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime)),
-- GiaoVien
(4, N'giaovien1@example.com', N'gvpass1', 3, N'GiaoVien', N'0987654321', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime)),
(5, N'giaovien2@example.com', N'gvpass2', 3, N'GiaoVien', N'0987654322', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime)),
(6, N'giaovien3@example.com', N'gvpass3', 3, N'GiaoVien', N'0987654323', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime)),
(7, N'giaovien4@example.com', N'gvpass4', 3, N'GiaoVien', N'0987654324', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime)),
(8, N'giaovien5@example.com', N'gvpass5', 3, N'GiaoVien', N'0987654325', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime)),
(9, N'giaovien6@example.com', N'gvpass6', 3, N'GiaoVien', N'0987654326', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime)),
(10, N'giaovien7@example.com', N'gvpass7', 3, N'GiaoVien', N'0987654327', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime)),
(11, N'giaovien8@example.com', N'gvpass8', 3, N'GiaoVien', N'0987654328', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime)),
(12, N'giaovien9@example.com', N'gvpass9', 3, N'GiaoVien', N'0987654329', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime)),
(13, N'giaovien10@example.com', N'gvpass10', 3, N'GiaoVien', N'0987654330', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime)),
-- HocSinh (100 bản ghi)
(14, N'hocsinh1@example.com', N'hspass1', 4, N'HocSinh', N'0911222331', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(15, N'hocsinh2@example.com', N'hspass2', 4, N'HocSinh', N'0911222332', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(16, N'hocsinh3@example.com', N'hspass3', 4, N'HocSinh', N'0911222333', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(17, N'hocsinh4@example.com', N'hspass4', 4, N'HocSinh', N'0911222334', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(18, N'hocsinh5@example.com', N'hspass5', 4, N'HocSinh', N'0911222335', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(19, N'hocsinh6@example.com', N'hspass6', 4, N'HocSinh', N'0911222336', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(20, N'hocsinh7@example.com', N'hspass7', 4, N'HocSinh', N'0911222337', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(21, N'hocsinh8@example.com', N'hspass8', 4, N'HocSinh', N'0911222338', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(22, N'hocsinh9@example.com', N'hspass9', 4, N'HocSinh', N'0911222339', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(23, N'hocsinh10@example.com', N'hspass10', 4, N'HocSinh', N'0911222340', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(24, N'hocsinh11@example.com', N'hspass11', 4, N'HocSinh', N'0911222341', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(25, N'hocsinh12@example.com', N'hspass12', 4, N'HocSinh', N'0911222342', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(26, N'hocsinh13@example.com', N'hspass13', 4, N'HocSinh', N'0911222343', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(27, N'hocsinh14@example.com', N'hspass14', 4, N'HocSinh', N'0911222344', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(28, N'hocsinh15@example.com', N'hspass15', 4, N'HocSinh', N'0911222345', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(29, N'hocsinh16@example.com', N'hspass16', 4, N'HocSinh', N'0911222346', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(30, N'hocsinh17@example.com', N'hspass17', 4, N'HocSinh', N'0911222347', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(31, N'hocsinh18@example.com', N'hspass18', 4, N'HocSinh', N'0911222348', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(32, N'hocsinh19@example.com', N'hspass19', 4, N'HocSinh', N'0911222349', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(33, N'hocsinh20@example.com', N'hspass20', 4, N'HocSinh', N'0911222350', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(34, N'hocsinh21@example.com', N'hspass21', 4, N'HocSinh', N'0911222351', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(35, N'hocsinh22@example.com', N'hspass22', 4, N'HocSinh', N'0911222352', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(36, N'hocsinh23@example.com', N'hspass23', 4, N'HocSinh', N'0911222353', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(37, N'hocsinh24@example.com', N'hspass24', 4, N'HocSinh', N'0911222354', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(38, N'hocsinh25@example.com', N'hspass25', 4, N'HocSinh', N'0911222355', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(39, N'hocsinh26@example.com', N'hspass26', 4, N'HocSinh', N'0911222356', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(40, N'hocsinh27@example.com', N'hspass27', 4, N'HocSinh', N'0911222357', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(41, N'hocsinh28@example.com', N'hspass28', 4, N'HocSinh', N'0911222358', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(42, N'hocsinh29@example.com', N'hspass29', 4, N'HocSinh', N'0911222359', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(43, N'hocsinh30@example.com', N'hspass30', 4, N'HocSinh', N'0911222360', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(44, N'hocsinh31@example.com', N'hspass31', 4, N'HocSinh', N'0911222361', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(45, N'hocsinh32@example.com', N'hspass32', 4, N'HocSinh', N'0911222362', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(46, N'hocsinh33@example.com', N'hspass33', 4, N'HocSinh', N'0911222363', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(47, N'hocsinh34@example.com', N'hspass34', 4, N'HocSinh', N'0911222364', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(48, N'hocsinh35@example.com', N'hspass35', 4, N'HocSinh', N'0911222365', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(49, N'hocsinh36@example.com', N'hspass36', 4, N'HocSinh', N'0911222366', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(50, N'hocsinh37@example.com', N'hspass37', 4, N'HocSinh', N'0911222367', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(51, N'hocsinh38@example.com', N'hspass38', 4, N'HocSinh', N'0911222368', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(52, N'hocsinh39@example.com', N'hspass39', 4, N'HocSinh', N'0911222369', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(53, N'hocsinh40@example.com', N'hspass40', 4, N'HocSinh', N'0911222370', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(54, N'hocsinh41@example.com', N'hspass41', 4, N'HocSinh', N'0911222371', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(55, N'hocsinh42@example.com', N'hspass42', 4, N'HocSinh', N'0911222372', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(56, N'hocsinh43@example.com', N'hspass43', 4, N'HocSinh', N'0911222373', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(57, N'hocsinh44@example.com', N'hspass44', 4, N'HocSinh', N'0911222374', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(58, N'hocsinh45@example.com', N'hspass45', 4, N'HocSinh', N'0911222375', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(59, N'hocsinh46@example.com', N'hspass46', 4, N'HocSinh', N'0911222376', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(60, N'hocsinh47@example.com', N'hspass47', 4, N'HocSinh', N'0911222377', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(61, N'hocsinh48@example.com', N'hspass48', 4, N'HocSinh', N'0911222378', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(62, N'hocsinh49@example.com', N'hspass49', 4, N'HocSinh', N'0911222379', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(63, N'hocsinh50@example.com', N'hspass50', 4, N'HocSinh', N'0911222380', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(64, N'hocsinh51@example.com', N'hspass51', 4, N'HocSinh', N'0911222381', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(65, N'hocsinh52@example.com', N'hspass52', 4, N'HocSinh', N'0911222382', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(66, N'hocsinh53@example.com', N'hspass53', 4, N'HocSinh', N'0911222383', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(67, N'hocsinh54@example.com', N'hspass54', 4, N'HocSinh', N'0911222384', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(68, N'hocsinh55@example.com', N'hspass55', 4, N'HocSinh', N'0911222385', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(69, N'hocsinh56@example.com', N'hspass56', 4, N'HocSinh', N'0911222386', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(70, N'hocsinh57@example.com', N'hspass57', 4, N'HocSinh', N'0911222387', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(71, N'hocsinh58@example.com', N'hspass58', 4, N'HocSinh', N'0911222388', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(72, N'hocsinh59@example.com', N'hspass59', 4, N'HocSinh', N'0911222389', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(73, N'hocsinh60@example.com', N'hspass60', 4, N'HocSinh', N'0911222390', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(74, N'hocsinh61@example.com', N'hspass61', 4, N'HocSinh', N'0911222391', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(75, N'hocsinh62@example.com', N'hspass62', 4, N'HocSinh', N'0911222392', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(76, N'hocsinh63@example.com', N'hspass63', 4, N'HocSinh', N'0911222393', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(77, N'hocsinh64@example.com', N'hspass64', 4, N'HocSinh', N'0911222394', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(78, N'hocsinh65@example.com', N'hspass65', 4, N'HocSinh', N'0911222395', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(79, N'hocsinh66@example.com', N'hspass66', 4, N'HocSinh', N'0911222396', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(80, N'hocsinh67@example.com', N'hspass67', 4, N'HocSinh', N'0911222397', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(81, N'hocsinh68@example.com', N'hspass68', 4, N'HocSinh', N'0911222398', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(82, N'hocsinh69@example.com', N'hspass69', 4, N'HocSinh', N'0911222399', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(83, N'hocsinh70@example.com', N'hspass70', 4, N'HocSinh', N'0911222400', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(84, N'hocsinh71@example.com', N'hspass71', 4, N'HocSinh', N'0911222401', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(85, N'hocsinh72@example.com', N'hspass72', 4, N'HocSinh', N'0911222402', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(86, N'hocsinh73@example.com', N'hspass73', 4, N'HocSinh', N'0911222403', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(87, N'hocsinh74@example.com', N'hspass74', 4, N'HocSinh', N'0911222404', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(88, N'hocsinh75@example.com', N'hspass75', 4, N'HocSinh', N'0911222405', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(89, N'hocsinh76@example.com', N'hspass76', 4, N'HocSinh', N'0911222406', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(90, N'hocsinh77@example.com', N'hspass77', 4, N'HocSinh', N'0911222407', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(91, N'hocsinh78@example.com', N'hspass78', 4, N'HocSinh', N'0911222408', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(92, N'hocsinh79@example.com', N'hspass79', 4, N'HocSinh', N'0911222409', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(93, N'hocsinh80@example.com', N'hspass80', 4, N'HocSinh', N'0911222410', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(94, N'hocsinh81@example.com', N'hspass81', 4, N'HocSinh', N'0911222411', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(95, N'hocsinh82@example.com', N'hspass82', 4, N'HocSinh', N'0911222412', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(96, N'hocsinh83@example.com', N'hspass83', 4, N'HocSinh', N'0911222413', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(97, N'hocsinh84@example.com', N'hspass84', 4, N'HocSinh', N'0911222414', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(98, N'hocsinh85@example.com', N'hspass85', 4, N'HocSinh', N'0911222415', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(99, N'hocsinh86@example.com', N'hspass86', 4, N'HocSinh', N'0911222416', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(100, N'hocsinh87@example.com', N'hspass87', 4, N'HocSinh', N'0911222417', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(101, N'hocsinh88@example.com', N'hspass88', 4, N'HocSinh', N'0911222418', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(102, N'hocsinh89@example.com', N'hspass89', 4, N'HocSinh', N'0911222419', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(103, N'hocsinh90@example.com', N'hspass90', 4, N'HocSinh', N'0911222420', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(104, N'hocsinh91@example.com', N'hspass91', 4, N'HocSinh', N'0911222421', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(105, N'hocsinh92@example.com', N'hspass92', 4, N'HocSinh', N'0911222422', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(106, N'hocsinh93@example.com', N'hspass93', 4, N'HocSinh', N'0911222423', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(107, N'hocsinh94@example.com', N'hspass94', 4, N'HocSinh', N'0911222424', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(108, N'hocsinh95@example.com', N'hspass95', 4, N'HocSinh', N'0911222425', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(109, N'hocsinh96@example.com', N'hspass96', 4, N'HocSinh', N'0911222426', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(110, N'hocsinh97@example.com', N'hspass97', 4, N'HocSinh', N'0911222427', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(111, N'hocsinh98@example.com', N'hspass98', 4, N'HocSinh', N'0911222428', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(112, N'hocsinh99@example.com', N'hspass99', 4, N'HocSinh', N'0911222429', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(113, N'hocsinh100@example.com', N'hspass100', 4, N'HocSinh', N'0911222430', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
-- PhuHuynh (50 bản ghi)
(114, N'phuhuynh1@example.com', N'phupass1', 5, N'PhuHuynh', N'0900111231', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(115, N'phuhuynh2@example.com', N'phupass2', 5, N'PhuHuynh', N'0900111232', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(116, N'phuhuynh3@example.com', N'phupass3', 5, N'PhuHuynh', N'0900111233', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(117, N'phuhuynh4@example.com', N'phupass4', 5, N'PhuHuynh', N'0900111234', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(118, N'phuhuynh5@example.com', N'phupass5', 5, N'PhuHuynh', N'0900111235', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(119, N'phuhuynh6@example.com', N'phupass6', 5, N'PhuHuynh', N'0900111236', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(120, N'phuhuynh7@example.com', N'phupass7', 5, N'PhuHuynh', N'0900111237', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(121, N'phuhuynh8@example.com', N'phupass8', 5, N'PhuHuynh', N'0900111238', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(122, N'phuhuynh9@example.com', N'phupass9', 5, N'PhuHuynh', N'0900111239', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(123, N'phuhuynh10@example.com', N'phupass10', 5, N'PhuHuynh', N'0900111240', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(124, N'phuhuynh11@example.com', N'phupass11', 5, N'PhuHuynh', N'0900111241', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(125, N'phuhuynh12@example.com', N'phupass12', 5, N'PhuHuynh', N'0900111242', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(126, N'phuhuynh13@example.com', N'phupass13', 5, N'PhuHuynh', N'0900111243', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(127, N'phuhuynh14@example.com', N'phupass14', 5, N'PhuHuynh', N'0900111244', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(128, N'phuhuynh15@example.com', N'phupass15', 5, N'PhuHuynh', N'0900111245', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(129, N'phuhuynh16@example.com', N'phupass16', 5, N'PhuHuynh', N'0900111246', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(130, N'phuhuynh17@example.com', N'phupass17', 5, N'PhuHuynh', N'0900111247', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(131, N'phuhuynh18@example.com', N'phupass18', 5, N'PhuHuynh', N'0900111248', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(132, N'phuhuynh19@example.com', N'phupass19', 5, N'PhuHuynh', N'0900111249', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(133, N'phuhuynh20@example.com', N'phupass20', 5, N'PhuHuynh', N'0900111250', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(134, N'phuhuynh21@example.com', N'phupass21', 5, N'PhuHuynh', N'0900111251', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(135, N'phuhuynh22@example.com', N'phupass22', 5, N'PhuHuynh', N'0900111252', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(136, N'phuhuynh23@example.com', N'phupass23', 5, N'PhuHuynh', N'0900111253', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(137, N'phuhuynh24@example.com', N'phupass24', 5, N'PhuHuynh', N'0900111254', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(138, N'phuhuynh25@example.com', N'phupass25', 5, N'PhuHuynh', N'0900111255', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(139, N'phuhuynh26@example.com', N'phupass26', 5, N'PhuHuynh', N'0900111256', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(140, N'phuhuynh27@example.com', N'phupass27', 5, N'PhuHuynh', N'0900111257', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(141, N'phuhuynh28@example.com', N'phupass28', 5, N'PhuHuynh', N'0900111258', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(142, N'phuhuynh29@example.com', N'phupass29', 5, N'PhuHuynh', N'0900111259', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(143, N'phuhuynh30@example.com', N'phupass30', 5, N'PhuHuynh', N'0900111260', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(144, N'phuhuynh31@example.com', N'phupass31', 5, N'PhuHuynh', N'0900111261', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(145, N'phuhuynh32@example.com', N'phupass32', 5, N'PhuHuynh', N'0900111262', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(146, N'phuhuynh33@example.com', N'phupass33', 5, N'PhuHuynh', N'0900111263', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(147, N'phuhuynh34@example.com', N'phupass34', 5, N'PhuHuynh', N'0900111264', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(148, N'phuhuynh35@example.com', N'phupass35', 5, N'PhuHuynh', N'0900111265', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(149, N'phuhuynh36@example.com', N'phupass36', 5, N'PhuHuynh', N'0900111266', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(150, N'phuhuynh37@example.com', N'phupass37', 5, N'PhuHuynh', N'0900111267', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(151, N'phuhuynh38@example.com', N'phupass38', 5, N'PhuHuynh', N'0900111268', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(152, N'phuhuynh39@example.com', N'phupass39', 5, N'PhuHuynh', N'0900111269', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(153, N'phuhuynh40@example.com', N'phupass40', 5, N'PhuHuynh', N'0900111270', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(154, N'phuhuynh41@example.com', N'phupass41', 5, N'PhuHuynh', N'0900111271', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(155, N'phuhuynh42@example.com', N'phupass42', 5, N'PhuHuynh', N'0900111272', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(156, N'phuhuynh43@example.com', N'phupass43', 5, N'PhuHuynh', N'0900111273', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(157, N'phuhuynh44@example.com', N'phupass44', 5, N'PhuHuynh', N'0900111274', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(158, N'phuhuynh45@example.com', N'phupass45', 5, N'PhuHuynh', N'0900111275', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(159, N'phuhuynh46@example.com', N'phupass46', 5, N'PhuHuynh', N'0900111276', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(160, N'phuhuynh47@example.com', N'phupass47', 5, N'PhuHuynh', N'0900111277', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(161, N'phuhuynh48@example.com', N'phupass48', 5, N'PhuHuynh', N'0900111278', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(162, N'phuhuynh49@example.com', N'phupass49', 5, N'PhuHuynh', N'0900111279', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(163, N'phuhuynh50@example.com', N'phupass50', 5, N'PhuHuynh', N'0900111280', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[TaiKhoan] OFF
GO

-- TruongHoc
SET IDENTITY_INSERT [dbo].[TruongHoc] ON 
INSERT [dbo].[TruongHoc] ([ID_TruongHoc], [TenTruongHoc], [DiaChi]) VALUES 
(1, N'Trường THPT Hà Nội - Amsterdam', N'1. Hoàng Minh Giám, Trung Hòa, Cầu Giấy, Hà Nội'),
(2, N'Trường THPT Nguyễn Trãi - Ba Đình', N'50 P. Nam Cao, Giảng Võ, Ba Đình, Hà Nội'),
(3, N'Trường THPT Chuyên Chu Văn An', N'10 Đ. Thụy Khuê, Thuỵ Khuê, Tây Hồ, Hà Nội'),
(4, N'Trường THCS Lê Quý Đôn', N'123 Đường Láng, Đống Đa, Hà Nội'),
(5, N'Trường THPT Trần Phú', N'8 Hai Bà Trưng, Hoàn Kiếm, Hà Nội')
SET IDENTITY_INSERT [dbo].[TruongHoc] OFF
GO

-- KhoiHoc
SET IDENTITY_INSERT [dbo].[KhoiHoc] ON 
INSERT [dbo].[KhoiHoc] ([ID_Khoi], [TenKhoi], [Status_Khoi]) VALUES 
(1, N'Khối 6', 1),
(2, N'Khối 7', 1),
(3, N'Khối 8', 1),
(4, N'Khối 9', 1),
(5, N'Khối 10', 1),
(6, N'Khối 11', 1),
(7, N'Khối 12', 1),
(8, N'Khối Tổng Ôn', 1)
SET IDENTITY_INSERT [dbo].[KhoiHoc] OFF
GO

-- PhongHoc
SET IDENTITY_INSERT [dbo].[PhongHoc] ON 
INSERT [dbo].[PhongHoc] ([ID_PhongHoc], [TenPhongHoc], [SucChua], [TrangThai]) VALUES 
(1, N'Phòng 101', 40, N'Active'),
(2, N'Phòng 102', 40, N'Active'),
(3, N'Phòng 103', 40, N'Active'),
(4, N'Phòng 104', 40, N'Active'),
(5, N'Phòng 105', 40, N'Active')
SET IDENTITY_INSERT [dbo].[PhongHoc] OFF
GO

-- GiaoVien (10 bản ghi, sử dụng ID_TaiKhoan từ 4-13)
SET IDENTITY_INSERT [dbo].[GiaoVien] ON 
INSERT [dbo].[GiaoVien] ([ID_GiaoVien], [ID_TaiKhoan], [HoTen], [ChuyenMon], [SDT], [ID_TruongHoc], [Luong], [IsHot], [TrangThai], [NgayTao], [Avatar], [BangCap], [LopDangDayTrenTruong], [TrangThaiDay]) VALUES 
(1, 4, N'Vũ Văn Chủ', N'Toán học', N'0987654321', 1, CAST(12000000.00 AS Decimal(10, 2)), 1, N'Active', CAST(N'2025-05-24T18:28:39.923' AS DateTime), N'avatar_teacher1.jpg', N'Cấp 3', N'10A1', N'Đang dạy'),
(2, 5, N'Nguyễn Thị Minh', N'Ngữ văn', N'0987654322', 2, CAST(13000000.00 AS Decimal(10, 2)), 1, N'Active', CAST(N'2025-05-24T18:28:39.923' AS DateTime), N'avatar_teacher2.jpg', N'Cấp 3', N'11B2', N'Đang dạy'),
(3, 6, N'Trần Văn Hùng', N'Tiếng Anh', N'0987654323', 3, CAST(11000000.00 AS Decimal(10, 2)), 0, N'Active', CAST(N'2025-05-24T18:28:39.923' AS DateTime), N'avatar_teacher3.jpg', N'Cấp 2', N'8C1', N'Chưa dạy'),
(4, 7, N'Lê Thị Hồng', N'Hóa học', N'0987654324', 4, CAST(12500000.00 AS Decimal(10, 2)), 1, N'Active', CAST(N'2025-05-24T18:28:39.923' AS DateTime), N'avatar_teacher4.jpg', N'Cấp 3', N'12D3', N'Đã dạy'),
(5, 8, N'Phạm Văn Nam', N'Vật lý', N'0987654325', 5, CAST(11500000.00 AS Decimal(10, 2)), 0, N'Active', CAST(N'2025-05-24T18:28:39.923' AS DateTime), N'avatar_teacher5.jpg', N'Cấp 3', N'10A3', N'Đang dạy'),
(6, 9, N'Đỗ Thị Lan', N'Sinh học', N'0987654326', 1, CAST(11000000.00 AS Decimal(10, 2)), 0, N'Active', CAST(N'2025-05-24T18:28:39.923' AS DateTime), N'avatar_teacher6.jpg', N'Cấp 3', N'11A1', N'Đang dạy'),
(7, 10, N'Nguyễn Văn Tùng', N'Lịch sử', N'0987654327', 2, CAST(10500000.00 AS Decimal(10, 2)), 1, N'Active', CAST(N'2025-05-24T18:28:39.923' AS DateTime), N'avatar_teacher7.jpg', N'Cấp 2', N'9B2', N'Chưa dạy'),
(8, 11, N'Trần Thị Mai', N'Địa lý', N'0987654328', 3, CAST(12000000.00 AS Decimal(10, 2)), 0, N'Active', CAST(N'2025-05-24T18:28:39.923' AS DateTime), N'avatar_teacher8.jpg', N'Cấp 2', N'8A2', N'Đang dạy'),
(9, 12, N'Hoàng Văn Long', N'Toán học', N'0987654329', 4, CAST(13000000.00 AS Decimal(10, 2)), 1, N'Active', CAST(N'2025-05-24T18:28:39.923' AS DateTime), N'avatar_teacher9.jpg', N'Cấp 3', N'12A1', N'Đang dạy'),
(10, 13, N'Phạm Thị Hoa', N'Ngữ văn', N'0987654330', 5, CAST(11500000.00 AS Decimal(10, 2)), 0, N'Active', CAST(N'2025-05-24T18:28:39.923' AS DateTime), N'avatar_teacher10.jpg', N'Cấp 3', N'11C3', N'Đã dạy')
SET IDENTITY_INSERT [dbo].[GiaoVien] OFF
GO

-- HocSinh (100 bản ghi, sử dụng ID_TaiKhoan từ 14-113, có Avatar)
SET IDENTITY_INSERT [dbo].[HocSinh] ON 
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES 
(1, N'HS001', 14, N'Nguyễn Văn A', CAST(N'2008-03-15' AS Date), N'Nam', N'Hà Nội', N'0900111231', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A2', N'Đang học', N'avatar_student1.jpg'),
(2, N'HS002', 15, N'Trần Thị B', CAST(N'2007-09-10' AS Date), N'Nữ', N'Hải Phòng', N'0900111231', 2, N'Đã đăng ký lớp văn nâng cao', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B1', N'Chờ học', N'avatar_student2.jpg'),
(3, N'HS003', 16, N'Lê Văn C', CAST(N'2009-01-20' AS Date), N'Nam', N'TP.HCM', N'0900111232', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9A1', N'Đang học', N'avatar_student3.jpg'),
(4, N'HS004', 17, N'Phạm Thị D', CAST(N'2006-05-12' AS Date), N'Nữ', N'Đà Nẵng', N'0900111232', 4, N'Đã hoàn thành khóa toán cơ bản', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'12C2', N'Đã học', N'avatar_student4.jpg'),
(5, N'HS005', 18, N'Hoàng Văn E', CAST(N'2008-11-30' AS Date), N'Nam', N'Hà Nội', N'0900111233', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A4', N'Đang học', N'avatar_student5.jpg'),
(6, N'HS006', 19, N'Nguyễn Thị F', CAST(N'2007-07-15' AS Date), N'Nữ', N'Huế', N'0900111233', 1, N'Đăng ký lớp tổng ôn', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11A2', N'Chờ học', N'avatar_student6.jpg'),
(7, N'HS007', 20, N'Trần Văn G', CAST(N'2009-03-10' AS Date), N'Nam', N'Hà Nội', N'0900111234', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9B1', N'Đang học', N'avatar_student7.jpg'),
(8, N'HS008', 21, N'Lê Thị H', CAST(N'2008-06-25' AS Date), N'Nữ', N'TP.HCM', N'0900111234', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10B3', N'Đang học', N'avatar_student8.jpg'),
(9, N'HS009', 22, N'Phạm Văn I', CAST(N'2007-12-15' AS Date), N'Nam', N'Đà Nẵng', N'0900111235', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11C1', N'Chờ học', N'avatar_student9.jpg'),
(10, N'HS010', 23, N'Hoàng Thị K', CAST(N'2009-09-20' AS Date), N'Nữ', N'Hà Nội', N'0900111235', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9A2', N'Đang học', N'avatar_student10.jpg'),
(11, N'HS011', 24, N'Nguyễn Văn L', CAST(N'2008-02-10' AS Date), N'Nam', N'Huế', N'0900111236', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A5', N'Đang học', N'avatar_student11.jpg'),
(12, N'HS012', 25, N'Trần Thị M', CAST(N'2007-04-15' AS Date), N'Nữ', N'Hà Nội', N'0900111236', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B4', N'Chờ học', N'avatar_student12.jpg'),
(13, N'HS013', 26, N'Lê Văn N', CAST(N'2009-07-30' AS Date), N'Nam', N'TP.HCM', N'0900111237', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9C2', N'Đang học', N'avatar_student13.jpg'),
(14, N'HS014', 27, N'Phạm Thị O', CAST(N'2006-11-25' AS Date), N'Nữ', N'Đà Nẵng', N'0900111237', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'12D1', N'Đã học', N'avatar_student14.jpg'),
(15, N'HS015', 28, N'Nguyễn Văn P', CAST(N'2008-05-10' AS Date), N'Nam', N'Hà Nội', N'0900111238', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10B2', N'Đang học', N'avatar_student15.jpg'),
(16, N'HS016', 29, N'Trần Thị Q', CAST(N'2007-08-20' AS Date), N'Nữ', N'Hải Phòng', N'0900111238', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11A3', N'Chờ học', N'avatar_student16.jpg'),
(17, N'HS017', 30, N'Lê Văn R', CAST(N'2009-02-15' AS Date), N'Nam', N'TP.HCM', N'0900111239', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9B3', N'Đang học', N'avatar_student17.jpg'),
(18, N'HS018', 31, N'Phạm Thị S', CAST(N'2006-06-30' AS Date), N'Nữ', N'Đà Nẵng', N'0900111239', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'12C3', N'Đã học', N'avatar_student18.jpg'),
(19, N'HS019', 32, N'Hoàng Văn T', CAST(N'2008-12-05' AS Date), N'Nam', N'Hà Nội', N'0900111240', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A6', N'Đang học', N'avatar_student19.jpg'),
(20, N'HS020', 33, N'Nguyễn Thị U', CAST(N'2007-10-25' AS Date), N'Nữ', N'Huế', N'0900111240', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B5', N'Chờ học', N'avatar_student20.jpg'),
(21, N'HS021', 34, N'Trần Văn V', CAST(N'2009-04-15' AS Date), N'Nam', N'Hà Nội', N'0900111241', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9A3', N'Đang học', N'avatar_student21.jpg'),
(22, N'HS022', 35, N'Lê Thị W', CAST(N'2008-07-20' AS Date), N'Nữ', N'TP.HCM', N'0900111241', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10B4', N'Đang học', N'avatar_student22.jpg'),
(23, N'HS023', 36, N'Phạm Văn X', CAST(N'2007-11-10' AS Date), N'Nam', N'Đà Nẵng', N'0900111242', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11C2', N'Chờ học', N'avatar_student23.jpg'),
(24, N'HS024', 37, N'Hoàng Thị Y', CAST(N'2009-05-25' AS Date), N'Nữ', N'Hà Nội', N'0900111242', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9C1', N'Đang học', N'avatar_student24.jpg'),
(25, N'HS025', 38, N'Nguyễn Văn Z', CAST(N'2008-03-30' AS Date), N'Nam', N'Huế', N'0900111243', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A7', N'Đang học', N'avatar_student25.jpg'),
(26, N'HS026', 39, N'Trần Thị AA', CAST(N'2007-09-15' AS Date), N'Nữ', N'Hà Nội', N'0900111243', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B6', N'Chờ học', N'avatar_student26.jpg'),
(27, N'HS027', 40, N'Lê Văn AB', CAST(N'2009-01-20' AS Date), N'Nam', N'TP.HCM', N'0900111244', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9A4', N'Đang học', N'avatar_student27.jpg'),
(28, N'HS028', 41, N'Phạm Thị AC', CAST(N'2006-06-10' AS Date), N'Nữ', N'Đà Nẵng', N'0900111244', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'12C4', N'Đã học', N'avatar_student28.jpg'),
(29, N'HS029', 42, N'Hoàng Văn AD', CAST(N'2008-12-25' AS Date), N'Nam', N'Hà Nội', N'0900111245', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A8', N'Đang học', N'avatar_student29.jpg'),
(30, N'HS030', 43, N'Nguyễn Thị AE', CAST(N'2007-10-30' AS Date), N'Nữ', N'Huế', N'0900111245', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B7', N'Chờ học', N'avatar_student30.jpg'),
(31, N'HS031', 44, N'Trần Văn AF', CAST(N'2009-05-15' AS Date), N'Nam', N'Hà Nội', N'0900111246', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9B4', N'Đang học', N'avatar_student31.jpg'),
(32, N'HS032', 45, N'Lê Thị AG', CAST(N'2008-08-20' AS Date), N'Nữ', N'TP.HCM', N'0900111246', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10B5', N'Đang học', N'avatar_student32.jpg'),
(33, N'HS033', 46, N'Phạm Văn AH', CAST(N'2007-12-05' AS Date), N'Nam', N'Đà Nẵng', N'0900111247', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11C3', N'Chờ học', N'avatar_student33.jpg'),
(34, N'HS034', 47, N'Hoàng Thị AI', CAST(N'2009-06-10' AS Date), N'Nữ', N'Hà Nội', N'0900111247', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9C2', N'Đang học', N'avatar_student34.jpg'),
(35, N'HS035', 48, N'Nguyễn Văn AJ', CAST(N'2008-04-15' AS Date), N'Nam', N'Huế', N'0900111248', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A9', N'Đang học', N'avatar_student35.jpg'),
(36, N'HS036', 49, N'Trần Thị AK', CAST(N'2007-09-25' AS Date), N'Nữ', N'Hà Nội', N'0900111248', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B8', N'Chờ học', N'avatar_student36.jpg'),
(37, N'HS037', 50, N'Lê Văn AL', CAST(N'2009-02-20' AS Date), N'Nam', N'TP.HCM', N'0900111249', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9A5', N'Đang học', N'avatar_student37.jpg'),
(38, N'HS038', 51, N'Phạm Thị AM', CAST(N'2006-07-10' AS Date), N'Nữ', N'Đà Nẵng', N'0900111249', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'12C5', N'Đã học', N'avatar_student38.jpg'),
(39, N'HS039', 52, N'Hoàng Văn AN', CAST(N'2008-01-25' AS Date), N'Nam', N'Hà Nội', N'0900111250', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A10', N'Đang học', N'avatar_student39.jpg'),
(40, N'HS040', 53, N'Nguyễn Thị AO', CAST(N'2007-11-30' AS Date), N'Nữ', N'Huế', N'0900111250', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B9', N'Chờ học', N'avatar_student40.jpg'),
(41, N'HS041', 54, N'Trần Văn AP', CAST(N'2009-06-15' AS Date), N'Nam', N'Hà Nội', N'0900111251', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9B5', N'Đang học', N'avatar_student41.jpg'),
(42, N'HS042', 55, N'Lê Thị AQ', CAST(N'2008-09-20' AS Date), N'Nữ', N'TP.HCM', N'0900111251', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10B6', N'Đang học', N'avatar_student42.jpg'),
(43, N'HS043', 56, N'Phạm Văn AR', CAST(N'2007-12-25' AS Date), N'Nam', N'Đà Nẵng', N'0900111252', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11C4', N'Chờ học', N'avatar_student43.jpg'),
(44, N'HS044', 57, N'Hoàng Thị AS', CAST(N'2009-07-10' AS Date), N'Nữ', N'Hà Nội', N'0900111252', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9C3', N'Đang học', N'avatar_student44.jpg'),
(45, N'HS045', 58, N'Nguyễn Văn AT', CAST(N'2008-05-15' AS Date), N'Nam', N'Huế', N'0900111253', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A11', N'Đang học', N'avatar_student45.jpg'),
(46, N'HS046', 59, N'Trần Thị AU', CAST(N'2007-10-20' AS Date), N'Nữ', N'Hà Nội', N'0900111253', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B10', N'Chờ học', N'avatar_student46.jpg'),
(47, N'HS047', 60, N'Lê Văn AV', CAST(N'2009-03-25' AS Date), N'Nam', N'TP.HCM', N'0900111254', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9A6', N'Đang học', N'avatar_student47.jpg'),
(48, N'HS048', 61, N'Phạm Thị AW', CAST(N'2006-08-10' AS Date), N'Nữ', N'Đà Nẵng', N'0900111254', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'12C6', N'Đã học', N'avatar_student48.jpg'),
(49, N'HS049', 62, N'Hoàng Văn AX', CAST(N'2008-02-15' AS Date), N'Nam', N'Hà Nội', N'0900111255', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A12', N'Đang học', N'avatar_student49.jpg'),
(50, N'HS050', 63, N'Nguyễn Thị AY', CAST(N'2007-12-20' AS Date), N'Nữ', N'Huế', N'0900111255', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B11', N'Chờ học', N'avatar_student50.jpg'),
(51, N'HS051', 64, N'Trần Văn AZ', CAST(N'2009-07-25' AS Date), N'Nam', N'Hà Nội', N'0900111256', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9B6', N'Đang học', N'avatar_student51.jpg'),
(52, N'HS052', 65, N'Lê Thị BA', CAST(N'2008-10-30' AS Date), N'Nữ', N'TP.HCM', N'0900111256', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10B7', N'Đang học', N'avatar_student52.jpg'),
(53, N'HS053', 66, N'Phạm Văn BB', CAST(N'2007-01-15' AS Date), N'Nam', N'Đà Nẵng', N'0900111257', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11C5', N'Chờ học', N'avatar_student53.jpg'),
(54, N'HS054', 67, N'Hoàng Thị BC', CAST(N'2009-08-10' AS Date), N'Nữ', N'Hà Nội', N'0900111257', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9C4', N'Đang học', N'avatar_student54.jpg'),
(55, N'HS055', 68, N'Nguyễn Văn BD', CAST(N'2008-06-15' AS Date), N'Nam', N'Huế', N'0900111258', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A13', N'Đang học', N'avatar_student55.jpg'),
(56, N'HS056', 69, N'Trần Thị BE', CAST(N'2007-11-20' AS Date), N'Nữ', N'Hà Nội', N'0900111258', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B12', N'Chờ học', N'avatar_student56.jpg'),
(57, N'HS057', 70, N'Lê Văn BF', CAST(N'2009-04-25' AS Date), N'Nam', N'TP.HCM', N'0900111259', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9A7', N'Đang học', N'avatar_student57.jpg'),
(58, N'HS058', 71, N'Phạm Thị BG', CAST(N'2006-09-10' AS Date), N'Nữ', N'Đà Nẵng', N'0900111259', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'12C7', N'Đã học', N'avatar_student58.jpg'),
(59, N'HS059', 72, N'Hoàng Văn BH', CAST(N'2008-03-20' AS Date), N'Nam', N'Hà Nội', N'0900111260', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A14', N'Đang học', N'avatar_student59.jpg'),
(60, N'HS060', 73, N'Nguyễn Thị BI', CAST(N'2007-12-25' AS Date), N'Nữ', N'Huế', N'0900111260', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B13', N'Chờ học', N'avatar_student60.jpg'),
(61, N'HS061', 74, N'Trần Văn BJ', CAST(N'2009-08-15' AS Date), N'Nam', N'Hà Nội', N'0900111261', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9B7', N'Đang học', N'avatar_student61.jpg'),
(62, N'HS062', 75, N'Lê Thị BK', CAST(N'2008-11-20' AS Date), N'Nữ', N'TP.HCM', N'0900111261', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10B8', N'Đang học', N'avatar_student62.jpg'),
(63, N'HS063', 76, N'Phạm Văn BL', CAST(N'2007-02-10' AS Date), N'Nam', N'Đà Nẵng', N'0900111262', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11C6', N'Chờ học', N'avatar_student63.jpg'),
(64, N'HS064', 77, N'Hoàng Thị BM', CAST(N'2009-09-25' AS Date), N'Nữ', N'Hà Nội', N'0900111262', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9C5', N'Đang học', N'avatar_student64.jpg'),
(65, N'HS065', 78, N'Nguyễn Văn BN', CAST(N'2008-07-10' AS Date), N'Nam', N'Huế', N'0900111263', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A15', N'Đang học', N'avatar_student65.jpg'),
(66, N'HS066', 79, N'Trần Thị BO', CAST(N'2007-12-15' AS Date), N'Nữ', N'Hà Nội', N'0900111263', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B14', N'Chờ học', N'avatar_student66.jpg'),
(67, N'HS067', 80, N'Lê Văn BP', CAST(N'2009-05-20' AS Date), N'Nam', N'TP.HCM', N'0900111264', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9A8', N'Đang học', N'avatar_student67.jpg'),
(68, N'HS068', 81, N'Phạm Thị BQ', CAST(N'2006-10-25' AS Date), N'Nữ', N'Đà Nẵng', N'0900111264', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'12C8', N'Đã học', N'avatar_student68.jpg'),
(69, N'HS069', 82, N'Hoàng Văn BR', CAST(N'2008-04-15' AS Date), N'Nam', N'Hà Nội', N'0900111265', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A16', N'Đang học', N'avatar_student69.jpg'),
(70, N'HS070', 83, N'Nguyễn Thị BS', CAST(N'2007-11-20' AS Date), N'Nữ', N'Huế', N'0900111265', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B15', N'Chờ học', N'avatar_student70.jpg'),
(71, N'HS071', 84, N'Trần Văn BT', CAST(N'2009-08-25' AS Date), N'Nam', N'Hà Nội', N'0900111266', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9B8', N'Đang học', N'avatar_student71.jpg'),
(72, N'HS072', 85, N'Lê Thị BU', CAST(N'2008-12-10' AS Date), N'Nữ', N'TP.HCM', N'0900111266', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10B9', N'Đang học', N'avatar_student72.jpg'),
(73, N'HS073', 86, N'Phạm Văn BV', CAST(N'2007-03-15' AS Date), N'Nam', N'Đà Nẵng', N'0900111267', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11C7', N'Chờ học', N'avatar_student73.jpg'),
(74, N'HS074', 87, N'Hoàng Thị BW', CAST(N'2009-10-20' AS Date), N'Nữ', N'Hà Nội', N'0900111267', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9C6', N'Đang học', N'avatar_student74.jpg'),
(75, N'HS075', 88, N'Nguyễn Văn BX', CAST(N'2008-08-25' AS Date), N'Nam', N'Huế', N'0900111268', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A17', N'Đang học', N'avatar_student75.jpg'),
(76, N'HS076', 89, N'Trần Thị BY', CAST(N'2007-01-30' AS Date), N'Nữ', N'Hà Nội', N'0900111268', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B16', N'Chờ học', N'avatar_student76.jpg'),
(77, N'HS077', 90, N'Lê Văn BZ', CAST(N'2009-06-15' AS Date), N'Nam', N'TP.HCM', N'0900111269', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9A9', N'Đang học', N'avatar_student77.jpg'),
(78, N'HS078', 91, N'Phạm Thị CA', CAST(N'2006-11-20' AS Date), N'Nữ', N'Đà Nẵng', N'0900111269', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'12C9', N'Đã học', N'avatar_student78.jpg'),
(79, N'HS079', 92, N'Hoàng Văn CB', CAST(N'2008-05-25' AS Date), N'Nam', N'Hà Nội', N'0900111270', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A18', N'Đang học', N'avatar_student79.jpg'),
(80, N'HS080', 93, N'Nguyễn Thị CC', CAST(N'2007-12-10' AS Date), N'Nữ', N'Huế', N'0900111270', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B17', N'Chờ học', N'avatar_student80.jpg'),
-- Phụ huynh có 3 con (ID_PhuHuynh từ 41-50)
(81, N'HS081', 94, N'Trần Văn CD', CAST(N'2009-09-15' AS Date), N'Nam', N'Hà Nội', N'0900111271', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9B9', N'Đang học', N'avatar_student81.jpg'),
(82, N'HS082', 95, N'Lê Thị CE', CAST(N'2008-02-20' AS Date), N'Nữ', N'TP.HCM', N'0900111271', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10B10', N'Đang học', N'avatar_student82.jpg'),
(83, N'HS083', 96, N'Phạm Văn CF', CAST(N'2007-07-25' AS Date), N'Nam', N'Đà Nẵng', N'0900111271', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11C8', N'Chờ học', N'avatar_student83.jpg'),
(84, N'HS084', 97, N'Hoàng Thị CG', CAST(N'2009-10-30' AS Date), N'Nữ', N'Hà Nội', N'0900111272', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9C7', N'Đang học', N'avatar_student84.jpg'),
(85, N'HS085', 98, N'Nguyễn Văn CH', CAST(N'2008-06-15' AS Date), N'Nam', N'Huế', N'0900111272', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A19', N'Đang học', N'avatar_student85.jpg'),
(86, N'HS086', 99, N'Trần Thị CI', CAST(N'2007-12-20' AS Date), N'Nữ', N'Hà Nội', N'0900111272', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B18', N'Chờ học', N'avatar_student86.jpg'),
(87, N'HS087', 100, N'Lê Văn CJ', CAST(N'2009-08-25' AS Date), N'Nam', N'TP.HCM', N'0900111273', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9A10', N'Đang học', N'avatar_student87.jpg'),
(88, N'HS088', 101, N'Phạm Thị CK', CAST(N'2006-01-30' AS Date), N'Nữ', N'Đà Nẵng', N'0900111273', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'12C10', N'Đã học', N'avatar_student88.jpg'),
(89, N'HS089', 102, N'Hoàng Văn CL', CAST(N'2008-07-10' AS Date), N'Nam', N'Hà Nội', N'0900111273', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A20', N'Đang học', N'avatar_student89.jpg'),
(90, N'HS090', 103, N'Nguyễn Thị CM', CAST(N'2007-12-15' AS Date), N'Nữ', N'Huế', N'0900111274', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B19', N'Chờ học', N'avatar_student90.jpg'),
(91, N'HS091', 104, N'Trần Văn CN', CAST(N'2009-09-20' AS Date), N'Nam', N'Hà Nội', N'0900111274', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9B10', N'Đang học', N'avatar_student91.jpg'),
(92, N'HS092', 105, N'Lê Thị CO', CAST(N'2008-03-25' AS Date), N'Nữ', N'TP.HCM', N'0900111274', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10B11', N'Đang học', N'avatar_student92.jpg'),
(93, N'HS093', 106, N'Phạm Văn CP', CAST(N'2007-08-30' AS Date), N'Nam', N'Đà Nẵng', N'0900111275', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11C9', N'Chờ học', N'avatar_student93.jpg'),
(94, N'HS094', 107, N'Hoàng Thị CQ', CAST(N'2009-11-15' AS Date), N'Nữ', N'Hà Nội', N'0900111275', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9C8', N'Đang học', N'avatar_student94.jpg'),
(95, N'HS095', 108, N'Nguyễn Văn CR', CAST(N'2008-07-20' AS Date), N'Nam', N'Huế', N'0900111275', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A21', N'Đang học', N'avatar_student95.jpg'),
(96, N'HS096', 109, N'Trần Thị CS', CAST(N'2007-02-25' AS Date), N'Nữ', N'Hà Nội', N'0900111276', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B20', N'Chờ học', N'avatar_student96.jpg'),
(97, N'HS097', 110, N'Lê Văn CT', CAST(N'2009-10-30' AS Date), N'Nam', N'TP.HCM', N'0900111276', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9A11', N'Đang học', N'avatar_student97.jpg'),
(98, N'HS098', 111, N'Phạm Thị CU', CAST(N'2006-05-15' AS Date), N'Nữ', N'Đà Nẵng', N'0900111276', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'12C11', N'Đã học', N'avatar_student98.jpg'),
(99, N'HS099', 112, N'Hoàng Văn CV', CAST(N'2008-09-20' AS Date), N'Nam', N'Hà Nội', N'0900111277', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A22', N'Đang học', N'avatar_student99.jpg'),
(100, N'HS100', 113, N'Nguyễn Thị CW', CAST(N'2007-12-25' AS Date), N'Nữ', N'Huế', N'0900111277', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B21', N'Chờ học', N'avatar_student100.jpg')
SET IDENTITY_INSERT [dbo].[HocSinh] OFF
GO

-- PhuHuynh (50 bản ghi, sử dụng ID_TaiKhoan từ 114-163)
SET IDENTITY_INSERT [dbo].[PhuHuynh] ON 
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES 
(1, 114, N'Nguyễn Văn B', N'0900111231', N'phuhuynh1@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(2, 115, N'Trần Thị H', N'0900111232', N'phuhuynh2@example.com', N'Hải Phòng', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(3, 116, N'Lê Văn F', N'0900111233', N'phuhuynh3@example.com', N'TP.HCM', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(4, 117, N'Phạm Thị G', N'0900111234', N'phuhuynh4@example.com', N'Đà Nẵng', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(5, 118, N'Hoàng Văn I', N'0900111235', N'phuhuynh5@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(6, 119, N'Nguyễn Văn J', N'0900111236', N'phuhuynh6@example.com', N'Huế', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(7, 120, N'Trần Thị K', N'0900111237', N'phuhuynh7@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(8, 121, N'Lê Văn L', N'0900111238', N'phuhuynh8@example.com', N'TP.HCM', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(9, 122, N'Phạm Thị M', N'0900111239', N'phuhuynh9@example.com', N'Đà Nẵng', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(10, 123, N'Hoàng Văn N', N'0900111240', N'phuhuynh10@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(11, 124, N'Nguyễn Thị O', N'0900111241', N'phuhuynh11@example.com', N'Huế', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(12, 125, N'Trần Văn P', N'0900111242', N'phuhuynh12@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(13, 126, N'Lê Thị Q', N'0900111243', N'phuhuynh13@example.com', N'TP.HCM', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(14, 127, N'Phạm Văn R', N'0900111244', N'phuhuynh14@example.com', N'Đà Nẵng', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(15, 128, N'Hoàng Thị S', N'0900111245', N'phuhuynh15@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(16, 129, N'Nguyễn Văn T', N'0900111246', N'phuhuynh16@example.com', N'Huế', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(17, 130, N'Trần Thị U', N'0900111247', N'phuhuynh17@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(18, 131, N'Lê Văn V', N'0900111248', N'phuhuynh18@example.com', N'TP.HCM', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(19, 132, N'Phạm Thị W', N'0900111249', N'phuhuynh19@example.com', N'Đà Nẵng', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(20, 133, N'Hoàng Văn X', N'0900111250', N'phuhuynh20@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(21, 134, N'Nguyễn Thị Y', N'0900111251', N'phuhuynh21@example.com', N'Huế', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(22, 135, N'Trần Văn Z', N'0900111252', N'phuhuynh22@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(23, 136, N'Lê Thị AA', N'0900111253', N'phuhuynh23@example.com', N'TP.HCM', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(24, 137, N'Phạm Văn AB', N'0900111254', N'phuhuynh24@example.com', N'Đà Nẵng', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(25, 138, N'Hoàng Thị AC', N'0900111255', N'phuhuynh25@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(26, 139, N'Nguyễn Văn AD', N'0900111256', N'phuhuynh26@example.com', N'Huế', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(27, 140, N'Trần Thị AE', N'0900111257', N'phuhuynh27@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(28, 141, N'Lê Văn AF', N'0900111258', N'phuhuynh28@example.com', N'TP.HCM', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(29, 142, N'Phạm Thị AG', N'0900111259', N'phuhuynh29@example.com', N'Đà Nẵng', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(30, 143, N'Hoàng Văn AH', N'0900111260', N'phuhuynh30@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(31, 144, N'Nguyễn Thị AI', N'0900111261', N'phuhuynh31@example.com', N'Huế', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(32, 145, N'Trần Văn AJ', N'0900111262', N'phuhuynh32@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(33, 146, N'Lê Thị AK', N'0900111263', N'phuhuynh33@example.com', N'TP.HCM', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(34, 147, N'Phạm Văn AL', N'0900111264', N'phuhuynh34@example.com', N'Đà Nẵng', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(35, 148, N'Hoàng Thị AM', N'0900111265', N'phuhuynh35@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(36, 149, N'Nguyễn Văn AN', N'0900111266', N'phuhuynh36@example.com', N'Huế', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(37, 150, N'Trần Thị AO', N'0900111267', N'phuhuynh37@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(38, 151, N'Lê Văn AP', N'0900111268', N'phuhuynh38@example.com', N'TP.HCM', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(39, 152, N'Phạm Thị AQ', N'0900111269', N'phuhuynh39@example.com', N'Đà Nẵng', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(40, 153, N'Hoàng Văn AR', N'0900111270', N'phuhuynh40@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
-- Phụ huynh có 3 con
(41, 154, N'Nguyễn Thị AS', N'0900111271', N'phuhuynh41@example.com', N'Huế', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(42, 155, N'Trần Văn AT', N'0900111272', N'phuhuynh42@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(43, 156, N'Lê Thị AU', N'0900111273', N'phuhuynh43@example.com', N'TP.HCM', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(44, 157, N'Phạm Văn AV', N'0900111274', N'phuhuynh44@example.com', N'Đà Nẵng', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(45, 158, N'Hoàng Thị AW', N'0900111275', N'phuhuynh45@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(46, 159, N'Nguyễn Văn AX', N'0900111276', N'phuhuynh46@example.com', N'Huế', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(47, 160, N'Trần Thị AY', N'0900111277', N'phuhuynh47@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(48, 161, N'Lê Văn AZ', N'0900111278', N'phuhuynh48@example.com', N'TP.HCM', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(49, 162, N'Phạm Thị BA', N'0900111279', N'phuhuynh49@example.com', N'Đà Nẵng', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(50, 163, N'Hoàng Văn BB', N'0900111280', N'phuhuynh50@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[PhuHuynh] OFF
GO

-- HocSinh_PhuHuynh (Liên kết 100 học sinh với 50 phụ huynh: 40 phụ huynh có 2 con, 10 phụ huynh có 3 con)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES 
-- Phụ huynh có 2 con (ID_PhuHuynh từ 1-40)
(1, 1), (2, 1),
(3, 2), (4, 2),
(5, 3), (6, 3),
(7, 4), (8, 4),
(9, 5), (10, 5),
(11, 6), (12, 6),
(13, 7), (14, 7),
(15, 8), (16, 8),
(17, 9), (18, 9),
(19, 10), (20, 10),
(21, 11), (22, 11),
(23, 12), (24, 12),
(25, 13), (26, 13),
(27, 14), (28, 14),
(29, 15), (30, 15),
(31, 16), (32, 16),
(33, 17), (34, 17),
(35, 18), (36, 18),
(37, 19), (38, 19),
(39, 20), (40, 20),
(41, 21), (42, 21),
(43, 22), (44, 22),
(45, 23), (46, 23),
(47, 24), (48, 24),
(49, 25), (50, 25),
(51, 26), (52, 26),
(53, 27), (54, 27),
(55, 28), (56, 28),
(57, 29), (58, 29),
(59, 30), (60, 30),
(61, 31), (62, 31),
(63, 32), (64, 32),
(65, 33), (66, 33),
(67, 34), (68, 34),
(69, 35), (70, 35),
(71, 36), (72, 36),
(73, 37), (74, 37),
(75, 38), (76, 38),
(77, 39), (78, 39),
(79, 40), (80, 40),
-- Phụ huynh có 3 con (ID_PhuHuynh từ 41-50)
(81, 41), (82, 41), (83, 41),
(84, 42), (85, 42), (86, 42),
(87, 43), (88, 43), (89, 43),
(90, 44), (91, 44), (92, 44),
(93, 45), (94, 45), (95, 45),
(96, 46), (97, 46), (98, 46),
(99, 47), (100, 47), (1, 47),
(2, 48), (3, 48), (4, 48),
(5, 49), (6, 49), (7, 49),
(8, 50), (9, 50), (10, 50)
GO

-- Admin
SET IDENTITY_INSERT [dbo].[Admin] ON 
INSERT [dbo].[Admin] ([ID_Admin], [ID_TaiKhoan], [HoTen], [Avatar]) VALUES 
(1, 1, N'Nguyen Van Admin', N'avatar_admin.jpg')
SET IDENTITY_INSERT [dbo].[Admin] OFF
GO

-- Staff
SET IDENTITY_INSERT [dbo].[Staff] ON 
INSERT [dbo].[Staff] ([ID_Staff], [ID_TaiKhoan], [HoTen], [Avatar]) VALUES 
(1, 2, N'Tran Thi Staff1', N'avatar_staff1.jpg'),
(2, 3, N'Le Van Staff2', N'avatar_staff2.jpg')
SET IDENTITY_INSERT [dbo].[Staff] OFF
GO

-- KhoaHoc
SET IDENTITY_INSERT [dbo].[KhoaHoc] ON 
INSERT [dbo].[KhoaHoc] ([ID_KhoaHoc], [CourseCode], [TenKhoaHoc], [MoTa], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [TrangThai], [NgayTao], [ID_Khoi], [Image], [Order]) VALUES 
(1, N'MATH06', N'Toán', N'Khóa học Toán nâng cao dành cho học sinh lớp 6', CAST(N'2025-06-01' AS Date), CAST(N'2025-12-01' AS Date), N'Khóa học gồm 2 học kỳ', N'Active', CAST(N'2025-05-24T18:28:39.920' AS DateTime), 1, N'course_math.jpg', 1),
(2, N'LIT06', N'Ngữ văn', N'Khóa học Văn lớp 6', CAST(N'2025-06-01' AS Date), CAST(N'2025-11-30' AS Date), NULL, N'Active', CAST(N'2025-05-24T18:28:39.920' AS DateTime), 1, N'course_literature.jpg', 2),
(3, N'SINH11', N'Sinh học', N'Khóa học Sinh học lớp 11', CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), 6, N'course_biology.jpg', 3),
(4, N'LICH09', N'Lịch sử', N'Khóa học Lịch sử lớp 9', CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), 4, N'course_history.jpg', 4)
SET IDENTITY_INSERT [dbo].[KhoaHoc] OFF
GO

-- LopHoc
SET IDENTITY_INSERT [dbo].[LopHoc] ON 
INSERT [dbo].[LopHoc] ([ID_LopHoc], [ClassCode], [TenLopHoc], [ID_KhoaHoc], [SiSo], [SiSoToiDa], [SiSoToiThieu], [ID_Schedule], [ID_PhongHoc], [GhiChu], [TrangThai], [SoTien], [NgayTao], [Image], [Order]) VALUES 
(1, N'TOAN06A', N'Toán Nâng Cao', 1, 25, 40, 5, 1, 1, N'Lớp dành cho người mới bắt đầu', N'Đang học', N'2000000', CAST(N'2025-05-24T18:28:39.920' AS DateTime), N'class_math.jpg', 1),
(2, N'VAN06A', N'Văn Học Nâng Cao', 2, 25, 40, 5, 2, 2, N'Lớp dành cho người mới bắt đầu', N'Đang học', N'2000000', CAST(N'2025-05-24T18:28:39.920' AS DateTime), N'class_literature.jpg', 2),
(3, N'SINH11A', N'Sinh Học Nâng Cao', 3, 25, 30, 5, 3, 3, N'Lớp Sinh học nâng cao', N'Chưa học', N'2500000', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'class_biology.jpg', 3),
(4, N'LICH09A', N'Lịch Sử Cơ Bản', 4, 25, 35, 5, 4, 4, N'Lớp Lịch sử cơ bản', N'Đang học', N'1800000', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'class_history.jpg', 4)
SET IDENTITY_INSERT [dbo].[LopHoc] OFF
GO

-- SlotHoc
SET IDENTITY_INSERT [dbo].[SlotHoc] ON 
INSERT [dbo].[SlotHoc] ([ID_SlotHoc], [SlotThoiGian]) VALUES 
(1, N'7:00 đến 9:00'),
(2, N'9:00 đến 11:00'),
(3, N'14:00 đến 16:00'),
(4, N'16:00 đến 18:00')
SET IDENTITY_INSERT [dbo].[SlotHoc] OFF
GO

-- LichHoc
SET IDENTITY_INSERT [dbo].[LichHoc] ON 
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu]) VALUES 
(1, CAST(N'2025-06-10' AS Date), 1, 1, 1, N'Lớp Toán nâng cao'),
(2, CAST(N'2025-06-10' AS Date), 2, 2, 2, N'Lớp Văn học nâng cao'),
(3, CAST(N'2025-06-11' AS Date), 3, 3, 3, N'Lớp Sinh học nâng cao'),
(4, CAST(N'2025-06-11' AS Date), 4, 4, 4, N'Lớp Lịch sử cơ bản')
SET IDENTITY_INSERT [dbo].[LichHoc] OFF
GO

-- GiaoVien_LopHoc
INSERT [dbo].[GiaoVien_LopHoc] ([ID_GiaoVien], [ID_LopHoc]) VALUES 
(1, 1), -- Vũ Văn Chủ dạy lớp Toán Nâng Cao
(2, 2), -- Nguyễn Thị Minh dạy lớp Văn Học Nâng Cao
(6, 3), -- Đỗ Thị Lan dạy lớp Sinh Học Nâng Cao
(7, 4)  -- Nguyễn Văn Tùng dạy lớp Lịch Sử Cơ Bản
GO

-- HocSinh_LopHoc (Phân bổ 100 học sinh vào 4 lớp học)
SET IDENTITY_INSERT [dbo].[HocSinh_LopHoc] ON 
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES 
(1, 1, 1, N'Học sinh tích cực', 1),
(2, 2, 2, N'Cần chú ý hơn trong lớp', 0),
(3, 3, 3, N'Học sinh chăm chỉ', 1),
(4, 4, 4, NULL, NULL),
(5, 1, 5, N'Cần cải thiện kỹ năng giải đề', 0),
(6, 3, 6, N'Học sinh chăm chỉ', 1),
(7, 4, 7, NULL, NULL),
(8, 1, 8, NULL, NULL),
(9, 2, 9, N'Cần chú ý hơn trong lớp', 0),
(10, 3, 10, NULL, NULL),
(11, 4, 11, N'Học sinh tích cực', 1),
(12, 1, 12, NULL, NULL),
(13, 2, 13, NULL, NULL),
(14, 3, 14, N'Cần cải thiện kỹ năng thực hành', 0),
(15, 1, 15, NULL, NULL),
(16, 2, 16, NULL, NULL),
(17, 4, 17, NULL, NULL),
(18, 3, 18, NULL, NULL),
(19, 1, 19, NULL, NULL),
(20, 2, 20, NULL, NULL),
(21, 4, 21, NULL, NULL),
(22, 3, 22, NULL, NULL),
(23, 1, 23, NULL, NULL),
(24, 2, 24, NULL, NULL),
(25, 4, 25, NULL, NULL),
(26, 3, 26, NULL, NULL),
(27, 1, 27, NULL, NULL),
(28, 2, 28, NULL, NULL),
(29, 4, 29, NULL, NULL),
(30, 3, 30, NULL, NULL),
(31, 1, 31, NULL, NULL),
(32, 2, 32, NULL, NULL),
(33, 4, 33, NULL, NULL),
(34, 3, 34, NULL, NULL),
(35, 1, 35, NULL, NULL),
(36, 2, 36, NULL, NULL),
(37, 4, 37, NULL, NULL),
(38, 3, 38, NULL, NULL),
(39, 1, 39, NULL, NULL),
(40, 2, 40, NULL, NULL),
(41, 4, 41, NULL, NULL),
(42, 3, 42, NULL, NULL),
(43, 1, 43, NULL, NULL),
(44, 2, 44, NULL, NULL),
(45, 4, 45, NULL, NULL),
(46, 3, 46, NULL, NULL),
(47, 1, 47, NULL, NULL),
(48, 2, 48, NULL, NULL),
(49, 4, 49, NULL, NULL),
(50, 3, 50, NULL, NULL),
(51, 1, 51, NULL, NULL),
(52, 2, 52, NULL, NULL),
(53, 4, 53, NULL, NULL),
(54, 3, 54, NULL, NULL),
(55, 1, 55, NULL, NULL),
(56, 2, 56, NULL, NULL),
(57, 4, 57, NULL, NULL),
(58, 3, 58, NULL, NULL),
(59, 1, 59, NULL, NULL),
(60, 2, 60, NULL, NULL),
(61, 4, 61, NULL, NULL),
(62, 3, 62, NULL, NULL),
(63, 1, 63, NULL, NULL),
(64, 2, 64, NULL, NULL),
(65, 4, 65, NULL, NULL),
(66, 3, 66, NULL, NULL),
(67, 1, 67, NULL, NULL),
(68, 2, 68, NULL, NULL),
(69, 4, 69, NULL, NULL),
(70, 3, 70, NULL, NULL),
(71, 1, 71, NULL, NULL),
(72, 2, 72, NULL, NULL),
(73, 4, 73, NULL, NULL),
(74, 3, 74, NULL, NULL),
(75, 1, 75, NULL, NULL),
(76, 2, 76, NULL, NULL),
(77, 4, 77, NULL, NULL),
(78, 3, 78, NULL, NULL),
(79, 1, 79, NULL, NULL),
(80, 2, 80, NULL, NULL),
(81, 4, 81, NULL, NULL),
(82, 3, 82, NULL, NULL),
(83, 1, 83, NULL, NULL),
(84, 2, 84, NULL, NULL),
(85, 4, 85, NULL, NULL),
(86, 3, 86, NULL, NULL),
(87, 1, 87, NULL, NULL),
(88, 2, 88, NULL, NULL),
(89, 4, 89, NULL, NULL),
(90, 3, 90, NULL, NULL),
(91, 1, 91, NULL, NULL),
(92, 2, 92, NULL, NULL),
(93, 4, 93, NULL, NULL),
(94, 3, 94, NULL, NULL),
(95, 1, 95, NULL, NULL),
(96, 2, 96, NULL, NULL),
(97, 4, 97, NULL, NULL),
(98, 3, 98, NULL, NULL),
(99, 1, 99, NULL, NULL),
(100, 2, 100, NULL, NULL)
SET IDENTITY_INSERT [dbo].[HocSinh_LopHoc] OFF
GO

-- DangKyLopHoc (Đăng ký 100 học sinh vào 4 lớp học)
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES 
(1, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(2, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(3, 3, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(4, 4, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(5, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(6, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(7, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(8, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(9, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(10, 3, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(11, 4, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(12, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(13, 2, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(14, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(15, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(16, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(17, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(18, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(19, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(20, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(21, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(22, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(23, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(24, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(25, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(26, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(27, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(28, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(29, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(30, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(31, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(32, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(33, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(34, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(35, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(36, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(37, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(38, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(39, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(40, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(41, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(42, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(43, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(44, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(45, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(46, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(47, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(48, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(49, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(50, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(51, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(52, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(53, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(54, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(55, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(56, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(57, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(58, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(59, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(60, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(61, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(62, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(63, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(64, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(65, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(66, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(67, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(68, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(69, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(70, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(71, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(72, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(73, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(74, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(75, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(76, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(77, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(78, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(79, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(80, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(81, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(82, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(83, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(84, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(85, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(86, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(87, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(88, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(89, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(90, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(91, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(92, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(93, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(94, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(95, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(96, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(97, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(98, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí'),
(99, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí'),
(100, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
GO

-- HocPhi (50 bản ghi cho học sinh đã đóng học phí)
SET IDENTITY_INSERT [dbo].[HocPhi] ON 
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu]) VALUES 
(1, 1, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(2, 3, 3, N'Sinh học', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(3, 5, 1, N'Toán', N'Chuyển khoản', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(4, 7, 4, N'Lịch sử', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(5, 8, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(6, 10, 3, N'Sinh học', N'Chuyển khoản', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(7, 11, 4, N'Lịch sử', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(8, 12, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(9, 13, 2, N'Ngữ văn', N'Chuyển khoản', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(10, 15, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(11, 17, 4, N'Lịch sử', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(12, 19, 1, N'Toán', N'Chuyển khoản', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(13, 21, 4, N'Lịch sử', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(14, 23, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(15, 25, 4, N'Lịch sử', N'Chuyển khoản', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(16, 27, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(17, 29, 4, N'Lịch sử', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(18, 31, 1, N'Toán', N'Chuyển khoản', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(19, 33, 4, N'Lịch sử', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(20, 35, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(21, 37, 4, N'Lịch sử', N'Chuyển khoản', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(22, 39, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(23, 41, 4, N'Lịch sử', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(24, 43, 1, N'Toán', N'Chuyển khoản', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(25, 45, 4, N'Lịch sử', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(26, 47, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(27, 49, 4, N'Lịch sử', N'Chuyển khoản', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(28, 51, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(29, 53, 4, N'Lịch sử', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(30, 55, 1, N'Toán', N'Chuyển khoản', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(31, 57, 4, N'Lịch sử', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(32, 59, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(33, 61, 4, N'Lịch sử', N'Chuyển khoản', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(34, 63, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(35, 65, 4, N'Lịch sử', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(36, 67, 1, N'Toán', N'Chuyển khoản', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(37, 69, 4, N'Lịch sử', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(38, 71, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(39, 73, 4, N'Lịch sử', N'Chuyển khoản', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(40, 75, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(41, 77, 4, N'Lịch sử', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(42, 79, 1, N'Toán', N'Chuyển khoản', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(43, 81, 4, N'Lịch sử', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(44, 83, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(45, 85, 4, N'Lịch sử', N'Chuyển khoản', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(46, 87, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(47, 89, 4, N'Lịch sử', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(48, 91, 1, N'Toán', N'Chuyển khoản', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(49, 93, 4, N'Lịch sử', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL),
(50, 95, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL)
SET IDENTITY_INSERT [dbo].[HocPhi] OFF
GO

-- ThongBao
SET IDENTITY_INSERT [dbo].[ThongBao] ON 
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian]) VALUES 
(1, 14, N'Bạn có bài tập mới cần nộp trước ngày 15/06', NULL, CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(2, 114, N'Phụ huynh vui lòng theo dõi kết quả học tập của con.', NULL, CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(3, 15, N'Nhắc nhở đóng học phí lớp Văn trước 10/06', NULL, CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(4, 115, N'Phụ huynh vui lòng kiểm tra lịch học mới.', NULL, CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(5, 16, N'Nhắc nhở đóng học phí lớp Sinh học trước 15/06', 2, CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(6, 17, N'Bài tập Toán đã được chấm, kiểm tra điểm!', NULL, CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(7, 116, N'Phụ huynh vui lòng đóng học phí lớp Lịch sử.', 4, CAST(N'2025-06-01T10:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[ThongBao] OFF
GO

-- TaoBaiTap
SET IDENTITY_INSERT [dbo].[TaoBaiTap] ON 
INSERT [dbo].[TaoBaiTap] ([ID_BaiTap], [ID_GiaoVien], [TenBaiTap], [MoTa], [NgayTao], [ID_LopHoc], [Deadline]) VALUES 
(1, 1, N'Bài tập Đại số tuần 1', N'Giải phương trình bậc hai', CAST(N'2025-06-01' AS Date), 1, CAST(N'2025-06-15' AS Date)),
(2, 2, N'Bài tập Văn tuần 1', N'Phân tích bài thơ', CAST(N'2025-06-01' AS Date), 2, CAST(N'2025-06-15' AS Date)),
(3, 6, N'Bài tập Sinh học tuần 1', N'Phân tích hệ sinh thái', CAST(N'2025-06-01' AS Date), 3, CAST(N'2025-06-15' AS Date)),
(4, 7, N'Bài tập Lịch sử tuần 1', N'Tóm tắt lịch sử Việt Nam', CAST(N'2025-06-01' AS Date), 4, CAST(N'2025-06-15' AS Date))
SET IDENTITY_INSERT [dbo].[TaoBaiTap] OFF
GO

-- NopBaiTap
INSERT [dbo].[NopBaiTap] ([ID_HocSinh], [ID_BaiTap], [TepNop], [NgayNop], [Diem], [NhanXet]) VALUES 
(1, 1, N'/nopbai/hs1_baitap1.pdf', CAST(N'2025-06-01' AS Date), CAST(9.00 AS Decimal(5, 2)), N'Hoàn thành tốt'),
(3, 3, N'/nopbai/hs3_baitap3.pdf', CAST(N'2025-06-01' AS Date), CAST(7.50 AS Decimal(5, 2)), N'Hoàn thành tốt, cần luyện thêm'),
(5, 1, N'/nopbai/hs5_baitap1.pdf', CAST(N'2025-06-01' AS Date), CAST(9.50 AS Decimal(5, 2)), N'Bài làm xuất sắc'),
(7, 4, N'/nopbai/hs7_baitap4.pdf', CAST(N'2025-06-01' AS Date), CAST(7.00 AS Decimal(5, 2)), N'Cần cải thiện nội dung'),
(8, 1, N'/nopbai/hs8_baitap1.pdf', CAST(N'2025-06-01' AS Date), CAST(8.00 AS Decimal(5, 2)), N'Bài làm tốt, cần trình bày rõ ràng'),
(10, 3, N'/nopbai/hs10_baitap3.pdf', CAST(N'2025-06-01' AS Date), CAST(8.50 AS Decimal(5, 2)), N'Bài làm tốt, cần bổ sung ví dụ'),
(11, 4, N'/nopbai/hs11_baitap4.pdf', CAST(N'2025-06-01' AS Date), CAST(7.50 AS Decimal(5, 2)), N'Cần cải thiện nội dung')
GO

-- Diem
SET IDENTITY_INSERT [dbo].[Diem] ON 
INSERT [dbo].[Diem] ([ID_Diem], [ID_HocSinh], [ID_LopHoc], [DiemKiemTra], [DiemBaiTap], [DiemGiuaKy], [DiemCuoiKy], [ThoiGianCapNhat]) VALUES 
(1, 1, 1, CAST(8.50 AS Decimal(5, 2)), CAST(9.00 AS Decimal(5, 2)), CAST(8.00 AS Decimal(5, 2)), CAST(8.50 AS Decimal(5, 2)), CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(2, 3, 3, CAST(8.00 AS Decimal(5, 2)), CAST(8.50 AS Decimal(5, 2)), CAST(7.50 AS Decimal(5, 2)), CAST(8.00 AS Decimal(5, 2)), CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(3, 5, 1, CAST(9.50 AS Decimal(5, 2)), CAST(9.00 AS Decimal(5, 2)), CAST(9.00 AS Decimal(5, 2)), CAST(9.50 AS Decimal(5, 2)), CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(4, 7, 4, CAST(7.50 AS Decimal(5, 2)), CAST(7.00 AS Decimal(5, 2)), CAST(7.50 AS Decimal(5, 2)), CAST(7.00 AS Decimal(5, 2)), CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(5, 8, 1, CAST(8.00 AS Decimal(5, 2)), CAST(8.50 AS Decimal(5, 2)), CAST(8.00 AS Decimal(5, 2)), CAST(8.50 AS Decimal(5, 2)), CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(6, 10, 3, CAST(8.50 AS Decimal(5, 2)), CAST(8.00 AS Decimal(5, 2)), CAST(8.50 AS Decimal(5, 2)), CAST(8.00 AS Decimal(5, 2)), CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(7, 11, 4, CAST(7.00 AS Decimal(5, 2)), CAST(7.50 AS Decimal(5, 2)), CAST(7.00 AS Decimal(5, 2)), CAST(7.50 AS Decimal(5, 2)), CAST(N'2025-06-01T10:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Diem] OFF
GO

-- DiemDanh
SET IDENTITY_INSERT [dbo].[DiemDanh] ON 
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES 
(1, 1, 1, N'Có mặt', NULL),
(2, 3, 3, N'Có mặt', NULL),
(3, 5, 1, N'Có mặt', NULL),
(4, 7, 4, N'Vắng mặt', N'Có việc gia đình'),
(5, 8, 1, N'Có mặt', NULL),
(6, 10, 3, N'Có mặt', NULL),
(7, 11, 4, N'Có mặt', NULL)
SET IDENTITY_INSERT [dbo].[DiemDanh] OFF
GO

-- PhanLoaiBlog
SET IDENTITY_INSERT [dbo].[PhanLoaiBlog] ON 
INSERT [dbo].[PhanLoaiBlog] ([ID_PhanLoai], [PhanLoai]) VALUES 
(1, N'Toán Học'),
(2, N'Văn Học'),
(3, N'Sinh học'),
(4, N'Lịch sử')
SET IDENTITY_INSERT [dbo].[PhanLoaiBlog] OFF
GO

-- Blog
SET IDENTITY_INSERT [dbo].[Blog] ON 
INSERT [dbo].[Blog] ([ID_Blog], [BlogTitle], [BlogDescription], [BlogDate], [Image], [ID_Khoi], [ID_PhanLoai], [KeyTag], [Keyword]) VALUES 
(1, N'Khám Phá Toán Học', N'Bài viết giới thiệu những phương pháp học Toán hiệu quả', CAST(N'2025-06-01' AS Date), N'blog_math.jpg', 1, 1, N'Toán, học tập', N'phương pháp học toán, toán học hiệu quả'),
(2, N'Học Văn Thú Vị', N'Cách cải thiện kỹ năng phân tích văn học', CAST(N'2025-06-01' AS Date), N'blog_literature.jpg', 1, 2, N'Văn học, phân tích', N'học văn, kỹ năng văn học'),
(3, N'Khám Phá Sinh Học', N'Tìm hiểu về hệ sinh thái và đa dạng sinh học', CAST(N'2025-06-01' AS Date), N'blog_biology.jpg', 6, 3, N'Sinh học, hệ sinh thái', N'hệ sinh thái, đa dạng sinh học'),
(4, N'Lịch Sử Việt Nam', N'Tổng quan các sự kiện lịch sử quan trọng', CAST(N'2025-06-01' AS Date), N'blog_history.jpg', 4, 4, N'Lịch sử, sự kiện', N'lịch sử Việt Nam, sự kiện lịch sử')
SET IDENTITY_INSERT [dbo].[Blog] OFF
GO

-- DangTaiLieu
SET IDENTITY_INSERT [dbo].[DangTaiLieu] ON 
INSERT [dbo].[DangTaiLieu] ([ID_Material], [ID_GiaoVien], [TenTaiLieu], [LoaiTaiLieu], [DuongDan], [NgayTao], [DanhMuc], [GiaTien], [Image]) VALUES 
(1, 1, N'Tài liệu Toán Đại số', N'PDF', N'/files/tailieu_toan_daiso.pdf', CAST(N'2025-06-01' AS Date), N'Toán Học', N'200,000', N'material_math.jpg'),
(2, 2, N'Tài liệu Văn học lớp 6', N'DOCX', N'/files/tailieu_van6.docx', CAST(N'2025-06-01' AS Date), N'Ngữ Văn', N'150,000', N'material_literature.jpg'),
(3, 6, N'Tài liệu Sinh học lớp 11', N'PDF', N'/files/tailieu_sinh11.pdf', CAST(N'2025-06-01' AS Date), N'Sinh học', N'200,000', N'material_biology.jpg'),
(4, 7, N'Tài liệu Lịch sử lớp 9', N'PDF', N'/files/tailieu_lichsu9.pdf', CAST(N'2025-06-01' AS Date), N'Lịch sử', N'180,000', N'material_history.jpg')
SET IDENTITY_INSERT [dbo].[DangTaiLieu] OFF
GO

-- HoTro
SET IDENTITY_INSERT [dbo].[HoTro] ON 
INSERT [dbo].[HoTro] ([ID_HoTro], [HoTen], [TenHoTro], [ThoiGian], [MoTa], [ID_TaiKhoan]) VALUES 
(1, N'Vũ Văn Chủ', N'Hỗ trợ sửa thành viên lớp', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'Thành viên lớp nghỉ học. Muốn xóa thành viên lớp', 4),
(2, N'Nguyễn Thị Minh', N'Hỗ trợ chuyển lớp', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'Học sinh muốn chuyển sang lớp khác', 5),
(3, N'Đỗ Thị Lan', N'Hỗ trợ thêm tài liệu', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'Cần thêm tài liệu Sinh học lớp 11', 9),
(4, N'Nguyễn Văn B', N'Hỗ trợ kiểm tra học phí', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'Phụ huynh cần kiểm tra trạng thái học phí', 114)
SET IDENTITY_INSERT [dbo].[HoTro] OFF
GO

-- Slider
SET IDENTITY_INSERT [dbo].[Slider] ON 
INSERT [dbo].[Slider] ([ID_Slider], [Title], [Image], [BackLink]) VALUES 
(1, N'Tuyển Sinh Khóa Học Hè', N'slider_summer.jpg', N'/summer-course'),
(2, N'Tiếp đà 2k9', N'slider_2k9.jpg', N'/2k9-program')
SET IDENTITY_INSERT [dbo].[Slider] OFF
GO

-- UserLogs
SET IDENTITY_INSERT [dbo].[UserLogs] ON 
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES 
(1, 1, N'Đăng nhập hệ thống', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(2, 4, N'Tải tài liệu Toán Đại số', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(3, 14, N'Xem lịch học', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(4, 114, N'Kiểm tra kết quả học tập', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(5, 5, N'Cập nhật bài tập', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(6, 9, N'Đăng nhập hệ thống', CAST(N'2025-06-01T10:00:00.000' AS DateTime)),
(7, 15, N'Xem điểm học sinh', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[UserLogs] OFF
GO

ALTER TABLE [dbo].[HoTro]
ADD DaDuyet BIT;

-- Đặt giá trị là 0 cho 2 dòng đầu (ID_HoTro = 1 và 2)
UPDATE [dbo].[HoTro]
SET DaDuyet = 0
WHERE ID_HoTro IN (1, 2);

-- Đặt giá trị là 1 cho các dòng còn lại
UPDATE [dbo].[HoTro]
SET DaDuyet = 1
WHERE ID_HoTro NOT IN (1, 2);

-- Insert 5 new classrooms into PhongHoc
SET IDENTITY_INSERT [dbo].[PhongHoc] ON 
INSERT [dbo].[PhongHoc] ([ID_PhongHoc], [TenPhongHoc], [SucChua], [TrangThai]) VALUES 
(6, N'Phòng 106', 40, N'Active'),
(7, N'Phòng 107', 40, N'Active'),
(8, N'Phòng 108', 40, N'Active'),
(9, N'Phòng 109', 40, N'Active'),
(10, N'Phòng 110', 40, N'Active')
SET IDENTITY_INSERT [dbo].[PhongHoc] OFF
GO

