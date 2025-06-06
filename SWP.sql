

USE [SWP]
GO
/****** Object:  Table [dbo].[Blog]    Script Date: 29/05/2025 4:04:25 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Blog](
	[ID_Blog] [int] IDENTITY(1,1) NOT NULL,
	[BlogTitle] [nvarchar](max) NULL,
	[BlogDescription] [nvarchar](max) NULL,
	[BlogDate] [date] NULL,
	[Image] [nvarchar](max) NULL,
	[ID_Khoi] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DangKyLopHoc]    Script Date: 29/05/2025 4:04:25 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DangKyLopHoc](
	[ID_HocSinh] [int] NOT NULL,
	[ID_LopHoc] [int] NOT NULL,
	[NgayDangKy] [date] NULL,
	[TinhTrangHocPhi] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_HocSinh] ASC,
	[ID_LopHoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DangTaiLieu]    Script Date: 29/05/2025 4:04:25 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DangTaiLieu](
	[ID_Material] [int] IDENTITY(1,1) NOT NULL,
	[ID_GiaoVien] [int] NULL,
	[TenTaiLieu] [nvarchar](100) NOT NULL,
	[LoaiTaiLieu] [nvarchar](50) NULL,
	[DuongDan] [nvarchar](255) NULL,
	[NgayTao] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Material] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Diem]    Script Date: 29/05/2025 4:04:25 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Diem](
	[ID_Diem] [int] IDENTITY(1,1) NOT NULL,
	[ID_HocSinh] [int] NULL,
	[ID_LopHoc] [int] NULL,
	[DiemKiemTra] [decimal](5, 2) NULL,
	[DiemBaiTap] [decimal](5, 2) NULL,
	[DiemGiuaKy] [decimal](5, 2) NULL,
	[DiemCuoiKy] [decimal](5, 2) NULL,
	[DiemTongKet]  AS (((([DiemKiemTra]+[DiemBaiTap])+[DiemGiuaKy])+[DiemCuoiKy])/(4)) PERSISTED,
	[ThoiGianCapNhat] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Diem] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DiemDanh]    Script Date: 29/05/2025 4:04:25 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiemDanh](
	[ID_DiemDanh] [int] IDENTITY(1,1) NOT NULL,
	[ID_HocSinh] [int] NULL,
	[ID_Schedule] [int] NULL,
	[TrangThai] [nvarchar](50) NULL,
	[LyDoVang] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_DiemDanh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiaoVien]    Script Date: 29/05/2025 4:04:25 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaoVien](
	[ID_GiaoVien] [int] IDENTITY(1,1) NOT NULL,
	[ID_TaiKhoan] [int] NULL,
	[HoTen] [nvarchar](100) NOT NULL,
	[ChuyenMon] [nvarchar](100) NULL,
	[SDT] [nvarchar](15) NULL,
	[TruongGiangDay] [nvarchar](255) NULL,
	[Luong] [decimal](10, 2) NULL,
	[GhiChu] [nvarchar](max) NULL,
	[TrangThai] [nvarchar](20) NULL,
	[NgayTao] [datetime] NULL,
	[Avatar] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_GiaoVien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiaoVien_LopHoc]    Script Date: 29/05/2025 4:04:25 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaoVien_LopHoc](
	[ID_GiaoVien] [int] NOT NULL,
	[ID_LopHoc] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_GiaoVien] ASC,
	[ID_LopHoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HocPhi]    Script Date: 29/05/2025 4:04:25 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HocPhi](
	[ID_HocPhi] [int] IDENTITY(1,1) NOT NULL,
	[ID_HocSinh] [int] NULL,
	[ID_LopHoc] [int] NULL,
	[MonHoc] [nvarchar](50) NULL,
	[PhuongThucThanhToan] [nvarchar](50) NULL,
	[TinhTrangThanhToan] [nvarchar](50) NULL,
	[NgayThanhToan] [date] NULL,
	[GhiChu] [nvarchar](max) NULL,
 CONSTRAINT [PK__HocPhi__D4E8B1E178582CC6] PRIMARY KEY CLUSTERED 
(
	[ID_HocPhi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HocSinh]    Script Date: 29/05/2025 4:04:25 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HocSinh](
	[ID_HocSinh] [int] IDENTITY(1,1) NOT NULL,
	[ID_TaiKhoan] [int] NULL,
	[HoTen] [nvarchar](100) NOT NULL,
	[NgaySinh] [date] NULL,
	[GioiTinh] [nvarchar](3) NULL,
	[DiaChi] [nvarchar](255) NULL,
	[SDT_PhuHuynh] [nvarchar](15) NULL,
	[TruongHoc] [nvarchar](255) NULL,
	[GhiChu] [nvarchar](max) NULL,
	[TrangThai] [nvarchar](20) NULL,
	[NgayTao] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_HocSinh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HocSinh_LopHoc]    Script Date: 29/05/2025 4:04:25 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HocSinh_LopHoc](
	[ID_LopHoc] [int] NULL,
	[ID_HocSinh] [int] NULL,
	[ID_HSLopHoc] [int] IDENTITY(1,1) NOT NULL,
	[FeedBack] [nvarchar](max) NULL,
	[status_FeedBack] [bit] NULL,
 CONSTRAINT [PK_HocSinh_LopHoc] PRIMARY KEY CLUSTERED 
(
	[ID_HSLopHoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HocSinh_PhuHuynh]    Script Date: 29/05/2025 4:04:25 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HocSinh_PhuHuynh](
	[ID_HocSinh] [int] NOT NULL,
	[ID_PhuHuynh] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_HocSinh] ASC,
	[ID_PhuHuynh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhoaHoc]    Script Date: 29/05/2025 4:04:25 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhoaHoc](
	[ID_KhoaHoc] [int] IDENTITY(1,1) NOT NULL,
	[TenKhoaHoc] [nvarchar](100) NOT NULL,
	[MoTa] [nvarchar](max) NULL,
	[ThoiGianBatDau] [date] NULL,
	[ThoiGianKetThuc] [date] NULL,
	[GhiChu] [nvarchar](max) NULL,
	[TrangThai] [nvarchar](20) NULL,
	[NgayTao] [datetime] NULL,
	[ID_Khoi] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_KhoaHoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhoiHoc]    Script Date: 29/05/2025 4:04:25 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhoiHoc](
	[ID_Khoi] [int] IDENTITY(1,1) NOT NULL,
	[TenKhoi] [nvarchar](50) NULL,
	[Status_Khoi] [bit] NULL,
 CONSTRAINT [PK_KhoiHoc] PRIMARY KEY CLUSTERED 
(
	[ID_Khoi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LichHoc]    Script Date: 29/05/2025 4:04:25 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LichHoc](
	[ID_Schedule] [int] IDENTITY(1,1) NOT NULL,
	[NgayHoc] [date] NOT NULL,
	[GioHoc] [nvarchar](50) NULL,
	[ID_LopHoc] [int] NULL,
	[GhiChu] [nvarchar](max) NULL,
 CONSTRAINT [PK__LichHoc__73616218C5C45370] PRIMARY KEY CLUSTERED 
(
	[ID_Schedule] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LopHoc]    Script Date: 29/05/2025 4:04:25 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LopHoc](
	[ID_LopHoc] [int] IDENTITY(1,1) NOT NULL,
	[TenLopHoc] [nvarchar](100) NOT NULL,
	[ID_KhoaHoc] [int] NULL,
	[SiSo] [int] NULL,
	[ThoiGianHoc] [nvarchar](50) NULL,
	[GhiChu] [nvarchar](max) NULL,
	[TrangThai] [nvarchar](20) NULL,
	[SoTien] [nchar](10) NULL,
	[NgayTao] [datetime] NULL,
	[Image] [nvarchar](max) NULL,
 CONSTRAINT [PK__LopHoc__5C25E9AE7400A479] PRIMARY KEY CLUSTERED 
(
	[ID_LopHoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NopBaiTap]    Script Date: 29/05/2025 4:04:25 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NopBaiTap](
	[ID_HocSinh] [int] NOT NULL,
	[ID_BaiTap] [int] NOT NULL,
	[TepNop] [nvarchar](255) NULL,
	[NgayNop] [date] NULL,
	[Diem] [decimal](5, 2) NULL,
	[NhanXet] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhuHuynh]    Script Date: 29/05/2025 4:04:25 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhuHuynh](
	[ID_PhuHuynh] [int] IDENTITY(1,1) NOT NULL,
	[ID_TaiKhoan] [int] NULL,
	[HoTen] [nvarchar](100) NOT NULL,
	[SDT] [nvarchar](15) NULL,
	[Email] [nvarchar](100) NULL,
	[DiaChi] [nvarchar](255) NULL,
	[GhiChu] [nvarchar](max) NULL,
	[ID_HocSinh] [int] NULL,
	[TrangThai] [nvarchar](20) NULL,
	[NgayTao] [datetime] NULL,
 CONSTRAINT [PK__PhuHuynh__05867582B87EB107] PRIMARY KEY CLUSTERED 
(
	[ID_PhuHuynh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Slider]    Script Date: 29/05/2025 4:04:25 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Slider](
	[ID_Slider] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](max) NULL,
	[Image] [nvarchar](max) NULL,
	[BackLink] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 29/05/2025 4:04:25 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiKhoan](
	[ID_TaiKhoan] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[MatKhau] [nvarchar](255) NOT NULL,
	[ID_VaiTro] [int] NOT NULL,
	[UserType] [nvarchar](20) NOT NULL,
	[SoDienThoai] [nvarchar](15) NULL,
	[TrangThai] [nvarchar](20) NULL,
	[NgayTao] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_TaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaoBaiTap]    Script Date: 29/05/2025 4:04:25 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaoBaiTap](
	[ID_BaiTap] [int] IDENTITY(1,1) NOT NULL,
	[ID_GiaoVien] [int] NULL,
	[TenBaiTap] [nvarchar](100) NOT NULL,
	[MoTa] [nvarchar](max) NULL,
	[NgayTao] [date] NULL,
	[ID_LopHoc] [int] NULL,
	[Deadline] [date] NULL,
 CONSTRAINT [PK__TaoBaiTa__F4A2723843F0AF5A] PRIMARY KEY CLUSTERED 
(
	[ID_BaiTap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThongBao]    Script Date: 29/05/2025 4:04:25 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThongBao](
	[ID_ThongBao] [int] IDENTITY(1,1) NOT NULL,
	[ID_TaiKhoan] [int] NOT NULL,
	[NoiDung] [nvarchar](max) NULL,
	[ID_HocPhi] [int] NULL,
	[ThoiGian] [datetime] NOT NULL,
 CONSTRAINT [PK__ThongBao__4D0B05D427B08070] PRIMARY KEY CLUSTERED 
(
	[ID_ThongBao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserLogs]    Script Date: 29/05/2025 4:04:25 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserLogs](
	[ID_Log] [int] IDENTITY(1,1) NOT NULL,
	[ID_TaiKhoan] [int] NULL,
	[HanhDong] [nvarchar](255) NULL,
	[ThoiGian] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Log] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE ThongBao ALTER COLUMN ID_TaiKhoan INT NULL;
/****** Object:  Table [dbo].[VaiTro]    Script Date: 29/05/2025 4:04:25 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VaiTro](
	[ID_VaiTro] [int] IDENTITY(1,1) NOT NULL,
	[TenVaiTro] [nvarchar](50) NOT NULL,
	[MieuTa] [nvarchar](max) NULL,
	[TrangThai] [nvarchar](20) NULL,
	[NgayTao] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_VaiTro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (1, 1, CAST(N'2025-05-24' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (2, 2, CAST(N'2025-05-24' AS Date), N'Chưa đóng học phí')
GO
SET IDENTITY_INSERT [dbo].[DangTaiLieu] ON 

INSERT [dbo].[DangTaiLieu] ([ID_Material], [ID_GiaoVien], [TenTaiLieu], [LoaiTaiLieu], [DuongDan], [NgayTao]) VALUES (1, 1, N'Tài liệu Toán Đại số', N'PDF', N'/files/tailieu_toan_daiso.pdf', CAST(N'2025-05-24' AS Date))
SET IDENTITY_INSERT [dbo].[DangTaiLieu] OFF
GO
SET IDENTITY_INSERT [dbo].[Diem] ON 

INSERT [dbo].[Diem] ([ID_Diem], [ID_HocSinh], [ID_LopHoc], [DiemKiemTra], [DiemBaiTap], [DiemGiuaKy], [DiemCuoiKy], [ThoiGianCapNhat]) VALUES (1, 1, 1, CAST(8.50 AS Decimal(5, 2)), CAST(9.00 AS Decimal(5, 2)), CAST(8.00 AS Decimal(5, 2)), CAST(8.50 AS Decimal(5, 2)), CAST(N'2025-05-24T18:28:39.930' AS DateTime))
INSERT [dbo].[Diem] ([ID_Diem], [ID_HocSinh], [ID_LopHoc], [DiemKiemTra], [DiemBaiTap], [DiemGiuaKy], [DiemCuoiKy], [ThoiGianCapNhat]) VALUES (2, 2, 2, CAST(7.00 AS Decimal(5, 2)), CAST(7.50 AS Decimal(5, 2)), CAST(7.00 AS Decimal(5, 2)), CAST(7.50 AS Decimal(5, 2)), CAST(N'2025-05-24T18:28:39.930' AS DateTime))
SET IDENTITY_INSERT [dbo].[Diem] OFF
GO
SET IDENTITY_INSERT [dbo].[DiemDanh] ON 

INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (1, 1, 1, N'Có mặt', NULL)
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (2, 2, 2, N'Vắng mặt', N'Ốm')
SET IDENTITY_INSERT [dbo].[DiemDanh] OFF
GO
SET IDENTITY_INSERT [dbo].[GiaoVien] ON 

INSERT [dbo].[GiaoVien] ([ID_GiaoVien], [ID_TaiKhoan], [HoTen], [ChuyenMon], [SDT], [TruongGiangDay], [Luong], [GhiChu], [TrangThai], [NgayTao], [Avatar]) VALUES (1, 3, N'Vũ Văn Chủ', N'Toán học', N'0987654321', N'THPT Hà Nội', CAST(12000000.00 AS Decimal(10, 2)), NULL, N'Active', CAST(N'2025-05-24T18:28:39.923' AS DateTime), N'avatarTeacher.jpg')
INSERT [dbo].[GiaoVien] ([ID_GiaoVien], [ID_TaiKhoan], [HoTen], [ChuyenMon], [SDT], [TruongGiangDay], [Luong], [GhiChu], [TrangThai], [NgayTao], [Avatar]) VALUES (2, 11, N'Đàm Quang Trung', N'Toán học', N'0987654321', N'Trường THPT Nguyễn Trãi', CAST(15000000.00 AS Decimal(10, 2)), N'Giáo viên dạy giỏi cấp tỉnh', N'Active', CAST(N'2025-05-29T10:20:03.967' AS DateTime), N'avatarTeacher.jpg')
INSERT [dbo].[GiaoVien] ([ID_GiaoVien], [ID_TaiKhoan], [HoTen], [ChuyenMon], [SDT], [TruongGiangDay], [Luong], [GhiChu], [TrangThai], [NgayTao], [Avatar]) VALUES (3, 16, N'Vũ Văn Chủ', N'Toán', N'0912345678', N'Trường THPT Nguyễn Trãi', CAST(12000000.00 AS Decimal(10, 2)), N'Giáo viên dạy giỏi cấp tỉnh', N'Active', CAST(N'2025-05-29T12:14:43.233' AS DateTime), N'avatarTeacher.jpg')
INSERT [dbo].[GiaoVien] ([ID_GiaoVien], [ID_TaiKhoan], [HoTen], [ChuyenMon], [SDT], [TruongGiangDay], [Luong], [GhiChu], [TrangThai], [NgayTao], [Avatar]) VALUES (4, 17, N'Vũ Minh Hoàng', N'Lý', N'0923456789', N'Trường THPT Nguyễn Trãi', CAST(12000000.00 AS Decimal(10, 2)), N'Giáo viên dạy giỏi cấp tỉnh', N'Active', CAST(N'2025-05-29T12:14:43.233' AS DateTime), N'avatarTeacher.jpg')
INSERT [dbo].[GiaoVien] ([ID_GiaoVien], [ID_TaiKhoan], [HoTen], [ChuyenMon], [SDT], [TruongGiangDay], [Luong], [GhiChu], [TrangThai], [NgayTao], [Avatar]) VALUES (5, 18, N'Đỗ Huy Đô', N'Hóa', N'0934567890', N'Trường THPT Nguyễn Trãi', CAST(12000000.00 AS Decimal(10, 2)), N'Giáo viên dạy giỏi cấp tỉnh', N'Active', CAST(N'2025-05-29T12:14:43.233' AS DateTime), N'avatarTeacher.jpg')
INSERT [dbo].[GiaoVien] ([ID_GiaoVien], [ID_TaiKhoan], [HoTen], [ChuyenMon], [SDT], [TruongGiangDay], [Luong], [GhiChu], [TrangThai], [NgayTao], [Avatar]) VALUES (6, 19, N'Ngô Xuân Tuấn Dũng', N'Sinh', N'0945678901', N'Trường THPT Nguyễn Trãi', CAST(12000000.00 AS Decimal(10, 2)), N'Giáo viên dạy giỏi cấp tỉnh', N'Active', CAST(N'2025-05-29T12:14:43.233' AS DateTime), N'avatarTeacher.jpg')
SET IDENTITY_INSERT [dbo].[GiaoVien] OFF
GO
INSERT [dbo].[GiaoVien_LopHoc] ([ID_GiaoVien], [ID_LopHoc]) VALUES (1, 1)
INSERT [dbo].[GiaoVien_LopHoc] ([ID_GiaoVien], [ID_LopHoc]) VALUES (1, 2)
GO
SET IDENTITY_INSERT [dbo].[HocPhi] ON 

INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu]) VALUES (1, 1, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu]) VALUES (2, 2, 1, N'Văn', N'Chuyển khoản', N'Chưa thanh toán', NULL, NULL)
SET IDENTITY_INSERT [dbo].[HocPhi] OFF
GO
SET IDENTITY_INSERT [dbo].[HocSinh] ON 

INSERT [dbo].[HocSinh] ([ID_HocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [TruongHoc], [GhiChu], [TrangThai], [NgayTao]) VALUES (1, 4, N'Nguyễn Văn A', CAST(N'2008-03-15' AS Date), N'Nam', N'Hà Nội', N'0900111222', N'THPT Hà Nội', NULL, N'Active', CAST(N'2025-05-24T18:28:39.920' AS DateTime))
INSERT [dbo].[HocSinh] ([ID_HocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [TruongHoc], [GhiChu], [TrangThai], [NgayTao]) VALUES (2, NULL, N'Trần Thị B', CAST(N'2007-09-10' AS Date), N'Nữ', N'Hải Phòng', N'0900333444', N'THPT Hải Phòng', NULL, N'Active', CAST(N'2025-05-24T18:28:39.920' AS DateTime))
INSERT [dbo].[HocSinh] ([ID_HocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [TruongHoc], [GhiChu], [TrangThai], [NgayTao]) VALUES (4, 7, N'Lê Thị B', CAST(N'2011-08-22' AS Date), N'Nữ', N'456 Đường XYZ, TP.HCM', N'0912345678', N'THCS Lê Lợi', N'Đã đăng ký lớp toán nâng cao', N'1', CAST(N'2025-05-26T09:46:55.163' AS DateTime))
INSERT [dbo].[HocSinh] ([ID_HocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [TruongHoc], [GhiChu], [TrangThai], [NgayTao]) VALUES (5, 9, N'Nguyễn Văn A', CAST(N'2010-05-15' AS Date), N'Nam', N'123 Đường ABC, Hà Nội', N'0987654321', N'THCS Nguyễn Trãi', NULL, N'1', CAST(N'2025-05-26T10:07:02.520' AS DateTime))
INSERT [dbo].[HocSinh] ([ID_HocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [TruongHoc], [GhiChu], [TrangThai], [NgayTao]) VALUES (6, 10, N'Lê Thị B', CAST(N'2011-08-22' AS Date), N'Nữ', N'456 Đường XYZ, TP.HCM', N'0912345678', N'THCS Lê Lợi', N'Đã đăng ký lớp toán nâng cao', N'1', CAST(N'2025-05-26T10:07:02.520' AS DateTime))
SET IDENTITY_INSERT [dbo].[HocSinh] OFF
GO
SET IDENTITY_INSERT [dbo].[HocSinh_LopHoc] ON 

INSERT [dbo].[HocSinh_LopHoc] ([ID_LopHoc], [ID_HocSinh], [ID_HSLopHoc], [FeedBack], [status_FeedBack]) VALUES (1, 1, 1, NULL, NULL)
SET IDENTITY_INSERT [dbo].[HocSinh_LopHoc] OFF
GO
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (1, 1)
GO
SET IDENTITY_INSERT [dbo].[KhoaHoc] ON 

INSERT [dbo].[KhoaHoc] ([ID_KhoaHoc], [TenKhoaHoc], [MoTa], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [TrangThai], [NgayTao], [ID_Khoi]) VALUES (1, N'Toán Cao Cấp', N'Khóa học Toán nâng cao dành cho học sinh lớp 10-12', CAST(N'2025-06-01' AS Date), CAST(N'2025-12-01' AS Date), N'Khóa học gồm 2 học kỳ', N'Active', CAST(N'2025-05-24T18:28:39.920' AS DateTime), NULL)
INSERT [dbo].[KhoaHoc] ([ID_KhoaHoc], [TenKhoaHoc], [MoTa], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [TrangThai], [NgayTao], [ID_Khoi]) VALUES (2, N'Văn Học', N'Khóa học Văn học cơ bản và nâng cao', CAST(N'2025-06-01' AS Date), CAST(N'2025-11-30' AS Date), NULL, N'Active', CAST(N'2025-05-24T18:28:39.920' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[KhoaHoc] OFF
GO
SET IDENTITY_INSERT [dbo].[LichHoc] ON 

INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [GioHoc], [ID_LopHoc], [GhiChu]) VALUES (1, CAST(N'2025-06-10' AS Date), N'7h30 - 9h30', NULL, N'Lớp 10A1 học Toán')
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [GioHoc], [ID_LopHoc], [GhiChu]) VALUES (2, CAST(N'2025-06-11' AS Date), N'7h30 - 9h30', NULL, N'Lớp 11B1 học Văn')
SET IDENTITY_INSERT [dbo].[LichHoc] OFF
GO
SET IDENTITY_INSERT [dbo].[LopHoc] ON 

INSERT [dbo].[LopHoc] ([ID_LopHoc], [TenLopHoc], [ID_KhoaHoc], [SiSo], [ThoiGianHoc], [GhiChu], [TrangThai], [SoTien], [NgayTao], [Image]) VALUES (1, N'Toán Nâng Cao', 1, 30, N'Thứ 2,4,6 - 7h30 đến 9h30', N'Lớp dành cho người mới bắt đầu', N'Active', N'2000000   ', CAST(N'2025-05-24T18:28:39.920' AS DateTime), NULL)
INSERT [dbo].[LopHoc] ([ID_LopHoc], [TenLopHoc], [ID_KhoaHoc], [SiSo], [ThoiGianHoc], [GhiChu], [TrangThai], [SoTien], [NgayTao], [Image]) VALUES (2, N'Văn Học Nâng Cao', 2, 26, N'Thứ 3,5,7 - 7h30 đến 9h30', N'Lớp dành cho người mới bắt đầu', N'Active', N'2000000   ', CAST(N'2025-05-24T18:28:39.920' AS DateTime), NULL)
INSERT [dbo].[LopHoc] ([ID_LopHoc], [TenLopHoc], [ID_KhoaHoc], [SiSo], [ThoiGianHoc], [GhiChu], [TrangThai], [SoTien], [NgayTao], [Image]) VALUES (3, N'Toán Cơ Bản', 1, 30, N'Th? 2,4,6 - 18h00-20h00', N'Lớp dành cho người mới bắt đầu', N'Active', N'2000000   ', CAST(N'2025-05-29T12:44:53.693' AS DateTime), NULL)
INSERT [dbo].[LopHoc] ([ID_LopHoc], [TenLopHoc], [ID_KhoaHoc], [SiSo], [ThoiGianHoc], [GhiChu], [TrangThai], [SoTien], [NgayTao], [Image]) VALUES (4, N'Văn Học Cơ Bản', 2, 30, N'Th? 2,4,5 - 18h00-20h00', N'Lớp dành cho người mới bắt đầu', N'Active', N'2000000   ', CAST(N'2025-05-29T12:46:43.910' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[LopHoc] OFF
GO
INSERT [dbo].[NopBaiTap] ([ID_HocSinh], [ID_BaiTap], [TepNop], [NgayNop], [Diem], [NhanXet]) VALUES (1, 1, N'/nopbai/hs1_baitap1.pdf', CAST(N'2025-05-24' AS Date), CAST(9.00 AS Decimal(5, 2)), N'Hoàn thành tốt')
GO
SET IDENTITY_INSERT [dbo].[PhuHuynh] ON 

INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [ID_HocSinh], [TrangThai], [NgayTao]) VALUES (1, 5, N'Nguyễn Văn B', N'0900111222', N'phuhuynh1@example.com', N'Hà Nội', NULL, NULL, N'Active', CAST(N'2025-05-24T18:28:39.923' AS DateTime))
SET IDENTITY_INSERT [dbo].[PhuHuynh] OFF
GO
SET IDENTITY_INSERT [dbo].[TaiKhoan] ON 

INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (1, N'admin@example.com', N'hashedpass1', 1, N'Admin', N'0123456789', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (2, N'staff1@example.com', N'hashedpass2', 2, N'Staff', N'0123987654', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (3, N'giaovien1@example.com', N'hashedpass3', 3, N'GiaoVien', N'0987654321', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (4, N'hocsinh1@example.com', N'hashedpass4', 4, N'HocSinh', N'0911222333', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (5, N'phuhuynh1@example.com', N'hashedpass5', 5, N'PhuHuynh', N'0900111222', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (6, N'nguyenvana@example.com', N'matkhau123', 2, N'HocSinh', N'0987654321', N'1', CAST(N'2025-05-26T09:45:43.293' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (7, N'lethib@example.com', N'abc123xyz', 2, N'HocSinh', N'0912345678', N'1', CAST(N'2025-05-26T09:45:43.293' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (9, N'nguyenvan2@example.com', N'matkhau123', 2, N'HocSinh', N'0987654321', N'1', CAST(N'2025-05-26T10:05:53.633' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (10, N'lethi3@example.com', N'abc123xyz', 2, N'HocSinh', N'0912345678', N'1', CAST(N'2025-05-26T10:05:53.633' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (11, N'trungdam@gmail.com', N'trung123', 3, N'GiaoVien', N'0972178865', N'Active', CAST(N'2025-05-29T10:18:31.363' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (16, N'chuvv@gmail.com', N'password1', 3, N'GiaoVien', N'0912345678', N'Active', CAST(N'2025-05-29T12:06:42.720' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (17, N'hoangvm@gmail.com', N'password2', 3, N'GiaoVien', N'0923456789', N'Active', CAST(N'2025-05-29T12:06:42.720' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (18, N'dohuydo@gmail.com', N'password3', 3, N'GiaoVien', N'0934567890', N'Active', CAST(N'2025-05-29T12:06:42.720' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (19, N'dungnxt@gmail.com', N'password4', 3, N'GiaoVien', N'0945678901', N'Active', CAST(N'2025-05-29T12:06:42.720' AS DateTime))
SET IDENTITY_INSERT [dbo].[TaiKhoan] OFF
GO
SET IDENTITY_INSERT [dbo].[TaoBaiTap] ON 

INSERT [dbo].[TaoBaiTap] ([ID_BaiTap], [ID_GiaoVien], [TenBaiTap], [MoTa], [NgayTao], [ID_LopHoc], [Deadline]) VALUES (1, 1, N'Bài tập Đại số tuần 1', N'Giải phương trình bậc hai', CAST(N'2025-05-24' AS Date), NULL, CAST(N'2025-06-15' AS Date))
SET IDENTITY_INSERT [dbo].[TaoBaiTap] OFF
GO
SET IDENTITY_INSERT [dbo].[ThongBao] ON 

INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian]) VALUES (1, 4, N'Bạn có bài tập mới cần nộp trước ngày 15/06', NULL, CAST(N'2025-05-24T18:28:39.937' AS DateTime))
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian]) VALUES (2, 5, N'Phụ huynh vui lòng theo dõi kết quả học tập của con.', NULL, CAST(N'2025-05-24T18:28:39.937' AS DateTime))
SET IDENTITY_INSERT [dbo].[ThongBao] OFF
GO
SET IDENTITY_INSERT [dbo].[UserLogs] ON 

INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1, 1, N'Đăng nhập hệ thống', CAST(N'2025-05-24T18:28:39.937' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (2, 3, N'Tải tài liệu Toán Đại số', CAST(N'2025-05-24T18:28:39.937' AS DateTime))
SET IDENTITY_INSERT [dbo].[UserLogs] OFF
GO
SET IDENTITY_INSERT [dbo].[VaiTro] ON 

INSERT [dbo].[VaiTro] ([ID_VaiTro], [TenVaiTro], [MieuTa], [TrangThai], [NgayTao]) VALUES (1, N'Admin', N'Quản trị hệ thống, có toàn quyền điều khiển', N'Active', CAST(N'2025-05-24T18:28:39.913' AS DateTime))
INSERT [dbo].[VaiTro] ([ID_VaiTro], [TenVaiTro], [MieuTa], [TrangThai], [NgayTao]) VALUES (2, N'Staff', N'Nhân viên hỗ trợ, có quyền điều khiển hệ thống ở mức giới hạn', N'Active', CAST(N'2025-05-24T18:28:39.913' AS DateTime))
INSERT [dbo].[VaiTro] ([ID_VaiTro], [TenVaiTro], [MieuTa], [TrangThai], [NgayTao]) VALUES (3, N'GiaoVien', N'Giáo viên giảng dạy, quản lý lớp học và học sinh', N'Active', CAST(N'2025-05-24T18:28:39.913' AS DateTime))
INSERT [dbo].[VaiTro] ([ID_VaiTro], [TenVaiTro], [MieuTa], [TrangThai], [NgayTao]) VALUES (4, N'HocSinh', N'Học sinh tham gia các khóa học', N'Active', CAST(N'2025-05-24T18:28:39.913' AS DateTime))
INSERT [dbo].[VaiTro] ([ID_VaiTro], [TenVaiTro], [MieuTa], [TrangThai], [NgayTao]) VALUES (5, N'PhuHuynh', N'Phụ huynh học sinh, theo dõi kết quả học tập', N'Active', CAST(N'2025-05-24T18:28:39.913' AS DateTime))
INSERT [dbo].[VaiTro] ([ID_VaiTro], [TenVaiTro], [MieuTa], [TrangThai], [NgayTao]) VALUES (6, N'Admin', N'Quản trị hệ thống, có quyền điều khiển toàn bộ', N'Active', CAST(N'2025-05-25T21:23:32.413' AS DateTime))
INSERT [dbo].[VaiTro] ([ID_VaiTro], [TenVaiTro], [MieuTa], [TrangThai], [NgayTao]) VALUES (7, N'Staff', N'Nhân viên hỗ trợ, quản lý nghiệp vụ', N'Active', CAST(N'2025-05-25T21:23:32.413' AS DateTime))
INSERT [dbo].[VaiTro] ([ID_VaiTro], [TenVaiTro], [MieuTa], [TrangThai], [NgayTao]) VALUES (8, N'Giáo viên', N'Giáo viên trực tiếp giảng dạy', N'Active', CAST(N'2025-05-25T21:23:32.413' AS DateTime))
INSERT [dbo].[VaiTro] ([ID_VaiTro], [TenVaiTro], [MieuTa], [TrangThai], [NgayTao]) VALUES (9, N'Học sinh', N'Người học tham gia lớp học', N'Active', CAST(N'2025-05-25T21:23:32.413' AS DateTime))
INSERT [dbo].[VaiTro] ([ID_VaiTro], [TenVaiTro], [MieuTa], [TrangThai], [NgayTao]) VALUES (10, N'Phụ huynh', N'Người giám hộ học sinh', N'Active', CAST(N'2025-05-25T21:23:32.413' AS DateTime))
SET IDENTITY_INSERT [dbo].[VaiTro] OFF
GO
/****** Object:  Index [UQ__GiaoVien__0E3EC21155FF47C9]    Script Date: 29/05/2025 4:04:25 CH ******/
ALTER TABLE [dbo].[GiaoVien] ADD UNIQUE NONCLUSTERED 
(
	[ID_TaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__HocSinh__0E3EC211F37A45BA]    Script Date: 29/05/2025 4:04:25 CH ******/
ALTER TABLE [dbo].[HocSinh] ADD UNIQUE NONCLUSTERED 
(
	[ID_TaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__PhuHuynh__0E3EC21165FFAC30]    Script Date: 29/05/2025 4:04:25 CH ******/
ALTER TABLE [dbo].[PhuHuynh] ADD  CONSTRAINT [UQ__PhuHuynh__0E3EC21165FFAC30] UNIQUE NONCLUSTERED 
(
	[ID_TaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__TaiKhoan__A9D1053431F3E0F9]    Script Date: 29/05/2025 4:04:25 CH ******/
ALTER TABLE [dbo].[TaiKhoan] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DangKyLopHoc] ADD  DEFAULT (getdate()) FOR [NgayDangKy]
GO
ALTER TABLE [dbo].[DangTaiLieu] ADD  DEFAULT (getdate()) FOR [NgayTao]
GO
ALTER TABLE [dbo].[Diem] ADD  DEFAULT (getdate()) FOR [ThoiGianCapNhat]
GO
ALTER TABLE [dbo].[GiaoVien] ADD  DEFAULT ('Active') FOR [TrangThai]
GO
ALTER TABLE [dbo].[GiaoVien] ADD  DEFAULT (getdate()) FOR [NgayTao]
GO
ALTER TABLE [dbo].[HocSinh] ADD  DEFAULT ('Active') FOR [TrangThai]
GO
ALTER TABLE [dbo].[HocSinh] ADD  DEFAULT (getdate()) FOR [NgayTao]
GO
ALTER TABLE [dbo].[KhoaHoc] ADD  DEFAULT ('Active') FOR [TrangThai]
GO
ALTER TABLE [dbo].[KhoaHoc] ADD  DEFAULT (getdate()) FOR [NgayTao]
GO
ALTER TABLE [dbo].[LopHoc] ADD  CONSTRAINT [DF__LopHoc__TrangTha__66603565]  DEFAULT ('Active') FOR [TrangThai]
GO
ALTER TABLE [dbo].[LopHoc] ADD  CONSTRAINT [DF__LopHoc__NgayTao__6754599E]  DEFAULT (getdate()) FOR [NgayTao]
GO
ALTER TABLE [dbo].[NopBaiTap] ADD  DEFAULT (getdate()) FOR [NgayNop]
GO
ALTER TABLE [dbo].[PhuHuynh] ADD  CONSTRAINT [DF__PhuHuynh__TrangT__693CA210]  DEFAULT ('Active') FOR [TrangThai]
GO
ALTER TABLE [dbo].[PhuHuynh] ADD  CONSTRAINT [DF__PhuHuynh__NgayTa__6A30C649]  DEFAULT (getdate()) FOR [NgayTao]
GO
ALTER TABLE [dbo].[TaiKhoan] ADD  DEFAULT ('Active') FOR [TrangThai]
GO
ALTER TABLE [dbo].[TaiKhoan] ADD  DEFAULT (getdate()) FOR [NgayTao]
GO
ALTER TABLE [dbo].[TaoBaiTap] ADD  CONSTRAINT [DF__TaoBaiTap__NgayT__6D0D32F4]  DEFAULT (getdate()) FOR [NgayTao]
GO
ALTER TABLE [dbo].[ThongBao] ADD  CONSTRAINT [DF__ThongBao__ThoiGi__6E01572D]  DEFAULT (getdate()) FOR [ThoiGian]
GO
ALTER TABLE [dbo].[UserLogs] ADD  DEFAULT (getdate()) FOR [ThoiGian]
GO
ALTER TABLE [dbo].[VaiTro] ADD  DEFAULT ('Active') FOR [TrangThai]
GO
ALTER TABLE [dbo].[VaiTro] ADD  DEFAULT (getdate()) FOR [NgayTao]
GO
ALTER TABLE [dbo].[Blog]  WITH CHECK ADD  CONSTRAINT [FK_Blog_KhoiHoc] FOREIGN KEY([ID_Khoi])
REFERENCES [dbo].[KhoiHoc] ([ID_Khoi])
GO
ALTER TABLE [dbo].[Blog] CHECK CONSTRAINT [FK_Blog_KhoiHoc]
GO
ALTER TABLE [dbo].[DangKyLopHoc]  WITH CHECK ADD FOREIGN KEY([ID_HocSinh])
REFERENCES [dbo].[HocSinh] ([ID_HocSinh])
GO
ALTER TABLE [dbo].[DangKyLopHoc]  WITH CHECK ADD  CONSTRAINT [FK_DangKyLopHoc_LopHoc] FOREIGN KEY([ID_LopHoc])
REFERENCES [dbo].[LopHoc] ([ID_LopHoc])
GO
ALTER TABLE [dbo].[DangKyLopHoc] CHECK CONSTRAINT [FK_DangKyLopHoc_LopHoc]
GO
ALTER TABLE [dbo].[DangTaiLieu]  WITH CHECK ADD FOREIGN KEY([ID_GiaoVien])
REFERENCES [dbo].[GiaoVien] ([ID_GiaoVien])
GO
ALTER TABLE [dbo].[Diem]  WITH CHECK ADD  CONSTRAINT [FK_Diem_LopHoc] FOREIGN KEY([ID_LopHoc])
REFERENCES [dbo].[LopHoc] ([ID_LopHoc])
GO
ALTER TABLE [dbo].[Diem] CHECK CONSTRAINT [FK_Diem_LopHoc]
GO
ALTER TABLE [dbo].[DiemDanh]  WITH CHECK ADD  CONSTRAINT [FK_DiemDanh_LichHoc] FOREIGN KEY([ID_Schedule])
REFERENCES [dbo].[LichHoc] ([ID_Schedule])
GO
ALTER TABLE [dbo].[DiemDanh] CHECK CONSTRAINT [FK_DiemDanh_LichHoc]
GO
ALTER TABLE [dbo].[GiaoVien]  WITH CHECK ADD FOREIGN KEY([ID_TaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([ID_TaiKhoan])
GO
ALTER TABLE [dbo].[GiaoVien_LopHoc]  WITH CHECK ADD FOREIGN KEY([ID_GiaoVien])
REFERENCES [dbo].[GiaoVien] ([ID_GiaoVien])
GO
ALTER TABLE [dbo].[GiaoVien_LopHoc]  WITH CHECK ADD  CONSTRAINT [FK_GiaoVien_LopHoc_LopHoc] FOREIGN KEY([ID_LopHoc])
REFERENCES [dbo].[LopHoc] ([ID_LopHoc])
GO
ALTER TABLE [dbo].[GiaoVien_LopHoc] CHECK CONSTRAINT [FK_GiaoVien_LopHoc_LopHoc]
GO
ALTER TABLE [dbo].[HocPhi]  WITH CHECK ADD  CONSTRAINT [FK__HocPhi__ID_HocSi__7B5B524B] FOREIGN KEY([ID_HocSinh])
REFERENCES [dbo].[HocSinh] ([ID_HocSinh])
GO
ALTER TABLE [dbo].[HocPhi] CHECK CONSTRAINT [FK__HocPhi__ID_HocSi__7B5B524B]
GO
ALTER TABLE [dbo].[HocPhi]  WITH CHECK ADD  CONSTRAINT [FK_HocPhi_LopHoc] FOREIGN KEY([ID_LopHoc])
REFERENCES [dbo].[LopHoc] ([ID_LopHoc])
GO
ALTER TABLE [dbo].[HocPhi] CHECK CONSTRAINT [FK_HocPhi_LopHoc]
GO
ALTER TABLE [dbo].[HocSinh]  WITH CHECK ADD FOREIGN KEY([ID_TaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([ID_TaiKhoan])
GO
ALTER TABLE [dbo].[HocSinh_LopHoc]  WITH CHECK ADD  CONSTRAINT [FK_HocSinh_LopHoc_DiemDanh] FOREIGN KEY([ID_LopHoc])
REFERENCES [dbo].[DiemDanh] ([ID_DiemDanh])
GO
ALTER TABLE [dbo].[HocSinh_LopHoc] CHECK CONSTRAINT [FK_HocSinh_LopHoc_DiemDanh]
GO
ALTER TABLE [dbo].[HocSinh_LopHoc]  WITH CHECK ADD  CONSTRAINT [FK_HocSinh_LopHoc_HocSinh] FOREIGN KEY([ID_HocSinh])
REFERENCES [dbo].[HocSinh] ([ID_HocSinh])
GO
ALTER TABLE [dbo].[HocSinh_LopHoc] CHECK CONSTRAINT [FK_HocSinh_LopHoc_HocSinh]
GO
ALTER TABLE [dbo].[HocSinh_LopHoc]  WITH CHECK ADD  CONSTRAINT [FK_HocSinh_LopHoc_LopHoc] FOREIGN KEY([ID_LopHoc])
REFERENCES [dbo].[LopHoc] ([ID_LopHoc])
GO
ALTER TABLE [dbo].[HocSinh_LopHoc] CHECK CONSTRAINT [FK_HocSinh_LopHoc_LopHoc]
GO
ALTER TABLE [dbo].[HocSinh_PhuHuynh]  WITH CHECK ADD FOREIGN KEY([ID_HocSinh])
REFERENCES [dbo].[HocSinh] ([ID_HocSinh])
GO
ALTER TABLE [dbo].[HocSinh_PhuHuynh]  WITH CHECK ADD  CONSTRAINT [FK__HocSinh_P__ID_Ph__7F2BE32F] FOREIGN KEY([ID_PhuHuynh])
REFERENCES [dbo].[PhuHuynh] ([ID_PhuHuynh])
GO
ALTER TABLE [dbo].[HocSinh_PhuHuynh] CHECK CONSTRAINT [FK__HocSinh_P__ID_Ph__7F2BE32F]
GO
ALTER TABLE [dbo].[KhoaHoc]  WITH CHECK ADD  CONSTRAINT [FK_KhoaHoc_KhoiHoc] FOREIGN KEY([ID_Khoi])
REFERENCES [dbo].[KhoiHoc] ([ID_Khoi])
GO
ALTER TABLE [dbo].[KhoaHoc] CHECK CONSTRAINT [FK_KhoaHoc_KhoiHoc]
GO
ALTER TABLE [dbo].[LichHoc]  WITH CHECK ADD  CONSTRAINT [FK_LichHoc_LopHoc] FOREIGN KEY([ID_LopHoc])
REFERENCES [dbo].[LopHoc] ([ID_LopHoc])
GO
ALTER TABLE [dbo].[LichHoc] CHECK CONSTRAINT [FK_LichHoc_LopHoc]
GO
ALTER TABLE [dbo].[LopHoc]  WITH CHECK ADD  CONSTRAINT [FK__LopHoc__ID_KhoaH__01142BA1] FOREIGN KEY([ID_KhoaHoc])
REFERENCES [dbo].[KhoaHoc] ([ID_KhoaHoc])
GO
ALTER TABLE [dbo].[LopHoc] CHECK CONSTRAINT [FK__LopHoc__ID_KhoaH__01142BA1]
GO
ALTER TABLE [dbo].[NopBaiTap]  WITH CHECK ADD  CONSTRAINT [FK__NopBaiTap__ID_Ba__02084FDA] FOREIGN KEY([ID_BaiTap])
REFERENCES [dbo].[TaoBaiTap] ([ID_BaiTap])
GO
ALTER TABLE [dbo].[NopBaiTap] CHECK CONSTRAINT [FK__NopBaiTap__ID_Ba__02084FDA]
GO
ALTER TABLE [dbo].[NopBaiTap]  WITH CHECK ADD  CONSTRAINT [FK_NopBaiTap_HocSinh] FOREIGN KEY([ID_HocSinh])
REFERENCES [dbo].[HocSinh] ([ID_HocSinh])
GO
ALTER TABLE [dbo].[NopBaiTap] CHECK CONSTRAINT [FK_NopBaiTap_HocSinh]
GO
ALTER TABLE [dbo].[PhuHuynh]  WITH CHECK ADD  CONSTRAINT [FK__PhuHuynh__ID_Tai__03F0984C] FOREIGN KEY([ID_TaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([ID_TaiKhoan])
GO
ALTER TABLE [dbo].[PhuHuynh] CHECK CONSTRAINT [FK__PhuHuynh__ID_Tai__03F0984C]
GO
ALTER TABLE [dbo].[PhuHuynh]  WITH CHECK ADD  CONSTRAINT [FK_PhuHuynh_HocSinh] FOREIGN KEY([ID_HocSinh])
REFERENCES [dbo].[HocSinh] ([ID_HocSinh])
GO
ALTER TABLE [dbo].[PhuHuynh] CHECK CONSTRAINT [FK_PhuHuynh_HocSinh]
GO
ALTER TABLE [dbo].[TaiKhoan]  WITH CHECK ADD FOREIGN KEY([ID_VaiTro])
REFERENCES [dbo].[VaiTro] ([ID_VaiTro])
GO
ALTER TABLE [dbo].[TaoBaiTap]  WITH CHECK ADD  CONSTRAINT [FK__TaoBaiTap__ID_Gi__05D8E0BE] FOREIGN KEY([ID_GiaoVien])
REFERENCES [dbo].[GiaoVien] ([ID_GiaoVien])
GO
ALTER TABLE [dbo].[TaoBaiTap] CHECK CONSTRAINT [FK__TaoBaiTap__ID_Gi__05D8E0BE]
GO
ALTER TABLE [dbo].[TaoBaiTap]  WITH CHECK ADD  CONSTRAINT [FK_TaoBaiTap_LopHoc] FOREIGN KEY([ID_LopHoc])
REFERENCES [dbo].[LopHoc] ([ID_LopHoc])
GO
ALTER TABLE [dbo].[TaoBaiTap] CHECK CONSTRAINT [FK_TaoBaiTap_LopHoc]
GO
ALTER TABLE [dbo].[ThongBao]  WITH CHECK ADD  CONSTRAINT [FK__ThongBao__ID_Tai__06CD04F7] FOREIGN KEY([ID_TaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([ID_TaiKhoan])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ThongBao] CHECK CONSTRAINT [FK__ThongBao__ID_Tai__06CD04F7]
GO
ALTER TABLE [dbo].[ThongBao]  WITH CHECK ADD  CONSTRAINT [FK_ThongBao_HocPhi] FOREIGN KEY([ID_HocPhi])
REFERENCES [dbo].[HocPhi] ([ID_HocPhi])
GO
ALTER TABLE [dbo].[ThongBao] CHECK CONSTRAINT [FK_ThongBao_HocPhi]
GO
ALTER TABLE [dbo].[UserLogs]  WITH CHECK ADD FOREIGN KEY([ID_TaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([ID_TaiKhoan])
GO

select * from TaiKhoan 
select * from HocSinh
select * from GiaoVien 
select * from PhuHuynh