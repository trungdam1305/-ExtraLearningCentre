
USE [SWP1]
GO
/****** Object:  Table [dbo].[Admin]    Script Date: 22/07/2025 7:51:27 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admin](
	[ID_Admin] [int] IDENTITY(1,1) NOT NULL,
	[ID_TaiKhoan] [int] NOT NULL,
	[HoTen] [nvarchar](max) NULL,
	[Avatar] [nvarchar](max) NULL,
 CONSTRAINT [PK_Admin] PRIMARY KEY CLUSTERED 
(
	[ID_Admin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Blog]    Script Date: 22/07/2025 7:51:27 SA ******/
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
	[ID_Khoi] [int] NULL,
	[ID_PhanLoai] [int] NULL,
	[ID_KeyTag] [int] NULL,
	[ID_Keyword] [int] NULL,
	[NoiDung] [nvarchar](max) NULL,
 CONSTRAINT [PK_Blog] PRIMARY KEY CLUSTERED 
(
	[ID_Blog] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DangKyLopHoc]    Script Date: 22/07/2025 7:51:27 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DangKyLopHoc](
	[ID_HocSinh] [int] NOT NULL,
	[ID_LopHoc] [int] NOT NULL,
	[NgayDangKy] [date] NOT NULL,
	[TinhTrangHocPhi] [nvarchar](50) NULL,
 CONSTRAINT [PK_DangKyLopHoc] PRIMARY KEY CLUSTERED 
(
	[ID_HocSinh] ASC,
	[ID_LopHoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DangTaiLieu]    Script Date: 22/07/2025 7:51:27 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DangTaiLieu](
	[ID_Material] [int] IDENTITY(1,1) NOT NULL,
	[ID_GiaoVien] [int] NULL,
	[TenTaiLieu] [nvarchar](100) NOT NULL,
	[ID_LoaiTaiLieu] [int] NULL,
	[DuongDan] [nvarchar](255) NULL,
	[NgayTao] [date] NOT NULL,
	[GiaTien] [nvarchar](max) NULL,
	[Image] [nvarchar](max) NULL,
	[ID_MonHoc] [int] NULL,
	[NoiDung] [nvarchar](max) NULL,
 CONSTRAINT [PK_DangTaiLieu] PRIMARY KEY CLUSTERED 
(
	[ID_Material] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Diem]    Script Date: 22/07/2025 7:51:27 SA ******/
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
	[ThoiGianCapNhat] [datetime] NOT NULL,
 CONSTRAINT [PK_Diem] PRIMARY KEY CLUSTERED 
(
	[ID_Diem] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DiemDanh]    Script Date: 22/07/2025 7:51:27 SA ******/
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
 CONSTRAINT [PK_DiemDanh] PRIMARY KEY CLUSTERED 
(
	[ID_DiemDanh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiaoVien]    Script Date: 22/07/2025 7:51:27 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaoVien](
	[ID_GiaoVien] [int] IDENTITY(1,1) NOT NULL,
	[ID_TaiKhoan] [int] NOT NULL,
	[HoTen] [nvarchar](100) NOT NULL,
	[ChuyenMon] [nvarchar](100) NULL,
	[SDT] [nvarchar](15) NULL,
	[ID_TruongHoc] [int] NOT NULL,
	[Luong] [decimal](10, 2) NULL,
	[IsHot] [int] NULL,
	[TrangThai] [nvarchar](20) NOT NULL,
	[NgayTao] [datetime] NOT NULL,
	[Avatar] [nvarchar](max) NULL,
	[BangCap] [nvarchar](50) NULL,
	[LopDangDayTrenTruong] [nvarchar](50) NULL,
	[TrangThaiDay] [nvarchar](20) NULL,
 CONSTRAINT [PK_GiaoVien] PRIMARY KEY CLUSTERED 
(
	[ID_GiaoVien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiaoVien_LopHoc]    Script Date: 22/07/2025 7:51:27 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaoVien_LopHoc](
	[ID_GiaoVien] [int] NOT NULL,
	[ID_LopHoc] [int] NOT NULL,
 CONSTRAINT [PK_GiaoVien_LopHoc] PRIMARY KEY CLUSTERED 
(
	[ID_GiaoVien] ASC,
	[ID_LopHoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HocPhi]    Script Date: 22/07/2025 7:51:27 SA ******/
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
	[Thang] [int] NULL,
	[Nam] [int] NULL,
	[SoBuoi] [int] NULL,
	[HocPhiPhaiDong] [int] NULL,
	[DaDong] [int] NULL,
	[NoConLai] [int] NULL,
 CONSTRAINT [PK_HocPhi] PRIMARY KEY CLUSTERED 
(
	[ID_HocPhi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HocSinh]    Script Date: 22/07/2025 7:51:27 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
	[TrangThai] [nvarchar](20) NOT NULL,
	[NgayTao] [datetime] NOT NULL,
	[LopDangHocTrenTruong] [nvarchar](50) NULL,
	[TrangThaiHoc] [nvarchar](20) NULL,
	[Avatar] [nvarchar](max) NULL,
 CONSTRAINT [PK_HocSinh] PRIMARY KEY CLUSTERED 
(
	[ID_HocSinh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HocSinh_LopHoc]    Script Date: 22/07/2025 7:51:27 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HocSinh_LopHoc](
	[ID_HSLopHoc] [int] IDENTITY(1,1) NOT NULL,
	[ID_LopHoc] [int] NULL,
	[ID_HocSinh] [int] NULL,
	[FeedBack] [nvarchar](max) NULL,
	[Status_FeedBack] [bit] NULL,
 CONSTRAINT [PK_HocSinh_LopHoc] PRIMARY KEY CLUSTERED 
(
	[ID_HSLopHoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HocSinh_PhuHuynh]    Script Date: 22/07/2025 7:51:27 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HocSinh_PhuHuynh](
	[ID_HocSinh] [int] NOT NULL,
	[ID_PhuHuynh] [int] NOT NULL,
 CONSTRAINT [PK_HocSinh_PhuHuynh] PRIMARY KEY CLUSTERED 
(
	[ID_HocSinh] ASC,
	[ID_PhuHuynh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HoTro]    Script Date: 22/07/2025 7:51:27 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoTro](
	[ID_HoTro] [int] IDENTITY(1,1) NOT NULL,
	[HoTen] [nvarchar](100) NULL,
	[TenHoTro] [nvarchar](100) NULL,
	[ThoiGian] [datetime] NULL,
	[MoTa] [nvarchar](255) NULL,
	[ID_TaiKhoan] [int] NULL,
	[PhanHoi] [nvarchar](max) NULL,
	[DaDuyet] [nvarchar](max) NULL,
 CONSTRAINT [PK_HoTro] PRIMARY KEY CLUSTERED 
(
	[ID_HoTro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KeyTag]    Script Date: 22/07/2025 7:51:27 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KeyTag](
	[ID_KeyTag] [int] IDENTITY(1,1) NOT NULL,
	[KeyTag] [nvarchar](max) NULL,
 CONSTRAINT [PK_KeyTag] PRIMARY KEY CLUSTERED 
(
	[ID_KeyTag] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Keyword]    Script Date: 22/07/2025 7:51:27 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Keyword](
	[ID_Keyword] [int] IDENTITY(1,1) NOT NULL,
	[Keyword] [nvarchar](max) NULL,
 CONSTRAINT [PK_Keyword] PRIMARY KEY CLUSTERED 
(
	[ID_Keyword] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhoaHoc]    Script Date: 22/07/2025 7:51:27 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhoaHoc](
	[ID_KhoaHoc] [int] IDENTITY(1,1) NOT NULL,
	[CourseCode] [nvarchar](20) NOT NULL,
	[TenKhoaHoc] [nvarchar](100) NOT NULL,
	[MoTa] [nvarchar](max) NULL,
	[ThoiGianBatDau] [date] NULL,
	[ThoiGianKetThuc] [date] NULL,
	[GhiChu] [nvarchar](max) NULL,
	[TrangThai] [nvarchar](20) NOT NULL,
	[NgayTao] [datetime] NOT NULL,
	[ID_Khoi] [int] NULL,
	[Image] [nvarchar](max) NULL,
	[Order] [int] NULL,
 CONSTRAINT [PK_KhoaHoc] PRIMARY KEY CLUSTERED 
(
	[ID_KhoaHoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhoiHoc]    Script Date: 22/07/2025 7:51:27 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhoiHoc](
	[ID_Khoi] [int] IDENTITY(1,1) NOT NULL,
	[TenKhoi] [nvarchar](50) NOT NULL,
	[Status_Khoi] [bit] NOT NULL,
	[Image] [nvarchar](max) NULL,
 CONSTRAINT [PK_KhoiHoc] PRIMARY KEY CLUSTERED 
(
	[ID_Khoi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LichHoc]    Script Date: 22/07/2025 7:51:27 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LichHoc](
	[ID_Schedule] [int] IDENTITY(1,1) NOT NULL,
	[NgayHoc] [date] NOT NULL,
	[ID_SlotHoc] [int] NOT NULL,
	[ID_LopHoc] [int] NULL,
	[ID_PhongHoc] [int] NULL,
	[GhiChu] [nvarchar](max) NULL,
	[DaDiemDanh] [bit] NULL,
 CONSTRAINT [PK_LichHoc] PRIMARY KEY CLUSTERED 
(
	[ID_Schedule] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiTaiLieu]    Script Date: 22/07/2025 7:51:27 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiTaiLieu](
	[ID_LoaiTaiLieu] [int] IDENTITY(1,1) NOT NULL,
	[LoaiTaiLieu] [nvarchar](max) NULL,
 CONSTRAINT [PK_LoaiTaiLieu] PRIMARY KEY CLUSTERED 
(
	[ID_LoaiTaiLieu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LopHoc]    Script Date: 22/07/2025 7:51:27 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
	[TrangThai] [nvarchar](20) NOT NULL,
	[SoTien] [nvarchar](10) NULL,
	[NgayTao] [datetime] NOT NULL,
	[Image] [nvarchar](max) NULL,
	[Order] [int] NULL,
 CONSTRAINT [PK_LopHoc] PRIMARY KEY CLUSTERED 
(
	[ID_LopHoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MonHoc]    Script Date: 22/07/2025 7:51:27 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MonHoc](
	[ID_MonHoc] [int] IDENTITY(1,1) NOT NULL,
	[TenMonHoc] [nvarchar](max) NULL,
 CONSTRAINT [PK_MonHoc] PRIMARY KEY CLUSTERED 
(
	[ID_MonHoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NopBaiTap]    Script Date: 22/07/2025 7:51:27 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NopBaiTap](
	[ID_HocSinh] [int] NOT NULL,
	[ID_BaiTap] [int] NOT NULL,
	[TepNop] [nvarchar](255) NULL,
	[NgayNop] [date] NOT NULL,
	[Diem] [decimal](5, 2) NULL,
	[NhanXet] [nvarchar](max) NULL,
	[ID_LopHoc] [int] NULL,
 CONSTRAINT [PK_NopBaiTap] PRIMARY KEY CLUSTERED 
(
	[ID_HocSinh] ASC,
	[ID_BaiTap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhanLoaiBlog]    Script Date: 22/07/2025 7:51:27 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhanLoaiBlog](
	[ID_PhanLoai] [int] IDENTITY(1,1) NOT NULL,
	[PhanLoai] [nvarchar](max) NULL,
 CONSTRAINT [PK_PhanLoaiBlog] PRIMARY KEY CLUSTERED 
(
	[ID_PhanLoai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhongHoc]    Script Date: 22/07/2025 7:51:27 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhongHoc](
	[ID_PhongHoc] [int] IDENTITY(1,1) NOT NULL,
	[TenPhongHoc] [nvarchar](50) NOT NULL,
	[SucChua] [int] NOT NULL,
	[TrangThai] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_PhongHoc] PRIMARY KEY CLUSTERED 
(
	[ID_PhongHoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhuHuynh]    Script Date: 22/07/2025 7:51:27 SA ******/
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
	[TrangThai] [nvarchar](20) NOT NULL,
	[NgayTao] [datetime] NOT NULL,
 CONSTRAINT [PK_PhuHuynh] PRIMARY KEY CLUSTERED 
(
	[ID_PhuHuynh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Slider]    Script Date: 22/07/2025 7:51:27 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Slider](
	[ID_Slider] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](max) NULL,
	[Image] [nvarchar](max) NULL,
	[BackLink] [nvarchar](max) NULL,
 CONSTRAINT [PK_Slider] PRIMARY KEY CLUSTERED 
(
	[ID_Slider] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SlotHoc]    Script Date: 22/07/2025 7:51:27 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SlotHoc](
	[ID_SlotHoc] [int] IDENTITY(1,1) NOT NULL,
	[SlotThoiGian] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_SlotHoc] PRIMARY KEY CLUSTERED 
(
	[ID_SlotHoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staff]    Script Date: 22/07/2025 7:51:27 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[ID_Staff] [int] IDENTITY(1,1) NOT NULL,
	[ID_TaiKhoan] [int] NOT NULL,
	[HoTen] [nvarchar](max) NOT NULL,
	[Avatar] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Staff] PRIMARY KEY CLUSTERED 
(
	[ID_Staff] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 22/07/2025 7:51:27 SA ******/
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
	[TrangThai] [nvarchar](20) NOT NULL,
	[NgayTao] [datetime] NOT NULL,
 CONSTRAINT [PK_TaiKhoan] PRIMARY KEY CLUSTERED 
(
	[ID_TaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaoBaiTap]    Script Date: 22/07/2025 7:51:27 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaoBaiTap](
	[ID_BaiTap] [int] IDENTITY(1,1) NOT NULL,
	[ID_GiaoVien] [int] NULL,
	[TenBaiTap] [nvarchar](100) NOT NULL,
	[MoTa] [nvarchar](max) NULL,
	[NgayTao] [date] NOT NULL,
	[ID_LopHoc] [int] NULL,
	[Deadline] [date] NULL,
	[FileName] [varchar](255) NULL,
 CONSTRAINT [PK_TaoBaiTap] PRIMARY KEY CLUSTERED 
(
	[ID_BaiTap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThongBao]    Script Date: 22/07/2025 7:51:27 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThongBao](
	[ID_ThongBao] [int] IDENTITY(1,1) NOT NULL,
	[ID_TaiKhoan] [int] NULL,
	[NoiDung] [nvarchar](max) NULL,
	[ID_HocPhi] [int] NULL,
	[ThoiGian] [datetime] NOT NULL,
	[Status] [varchar](50) NULL,
 CONSTRAINT [PK_ThongBao] PRIMARY KEY CLUSTERED 
(
	[ID_ThongBao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TruongHoc]    Script Date: 22/07/2025 7:51:27 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TruongHoc](
	[ID_TruongHoc] [int] IDENTITY(1,1) NOT NULL,
	[TenTruongHoc] [nvarchar](max) NOT NULL,
	[DiaChi] [nvarchar](max) NULL,
 CONSTRAINT [PK_TruongHoc] PRIMARY KEY CLUSTERED 
(
	[ID_TruongHoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserLogs]    Script Date: 22/07/2025 7:51:27 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserLogs](
	[ID_Log] [int] IDENTITY(1,1) NOT NULL,
	[ID_TaiKhoan] [int] NULL,
	[HanhDong] [nvarchar](255) NULL,
	[ThoiGian] [datetime] NOT NULL,
 CONSTRAINT [PK_UserLogs] PRIMARY KEY CLUSTERED 
(
	[ID_Log] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VaiTro]    Script Date: 22/07/2025 7:51:27 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VaiTro](
	[ID_VaiTro] [int] IDENTITY(1,1) NOT NULL,
	[TenVaiTro] [nvarchar](50) NOT NULL,
	[MieuTa] [nvarchar](max) NULL,
	[TrangThai] [nvarchar](20) NOT NULL,
	[NgayTao] [datetime] NOT NULL,
 CONSTRAINT [PK_VaiTro] PRIMARY KEY CLUSTERED 
(
	[ID_VaiTro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Admin] ON 

INSERT [dbo].[Admin] ([ID_Admin], [ID_TaiKhoan], [HoTen], [Avatar]) VALUES (1, 1, N'Nguyen Van Admin', N'avatar_admin.jpg')
SET IDENTITY_INSERT [dbo].[Admin] OFF
GO
SET IDENTITY_INSERT [dbo].[Blog] ON 

INSERT [dbo].[Blog] ([ID_Blog], [BlogTitle], [BlogDescription], [BlogDate], [Image], [ID_Khoi], [ID_PhanLoai], [ID_KeyTag], [ID_Keyword], [NoiDung]) VALUES (2, N'Bài viết test từ Main - 2025-07-19T21:14:03.227588800', N'Mô tả ngắn của bài viết test.', CAST(N'2025-07-19' AS Date), N'56683a94-597d-4b4c-a7c7-46fd2f98281e.png', 1, 2, 2, 1, N'<blockquote>
<p>Nội dung chi tiết <strong>từ h&agrave;m main</strong> của b&agrave;i viết test.1</p>
</blockquote>

<ul>
	<li><img alt="" src="https://i.pinimg.com/1200x/06/b2/ab/06b2ab49b73d0ce1196ba5f0773b0e6e.jpg" style="height:185px; width:300px" /></li>
</ul>

<p>Đ&acirc;y L&agrave; B&agrave;i Viết để quảng b&aacute; cơ sở vật chất của trung t&acirc;m</p>

<p>&nbsp;</p>
')
INSERT [dbo].[Blog] ([ID_Blog], [BlogTitle], [BlogDescription], [BlogDate], [Image], [ID_Khoi], [ID_PhanLoai], [ID_KeyTag], [ID_Keyword], [NoiDung]) VALUES (4, N'Bài Viết Giới Thiệu Cơ sở vật chất của trung tâm', N'Mô tả ngắn của bài viết test.', CAST(N'2025-07-20' AS Date), N'default_blog_image.jpg', NULL, 1, 1, 1, N'<p>Nội dung chi tiết <strong>từ h&agrave;m main</strong> của b&agrave;i viết test<br />
<br />
<br />
<br />
.&nbsp;&nbsp;<img alt="" src="https://i.pinimg.com/1200x/26/a8/e1/26a8e12cfad5ac0eff8fe7fac1d7810d.jpg" style="height:332px; width:500px" /></p>
')
INSERT [dbo].[Blog] ([ID_Blog], [BlogTitle], [BlogDescription], [BlogDate], [Image], [ID_Khoi], [ID_PhanLoai], [ID_KeyTag], [ID_Keyword], [NoiDung]) VALUES (5, N'Bài Viết giới thiệu về trung tâm', N'demo', CAST(N'2025-07-20' AS Date), N'a4ebff58-12db-4d0d-a8b3-7b4ae20392c3.png', NULL, 1, 2, 1, N'<p>aaaa</p><p>&nbsp;</p><p><a href="https://aistudio.google.com/app/prompts/new_chat?model=gemini-2.5-pro">https://aistudio.google.com/app/prompts/new_chat?model=gemini-2.5-pro</a></p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>aaaaa</p>')
INSERT [dbo].[Blog] ([ID_Blog], [BlogTitle], [BlogDescription], [BlogDate], [Image], [ID_Khoi], [ID_PhanLoai], [ID_KeyTag], [ID_Keyword], [NoiDung]) VALUES (6, N'Bài Viết giới thiệu về trung tâm', N'demo', CAST(N'2025-07-20' AS Date), N'f12d3b01-d2a5-4fff-bbc3-06f825111b5c.png', NULL, 1, 2, 2, N'<p><img alt="aaaa" src="https://www.pinterest.com/pin/40039884185969403/" style="float:left; width:132px" /></p>
')
INSERT [dbo].[Blog] ([ID_Blog], [BlogTitle], [BlogDescription], [BlogDate], [Image], [ID_Khoi], [ID_PhanLoai], [ID_KeyTag], [ID_Keyword], [NoiDung]) VALUES (7, N'Bai Viet Test Blog', N'Demo', CAST(N'2025-07-20' AS Date), N'486ffca0-e3a0-4366-9b20-239020726631.png', NULL, 4, 2, 1, N'<p><span style="background-color:#2ecc71">aaaaaa heheheh&nbsp; &nbsp; &nbsp;&acirc; a</span><span style="background-color:#ffffff">aaa&nbsp;</span></p>

<table border="1" cellpadding="1" cellspacing="1" style="width:500px">
	<tbody>
		<tr>
			<td>ấdasd</td>
			<td>&aacute;dasd</td>
		</tr>
		<tr>
			<td><a href="https://www.facebook.com/trungdamq">Link to fb</a></td>
			<td><img alt="" src="https://i.pinimg.com/736x/be/c8/0f/bec80f789dcaae9d1dc4298ea15c550f.jpg" style="border-style:solid; border-width:1px; height:200px; width:300px" /></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
	</tbody>
</table>

<p>&nbsp;</p>
')
SET IDENTITY_INSERT [dbo].[Blog] OFF
GO
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (1, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (2, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (3, 3, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (4, 4, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (5, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (6, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (7, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (8, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (9, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (10, 3, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (11, 4, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (12, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (13, 2, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (14, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (15, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (16, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (17, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (18, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (19, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (20, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (21, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (22, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (23, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (24, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (25, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (26, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (27, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (28, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (29, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (30, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (31, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (32, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (33, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (34, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (35, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (36, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (37, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (38, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (39, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (40, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (41, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (42, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (43, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (44, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (45, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (46, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (47, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (48, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (49, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (50, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (51, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (52, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (53, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (54, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (55, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (56, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (57, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (58, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (59, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (60, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (61, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (62, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (63, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (64, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (65, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (66, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (67, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (68, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (69, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (70, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (71, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (72, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (73, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (74, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (75, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (76, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (77, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (78, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (79, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (80, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (81, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (82, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (83, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (84, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (85, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (86, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (87, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (88, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (89, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (90, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (91, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (92, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (93, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (94, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (95, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (96, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (97, 4, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (98, 3, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (99, 1, CAST(N'2025-06-01' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (100, 2, CAST(N'2025-06-01' AS Date), N'Chưa đóng học phí')
GO
SET IDENTITY_INSERT [dbo].[DangTaiLieu] ON 

INSERT [dbo].[DangTaiLieu] ([ID_Material], [ID_GiaoVien], [TenTaiLieu], [ID_LoaiTaiLieu], [DuongDan], [NgayTao], [GiaTien], [Image], [ID_MonHoc], [NoiDung]) VALUES (1, 1, N'Tài liệu Toán Đại số', 1, N'51d94bd0-9950-4d14-a32a-548b24a27908.pdf', CAST(N'2025-06-01' AS Date), N'200,000', N'img/avatar/Grade.jpg', 1, N'<p>hehehee&nbsp;<img alt="" src="https://i.pinimg.com/1200x/58/a8/8b/58a88b1b6586b3051956f1a76adf551c.jpg" style="height:973px; width:1005px" /></p>
')
INSERT [dbo].[DangTaiLieu] ([ID_Material], [ID_GiaoVien], [TenTaiLieu], [ID_LoaiTaiLieu], [DuongDan], [NgayTao], [GiaTien], [Image], [ID_MonHoc], [NoiDung]) VALUES (2, 2, N'Tài liệu Văn học lớp 6', 1, N'tesstt.txt', CAST(N'2025-06-01' AS Date), N'150,000', N'img/avatar/Grade.jpg', 2, NULL)
INSERT [dbo].[DangTaiLieu] ([ID_Material], [ID_GiaoVien], [TenTaiLieu], [ID_LoaiTaiLieu], [DuongDan], [NgayTao], [GiaTien], [Image], [ID_MonHoc], [NoiDung]) VALUES (3, 6, N'Tài liệu Sinh học lớp 11', 1, N'tesstt.txt', CAST(N'2025-06-01' AS Date), N'200,000', N'img/avatar/Grade.jpg', 6, NULL)
INSERT [dbo].[DangTaiLieu] ([ID_Material], [ID_GiaoVien], [TenTaiLieu], [ID_LoaiTaiLieu], [DuongDan], [NgayTao], [GiaTien], [Image], [ID_MonHoc], [NoiDung]) VALUES (4, 7, N'Tài liệu Lịch sử lớp 9', 1, N'tesstt.txt', CAST(N'2025-06-01' AS Date), N'180,000', N'img/avatar/Grade.jpg', 7, NULL)
SET IDENTITY_INSERT [dbo].[DangTaiLieu] OFF
GO
SET IDENTITY_INSERT [dbo].[Diem] ON 

INSERT [dbo].[Diem] ([ID_Diem], [ID_HocSinh], [ID_LopHoc], [DiemKiemTra], [DiemBaiTap], [DiemGiuaKy], [DiemCuoiKy], [ThoiGianCapNhat]) VALUES (1, 1, 1, CAST(8.50 AS Decimal(5, 2)), CAST(9.00 AS Decimal(5, 2)), CAST(8.00 AS Decimal(5, 2)), CAST(8.50 AS Decimal(5, 2)), CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[Diem] ([ID_Diem], [ID_HocSinh], [ID_LopHoc], [DiemKiemTra], [DiemBaiTap], [DiemGiuaKy], [DiemCuoiKy], [ThoiGianCapNhat]) VALUES (2, 3, 3, CAST(8.00 AS Decimal(5, 2)), CAST(8.50 AS Decimal(5, 2)), CAST(7.50 AS Decimal(5, 2)), CAST(8.00 AS Decimal(5, 2)), CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[Diem] ([ID_Diem], [ID_HocSinh], [ID_LopHoc], [DiemKiemTra], [DiemBaiTap], [DiemGiuaKy], [DiemCuoiKy], [ThoiGianCapNhat]) VALUES (3, 5, 1, CAST(9.50 AS Decimal(5, 2)), CAST(9.00 AS Decimal(5, 2)), CAST(9.00 AS Decimal(5, 2)), CAST(9.50 AS Decimal(5, 2)), CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[Diem] ([ID_Diem], [ID_HocSinh], [ID_LopHoc], [DiemKiemTra], [DiemBaiTap], [DiemGiuaKy], [DiemCuoiKy], [ThoiGianCapNhat]) VALUES (4, 7, 4, CAST(7.50 AS Decimal(5, 2)), CAST(7.00 AS Decimal(5, 2)), CAST(7.50 AS Decimal(5, 2)), CAST(7.00 AS Decimal(5, 2)), CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[Diem] ([ID_Diem], [ID_HocSinh], [ID_LopHoc], [DiemKiemTra], [DiemBaiTap], [DiemGiuaKy], [DiemCuoiKy], [ThoiGianCapNhat]) VALUES (5, 8, 1, CAST(8.00 AS Decimal(5, 2)), CAST(8.50 AS Decimal(5, 2)), CAST(8.00 AS Decimal(5, 2)), CAST(8.50 AS Decimal(5, 2)), CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[Diem] ([ID_Diem], [ID_HocSinh], [ID_LopHoc], [DiemKiemTra], [DiemBaiTap], [DiemGiuaKy], [DiemCuoiKy], [ThoiGianCapNhat]) VALUES (6, 10, 3, CAST(8.50 AS Decimal(5, 2)), CAST(8.00 AS Decimal(5, 2)), CAST(8.50 AS Decimal(5, 2)), CAST(8.00 AS Decimal(5, 2)), CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[Diem] ([ID_Diem], [ID_HocSinh], [ID_LopHoc], [DiemKiemTra], [DiemBaiTap], [DiemGiuaKy], [DiemCuoiKy], [ThoiGianCapNhat]) VALUES (7, 11, 4, CAST(7.00 AS Decimal(5, 2)), CAST(7.50 AS Decimal(5, 2)), CAST(7.00 AS Decimal(5, 2)), CAST(7.50 AS Decimal(5, 2)), CAST(N'2025-06-01T10:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Diem] OFF
GO
SET IDENTITY_INSERT [dbo].[DiemDanh] ON 

INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (1, 1, 1, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (2, 3, 3, NULL, NULL)
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (3, 5, 1, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (4, 7, 4, NULL, NULL)
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (5, 8, 1, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (6, 10, 3, NULL, NULL)
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (7, 11, 4, NULL, NULL)
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (8, 12, 1, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (9, 15, 1, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (10, 19, 1, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (11, 23, 1, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (12, 27, 1, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (13, 31, 1, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (14, 35, 1, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (15, 39, 1, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (16, 43, 1, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (17, 47, 1, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (18, 51, 1, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (19, 55, 1, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (20, 59, 1, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (21, 63, 1, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (22, 67, 1, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (23, 71, 1, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (24, 75, 1, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (25, 79, 1, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (26, 83, 1, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (27, 87, 1, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (28, 91, 1, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (29, 95, 1, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (30, 99, 1, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (31, 1, 6, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (32, 5, 6, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (33, 8, 6, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (34, 12, 6, N'Đi muộn', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (35, 15, 6, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (36, 19, 6, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (37, 23, 6, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (38, 27, 6, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (39, 31, 6, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (40, 35, 6, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (41, 39, 6, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (42, 43, 6, N'Đi muộn', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (43, 47, 6, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (44, 51, 6, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (45, 55, 6, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (46, 59, 6, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (47, 63, 6, N'Đi muộn', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (48, 67, 6, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (49, 71, 6, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (50, 75, 6, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (51, 79, 6, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (52, 83, 6, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (53, 87, 6, N'Đi muộn', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (54, 91, 6, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (55, 95, 6, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (56, 99, 6, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (57, 1, 5, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (58, 5, 5, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (59, 8, 5, N'Đi muộn', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (60, 12, 5, N'Đi muộn', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (61, 15, 5, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (62, 19, 5, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (63, 23, 5, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (64, 27, 5, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (65, 31, 5, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (66, 35, 5, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (67, 39, 5, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (68, 43, 5, N'Đi muộn', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (69, 47, 5, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (70, 51, 5, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (71, 55, 5, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (72, 59, 5, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (73, 63, 5, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (74, 67, 5, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (75, 71, 5, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (76, 75, 5, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (77, 79, 5, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (78, 83, 5, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (79, 87, 5, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (80, 91, 5, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (81, 95, 5, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (82, 99, 5, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (83, 1, 7, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (84, 5, 7, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (85, 8, 7, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (86, 12, 7, N'Đi muộn', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (87, 15, 7, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (88, 19, 7, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (89, 23, 7, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (90, 27, 7, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (91, 31, 7, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (92, 35, 7, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (93, 39, 7, N'Đi muộn', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (94, 43, 7, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (95, 47, 7, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (96, 51, 7, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (97, 55, 7, N'Đi muộn', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (98, 59, 7, N'Đi muộn', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (99, 63, 7, N'Có mặt', N'')
GO
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (100, 67, 7, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (101, 71, 7, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (102, 75, 7, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (103, 79, 7, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (104, 83, 7, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (105, 87, 7, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (106, 91, 7, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (107, 95, 7, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (108, 99, 7, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (109, 1, 16, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (110, 5, 16, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (111, 8, 16, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (112, 12, 16, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (113, 15, 16, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (114, 19, 16, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (115, 23, 16, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (116, 27, 16, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (117, 31, 16, N'Đi muộn', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (118, 35, 16, N'Đi muộn', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (119, 39, 16, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (120, 43, 16, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (121, 47, 16, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (122, 51, 16, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (123, 55, 16, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (124, 59, 16, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (125, 63, 16, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (126, 67, 16, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (127, 71, 16, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (128, 75, 16, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (129, 79, 16, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (130, 83, 16, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (131, 87, 16, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (132, 91, 16, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (133, 95, 16, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (134, 99, 16, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (135, 1, 8, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (136, 5, 8, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (137, 8, 8, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (138, 12, 8, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (139, 15, 8, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (140, 19, 8, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (141, 23, 8, N'Đi muộn', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (142, 27, 8, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (143, 31, 8, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (144, 35, 8, N'Đi muộn', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (145, 39, 8, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (146, 43, 8, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (147, 47, 8, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (148, 51, 8, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (149, 55, 8, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (150, 59, 8, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (151, 63, 8, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (152, 67, 8, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (153, 71, 8, N'Đi muộn', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (154, 75, 8, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (155, 79, 8, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (156, 83, 8, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (157, 87, 8, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (158, 91, 8, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (159, 95, 8, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (160, 99, 8, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (161, 24, 8, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (162, 80, 8, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (163, 1, 9, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (164, 5, 9, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (165, 8, 9, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (166, 12, 9, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (167, 15, 9, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (168, 19, 9, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (169, 23, 9, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (170, 27, 9, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (171, 31, 9, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (172, 35, 9, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (173, 39, 9, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (174, 43, 9, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (175, 47, 9, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (176, 51, 9, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (177, 55, 9, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (178, 59, 9, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (179, 63, 9, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (180, 67, 9, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (181, 71, 9, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (182, 75, 9, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (183, 79, 9, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (184, 83, 9, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (185, 87, 9, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (186, 91, 9, N'Đi muộn', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (187, 95, 9, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (188, 99, 9, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (189, 24, 9, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (190, 80, 9, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (191, 1, 10, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (192, 5, 10, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (193, 8, 10, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (194, 12, 10, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (195, 15, 10, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (196, 19, 10, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (197, 23, 10, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (198, 27, 10, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (199, 31, 10, N'Có mặt', N'')
GO
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (200, 35, 10, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (201, 39, 10, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (202, 43, 10, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (203, 47, 10, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (204, 51, 10, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (205, 55, 10, N'Đi muộn', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (206, 59, 10, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (207, 63, 10, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (208, 67, 10, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (209, 71, 10, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (210, 75, 10, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (211, 79, 10, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (212, 83, 10, N'Đi muộn', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (213, 87, 10, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (214, 91, 10, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (215, 95, 10, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (216, 99, 10, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (217, 24, 10, N'Đi muộn', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (218, 80, 10, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (219, 1, 11, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (220, 5, 11, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (221, 8, 11, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (222, 12, 11, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (223, 15, 11, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (224, 19, 11, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (225, 23, 11, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (226, 27, 11, N'Đi muộn', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (227, 31, 11, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (228, 35, 11, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (229, 39, 11, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (230, 43, 11, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (231, 47, 11, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (232, 51, 11, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (233, 55, 11, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (234, 59, 11, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (235, 63, 11, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (236, 67, 11, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (237, 71, 11, N'Đi muộn', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (238, 75, 11, N'Đi muộn', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (239, 79, 11, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (240, 83, 11, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (241, 87, 11, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (242, 91, 11, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (243, 95, 11, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (244, 99, 11, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (245, 24, 11, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (246, 80, 11, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (247, 1, 223, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (248, 5, 223, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (249, 8, 223, N'Đi muộn', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (250, 12, 223, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (251, 15, 223, N'Đi muộn', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (252, 19, 223, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (253, 23, 223, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (254, 27, 223, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (255, 31, 223, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (256, 35, 223, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (257, 39, 223, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (258, 43, 223, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (259, 47, 223, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (260, 51, 223, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (261, 55, 223, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (262, 59, 223, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (263, 63, 223, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (264, 67, 223, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (265, 71, 223, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (266, 75, 223, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (267, 79, 223, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (268, 83, 223, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (269, 87, 223, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (270, 91, 223, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (271, 95, 223, N'Vắng', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (272, 99, 223, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (273, 24, 223, N'Có mặt', N'')
INSERT [dbo].[DiemDanh] ([ID_DiemDanh], [ID_HocSinh], [ID_Schedule], [TrangThai], [LyDoVang]) VALUES (274, 80, 223, N'Vắng', N'')
SET IDENTITY_INSERT [dbo].[DiemDanh] OFF
GO
SET IDENTITY_INSERT [dbo].[GiaoVien] ON 

INSERT [dbo].[GiaoVien] ([ID_GiaoVien], [ID_TaiKhoan], [HoTen], [ChuyenMon], [SDT], [ID_TruongHoc], [Luong], [IsHot], [TrangThai], [NgayTao], [Avatar], [BangCap], [LopDangDayTrenTruong], [TrangThaiDay]) VALUES (1, 4, N'Vũ Văn Chủ', N'Toán học', N'0987654321', 1, CAST(10000000.00 AS Decimal(10, 2)), 1, N'Active', CAST(N'2025-05-24T18:28:39.923' AS DateTime), N'avatarTeacher.jpg', N'Cấp 3', N'10A1', N'Đang dạy')
INSERT [dbo].[GiaoVien] ([ID_GiaoVien], [ID_TaiKhoan], [HoTen], [ChuyenMon], [SDT], [ID_TruongHoc], [Luong], [IsHot], [TrangThai], [NgayTao], [Avatar], [BangCap], [LopDangDayTrenTruong], [TrangThaiDay]) VALUES (2, 5, N'Nguyễn Thị Minh', N'Ngữ văn', N'0987654322', 2, CAST(13000000.00 AS Decimal(10, 2)), 1, N'Active', CAST(N'2025-05-24T18:28:39.923' AS DateTime), N'avatarTeacher.jpg', N'Cấp 3', N'11B2', N'Đang dạy')
INSERT [dbo].[GiaoVien] ([ID_GiaoVien], [ID_TaiKhoan], [HoTen], [ChuyenMon], [SDT], [ID_TruongHoc], [Luong], [IsHot], [TrangThai], [NgayTao], [Avatar], [BangCap], [LopDangDayTrenTruong], [TrangThaiDay]) VALUES (3, 6, N'Trần Văn Hùng', N'Tiếng Anh', N'0987654323', 3, CAST(11000000.00 AS Decimal(10, 2)), 0, N'Active', CAST(N'2025-05-24T18:28:39.923' AS DateTime), N'avatarTeacher.jpg', N'Cấp 2', N'8C1', N'Chưa dạy')
INSERT [dbo].[GiaoVien] ([ID_GiaoVien], [ID_TaiKhoan], [HoTen], [ChuyenMon], [SDT], [ID_TruongHoc], [Luong], [IsHot], [TrangThai], [NgayTao], [Avatar], [BangCap], [LopDangDayTrenTruong], [TrangThaiDay]) VALUES (4, 7, N'Lê Thị Hồng', N'Hóa học', N'0987654324', 4, CAST(12500000.00 AS Decimal(10, 2)), 1, N'Active', CAST(N'2025-05-24T18:28:39.923' AS DateTime), N'avatarTeacher.jpg', N'Cấp 3', N'12D3', N'Đang dạy')
INSERT [dbo].[GiaoVien] ([ID_GiaoVien], [ID_TaiKhoan], [HoTen], [ChuyenMon], [SDT], [ID_TruongHoc], [Luong], [IsHot], [TrangThai], [NgayTao], [Avatar], [BangCap], [LopDangDayTrenTruong], [TrangThaiDay]) VALUES (5, 8, N'Phạm Văn Nam', N'Vật lý', N'0987654325', 5, CAST(11500000.00 AS Decimal(10, 2)), 0, N'Active', CAST(N'2025-05-24T18:28:39.923' AS DateTime), N'avatarTeacher.jpg', N'Cấp 3', N'10A3', N'Đang dạy')
INSERT [dbo].[GiaoVien] ([ID_GiaoVien], [ID_TaiKhoan], [HoTen], [ChuyenMon], [SDT], [ID_TruongHoc], [Luong], [IsHot], [TrangThai], [NgayTao], [Avatar], [BangCap], [LopDangDayTrenTruong], [TrangThaiDay]) VALUES (6, 9, N'Đỗ Thị Lan', N'Sinh học', N'0987654326', 1, CAST(11000000.00 AS Decimal(10, 2)), 0, N'Active', CAST(N'2025-05-24T18:28:39.923' AS DateTime), N'avatarTeacher.jpg', N'Cấp 3', N'11A1', N'Đang dạy')
INSERT [dbo].[GiaoVien] ([ID_GiaoVien], [ID_TaiKhoan], [HoTen], [ChuyenMon], [SDT], [ID_TruongHoc], [Luong], [IsHot], [TrangThai], [NgayTao], [Avatar], [BangCap], [LopDangDayTrenTruong], [TrangThaiDay]) VALUES (7, 10, N'Nguyễn Văn Tùng', N'Lịch sử', N'0987654327', 2, CAST(10500000.00 AS Decimal(10, 2)), 1, N'Active', CAST(N'2025-05-24T18:28:39.923' AS DateTime), N'avatarTeacher.jpg', N'Cấp 2', N'9B2', N'Chưa dạy')
INSERT [dbo].[GiaoVien] ([ID_GiaoVien], [ID_TaiKhoan], [HoTen], [ChuyenMon], [SDT], [ID_TruongHoc], [Luong], [IsHot], [TrangThai], [NgayTao], [Avatar], [BangCap], [LopDangDayTrenTruong], [TrangThaiDay]) VALUES (8, 11, N'Trần Thị Mai', N'Địa lý', N'0987654328', 3, CAST(12000000.00 AS Decimal(10, 2)), 0, N'Active', CAST(N'2025-05-24T18:28:39.923' AS DateTime), N'avatarTeacher.jpg', N'Cấp 2', N'8A2', N'Đang dạy')
INSERT [dbo].[GiaoVien] ([ID_GiaoVien], [ID_TaiKhoan], [HoTen], [ChuyenMon], [SDT], [ID_TruongHoc], [Luong], [IsHot], [TrangThai], [NgayTao], [Avatar], [BangCap], [LopDangDayTrenTruong], [TrangThaiDay]) VALUES (9, 12, N'Hoàng Văn Long', N'Toán học', N'0987654329', 4, CAST(13000000.00 AS Decimal(10, 2)), 1, N'Active', CAST(N'2025-05-24T18:28:39.923' AS DateTime), N'avatarTeacher.jpg', N'Cấp 3', N'12A1', N'Đang dạy')
INSERT [dbo].[GiaoVien] ([ID_GiaoVien], [ID_TaiKhoan], [HoTen], [ChuyenMon], [SDT], [ID_TruongHoc], [Luong], [IsHot], [TrangThai], [NgayTao], [Avatar], [BangCap], [LopDangDayTrenTruong], [TrangThaiDay]) VALUES (10, 13, N'Phạm Thị Hoa', N'Ngữ văn', N'0987654330', 5, CAST(11500000.00 AS Decimal(10, 2)), 0, N'Active', CAST(N'2025-05-24T18:28:39.923' AS DateTime), N'avatarTeacher.jpg', N'Cấp 3', N'11C3', N'Đã dạy')
SET IDENTITY_INSERT [dbo].[GiaoVien] OFF
GO
INSERT [dbo].[GiaoVien_LopHoc] ([ID_GiaoVien], [ID_LopHoc]) VALUES (1, 1)
INSERT [dbo].[GiaoVien_LopHoc] ([ID_GiaoVien], [ID_LopHoc]) VALUES (1, 6)
INSERT [dbo].[GiaoVien_LopHoc] ([ID_GiaoVien], [ID_LopHoc]) VALUES (1, 11)
INSERT [dbo].[GiaoVien_LopHoc] ([ID_GiaoVien], [ID_LopHoc]) VALUES (2, 2)
INSERT [dbo].[GiaoVien_LopHoc] ([ID_GiaoVien], [ID_LopHoc]) VALUES (4, 9)
INSERT [dbo].[GiaoVien_LopHoc] ([ID_GiaoVien], [ID_LopHoc]) VALUES (6, 3)
INSERT [dbo].[GiaoVien_LopHoc] ([ID_GiaoVien], [ID_LopHoc]) VALUES (7, 4)
GO
SET IDENTITY_INSERT [dbo].[HocPhi] ON 

INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (1, 1, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (2, 3, 3, N'Sinh học', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (3, 5, 1, N'Toán', N'Chuyển khoản', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (4, 7, 4, N'Lịch sử', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (5, 8, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (6, 10, 3, N'Sinh học', N'Chuyển khoản', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (7, 11, 4, N'Lịch sử', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (8, 12, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (9, 13, 2, N'Ngữ văn', N'Chuyển khoản', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (10, 15, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (11, 17, 4, N'Lịch sử', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (12, 19, 1, N'Toán', N'Chuyển khoản', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (13, 21, 4, N'Lịch sử', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (14, 23, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (15, 25, 4, N'Lịch sử', N'Chuyển khoản', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (16, 27, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (17, 29, 4, N'Lịch sử', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (18, 31, 1, N'Toán', N'Chuyển khoản', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (19, 33, 4, N'Lịch sử', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (20, 35, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (21, 37, 4, N'Lịch sử', N'Chuyển khoản', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (22, 39, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (23, 41, 4, N'Lịch sử', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (24, 43, 1, N'Toán', N'Chuyển khoản', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (25, 45, 4, N'Lịch sử', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (26, 47, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (27, 49, 4, N'Lịch sử', N'Chuyển khoản', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (28, 51, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (29, 53, 4, N'Lịch sử', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (30, 55, 1, N'Toán', N'Chuyển khoản', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (31, 57, 4, N'Lịch sử', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (32, 59, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (33, 61, 4, N'Lịch sử', N'Chuyển khoản', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (34, 63, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (35, 65, 4, N'Lịch sử', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (36, 67, 1, N'Toán', N'Chuyển khoản', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (37, 69, 4, N'Lịch sử', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (38, 71, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (39, 73, 4, N'Lịch sử', N'Chuyển khoản', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (40, 75, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (41, 77, 4, N'Lịch sử', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (42, 79, 1, N'Toán', N'Chuyển khoản', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (43, 81, 4, N'Lịch sử', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (44, 83, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (45, 85, 4, N'Lịch sử', N'Chuyển khoản', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (46, 87, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (47, 89, 4, N'Lịch sử', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (48, 91, 1, N'Toán', N'Chuyển khoản', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (49, 93, 4, N'Lịch sử', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (50, 95, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (51, 1, 1, NULL, N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-07-21' AS Date), NULL, 6, 2025, 1, 2000000, 2000000, 0)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (52, 5, 1, NULL, NULL, N'Chưa thanh toán', NULL, NULL, 6, 2025, 1, 2000000, NULL, 2000000)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (53, 8, 1, NULL, NULL, N'Chưa thanh toán', NULL, NULL, 6, 2025, 1, 2000000, NULL, 2000000)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (54, 19, 1, NULL, NULL, N'Chưa thanh toán', NULL, NULL, 6, 2025, 1, 2000000, NULL, 2000000)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (55, 23, 1, NULL, NULL, N'Chưa thanh toán', NULL, NULL, 6, 2025, 1, 2000000, NULL, 2000000)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (56, 27, 1, NULL, NULL, N'Chưa thanh toán', NULL, NULL, 6, 2025, 1, 2000000, NULL, 2000000)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (57, 35, 1, NULL, NULL, N'Chưa thanh toán', NULL, NULL, 6, 2025, 1, 2000000, NULL, 2000000)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (58, 39, 1, NULL, NULL, N'Chưa thanh toán', NULL, NULL, 6, 2025, 1, 2000000, NULL, 2000000)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (59, 47, 1, NULL, NULL, N'Chưa thanh toán', NULL, NULL, 6, 2025, 1, 2000000, NULL, 2000000)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (60, 51, 1, NULL, NULL, N'Chưa thanh toán', NULL, NULL, 6, 2025, 1, 2000000, NULL, 2000000)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (61, 59, 1, NULL, NULL, N'Chưa thanh toán', NULL, NULL, 6, 2025, 1, 2000000, NULL, 2000000)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (62, 63, 1, NULL, NULL, N'Chưa thanh toán', NULL, NULL, 6, 2025, 1, 2000000, NULL, 2000000)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (63, 71, 1, NULL, NULL, N'Chưa thanh toán', NULL, NULL, 6, 2025, 1, 2000000, NULL, 2000000)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (64, 87, 1, NULL, NULL, N'Chưa thanh toán', NULL, NULL, 6, 2025, 1, 2000000, NULL, 2000000)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (65, 91, 1, NULL, NULL, N'Chưa thanh toán', NULL, NULL, 6, 2025, 1, 2000000, NULL, 2000000)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (66, 95, 1, NULL, NULL, N'Chưa thanh toán', NULL, NULL, 6, 2025, 1, 2000000, NULL, 2000000)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu], [Thang], [Nam], [SoBuoi], [HocPhiPhaiDong], [DaDong], [NoConLai]) VALUES (67, 99, 1, NULL, NULL, N'Chưa thanh toán', NULL, NULL, 6, 2025, 1, 2000000, NULL, 2000000)
SET IDENTITY_INSERT [dbo].[HocPhi] OFF
GO
SET IDENTITY_INSERT [dbo].[HocSinh] ON 

INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (1, N'HS001', 14, N'Nguyễn Văn A', CAST(N'2008-03-15' AS Date), N'Nam', N'Hà Nội', N'0900111231', 1, N'1111', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B1', N'Đang học', NULL)
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (2, N'HS002', 15, N'Trần Thị B', CAST(N'2007-09-10' AS Date), N'Nữ', N'Hải Phòng', N'0900111231', 2, N'Đã đăng ký lớp văn nâng cao', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B1', N'Đang học', N'avatarTeacher.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (3, N'HS003', 16, N'Lê Văn C', CAST(N'2009-01-20' AS Date), N'Nam', N'TP.HCM', N'0900111232', 2, N'Không có ghi chú', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9A1', N'Đang học', N'avatarTeacher.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (4, N'HS004', 17, N'Phạm Thị D', CAST(N'2006-05-12' AS Date), N'Nữ', N'Đà Nẵng', N'0900111232', 3, N'Đã hoàn thành khóa toán cơ bản', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'12C2', N'Đang học', N'uploads/Prestashop - Product list page-Page 2 (2).png')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (5, N'HS005', 18, N'Hoàng Văn E', CAST(N'2008-11-30' AS Date), N'Nam', N'Hà Nội', N'0900111233', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A4', N'Đang học', N'avatarTeacher.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (6, N'HS006', 19, N'Nguyễn Thị F', CAST(N'2007-07-15' AS Date), N'Nữ', N'Huế', N'0900111233', 1, N'Đăng ký lớp tổng ôn', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11A2', N'Đang học', N'avatarTeacher.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (7, N'HS007', 20, N'Trần Văn G', CAST(N'2009-03-10' AS Date), N'Nam', N'Hà Nội', N'0900111234', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9B1', N'Đang học', N'avatarTeacher.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (8, N'HS008', 21, N'Lê Thị H', CAST(N'2008-06-25' AS Date), N'Nữ', N'TP.HCM', N'0900111234', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10B3', N'Đang học', N'avatarTeacher.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (9, N'HS009', 22, N'Phạm Văn I', CAST(N'2007-12-15' AS Date), N'Nam', N'Đà Nẵng', N'0900111235', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11C1', N'Đang học', N'avatarTeacher.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (10, N'HS010', 23, N'Hoàng Thị K', CAST(N'2009-09-20' AS Date), N'Nữ', N'Hà Nội', N'0900111235', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9A2', N'Đang học', N'avatarTeacher.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (11, N'HS011', 24, N'Nguyễn Văn L', CAST(N'2008-02-10' AS Date), N'Nam', N'Huế', N'0900111236', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A5', N'Đang học', N'avatarTeacher.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (12, N'HS012', 25, N'Trần Thị M', CAST(N'2007-04-15' AS Date), N'Nữ', N'Hà Nội', N'0900111236', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B4', N'Chờ học', N'avatarTeacher.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (13, N'HS013', 26, N'Lê Văn N', CAST(N'2009-07-30' AS Date), N'Nam', N'TP.HCM', N'0900111237', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9C2', N'Đang học', N'avatarTeacher.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (14, N'HS014', 27, N'Phạm Thị O', CAST(N'2006-11-25' AS Date), N'Nữ', N'Đà Nẵng', N'0900111237', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'12D1', N'Đã học', N'avatarTeacher.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (15, N'HS015', 28, N'Nguyễn Văn P', CAST(N'2008-05-10' AS Date), N'Nam', N'Hà Nội', N'0900111238', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10B2', N'Đang học', N'avatarTeacher.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (16, N'HS016', 29, N'Trần Thị Q', CAST(N'2007-08-20' AS Date), N'Nữ', N'Hải Phòng', N'0900111238', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11A3', N'Chờ học', N'avatar_student16.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (17, N'HS017', 30, N'Lê Văn R', CAST(N'2009-02-15' AS Date), N'Nam', N'TP.HCM', N'0900111239', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9B3', N'Đang học', N'avatarTeacher.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (18, N'HS018', 31, N'Phạm Thị S', CAST(N'2006-06-30' AS Date), N'Nữ', N'Đà Nẵng', N'0900111239', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'12C3', N'Đã học', N'avatar_student18.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (19, N'HS019', 32, N'Hoàng Văn T', CAST(N'2008-12-05' AS Date), N'Nam', N'Hà Nội', N'0900111240', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A6', N'Đang học', N'avatarTeacher.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (20, N'HS020', 33, N'Nguyễn Thị U', CAST(N'2007-10-25' AS Date), N'Nữ', N'Huế', N'0900111240', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B5', N'Chờ học', N'avatar_student20.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (21, N'HS021', 34, N'Trần Văn V', CAST(N'2009-04-15' AS Date), N'Nam', N'Hà Nội', N'0900111241', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9A3', N'Đang học', N'avatarTeacher.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (22, N'HS022', 35, N'Lê Thị W', CAST(N'2008-07-20' AS Date), N'Nữ', N'TP.HCM', N'0900111241', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10B4', N'Đang học', N'avatarTeacher.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (23, N'HS023', 36, N'Phạm Văn X', CAST(N'2007-11-10' AS Date), N'Nam', N'Đà Nẵng', N'0900111242', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11C2', N'Chờ học', N'avatar_student23.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (24, N'HS024', 37, N'Hoàng Thị Y', CAST(N'2009-05-25' AS Date), N'Nữ', N'Hà Nội', N'0900111242', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9C1', N'Đang học', N'avatar_student24.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (25, N'HS025', 38, N'Nguyễn Văn Z', CAST(N'2008-03-30' AS Date), N'Nam', N'Huế', N'0900111243', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A7', N'Đang học', N'avatar_student25.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (26, N'HS026', 39, N'Trần Thị AA', CAST(N'2007-09-15' AS Date), N'Nữ', N'Hà Nội', N'0900111243', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B6', N'Chờ học', N'avatar_student26.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (27, N'HS027', 40, N'Lê Văn AB', CAST(N'2009-01-20' AS Date), N'Nam', N'TP.HCM', N'0900111244', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9A4', N'Đang học', N'avatar_student27.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (28, N'HS028', 41, N'Phạm Thị AC', CAST(N'2006-06-10' AS Date), N'Nữ', N'Đà Nẵng', N'0900111244', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'12C4', N'Đã học', N'avatar_student28.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (29, N'HS029', 42, N'Hoàng Văn AD', CAST(N'2008-12-25' AS Date), N'Nam', N'Hà Nội', N'0900111245', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A8', N'Đang học', N'avatar_student29.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (30, N'HS030', 43, N'Nguyễn Thị AE', CAST(N'2007-10-30' AS Date), N'Nữ', N'Huế', N'0900111245', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B7', N'Chờ học', N'avatar_student30.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (31, N'HS031', 44, N'Trần Văn AF', CAST(N'2009-05-15' AS Date), N'Nam', N'Hà Nội', N'0900111246', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9B4', N'Đang học', N'avatar_student31.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (32, N'HS032', 45, N'Lê Thị AG', CAST(N'2008-08-20' AS Date), N'Nữ', N'TP.HCM', N'0900111246', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10B5', N'Đang học', N'avatar_student32.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (33, N'HS033', 46, N'Phạm Văn AH', CAST(N'2007-12-05' AS Date), N'Nam', N'Đà Nẵng', N'0900111247', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11C3', N'Chờ học', N'avatar_student33.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (34, N'HS034', 47, N'Hoàng Thị AI', CAST(N'2009-06-10' AS Date), N'Nữ', N'Hà Nội', N'0900111247', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9C2', N'Đang học', N'avatar_student34.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (35, N'HS035', 48, N'Nguyễn Văn AJ', CAST(N'2008-04-15' AS Date), N'Nam', N'Huế', N'0900111248', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A9', N'Đang học', N'avatar_student35.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (36, N'HS036', 49, N'Trần Thị AK', CAST(N'2007-09-25' AS Date), N'Nữ', N'Hà Nội', N'0900111248', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B8', N'Chờ học', N'avatar_student36.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (37, N'HS037', 50, N'Lê Văn AL', CAST(N'2009-02-20' AS Date), N'Nam', N'TP.HCM', N'0900111249', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9A5', N'Đang học', N'avatar_student37.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (38, N'HS038', 51, N'Phạm Thị AM', CAST(N'2006-07-10' AS Date), N'Nữ', N'Đà Nẵng', N'0900111249', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'12C5', N'Đã học', N'avatar_student38.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (39, N'HS039', 52, N'Hoàng Văn AN', CAST(N'2008-01-25' AS Date), N'Nam', N'Hà Nội', N'0900111250', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A10', N'Đang học', N'avatar_student39.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (40, N'HS040', 53, N'Nguyễn Thị AO', CAST(N'2007-11-30' AS Date), N'Nữ', N'Huế', N'0900111250', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B9', N'Chờ học', N'avatar_student40.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (41, N'HS041', 54, N'Trần Văn AP', CAST(N'2009-06-15' AS Date), N'Nam', N'Hà Nội', N'0900111251', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9B5', N'Đang học', N'avatar_student41.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (42, N'HS042', 55, N'Lê Thị AQ', CAST(N'2008-09-20' AS Date), N'Nữ', N'TP.HCM', N'0900111251', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10B6', N'Đang học', N'avatar_student42.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (43, N'HS043', 56, N'Phạm Văn AR', CAST(N'2007-12-25' AS Date), N'Nam', N'Đà Nẵng', N'0900111252', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11C4', N'Chờ học', N'avatar_student43.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (44, N'HS044', 57, N'Hoàng Thị AS', CAST(N'2009-07-10' AS Date), N'Nữ', N'Hà Nội', N'0900111252', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9C3', N'Đang học', N'avatar_student44.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (45, N'HS045', 58, N'Nguyễn Văn AT', CAST(N'2008-05-15' AS Date), N'Nam', N'Huế', N'0900111253', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A11', N'Đang học', N'avatar_student45.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (46, N'HS046', 59, N'Trần Thị AU', CAST(N'2007-10-20' AS Date), N'Nữ', N'Hà Nội', N'0900111253', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B10', N'Chờ học', N'avatar_student46.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (47, N'HS047', 60, N'Lê Văn AV', CAST(N'2009-03-25' AS Date), N'Nam', N'TP.HCM', N'0900111254', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9A6', N'Đang học', N'avatar_student47.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (48, N'HS048', 61, N'Phạm Thị AW', CAST(N'2006-08-10' AS Date), N'Nữ', N'Đà Nẵng', N'0900111254', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'12C6', N'Đã học', N'avatar_student48.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (49, N'HS049', 62, N'Hoàng Văn AX', CAST(N'2008-02-15' AS Date), N'Nam', N'Hà Nội', N'0900111255', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A12', N'Đang học', N'avatar_student49.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (50, N'HS050', 63, N'Nguyễn Thị AY', CAST(N'2007-12-20' AS Date), N'Nữ', N'Huế', N'0900111255', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B11', N'Chờ học', N'avatar_student50.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (51, N'HS051', 64, N'Trần Văn AZ', CAST(N'2009-07-25' AS Date), N'Nam', N'Hà Nội', N'0900111256', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9B6', N'Đang học', N'avatar_student51.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (52, N'HS052', 65, N'Lê Thị BA', CAST(N'2008-10-30' AS Date), N'Nữ', N'TP.HCM', N'0900111256', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10B7', N'Đang học', N'avatar_student52.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (53, N'HS053', 66, N'Phạm Văn BB', CAST(N'2007-01-15' AS Date), N'Nam', N'Đà Nẵng', N'0900111257', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11C5', N'Chờ học', N'avatar_student53.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (54, N'HS054', 67, N'Hoàng Thị BC', CAST(N'2009-08-10' AS Date), N'Nữ', N'Hà Nội', N'0900111257', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9C4', N'Đang học', N'avatar_student54.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (55, N'HS055', 68, N'Nguyễn Văn BD', CAST(N'2008-06-15' AS Date), N'Nam', N'Huế', N'0900111258', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A13', N'Đang học', N'avatar_student55.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (56, N'HS056', 69, N'Trần Thị BE', CAST(N'2007-11-20' AS Date), N'Nữ', N'Hà Nội', N'0900111258', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B12', N'Chờ học', N'avatar_student56.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (57, N'HS057', 70, N'Lê Văn BF', CAST(N'2009-04-25' AS Date), N'Nam', N'TP.HCM', N'0900111259', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9A7', N'Đang học', N'avatar_student57.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (58, N'HS058', 71, N'Phạm Thị BG', CAST(N'2006-09-10' AS Date), N'Nữ', N'Đà Nẵng', N'0900111259', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'12C7', N'Đã học', N'avatar_student58.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (59, N'HS059', 72, N'Hoàng Văn BH', CAST(N'2008-03-20' AS Date), N'Nam', N'Hà Nội', N'0900111260', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A14', N'Đang học', N'avatar_student59.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (60, N'HS060', 73, N'Nguyễn Thị BI', CAST(N'2007-12-25' AS Date), N'Nữ', N'Huế', N'0900111260', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B13', N'Chờ học', N'avatar_student60.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (61, N'HS061', 74, N'Trần Văn BJ', CAST(N'2009-08-15' AS Date), N'Nam', N'Hà Nội', N'0900111261', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9B7', N'Đang học', N'avatar_student61.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (62, N'HS062', 75, N'Lê Thị BK', CAST(N'2008-11-20' AS Date), N'Nữ', N'TP.HCM', N'0900111261', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10B8', N'Đang học', N'avatar_student62.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (63, N'HS063', 76, N'Phạm Văn BL', CAST(N'2007-02-10' AS Date), N'Nam', N'Đà Nẵng', N'0900111262', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11C6', N'Chờ học', N'avatar_student63.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (64, N'HS064', 77, N'Hoàng Thị BM', CAST(N'2009-09-25' AS Date), N'Nữ', N'Hà Nội', N'0900111262', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9C5', N'Đang học', N'avatar_student64.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (65, N'HS065', 78, N'Nguyễn Văn BN', CAST(N'2008-07-10' AS Date), N'Nam', N'Huế', N'0900111263', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A15', N'Đang học', N'avatar_student65.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (66, N'HS066', 79, N'Trần Thị BO', CAST(N'2007-12-15' AS Date), N'Nữ', N'Hà Nội', N'0900111263', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B14', N'Chờ học', N'avatar_student66.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (67, N'HS067', 80, N'Lê Văn BP', CAST(N'2009-05-20' AS Date), N'Nam', N'TP.HCM', N'0900111264', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9A8', N'Đang học', N'avatar_student67.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (68, N'HS068', 81, N'Phạm Thị BQ', CAST(N'2006-10-25' AS Date), N'Nữ', N'Đà Nẵng', N'0900111264', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'12C8', N'Đã học', N'avatar_student68.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (69, N'HS069', 82, N'Hoàng Văn BR', CAST(N'2008-04-15' AS Date), N'Nam', N'Hà Nội', N'0900111265', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A16', N'Đang học', N'avatar_student69.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (70, N'HS070', 83, N'Nguyễn Thị BS', CAST(N'2007-11-20' AS Date), N'Nữ', N'Huế', N'0900111265', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B15', N'Chờ học', N'avatar_student70.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (71, N'HS071', 84, N'Trần Văn BT', CAST(N'2009-08-25' AS Date), N'Nam', N'Hà Nội', N'0900111266', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9B8', N'Đang học', N'avatar_student71.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (72, N'HS072', 85, N'Lê Thị BU', CAST(N'2008-12-10' AS Date), N'Nữ', N'TP.HCM', N'0900111266', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10B9', N'Đang học', N'avatar_student72.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (73, N'HS073', 86, N'Phạm Văn BV', CAST(N'2007-03-15' AS Date), N'Nam', N'Đà Nẵng', N'0900111267', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11C7', N'Chờ học', N'avatar_student73.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (74, N'HS074', 87, N'Hoàng Thị BW', CAST(N'2009-10-20' AS Date), N'Nữ', N'Hà Nội', N'0900111267', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9C6', N'Đang học', N'avatar_student74.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (75, N'HS075', 88, N'Nguyễn Văn BX', CAST(N'2008-08-25' AS Date), N'Nam', N'Huế', N'0900111268', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A17', N'Đang học', N'avatar_student75.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (76, N'HS076', 89, N'Trần Thị BY', CAST(N'2007-01-30' AS Date), N'Nữ', N'Hà Nội', N'0900111268', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B16', N'Chờ học', N'avatar_student76.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (77, N'HS077', 90, N'Lê Văn BZ', CAST(N'2009-06-15' AS Date), N'Nam', N'TP.HCM', N'0900111269', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9A9', N'Đang học', N'avatar_student77.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (78, N'HS078', 91, N'Phạm Thị CA', CAST(N'2006-11-20' AS Date), N'Nữ', N'Đà Nẵng', N'0900111269', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'12C9', N'Đã học', N'avatar_student78.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (79, N'HS079', 92, N'Hoàng Văn CB', CAST(N'2008-05-25' AS Date), N'Nam', N'Hà Nội', N'0900111270', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A18', N'Đang học', N'avatar_student79.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (80, N'HS080', 93, N'Nguyễn Thị CC', CAST(N'2007-12-10' AS Date), N'Nữ', N'Huế', N'0900111270', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B17', N'Chờ học', N'avatar_student80.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (81, N'HS081', 94, N'Trần Văn CD', CAST(N'2009-09-15' AS Date), N'Nam', N'Hà Nội', N'0900111271', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9B9', N'Đang học', N'avatar_student81.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (82, N'HS082', 95, N'Lê Thị CE', CAST(N'2008-02-20' AS Date), N'Nữ', N'TP.HCM', N'0900111271', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10B10', N'Đang học', N'avatar_student82.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (83, N'HS083', 96, N'Phạm Văn CF', CAST(N'2007-07-25' AS Date), N'Nam', N'Đà Nẵng', N'0900111271', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11C8', N'Chờ học', N'avatar_student83.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (84, N'HS084', 97, N'Hoàng Thị CG', CAST(N'2009-10-30' AS Date), N'Nữ', N'Hà Nội', N'0900111272', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9C7', N'Đang học', N'avatar_student84.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (85, N'HS085', 98, N'Nguyễn Văn CH', CAST(N'2008-06-15' AS Date), N'Nam', N'Huế', N'0900111272', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A19', N'Đang học', N'avatar_student85.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (86, N'HS086', 99, N'Trần Thị CI', CAST(N'2007-12-20' AS Date), N'Nữ', N'Hà Nội', N'0900111272', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B18', N'Chờ học', N'avatar_student86.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (87, N'HS087', 100, N'Lê Văn CJ', CAST(N'2009-08-25' AS Date), N'Nam', N'TP.HCM', N'0900111273', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9A10', N'Đang học', N'avatar_student87.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (88, N'HS088', 101, N'Phạm Thị CK', CAST(N'2006-01-30' AS Date), N'Nữ', N'Đà Nẵng', N'0900111273', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'12C10', N'Đã học', N'avatar_student88.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (89, N'HS089', 102, N'Hoàng Văn CL', CAST(N'2008-07-10' AS Date), N'Nam', N'Hà Nội', N'0900111273', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A20', N'Đang học', N'avatar_student89.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (90, N'HS090', 103, N'Nguyễn Thị CM', CAST(N'2007-12-15' AS Date), N'Nữ', N'Huế', N'0900111274', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B19', N'Chờ học', N'avatar_student90.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (91, N'HS091', 104, N'Trần Văn CN', CAST(N'2009-09-20' AS Date), N'Nam', N'Hà Nội', N'0900111274', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9B10', N'Đang học', N'avatar_student91.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (92, N'HS092', 105, N'Lê Thị CO', CAST(N'2008-03-25' AS Date), N'Nữ', N'TP.HCM', N'0900111274', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10B11', N'Đang học', N'avatar_student92.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (93, N'HS093', 106, N'Phạm Văn CP', CAST(N'2007-08-30' AS Date), N'Nam', N'Đà Nẵng', N'0900111275', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11C9', N'Chờ học', N'avatar_student93.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (94, N'HS094', 107, N'Hoàng Thị CQ', CAST(N'2009-11-15' AS Date), N'Nữ', N'Hà Nội', N'0900111275', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9C8', N'Đang học', N'avatar_student94.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (95, N'HS095', 108, N'Nguyễn Văn CR', CAST(N'2008-07-20' AS Date), N'Nam', N'Huế', N'0900111275', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A21', N'Đang học', N'avatar_student95.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (96, N'HS096', 109, N'Trần Thị CS', CAST(N'2007-02-25' AS Date), N'Nữ', N'Hà Nội', N'0900111276', 1, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B20', N'Chờ học', N'avatar_student96.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (97, N'HS097', 110, N'Lê Văn CT', CAST(N'2009-10-30' AS Date), N'Nam', N'TP.HCM', N'0900111276', 2, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'9A11', N'Đang học', N'avatar_student97.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (98, N'HS098', 111, N'Phạm Thị CU', CAST(N'2006-05-15' AS Date), N'Nữ', N'Đà Nẵng', N'0900111276', 3, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'12C11', N'Đã học', N'avatar_student98.jpg')
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (99, N'HS099', 112, N'Hoàng Văn CV', CAST(N'2008-09-20' AS Date), N'Nam', N'Hà Nội', N'0900111277', 4, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'10A22', N'Đang học', N'avatar_student99.jpg')
GO
INSERT [dbo].[HocSinh] ([ID_HocSinh], [MaHocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao], [LopDangHocTrenTruong], [TrangThaiHoc], [Avatar]) VALUES (100, N'HS100', 113, N'Nguyễn Thị CW', CAST(N'2007-12-25' AS Date), N'Nữ', N'Huế', N'0900111277', 5, NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'11B21', N'Chờ học', N'avatar_student100.jpg')
SET IDENTITY_INSERT [dbo].[HocSinh] OFF
GO
SET IDENTITY_INSERT [dbo].[HocSinh_LopHoc] ON 

INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (1, 1, 1, N'Học sinh tích cực', 1)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (2, 2, 2, N'Cần chú ý hơn trong lớp', 0)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (3, 3, 3, N'Học sinh chăm chỉ', 1)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (4, 4, 4, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (5, 1, 5, N'Cần cải thiện kỹ năng giải đề', 0)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (6, 3, 6, N'Học sinh chăm chỉ', 1)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (7, 4, 7, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (8, 1, 8, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (9, 2, 9, N'Cần chú ý hơn trong lớp', 0)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (10, 3, 10, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (11, 4, 11, N'Học sinh tích cực', 1)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (12, 1, 12, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (13, 2, 13, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (14, 3, 14, N'Cần cải thiện kỹ năng thực hành', 0)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (15, 1, 15, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (16, 2, 16, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (17, 4, 17, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (18, 3, 18, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (19, 1, 19, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (20, 2, 20, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (21, 4, 21, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (22, 3, 22, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (23, 1, 23, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (24, 2, 24, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (25, 4, 25, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (26, 3, 26, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (27, 1, 27, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (28, 2, 28, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (29, 4, 29, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (30, 3, 30, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (31, 1, 31, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (32, 2, 32, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (33, 4, 33, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (34, 3, 34, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (35, 1, 35, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (36, 2, 36, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (37, 4, 37, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (38, 3, 38, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (39, 1, 39, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (40, 2, 40, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (41, 4, 41, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (42, 3, 42, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (43, 1, 43, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (44, 2, 44, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (45, 4, 45, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (46, 3, 46, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (47, 1, 47, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (48, 2, 48, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (49, 4, 49, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (50, 3, 50, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (51, 1, 51, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (52, 2, 52, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (53, 4, 53, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (54, 3, 54, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (55, 1, 55, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (56, 2, 56, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (57, 4, 57, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (58, 3, 58, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (59, 1, 59, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (60, 2, 60, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (61, 4, 61, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (62, 3, 62, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (63, 1, 63, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (64, 2, 64, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (65, 4, 65, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (66, 3, 66, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (67, 1, 67, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (68, 2, 68, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (69, 4, 69, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (70, 3, 70, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (71, 1, 71, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (72, 2, 72, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (73, 4, 73, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (74, 3, 74, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (75, 1, 75, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (76, 2, 76, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (77, 4, 77, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (78, 3, 78, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (79, 1, 79, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (80, 2, 80, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (81, 4, 81, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (82, 3, 82, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (83, 1, 83, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (84, 2, 84, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (85, 4, 85, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (86, 3, 86, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (87, 1, 87, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (88, 2, 88, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (89, 4, 89, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (90, 3, 90, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (91, 1, 91, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (92, 2, 92, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (93, 4, 93, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (94, 3, 94, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (95, 1, 95, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (96, 2, 96, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (97, 4, 97, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (98, 3, 98, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (99, 1, 99, NULL, NULL)
GO
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (100, 2, 100, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (101, 1, 24, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (102, 1, 80, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (103, 11, 2, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (104, 4, 1, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (105, 4, 6, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (106, 9, 9, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_HSLopHoc], [ID_LopHoc], [ID_HocSinh], [FeedBack], [Status_FeedBack]) VALUES (107, 13, 3, NULL, NULL)
SET IDENTITY_INSERT [dbo].[HocSinh_LopHoc] OFF
GO
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (1, 1)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (1, 47)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (2, 1)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (2, 48)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (3, 2)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (3, 48)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (4, 2)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (4, 48)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (5, 3)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (5, 49)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (6, 3)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (6, 49)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (7, 4)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (7, 49)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (8, 4)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (8, 50)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (9, 5)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (9, 50)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (10, 5)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (10, 50)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (11, 6)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (12, 6)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (13, 7)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (14, 7)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (15, 8)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (16, 8)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (17, 9)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (18, 9)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (19, 10)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (20, 10)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (21, 11)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (22, 11)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (23, 12)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (24, 12)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (25, 13)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (26, 13)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (27, 14)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (28, 14)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (29, 15)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (30, 15)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (31, 16)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (32, 16)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (33, 17)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (34, 17)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (35, 18)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (36, 18)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (37, 19)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (38, 19)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (39, 20)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (40, 20)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (41, 21)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (42, 21)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (43, 22)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (44, 22)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (45, 23)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (46, 23)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (47, 24)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (48, 24)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (49, 25)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (50, 25)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (51, 26)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (52, 26)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (53, 27)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (54, 27)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (55, 28)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (56, 28)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (57, 29)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (58, 29)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (59, 30)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (60, 30)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (61, 31)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (62, 31)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (63, 32)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (64, 32)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (65, 33)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (66, 33)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (67, 34)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (68, 34)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (69, 35)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (70, 35)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (71, 36)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (72, 36)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (73, 37)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (74, 37)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (75, 38)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (76, 38)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (77, 39)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (78, 39)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (79, 40)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (80, 40)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (81, 41)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (82, 41)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (83, 41)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (84, 42)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (85, 42)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (86, 42)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (87, 43)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (88, 43)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (89, 43)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (90, 44)
GO
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (91, 44)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (92, 44)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (93, 45)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (94, 45)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (95, 45)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (96, 46)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (97, 46)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (98, 46)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (99, 47)
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (100, 47)
GO
SET IDENTITY_INSERT [dbo].[HoTro] ON 

INSERT [dbo].[HoTro] ([ID_HoTro], [HoTen], [TenHoTro], [ThoiGian], [MoTa], [ID_TaiKhoan], [PhanHoi], [DaDuyet]) VALUES (1, N'Vũ Văn Chủ', N'Hỗ trợ sửa thành viên lớp', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'Thành viên lớp nghỉ học. Muốn xóa thành viên lớp', 4, NULL, NULL)
INSERT [dbo].[HoTro] ([ID_HoTro], [HoTen], [TenHoTro], [ThoiGian], [MoTa], [ID_TaiKhoan], [PhanHoi], [DaDuyet]) VALUES (2, N'Nguyễn Thị Minh', N'Hỗ trợ chuyển lớp', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'Học sinh muốn chuyển sang lớp khác', 5, NULL, NULL)
INSERT [dbo].[HoTro] ([ID_HoTro], [HoTen], [TenHoTro], [ThoiGian], [MoTa], [ID_TaiKhoan], [PhanHoi], [DaDuyet]) VALUES (3, N'Đỗ Thị Lan', N'Hỗ trợ thêm tài liệu', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'Cần thêm tài liệu Sinh học lớp 11', 9, NULL, NULL)
INSERT [dbo].[HoTro] ([ID_HoTro], [HoTen], [TenHoTro], [ThoiGian], [MoTa], [ID_TaiKhoan], [PhanHoi], [DaDuyet]) VALUES (4, N'Nguyễn Văn B', N'Hỗ trợ kiểm tra học phí', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'Phụ huynh cần kiểm tra trạng thái học phí', 114, NULL, NULL)
INSERT [dbo].[HoTro] ([ID_HoTro], [HoTen], [TenHoTro], [ThoiGian], [MoTa], [ID_TaiKhoan], [PhanHoi], [DaDuyet]) VALUES (5, N'Nguyễn Văn A', N'Em xin ddooir lop', CAST(N'2025-07-18T02:12:54.227' AS DateTime), N'aaaa', 14, N'ko cho ', N'Từ chối')
INSERT [dbo].[HoTro] ([ID_HoTro], [HoTen], [TenHoTro], [ThoiGian], [MoTa], [ID_TaiKhoan], [PhanHoi], [DaDuyet]) VALUES (6, N'Vũ Văn Chủ', N'Doi Phong Hoc', CAST(N'2025-07-18T02:15:01.020' AS DateTime), N'aaaa', 4, N'oke em ', N'Đã duyệt')
SET IDENTITY_INSERT [dbo].[HoTro] OFF
GO
SET IDENTITY_INSERT [dbo].[KeyTag] ON 

INSERT [dbo].[KeyTag] ([ID_KeyTag], [KeyTag]) VALUES (1, N'Học Sinh Tiêu Biểu')
INSERT [dbo].[KeyTag] ([ID_KeyTag], [KeyTag]) VALUES (2, N'Giáo Viên Xuất Sắc')
SET IDENTITY_INSERT [dbo].[KeyTag] OFF
GO
SET IDENTITY_INSERT [dbo].[Keyword] ON 

INSERT [dbo].[Keyword] ([ID_Keyword], [Keyword]) VALUES (1, N'FeedBack')
INSERT [dbo].[Keyword] ([ID_Keyword], [Keyword]) VALUES (2, N'Giới Thiệu')
SET IDENTITY_INSERT [dbo].[Keyword] OFF
GO
SET IDENTITY_INSERT [dbo].[KhoaHoc] ON 

INSERT [dbo].[KhoaHoc] ([ID_KhoaHoc], [CourseCode], [TenKhoaHoc], [MoTa], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [TrangThai], [NgayTao], [ID_Khoi], [Image], [Order]) VALUES (1, N'MATH06', N'Toán', N'Khóa học Toán nâng cao dành cho học sinh lớp 6', CAST(N'2025-06-01' AS Date), CAST(N'2025-12-01' AS Date), N'Khóa học gồm 2 học kỳ', N'Active', CAST(N'2025-05-24T18:28:39.920' AS DateTime), 1, N'img/avatar/Grade.jpg', 1)
INSERT [dbo].[KhoaHoc] ([ID_KhoaHoc], [CourseCode], [TenKhoaHoc], [MoTa], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [TrangThai], [NgayTao], [ID_Khoi], [Image], [Order]) VALUES (2, N'LIT06', N'Ngữ văn', N'Khóa học Văn lớp 6', CAST(N'2025-06-01' AS Date), CAST(N'2025-11-30' AS Date), NULL, N'Active', CAST(N'2025-05-24T18:28:39.920' AS DateTime), 1, N'img/avatar/Grade.jpg', 2)
INSERT [dbo].[KhoaHoc] ([ID_KhoaHoc], [CourseCode], [TenKhoaHoc], [MoTa], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [TrangThai], [NgayTao], [ID_Khoi], [Image], [Order]) VALUES (3, N'SINH11', N'Sinh học', N'Khóa học Sinh học lớp 11', CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), 6, N'img/avatar/Grade.jpg', 3)
INSERT [dbo].[KhoaHoc] ([ID_KhoaHoc], [CourseCode], [TenKhoaHoc], [MoTa], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [TrangThai], [NgayTao], [ID_Khoi], [Image], [Order]) VALUES (4, N'LICH09', N'Lịch sử', N'Khóa học Lịch sử lớp 9', CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime), 4, N'img/avatar/Grade.jpg', 4)
INSERT [dbo].[KhoaHoc] ([ID_KhoaHoc], [CourseCode], [TenKhoaHoc], [MoTa], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [TrangThai], [NgayTao], [ID_Khoi], [Image], [Order]) VALUES (5, N'TOA12', N'Toán', N'hehehe', CAST(N'2025-07-21' AS Date), CAST(N'2025-10-01' AS Date), N'Ghi chú ví dụ', N'Đang hoạt động', CAST(N'2025-07-14T21:43:53.887' AS DateTime), 7, N'img/avatar/Grade.jpg', 1)
INSERT [dbo].[KhoaHoc] ([ID_KhoaHoc], [CourseCode], [TenKhoaHoc], [MoTa], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [TrangThai], [NgayTao], [ID_Khoi], [Image], [Order]) VALUES (6, N'CON10', N'Công nghệ', N'', CAST(N'2025-08-01' AS Date), CAST(N'2025-09-10' AS Date), N'', N'Chưa bắt đầu', CAST(N'2025-07-15T16:46:44.820' AS DateTime), 5, N'img/avatar/Grade.jpg', 0)
INSERT [dbo].[KhoaHoc] ([ID_KhoaHoc], [CourseCode], [TenKhoaHoc], [MoTa], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [TrangThai], [NgayTao], [ID_Khoi], [Image], [Order]) VALUES (9, N'TOA10', N'Toán', N'', CAST(N'2025-09-01' AS Date), CAST(N'2026-05-31' AS Date), N'', N'Chưa bắt đầu', CAST(N'2025-07-15T23:43:35.000' AS DateTime), 5, N'img/avatar/Grade.jpg', 0)
INSERT [dbo].[KhoaHoc] ([ID_KhoaHoc], [CourseCode], [TenKhoaHoc], [MoTa], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [TrangThai], [NgayTao], [ID_Khoi], [Image], [Order]) VALUES (11, N'HOA08', N'Hóa học', N'', CAST(N'2025-07-20' AS Date), CAST(N'2025-11-01' AS Date), N'', N'Chưa bắt đầu', CAST(N'2025-07-17T21:04:10.737' AS DateTime), 3, N'img/avatar/Grade.jpg', 0)
SET IDENTITY_INSERT [dbo].[KhoaHoc] OFF
GO
SET IDENTITY_INSERT [dbo].[KhoiHoc] ON 

INSERT [dbo].[KhoiHoc] ([ID_Khoi], [TenKhoi], [Status_Khoi], [Image]) VALUES (1, N'Khối 6', 1, N'img/avatar/Grade.jpg')
INSERT [dbo].[KhoiHoc] ([ID_Khoi], [TenKhoi], [Status_Khoi], [Image]) VALUES (2, N'Khối 7', 1, N'img/avatar/Grade.jpg')
INSERT [dbo].[KhoiHoc] ([ID_Khoi], [TenKhoi], [Status_Khoi], [Image]) VALUES (3, N'Khối 8', 1, N'img/avatar/Grade.jpg')
INSERT [dbo].[KhoiHoc] ([ID_Khoi], [TenKhoi], [Status_Khoi], [Image]) VALUES (4, N'Khối 9', 1, N'img/avatar/Grade.jpg')
INSERT [dbo].[KhoiHoc] ([ID_Khoi], [TenKhoi], [Status_Khoi], [Image]) VALUES (5, N'Khối 10', 1, N'img/avatar/Grade.jpg')
INSERT [dbo].[KhoiHoc] ([ID_Khoi], [TenKhoi], [Status_Khoi], [Image]) VALUES (6, N'Khối 11', 1, N'img/avatar/Grade.jpg')
INSERT [dbo].[KhoiHoc] ([ID_Khoi], [TenKhoi], [Status_Khoi], [Image]) VALUES (7, N'Khối 12', 1, N'img/avatar/Grade.jpg')
INSERT [dbo].[KhoiHoc] ([ID_Khoi], [TenKhoi], [Status_Khoi], [Image]) VALUES (8, N'Khối Tổng Ôn', 1, N'img/avatar/Grade.jpg')
SET IDENTITY_INSERT [dbo].[KhoiHoc] OFF
GO
SET IDENTITY_INSERT [dbo].[LichHoc] ON 

INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (1, CAST(N'2025-06-10' AS Date), 1, 1, 1, N'Cố Gắng lên nhé', 1)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (2, CAST(N'2025-06-10' AS Date), 2, 2, 2, N'Học Tập tốt', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (3, CAST(N'2025-06-11' AS Date), 3, 3, 3, N'Học Tập tốt', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (4, CAST(N'2025-06-11' AS Date), 4, 4, 4, N'Học Tập tốt', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (5, CAST(N'2025-07-09' AS Date), 4, 1, 1, N'Hẹ Hẹ', 1)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (6, CAST(N'2025-07-09' AS Date), 3, 1, 1, N'Chú Ý về nhà làm bài tập', 1)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (7, CAST(N'2025-07-10' AS Date), 1, 1, 1, N'aaaaa', 1)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (8, CAST(N'2025-07-11' AS Date), 1, 1, 1, NULL, 1)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (9, CAST(N'2025-07-12' AS Date), 1, 1, 1, N'Lớp học tốt', 1)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (10, CAST(N'2025-07-13' AS Date), 1, 1, 1, N'', 1)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (11, CAST(N'2025-07-14' AS Date), 1, 1, 1, N'đi học không đầy đủ', 1)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (12, CAST(N'2025-07-20' AS Date), 1, 1, 1, NULL, NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (13, CAST(N'2025-07-21' AS Date), 1, 1, 1, NULL, NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (14, CAST(N'2025-07-22' AS Date), 1, 1, 1, NULL, NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (16, CAST(N'2025-07-10' AS Date), 2, 1, 4, N'123123123', 1)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (17, CAST(N'2025-07-10' AS Date), 3, 1, 3, N'kakaka', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (18, CAST(N'2025-07-10' AS Date), 4, 1, 2, NULL, NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (19, CAST(N'2025-07-11' AS Date), 2, 1, 2, NULL, NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (20, CAST(N'2025-07-11' AS Date), 3, 1, 3, NULL, NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (21, CAST(N'2025-07-30' AS Date), 1, 5, 1, N'aaaa', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (22, CAST(N'2025-08-02' AS Date), 1, 5, 1, N'aaaa', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (23, CAST(N'2025-08-06' AS Date), 1, 5, 1, N'aaaa', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (24, CAST(N'2025-08-09' AS Date), 1, 5, 1, N'aaaa', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (25, CAST(N'2025-08-13' AS Date), 1, 5, 1, N'aaaa', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (26, CAST(N'2025-08-16' AS Date), 1, 5, 1, N'aaaa', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (27, CAST(N'2025-08-20' AS Date), 1, 5, 1, N'aaaa', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (28, CAST(N'2025-08-23' AS Date), 1, 5, 1, N'aaaa', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (29, CAST(N'2025-08-27' AS Date), 1, 5, 1, N'aaaa', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (30, CAST(N'2025-08-30' AS Date), 1, 5, 1, N'aaaa', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (31, CAST(N'2025-09-03' AS Date), 1, 5, 1, N'aaaa', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (32, CAST(N'2025-09-06' AS Date), 1, 5, 1, N'aaaa', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (33, CAST(N'2025-09-10' AS Date), 1, 5, 1, N'aaaa', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (34, CAST(N'2025-09-13' AS Date), 1, 5, 1, N'aaaa', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (35, CAST(N'2025-09-17' AS Date), 1, 5, 1, N'aaaa', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (36, CAST(N'2025-09-20' AS Date), 1, 5, 1, N'aaaa', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (37, CAST(N'2025-09-24' AS Date), 1, 5, 1, N'aaaa', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (38, CAST(N'2025-09-27' AS Date), 1, 5, 1, N'aaaa', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (39, CAST(N'2025-10-01' AS Date), 1, 5, 1, N'aaaa', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (40, CAST(N'2025-07-25' AS Date), 4, 5, 1, N'aaaa', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (41, CAST(N'2025-07-31' AS Date), 1, 6, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (42, CAST(N'2025-08-04' AS Date), 1, 6, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (43, CAST(N'2025-08-07' AS Date), 1, 6, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (44, CAST(N'2025-08-11' AS Date), 1, 6, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (45, CAST(N'2025-08-14' AS Date), 1, 6, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (46, CAST(N'2025-08-18' AS Date), 1, 6, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (47, CAST(N'2025-08-21' AS Date), 1, 6, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (48, CAST(N'2025-08-25' AS Date), 1, 6, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (49, CAST(N'2025-08-28' AS Date), 1, 6, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (50, CAST(N'2025-09-01' AS Date), 1, 6, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (51, CAST(N'2025-09-04' AS Date), 1, 6, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (52, CAST(N'2025-09-08' AS Date), 1, 6, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (53, CAST(N'2025-09-11' AS Date), 1, 6, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (54, CAST(N'2025-09-15' AS Date), 1, 6, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (55, CAST(N'2025-09-18' AS Date), 1, 6, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (56, CAST(N'2025-09-22' AS Date), 1, 6, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (57, CAST(N'2025-09-25' AS Date), 1, 6, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (58, CAST(N'2025-09-29' AS Date), 1, 6, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (59, CAST(N'2025-08-01' AS Date), 4, 6, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (60, CAST(N'2025-08-21' AS Date), 3, 7, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (61, CAST(N'2025-08-25' AS Date), 3, 7, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (62, CAST(N'2025-08-27' AS Date), 3, 7, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (63, CAST(N'2025-08-28' AS Date), 3, 7, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (64, CAST(N'2025-09-01' AS Date), 3, 7, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (65, CAST(N'2025-09-03' AS Date), 3, 7, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (66, CAST(N'2025-09-04' AS Date), 3, 7, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (67, CAST(N'2025-09-08' AS Date), 3, 7, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (68, CAST(N'2025-09-10' AS Date), 3, 7, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (69, CAST(N'2025-09-11' AS Date), 3, 7, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (70, CAST(N'2025-09-15' AS Date), 3, 7, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (71, CAST(N'2025-09-17' AS Date), 3, 7, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (72, CAST(N'2025-09-18' AS Date), 3, 7, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (73, CAST(N'2025-09-22' AS Date), 3, 7, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (74, CAST(N'2025-09-24' AS Date), 3, 7, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (75, CAST(N'2025-09-25' AS Date), 3, 7, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (76, CAST(N'2025-09-29' AS Date), 3, 7, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (77, CAST(N'2025-10-01' AS Date), 3, 7, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (90, CAST(N'2025-08-04' AS Date), 1, 9, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (91, CAST(N'2025-08-07' AS Date), 1, 9, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (92, CAST(N'2025-08-11' AS Date), 1, 9, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (93, CAST(N'2025-08-14' AS Date), 1, 9, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (94, CAST(N'2025-08-18' AS Date), 1, 9, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (95, CAST(N'2025-08-21' AS Date), 1, 9, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (96, CAST(N'2025-08-25' AS Date), 1, 9, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (97, CAST(N'2025-08-28' AS Date), 1, 9, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (98, CAST(N'2025-09-01' AS Date), 1, 9, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (99, CAST(N'2025-09-04' AS Date), 1, 9, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (100, CAST(N'2025-09-08' AS Date), 1, 9, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (101, CAST(N'2025-09-11' AS Date), 1, 9, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (102, CAST(N'2025-09-15' AS Date), 1, 9, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (103, CAST(N'2025-09-18' AS Date), 1, 9, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (104, CAST(N'2025-09-22' AS Date), 1, 9, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (105, CAST(N'2025-09-25' AS Date), 1, 9, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (106, CAST(N'2025-09-29' AS Date), 1, 9, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (107, CAST(N'2025-10-02' AS Date), 1, 9, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (108, CAST(N'2025-10-06' AS Date), 1, 9, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (109, CAST(N'2025-10-09' AS Date), 1, 9, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (110, CAST(N'2025-10-13' AS Date), 1, 9, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (111, CAST(N'2025-10-16' AS Date), 1, 9, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (112, CAST(N'2025-10-20' AS Date), 1, 9, 2, N'', NULL)
GO
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (113, CAST(N'2025-10-23' AS Date), 1, 9, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (114, CAST(N'2025-10-27' AS Date), 1, 9, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (115, CAST(N'2025-10-30' AS Date), 1, 9, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (116, CAST(N'2025-08-01' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (117, CAST(N'2025-08-05' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (118, CAST(N'2025-08-08' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (119, CAST(N'2025-08-12' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (120, CAST(N'2025-08-15' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (121, CAST(N'2025-08-19' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (122, CAST(N'2025-08-22' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (123, CAST(N'2025-08-26' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (124, CAST(N'2025-08-29' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (125, CAST(N'2025-09-02' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (126, CAST(N'2025-09-05' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (127, CAST(N'2025-09-09' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (128, CAST(N'2025-09-12' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (129, CAST(N'2025-09-16' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (130, CAST(N'2025-09-19' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (131, CAST(N'2025-09-23' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (132, CAST(N'2025-09-26' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (133, CAST(N'2025-09-30' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (134, CAST(N'2025-10-03' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (135, CAST(N'2025-10-07' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (136, CAST(N'2025-10-10' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (137, CAST(N'2025-10-14' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (138, CAST(N'2025-10-17' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (139, CAST(N'2025-10-21' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (140, CAST(N'2025-10-24' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (141, CAST(N'2025-10-28' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (142, CAST(N'2025-10-31' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (143, CAST(N'2025-11-04' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (144, CAST(N'2025-11-07' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (145, CAST(N'2025-11-11' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (146, CAST(N'2025-11-14' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (147, CAST(N'2025-11-18' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (148, CAST(N'2025-11-21' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (149, CAST(N'2025-11-25' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (150, CAST(N'2025-11-28' AS Date), 2, 10, 4, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (186, CAST(N'2025-08-04' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (187, CAST(N'2025-08-05' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (188, CAST(N'2025-08-11' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (189, CAST(N'2025-08-12' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (190, CAST(N'2025-08-18' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (191, CAST(N'2025-08-19' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (192, CAST(N'2025-08-25' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (193, CAST(N'2025-08-26' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (194, CAST(N'2025-09-01' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (195, CAST(N'2025-09-02' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (196, CAST(N'2025-09-08' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (197, CAST(N'2025-09-09' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (198, CAST(N'2025-09-15' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (199, CAST(N'2025-09-16' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (200, CAST(N'2025-09-22' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (201, CAST(N'2025-09-23' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (202, CAST(N'2025-09-29' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (203, CAST(N'2025-09-30' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (204, CAST(N'2025-10-06' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (205, CAST(N'2025-10-07' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (206, CAST(N'2025-10-13' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (207, CAST(N'2025-10-14' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (208, CAST(N'2025-10-20' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (209, CAST(N'2025-10-21' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (210, CAST(N'2025-10-27' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (211, CAST(N'2025-10-28' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (212, CAST(N'2025-11-03' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (213, CAST(N'2025-11-04' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (214, CAST(N'2025-11-10' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (215, CAST(N'2025-11-11' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (216, CAST(N'2025-11-17' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (217, CAST(N'2025-11-18' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (218, CAST(N'2025-11-24' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (219, CAST(N'2025-11-25' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (220, CAST(N'2025-12-01' AS Date), 2, 11, 1, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (221, CAST(N'2025-07-18' AS Date), 1, 2, 3, N'Lịch học hôm nay', 0)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (222, CAST(N'2025-07-18' AS Date), 1, 2, 1, N'Lịch học hôm nay', 0)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (223, CAST(N'2025-07-18' AS Date), 1, 1, 1, N'Lịch học hôm nay', 1)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (263, CAST(N'2025-07-26' AS Date), 3, 14, 3, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (264, CAST(N'2025-07-28' AS Date), 3, 14, 3, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (265, CAST(N'2025-08-02' AS Date), 3, 14, 3, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (266, CAST(N'2025-08-04' AS Date), 3, 14, 3, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (267, CAST(N'2025-08-09' AS Date), 3, 14, 3, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (268, CAST(N'2025-08-11' AS Date), 3, 14, 3, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (269, CAST(N'2025-08-16' AS Date), 3, 14, 3, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (270, CAST(N'2025-08-18' AS Date), 3, 14, 3, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (271, CAST(N'2025-08-23' AS Date), 3, 14, 3, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (272, CAST(N'2025-08-25' AS Date), 3, 14, 3, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (273, CAST(N'2025-08-30' AS Date), 3, 14, 3, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (274, CAST(N'2025-09-01' AS Date), 3, 14, 3, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (275, CAST(N'2025-09-06' AS Date), 3, 14, 3, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (276, CAST(N'2025-09-08' AS Date), 3, 14, 3, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (277, CAST(N'2025-09-13' AS Date), 3, 14, 3, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (278, CAST(N'2025-09-15' AS Date), 3, 14, 3, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (279, CAST(N'2025-09-20' AS Date), 3, 14, 3, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (280, CAST(N'2025-09-22' AS Date), 3, 14, 3, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (281, CAST(N'2025-09-27' AS Date), 3, 14, 3, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (282, CAST(N'2025-09-29' AS Date), 3, 14, 3, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (283, CAST(N'2025-10-04' AS Date), 3, 14, 3, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (284, CAST(N'2025-10-06' AS Date), 3, 14, 3, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (285, CAST(N'2025-10-11' AS Date), 3, 14, 3, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (286, CAST(N'2025-10-13' AS Date), 3, 14, 3, N'', NULL)
GO
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (287, CAST(N'2025-10-18' AS Date), 3, 14, 3, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (288, CAST(N'2025-10-20' AS Date), 3, 14, 3, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (289, CAST(N'2025-10-25' AS Date), 3, 14, 3, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (290, CAST(N'2025-10-27' AS Date), 3, 14, 3, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (291, CAST(N'2025-11-01' AS Date), 3, 14, 3, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (292, CAST(N'2025-07-20' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (293, CAST(N'2025-07-26' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (294, CAST(N'2025-07-27' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (295, CAST(N'2025-08-02' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (296, CAST(N'2025-08-03' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (297, CAST(N'2025-08-09' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (298, CAST(N'2025-08-10' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (299, CAST(N'2025-08-16' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (300, CAST(N'2025-08-17' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (301, CAST(N'2025-08-23' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (302, CAST(N'2025-08-24' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (303, CAST(N'2025-08-30' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (304, CAST(N'2025-08-31' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (305, CAST(N'2025-09-06' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (306, CAST(N'2025-09-07' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (307, CAST(N'2025-09-13' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (308, CAST(N'2025-09-14' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (309, CAST(N'2025-09-20' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (310, CAST(N'2025-09-21' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (311, CAST(N'2025-09-27' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (312, CAST(N'2025-09-28' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (313, CAST(N'2025-10-04' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (314, CAST(N'2025-10-05' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (315, CAST(N'2025-10-11' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (316, CAST(N'2025-10-12' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (317, CAST(N'2025-10-18' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (318, CAST(N'2025-10-19' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (319, CAST(N'2025-10-25' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (320, CAST(N'2025-10-26' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (321, CAST(N'2025-11-01' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (322, CAST(N'2025-11-02' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (323, CAST(N'2025-11-08' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (324, CAST(N'2025-11-09' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (325, CAST(N'2025-11-15' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (326, CAST(N'2025-11-16' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (327, CAST(N'2025-11-22' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (328, CAST(N'2025-11-23' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (329, CAST(N'2025-11-29' AS Date), 7, 13, 2, N'', NULL)
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [ID_PhongHoc], [GhiChu], [DaDiemDanh]) VALUES (330, CAST(N'2025-11-30' AS Date), 7, 13, 2, N'', NULL)
SET IDENTITY_INSERT [dbo].[LichHoc] OFF
GO
SET IDENTITY_INSERT [dbo].[LoaiTaiLieu] ON 

INSERT [dbo].[LoaiTaiLieu] ([ID_LoaiTaiLieu], [LoaiTaiLieu]) VALUES (1, N'Tài Liệu Tham Khảo')
INSERT [dbo].[LoaiTaiLieu] ([ID_LoaiTaiLieu], [LoaiTaiLieu]) VALUES (2, N'Tài Liệu Ôn Tập')
INSERT [dbo].[LoaiTaiLieu] ([ID_LoaiTaiLieu], [LoaiTaiLieu]) VALUES (3, N'Tài Liệu Làm Thêm')
INSERT [dbo].[LoaiTaiLieu] ([ID_LoaiTaiLieu], [LoaiTaiLieu]) VALUES (4, N'Tài Liệu Ôn Thi')
INSERT [dbo].[LoaiTaiLieu] ([ID_LoaiTaiLieu], [LoaiTaiLieu]) VALUES (5, N'Đề Thi Mẫu')
SET IDENTITY_INSERT [dbo].[LoaiTaiLieu] OFF
GO
SET IDENTITY_INSERT [dbo].[LopHoc] ON 

INSERT [dbo].[LopHoc] ([ID_LopHoc], [ClassCode], [TenLopHoc], [ID_KhoaHoc], [SiSo], [SiSoToiDa], [SiSoToiThieu], [ID_Schedule], [ID_PhongHoc], [GhiChu], [TrangThai], [SoTien], [NgayTao], [Image], [Order]) VALUES (1, N'TOAN06A', N'Toán Nâng Cao', 1, 28, 40, 5, 1, 1, N'Thứ 2, Thứ 4, Thứ 6 7H30-9H30', N'Đang học', N'2000000', CAST(N'2025-05-24T18:28:39.920' AS DateTime), N'img/avatar/Grade.jpg', 1)
INSERT [dbo].[LopHoc] ([ID_LopHoc], [ClassCode], [TenLopHoc], [ID_KhoaHoc], [SiSo], [SiSoToiDa], [SiSoToiThieu], [ID_Schedule], [ID_PhongHoc], [GhiChu], [TrangThai], [SoTien], [NgayTao], [Image], [Order]) VALUES (2, N'VAN06A', N'Văn Học Nâng Cao', 2, 25, 40, 5, 2, 2, N'Thứ 2, Thứ 4, Thứ 6 7H30-9H30', N'Đang học', N'2000000', CAST(N'2025-05-24T18:28:39.920' AS DateTime), N'img/avatar/Grade.jpg', 2)
INSERT [dbo].[LopHoc] ([ID_LopHoc], [ClassCode], [TenLopHoc], [ID_KhoaHoc], [SiSo], [SiSoToiDa], [SiSoToiThieu], [ID_Schedule], [ID_PhongHoc], [GhiChu], [TrangThai], [SoTien], [NgayTao], [Image], [Order]) VALUES (3, N'SINH11A', N'Sinh Học Nâng Cao', 3, 25, 30, 5, 3, 3, N'Thứ 2, Thứ 4, Thứ 6 7H30-9H30', N'Chưa học', N'2500000', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'img/avatar/Grade.jpg', 3)
INSERT [dbo].[LopHoc] ([ID_LopHoc], [ClassCode], [TenLopHoc], [ID_KhoaHoc], [SiSo], [SiSoToiDa], [SiSoToiThieu], [ID_Schedule], [ID_PhongHoc], [GhiChu], [TrangThai], [SoTien], [NgayTao], [Image], [Order]) VALUES (4, N'LICH09A', N'Lịch Sử Cơ Bản', 4, 27, 35, 5, 4, 4, N'Thứ 2, Thứ 4, Thứ 6 7H30-9H30', N'Đang học', N'1800000', CAST(N'2025-06-01T10:00:00.000' AS DateTime), N'img/avatar/Grade.jpg', 4)
INSERT [dbo].[LopHoc] ([ID_LopHoc], [ClassCode], [TenLopHoc], [ID_KhoaHoc], [SiSo], [SiSoToiDa], [SiSoToiThieu], [ID_Schedule], [ID_PhongHoc], [GhiChu], [TrangThai], [SoTien], [NgayTao], [Image], [Order]) VALUES (5, N'TCBA12', N'Toán Cơ Bản ABC', 5, 0, 40, 15, NULL, NULL, N'aaaa', N'Chưa học', N'70000', CAST(N'2025-07-14T22:17:05.843' AS DateTime), N'/images/class/a9deb332-3069-41d9-ba2c-17a7796a82c0_Grade.jpg', 0)
INSERT [dbo].[LopHoc] ([ID_LopHoc], [ClassCode], [TenLopHoc], [ID_KhoaHoc], [SiSo], [SiSoToiDa], [SiSoToiThieu], [ID_Schedule], [ID_PhongHoc], [GhiChu], [TrangThai], [SoTien], [NgayTao], [Image], [Order]) VALUES (6, N'TNCA12', N'Toán Nâng Cao AD', 5, 0, 40, 15, NULL, NULL, N'', N'Chưa học', N'70000', CAST(N'2025-07-14T22:18:51.373' AS DateTime), N'/images/class/7f6cc9ba-84d5-4fe6-b7cf-5addec9156be_Grade.jpg', 0)
INSERT [dbo].[LopHoc] ([ID_LopHoc], [ClassCode], [TenLopHoc], [ID_KhoaHoc], [SiSo], [SiSoToiDa], [SiSoToiThieu], [ID_Schedule], [ID_PhongHoc], [GhiChu], [TrangThai], [SoTien], [NgayTao], [Image], [Order]) VALUES (7, N'TCBD12', N'Toán Cơ Bản D', 5, 0, 40, 10, NULL, NULL, N'', N'Chưa học', N'100000', CAST(N'2025-07-15T17:13:53.447' AS DateTime), NULL, 0)
INSERT [dbo].[LopHoc] ([ID_LopHoc], [ClassCode], [TenLopHoc], [ID_KhoaHoc], [SiSo], [SiSoToiDa], [SiSoToiThieu], [ID_Schedule], [ID_PhongHoc], [GhiChu], [TrangThai], [SoTien], [NgayTao], [Image], [Order]) VALUES (9, N'HCBA08', N'Hóa C B A1', 11, 1, 40, 20, NULL, NULL, N'', N'Chưa học', N'100000', CAST(N'2025-07-17T21:05:42.750' AS DateTime), N'/images/class/0c076fc8-c8ac-4ba2-bb52-78b453776b06_srs.png', 0)
INSERT [dbo].[LopHoc] ([ID_LopHoc], [ClassCode], [TenLopHoc], [ID_KhoaHoc], [SiSo], [SiSoToiDa], [SiSoToiThieu], [ID_Schedule], [ID_PhongHoc], [GhiChu], [TrangThai], [SoTien], [NgayTao], [Image], [Order]) VALUES (10, N'TCBD06', N'Toán Cơ Bản D', 1, 0, 40, 20, NULL, NULL, N'', N'Chưa học', N'100000', CAST(N'2025-07-18T02:23:21.877' AS DateTime), NULL, 0)
INSERT [dbo].[LopHoc] ([ID_LopHoc], [ClassCode], [TenLopHoc], [ID_KhoaHoc], [SiSo], [SiSoToiDa], [SiSoToiThieu], [ID_Schedule], [ID_PhongHoc], [GhiChu], [TrangThai], [SoTien], [NgayTao], [Image], [Order]) VALUES (11, N'TNCZ06', N'Toán Nâng Cao Z', 1, 1, 40, 1, NULL, NULL, N'', N'Đang học', N'100000', CAST(N'2025-07-18T02:25:02.753' AS DateTime), N'avatarTeacher.jpg', 0)
INSERT [dbo].[LopHoc] ([ID_LopHoc], [ClassCode], [TenLopHoc], [ID_KhoaHoc], [SiSo], [SiSoToiDa], [SiSoToiThieu], [ID_Schedule], [ID_PhongHoc], [GhiChu], [TrangThai], [SoTien], [NgayTao], [Image], [Order]) VALUES (13, N'TCBDA06', N'Toán Cơ Bản D A', 1, 1, 40, 1, NULL, NULL, N'', N'Chưa học', N'0', CAST(N'2025-07-18T10:31:28.983' AS DateTime), N'', 0)
INSERT [dbo].[LopHoc] ([ID_LopHoc], [ClassCode], [TenLopHoc], [ID_KhoaHoc], [SiSo], [SiSoToiDa], [SiSoToiThieu], [ID_Schedule], [ID_PhongHoc], [GhiChu], [TrangThai], [SoTien], [NgayTao], [Image], [Order]) VALUES (14, N'HHCBJ08', N'Hóa Học Cơ Bản J', 11, 0, 40, 10, NULL, NULL, N'', N'Chưa học', N'50000', CAST(N'2025-07-18T11:45:55.750' AS DateTime), NULL, 0)
SET IDENTITY_INSERT [dbo].[LopHoc] OFF
GO
SET IDENTITY_INSERT [dbo].[MonHoc] ON 

INSERT [dbo].[MonHoc] ([ID_MonHoc], [TenMonHoc]) VALUES (1, N'Toán ')
INSERT [dbo].[MonHoc] ([ID_MonHoc], [TenMonHoc]) VALUES (2, N'Văn')
INSERT [dbo].[MonHoc] ([ID_MonHoc], [TenMonHoc]) VALUES (3, N'Anh')
INSERT [dbo].[MonHoc] ([ID_MonHoc], [TenMonHoc]) VALUES (4, N'Lý')
INSERT [dbo].[MonHoc] ([ID_MonHoc], [TenMonHoc]) VALUES (5, N'Hóa')
INSERT [dbo].[MonHoc] ([ID_MonHoc], [TenMonHoc]) VALUES (6, N'Sinh')
INSERT [dbo].[MonHoc] ([ID_MonHoc], [TenMonHoc]) VALUES (7, N'Sử')
INSERT [dbo].[MonHoc] ([ID_MonHoc], [TenMonHoc]) VALUES (8, N'Địa')
INSERT [dbo].[MonHoc] ([ID_MonHoc], [TenMonHoc]) VALUES (9, N'GDCD')
SET IDENTITY_INSERT [dbo].[MonHoc] OFF
GO
INSERT [dbo].[NopBaiTap] ([ID_HocSinh], [ID_BaiTap], [TepNop], [NgayNop], [Diem], [NhanXet], [ID_LopHoc]) VALUES (1, 1, N'/nopbai/hs1_baitap1.pdf', CAST(N'2025-06-01' AS Date), CAST(10.00 AS Decimal(5, 2)), N'Khong Ok', NULL)
INSERT [dbo].[NopBaiTap] ([ID_HocSinh], [ID_BaiTap], [TepNop], [NgayNop], [Diem], [NhanXet], [ID_LopHoc]) VALUES (3, 3, N'/nopbai/hs3_baitap3.pdf', CAST(N'2025-06-01' AS Date), CAST(7.50 AS Decimal(5, 2)), N'Hoàn thành tốt, cần luyện thêm', NULL)
INSERT [dbo].[NopBaiTap] ([ID_HocSinh], [ID_BaiTap], [TepNop], [NgayNop], [Diem], [NhanXet], [ID_LopHoc]) VALUES (5, 1, N'/nopbai/hs5_baitap1.pdf', CAST(N'2025-06-01' AS Date), CAST(9.50 AS Decimal(5, 2)), N'Bài làm xuất sắc', NULL)
INSERT [dbo].[NopBaiTap] ([ID_HocSinh], [ID_BaiTap], [TepNop], [NgayNop], [Diem], [NhanXet], [ID_LopHoc]) VALUES (7, 4, N'/nopbai/hs7_baitap4.pdf', CAST(N'2025-06-01' AS Date), CAST(7.00 AS Decimal(5, 2)), N'Cần cải thiện nội dung', NULL)
INSERT [dbo].[NopBaiTap] ([ID_HocSinh], [ID_BaiTap], [TepNop], [NgayNop], [Diem], [NhanXet], [ID_LopHoc]) VALUES (8, 1, N'/nopbai/hs8_baitap1.pdf', CAST(N'2025-06-01' AS Date), CAST(8.00 AS Decimal(5, 2)), N'Bài làm tốt, cần trình bày rõ ràng', NULL)
INSERT [dbo].[NopBaiTap] ([ID_HocSinh], [ID_BaiTap], [TepNop], [NgayNop], [Diem], [NhanXet], [ID_LopHoc]) VALUES (10, 3, N'/nopbai/hs10_baitap3.pdf', CAST(N'2025-06-01' AS Date), CAST(8.50 AS Decimal(5, 2)), N'Bài làm tốt, cần bổ sung ví dụ', NULL)
INSERT [dbo].[NopBaiTap] ([ID_HocSinh], [ID_BaiTap], [TepNop], [NgayNop], [Diem], [NhanXet], [ID_LopHoc]) VALUES (11, 4, N'/nopbai/hs11_baitap4.pdf', CAST(N'2025-06-01' AS Date), CAST(7.50 AS Decimal(5, 2)), N'Cần cải thiện nội dung', NULL)
INSERT [dbo].[NopBaiTap] ([ID_HocSinh], [ID_BaiTap], [TepNop], [NgayNop], [Diem], [NhanXet], [ID_LopHoc]) VALUES (14, 1, N'1752731563774_message.txt', CAST(N'2025-07-17' AS Date), CAST(10.00 AS Decimal(5, 2)), N'Bài Làm tốt', 1)
INSERT [dbo].[NopBaiTap] ([ID_HocSinh], [ID_BaiTap], [TepNop], [NgayNop], [Diem], [NhanXet], [ID_LopHoc]) VALUES (14, 13, N'1753010678397_Page_3 (3).png', CAST(N'2025-07-20' AS Date), NULL, NULL, 1)
INSERT [dbo].[NopBaiTap] ([ID_HocSinh], [ID_BaiTap], [TepNop], [NgayNop], [Diem], [NhanXet], [ID_LopHoc]) VALUES (14, 14, N'1753010618383_tesstt (5).txt', CAST(N'2025-07-20' AS Date), CAST(10.00 AS Decimal(5, 2)), N'oke Day', 1)
GO
SET IDENTITY_INSERT [dbo].[PhanLoaiBlog] ON 

INSERT [dbo].[PhanLoaiBlog] ([ID_PhanLoai], [PhanLoai]) VALUES (1, N'Toán Học')
INSERT [dbo].[PhanLoaiBlog] ([ID_PhanLoai], [PhanLoai]) VALUES (2, N'Văn Học')
INSERT [dbo].[PhanLoaiBlog] ([ID_PhanLoai], [PhanLoai]) VALUES (3, N'Sinh học')
INSERT [dbo].[PhanLoaiBlog] ([ID_PhanLoai], [PhanLoai]) VALUES (4, N'Lịch sử')
SET IDENTITY_INSERT [dbo].[PhanLoaiBlog] OFF
GO
SET IDENTITY_INSERT [dbo].[PhongHoc] ON 

INSERT [dbo].[PhongHoc] ([ID_PhongHoc], [TenPhongHoc], [SucChua], [TrangThai]) VALUES (1, N'Phòng 101', 40, N'Active')
INSERT [dbo].[PhongHoc] ([ID_PhongHoc], [TenPhongHoc], [SucChua], [TrangThai]) VALUES (2, N'Phòng 102', 40, N'Active')
INSERT [dbo].[PhongHoc] ([ID_PhongHoc], [TenPhongHoc], [SucChua], [TrangThai]) VALUES (3, N'Phòng 103', 40, N'Active')
INSERT [dbo].[PhongHoc] ([ID_PhongHoc], [TenPhongHoc], [SucChua], [TrangThai]) VALUES (4, N'Phòng 104', 40, N'Active')
INSERT [dbo].[PhongHoc] ([ID_PhongHoc], [TenPhongHoc], [SucChua], [TrangThai]) VALUES (5, N'Phòng 105', 40, N'Active')
SET IDENTITY_INSERT [dbo].[PhongHoc] OFF
GO
SET IDENTITY_INSERT [dbo].[PhuHuynh] ON 

INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (1, 114, N'Nguyễn Văn B', N'0900111231', N'phuhuynh1@example.com', N'Hà Nội', N'Không có ghi chú', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (2, 115, N'Trần Thị H', N'0900111232', N'phuhuynh2@example.com', N'Hải Phòng', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (3, 116, N'Lê Văn F', N'0900111233', N'phuhuynh3@example.com', N'TP.HCM', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (4, 117, N'Phạm Thị G', N'0900111234', N'phuhuynh4@example.com', N'Đà Nẵng', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (5, 118, N'Hoàng Văn I', N'0900111235', N'phuhuynh5@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (6, 119, N'Nguyễn Văn J', N'0900111236', N'phuhuynh6@example.com', N'Huế', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (7, 120, N'Trần Thị K', N'0900111237', N'phuhuynh7@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (8, 121, N'Lê Văn L', N'0900111238', N'phuhuynh8@example.com', N'TP.HCM', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (9, 122, N'Phạm Thị M', N'0900111239', N'phuhuynh9@example.com', N'Đà Nẵng', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (10, 123, N'Hoàng Văn N', N'0900111240', N'phuhuynh10@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (11, 124, N'Nguyễn Thị O', N'0900111241', N'phuhuynh11@example.com', N'Huế', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (12, 125, N'Trần Văn P', N'0900111242', N'phuhuynh12@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (13, 126, N'Lê Thị Q', N'0900111243', N'phuhuynh13@example.com', N'TP.HCM', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (14, 127, N'Phạm Văn R', N'0900111244', N'phuhuynh14@example.com', N'Đà Nẵng', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (15, 128, N'Hoàng Thị S', N'0900111245', N'phuhuynh15@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (16, 129, N'Nguyễn Văn T', N'0900111246', N'phuhuynh16@example.com', N'Huế', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (17, 130, N'Trần Thị U', N'0900111247', N'phuhuynh17@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (18, 131, N'Lê Văn V', N'0900111248', N'phuhuynh18@example.com', N'TP.HCM', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (19, 132, N'Phạm Thị W', N'0900111249', N'phuhuynh19@example.com', N'Đà Nẵng', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (20, 133, N'Hoàng Văn X', N'0900111250', N'phuhuynh20@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (21, 134, N'Nguyễn Thị Y', N'0900111251', N'phuhuynh21@example.com', N'Huế', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (22, 135, N'Trần Văn Z', N'0900111252', N'phuhuynh22@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (23, 136, N'Lê Thị AA', N'0900111253', N'phuhuynh23@example.com', N'TP.HCM', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (24, 137, N'Phạm Văn AB', N'0900111254', N'phuhuynh24@example.com', N'Đà Nẵng', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (25, 138, N'Hoàng Thị AC', N'0900111255', N'phuhuynh25@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (26, 139, N'Nguyễn Văn AD', N'0900111256', N'phuhuynh26@example.com', N'Huế', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (27, 140, N'Trần Thị AE', N'0900111257', N'phuhuynh27@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (28, 141, N'Lê Văn AF', N'0900111258', N'phuhuynh28@example.com', N'TP.HCM', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (29, 142, N'Phạm Thị AG', N'0900111259', N'phuhuynh29@example.com', N'Đà Nẵng', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (30, 143, N'Hoàng Văn AH', N'0900111260', N'phuhuynh30@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (31, 144, N'Nguyễn Thị AI', N'0900111261', N'phuhuynh31@example.com', N'Huế', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (32, 145, N'Trần Văn AJ', N'0900111262', N'phuhuynh32@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (33, 146, N'Lê Thị AK', N'0900111263', N'phuhuynh33@example.com', N'TP.HCM', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (34, 147, N'Phạm Văn AL', N'0900111264', N'phuhuynh34@example.com', N'Đà Nẵng', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (35, 148, N'Hoàng Thị AM', N'0900111265', N'phuhuynh35@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (36, 149, N'Nguyễn Văn AN', N'0900111266', N'phuhuynh36@example.com', N'Huế', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (37, 150, N'Trần Thị AO', N'0900111267', N'phuhuynh37@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (38, 151, N'Lê Văn AP', N'0900111268', N'phuhuynh38@example.com', N'TP.HCM', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (39, 152, N'Phạm Thị AQ', N'0900111269', N'phuhuynh39@example.com', N'Đà Nẵng', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (40, 153, N'Hoàng Văn AR', N'0900111270', N'phuhuynh40@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (41, 154, N'Nguyễn Thị AS', N'0900111271', N'phuhuynh41@example.com', N'Huế', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (42, 155, N'Trần Văn AT', N'0900111272', N'phuhuynh42@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (43, 156, N'Lê Thị AU', N'0900111273', N'phuhuynh43@example.com', N'TP.HCM', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (44, 157, N'Phạm Văn AV', N'0900111274', N'phuhuynh44@example.com', N'Đà Nẵng', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (45, 158, N'Hoàng Thị AW', N'0900111275', N'phuhuynh45@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (46, 159, N'Nguyễn Văn AX', N'0900111276', N'phuhuynh46@example.com', N'Huế', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (47, 160, N'Trần Thị AY', N'0900111277', N'phuhuynh47@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (48, 161, N'Lê Văn AZ', N'0900111278', N'phuhuynh48@example.com', N'TP.HCM', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (49, 162, N'Phạm Thị BA', N'0900111279', N'phuhuynh49@example.com', N'Đà Nẵng', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [TrangThai], [NgayTao]) VALUES (50, 163, N'Hoàng Văn BB', N'0900111280', N'phuhuynh50@example.com', N'Hà Nội', NULL, N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[PhuHuynh] OFF
GO
SET IDENTITY_INSERT [dbo].[Slider] ON 

INSERT [dbo].[Slider] ([ID_Slider], [Title], [Image], [BackLink]) VALUES (1, N'Tuyển Sinh Khóa Học Hè', N'img/avatar/Grade.jpg', N'img/avatar/Grade.jpg')
INSERT [dbo].[Slider] ([ID_Slider], [Title], [Image], [BackLink]) VALUES (2, N'Tiếp đà 2k9', N'img/avatar/Grade.jpg', N'http://localhost:8080/ELCentre1/HomePageCourse')
SET IDENTITY_INSERT [dbo].[Slider] OFF
GO
SET IDENTITY_INSERT [dbo].[SlotHoc] ON 

INSERT [dbo].[SlotHoc] ([ID_SlotHoc], [SlotThoiGian]) VALUES (1, N'7:00 - 9:00')
INSERT [dbo].[SlotHoc] ([ID_SlotHoc], [SlotThoiGian]) VALUES (2, N'9:00 - 11:00')
INSERT [dbo].[SlotHoc] ([ID_SlotHoc], [SlotThoiGian]) VALUES (3, N'11:00 - 13:00')
INSERT [dbo].[SlotHoc] ([ID_SlotHoc], [SlotThoiGian]) VALUES (4, N'14:00 - 16:00')
INSERT [dbo].[SlotHoc] ([ID_SlotHoc], [SlotThoiGian]) VALUES (5, N'16:00 - 18:00')
INSERT [dbo].[SlotHoc] ([ID_SlotHoc], [SlotThoiGian]) VALUES (6, N'17:00 - 19:00')
INSERT [dbo].[SlotHoc] ([ID_SlotHoc], [SlotThoiGian]) VALUES (7, N'18:00 - 20:00')
INSERT [dbo].[SlotHoc] ([ID_SlotHoc], [SlotThoiGian]) VALUES (8, N'19:00 - 21:00')
INSERT [dbo].[SlotHoc] ([ID_SlotHoc], [SlotThoiGian]) VALUES (9, N'20:00 - 22:00')
SET IDENTITY_INSERT [dbo].[SlotHoc] OFF
GO
SET IDENTITY_INSERT [dbo].[Staff] ON 

INSERT [dbo].[Staff] ([ID_Staff], [ID_TaiKhoan], [HoTen], [Avatar]) VALUES (1, 2, N'Tran Thi Staff1', N'avatar_staff1.jpg')
INSERT [dbo].[Staff] ([ID_Staff], [ID_TaiKhoan], [HoTen], [Avatar]) VALUES (2, 3, N'Le Van Staff2', N'avatar_staff2.jpg')
SET IDENTITY_INSERT [dbo].[Staff] OFF
GO
SET IDENTITY_INSERT [dbo].[TaiKhoan] ON 

INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (1, N'admin1@example.com', N'adminpass1', 1, N'Admin', N'0123456789', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (2, N'staff1@example.com', N'staffpass1', 2, N'Staff', N'0123987654', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (3, N'staff2@example.com', N'staffpass2', 2, N'Staff', N'0123987655', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (4, N'giaovien1@example.com', N'gvpass', 3, N'GiaoVien', N'0987654321', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (5, N'giaovien2@example.com', N'gvpass2', 3, N'GiaoVien', N'0987654322', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (6, N'giaovien3@example.com', N'gvpass3', 3, N'GiaoVien', N'0987654323', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (7, N'giaovien4@example.com', N'gvpass4', 3, N'GiaoVien', N'0987654324', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (8, N'giaovien5@example.com', N'gvpass5', 3, N'GiaoVien', N'0987654325', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (9, N'giaovien6@example.com', N'gvpass6', 3, N'GiaoVien', N'0987654326', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (10, N'giaovien7@example.com', N'gvpass7', 3, N'GiaoVien', N'0987654327', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (11, N'giaovien8@example.com', N'gvpass8', 3, N'GiaoVien', N'0987654328', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (12, N'giaovien9@example.com', N'gvpass9', 3, N'GiaoVien', N'0987654329', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (13, N'giaovien10@example.com', N'gvpass10', 3, N'GiaoVien', N'0987654330', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (14, N'hocsinh1@example.com', N'hspass', 4, N'HocSinh', N'0911222331', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (15, N'hocsinh2@example.com', N'hspass2', 4, N'HocSinh', N'0911222332', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (16, N'hocsinh3@example.com', N'hspass3', 4, N'HocSinh', N'0911222333', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (17, N'hocsinh4@example.com', N'hspass4', 4, N'HocSinh', N'0911222334', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (18, N'hocsinh5@example.com', N'hspass5', 4, N'HocSinh', N'0911222335', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (19, N'hocsinh6@example.com', N'hspass6', 4, N'HocSinh', N'0911222336', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (20, N'hocsinh7@example.com', N'hspass7', 4, N'HocSinh', N'0911222337', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (21, N'hocsinh8@example.com', N'hspass8', 4, N'HocSinh', N'0911222338', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (22, N'hocsinh9@example.com', N'hspass9', 4, N'HocSinh', N'0911222339', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (23, N'hocsinh10@example.com', N'hspass10', 4, N'HocSinh', N'0911222340', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (24, N'hocsinh11@example.com', N'hspass11', 4, N'HocSinh', N'0911222341', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (25, N'hocsinh12@example.com', N'hspass12', 4, N'HocSinh', N'0911222342', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (26, N'hocsinh13@example.com', N'hspass13', 4, N'HocSinh', N'0911222343', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (27, N'hocsinh14@example.com', N'hspass14', 4, N'HocSinh', N'0911222344', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (28, N'hocsinh15@example.com', N'hspass15', 4, N'HocSinh', N'0911222345', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (29, N'hocsinh16@example.com', N'hspass16', 4, N'HocSinh', N'0911222346', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (30, N'hocsinh17@example.com', N'hspass17', 4, N'HocSinh', N'0911222347', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (31, N'hocsinh18@example.com', N'hspass18', 4, N'HocSinh', N'0911222348', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (32, N'hocsinh19@example.com', N'hspass19', 4, N'HocSinh', N'0911222349', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (33, N'hocsinh20@example.com', N'hspass20', 4, N'HocSinh', N'0911222350', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (34, N'hocsinh21@example.com', N'hspass21', 4, N'HocSinh', N'0911222351', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (35, N'hocsinh22@example.com', N'hspass22', 4, N'HocSinh', N'0911222352', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (36, N'hocsinh23@example.com', N'hspass23', 4, N'HocSinh', N'0911222353', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (37, N'hocsinh24@example.com', N'hspass24', 4, N'HocSinh', N'0911222354', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (38, N'hocsinh25@example.com', N'hspass25', 4, N'HocSinh', N'0911222355', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (39, N'hocsinh26@example.com', N'hspass26', 4, N'HocSinh', N'0911222356', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (40, N'hocsinh27@example.com', N'hspass27', 4, N'HocSinh', N'0911222357', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (41, N'hocsinh28@example.com', N'hspass28', 4, N'HocSinh', N'0911222358', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (42, N'hocsinh29@example.com', N'hspass29', 4, N'HocSinh', N'0911222359', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (43, N'hocsinh30@example.com', N'hspass30', 4, N'HocSinh', N'0911222360', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (44, N'hocsinh31@example.com', N'hspass31', 4, N'HocSinh', N'0911222361', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (45, N'hocsinh32@example.com', N'hspass32', 4, N'HocSinh', N'0911222362', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (46, N'hocsinh33@example.com', N'hspass33', 4, N'HocSinh', N'0911222363', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (47, N'hocsinh34@example.com', N'hspass34', 4, N'HocSinh', N'0911222364', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (48, N'hocsinh35@example.com', N'hspass35', 4, N'HocSinh', N'0911222365', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (49, N'hocsinh36@example.com', N'hspass36', 4, N'HocSinh', N'0911222366', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (50, N'hocsinh37@example.com', N'hspass37', 4, N'HocSinh', N'0911222367', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (51, N'hocsinh38@example.com', N'hspass38', 4, N'HocSinh', N'0911222368', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (52, N'hocsinh39@example.com', N'hspass39', 4, N'HocSinh', N'0911222369', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (53, N'hocsinh40@example.com', N'hspass40', 4, N'HocSinh', N'0911222370', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (54, N'hocsinh41@example.com', N'hspass41', 4, N'HocSinh', N'0911222371', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (55, N'hocsinh42@example.com', N'hspass42', 4, N'HocSinh', N'0911222372', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (56, N'hocsinh43@example.com', N'hspass43', 4, N'HocSinh', N'0911222373', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (57, N'hocsinh44@example.com', N'hspass44', 4, N'HocSinh', N'0911222374', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (58, N'hocsinh45@example.com', N'hspass45', 4, N'HocSinh', N'0911222375', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (59, N'hocsinh46@example.com', N'hspass46', 4, N'HocSinh', N'0911222376', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (60, N'hocsinh47@example.com', N'hspass47', 4, N'HocSinh', N'0911222377', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (61, N'hocsinh48@example.com', N'hspass48', 4, N'HocSinh', N'0911222378', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (62, N'hocsinh49@example.com', N'hspass49', 4, N'HocSinh', N'0911222379', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (63, N'hocsinh50@example.com', N'hspass50', 4, N'HocSinh', N'0911222380', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (64, N'hocsinh51@example.com', N'hspass51', 4, N'HocSinh', N'0911222381', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (65, N'hocsinh52@example.com', N'hspass52', 4, N'HocSinh', N'0911222382', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (66, N'hocsinh53@example.com', N'hspass53', 4, N'HocSinh', N'0911222383', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (67, N'hocsinh54@example.com', N'hspass54', 4, N'HocSinh', N'0911222384', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (68, N'hocsinh55@example.com', N'hspass55', 4, N'HocSinh', N'0911222385', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (69, N'hocsinh56@example.com', N'hspass56', 4, N'HocSinh', N'0911222386', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (70, N'hocsinh57@example.com', N'hspass57', 4, N'HocSinh', N'0911222387', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (71, N'hocsinh58@example.com', N'hspass58', 4, N'HocSinh', N'0911222388', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (72, N'hocsinh59@example.com', N'hspass59', 4, N'HocSinh', N'0911222389', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (73, N'hocsinh60@example.com', N'hspass60', 4, N'HocSinh', N'0911222390', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (74, N'hocsinh61@example.com', N'hspass61', 4, N'HocSinh', N'0911222391', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (75, N'hocsinh62@example.com', N'hspass62', 4, N'HocSinh', N'0911222392', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (76, N'hocsinh63@example.com', N'hspass63', 4, N'HocSinh', N'0911222393', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (77, N'hocsinh64@example.com', N'hspass64', 4, N'HocSinh', N'0911222394', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (78, N'hocsinh65@example.com', N'hspass65', 4, N'HocSinh', N'0911222395', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (79, N'hocsinh66@example.com', N'hspass66', 4, N'HocSinh', N'0911222396', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (80, N'hocsinh67@example.com', N'hspass67', 4, N'HocSinh', N'0911222397', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (81, N'hocsinh68@example.com', N'hspass68', 4, N'HocSinh', N'0911222398', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (82, N'hocsinh69@example.com', N'hspass69', 4, N'HocSinh', N'0911222399', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (83, N'hocsinh70@example.com', N'hspass70', 4, N'HocSinh', N'0911222400', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (84, N'hocsinh71@example.com', N'hspass71', 4, N'HocSinh', N'0911222401', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (85, N'hocsinh72@example.com', N'hspass72', 4, N'HocSinh', N'0911222402', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (86, N'hocsinh73@example.com', N'hspass73', 4, N'HocSinh', N'0911222403', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (87, N'hocsinh74@example.com', N'hspass74', 4, N'HocSinh', N'0911222404', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (88, N'hocsinh75@example.com', N'hspass75', 4, N'HocSinh', N'0911222405', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (89, N'hocsinh76@example.com', N'hspass76', 4, N'HocSinh', N'0911222406', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (90, N'hocsinh77@example.com', N'hspass77', 4, N'HocSinh', N'0911222407', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (91, N'hocsinh78@example.com', N'hspass78', 4, N'HocSinh', N'0911222408', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (92, N'hocsinh79@example.com', N'hspass79', 4, N'HocSinh', N'0911222409', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (93, N'hocsinh80@example.com', N'hspass80', 4, N'HocSinh', N'0911222410', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (94, N'hocsinh81@example.com', N'hspass81', 4, N'HocSinh', N'0911222411', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (95, N'hocsinh82@example.com', N'hspass82', 4, N'HocSinh', N'0911222412', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (96, N'hocsinh83@example.com', N'hspass83', 4, N'HocSinh', N'0911222413', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (97, N'hocsinh84@example.com', N'hspass84', 4, N'HocSinh', N'0911222414', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (98, N'hocsinh85@example.com', N'hspass85', 4, N'HocSinh', N'0911222415', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (99, N'hocsinh86@example.com', N'hspass86', 4, N'HocSinh', N'0911222416', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
GO
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (100, N'hocsinh87@example.com', N'hspass87', 4, N'HocSinh', N'0911222417', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (101, N'hocsinh88@example.com', N'hspass88', 4, N'HocSinh', N'0911222418', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (102, N'hocsinh89@example.com', N'hspass89', 4, N'HocSinh', N'0911222419', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (103, N'hocsinh90@example.com', N'hspass90', 4, N'HocSinh', N'0911222420', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (104, N'hocsinh91@example.com', N'hspass91', 4, N'HocSinh', N'0911222421', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (105, N'hocsinh92@example.com', N'hspass92', 4, N'HocSinh', N'0911222422', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (106, N'hocsinh93@example.com', N'hspass93', 4, N'HocSinh', N'0911222423', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (107, N'hocsinh94@example.com', N'hspass94', 4, N'HocSinh', N'0911222424', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (108, N'hocsinh95@example.com', N'hspass95', 4, N'HocSinh', N'0911222425', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (109, N'hocsinh96@example.com', N'hspass96', 4, N'HocSinh', N'0911222426', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (110, N'hocsinh97@example.com', N'hspass97', 4, N'HocSinh', N'0911222427', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (111, N'hocsinh98@example.com', N'hspass98', 4, N'HocSinh', N'0911222428', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (112, N'hocsinh99@example.com', N'hspass99', 4, N'HocSinh', N'0911222429', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (113, N'hocsinh100@example.com', N'hspass100', 4, N'HocSinh', N'0911222430', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (114, N'phuhuynh1@example.com', N'phupass', 5, N'PhuHuynh', N'0900111231', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (115, N'phuhuynh2@example.com', N'phupass2', 5, N'PhuHuynh', N'0900111232', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (116, N'phuhuynh3@example.com', N'phupass3', 5, N'PhuHuynh', N'0900111233', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (117, N'phuhuynh4@example.com', N'phupass4', 5, N'PhuHuynh', N'0900111234', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (118, N'phuhuynh5@example.com', N'phupass5', 5, N'PhuHuynh', N'0900111235', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (119, N'phuhuynh6@example.com', N'phupass6', 5, N'PhuHuynh', N'0900111236', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (120, N'phuhuynh7@example.com', N'phupass7', 5, N'PhuHuynh', N'0900111237', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (121, N'phuhuynh8@example.com', N'phupass8', 5, N'PhuHuynh', N'0900111238', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (122, N'phuhuynh9@example.com', N'phupass9', 5, N'PhuHuynh', N'0900111239', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (123, N'phuhuynh10@example.com', N'phupass10', 5, N'PhuHuynh', N'0900111240', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (124, N'phuhuynh11@example.com', N'phupass11', 5, N'PhuHuynh', N'0900111241', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (125, N'phuhuynh12@example.com', N'phupass12', 5, N'PhuHuynh', N'0900111242', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (126, N'phuhuynh13@example.com', N'phupass13', 5, N'PhuHuynh', N'0900111243', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (127, N'phuhuynh14@example.com', N'phupass14', 5, N'PhuHuynh', N'0900111244', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (128, N'phuhuynh15@example.com', N'phupass15', 5, N'PhuHuynh', N'0900111245', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (129, N'phuhuynh16@example.com', N'phupass16', 5, N'PhuHuynh', N'0900111246', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (130, N'phuhuynh17@example.com', N'phupass17', 5, N'PhuHuynh', N'0900111247', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (131, N'phuhuynh18@example.com', N'phupass18', 5, N'PhuHuynh', N'0900111248', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (132, N'phuhuynh19@example.com', N'phupass19', 5, N'PhuHuynh', N'0900111249', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (133, N'phuhuynh20@example.com', N'phupass20', 5, N'PhuHuynh', N'0900111250', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (134, N'phuhuynh21@example.com', N'phupass21', 5, N'PhuHuynh', N'0900111251', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (135, N'phuhuynh22@example.com', N'phupass22', 5, N'PhuHuynh', N'0900111252', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (136, N'phuhuynh23@example.com', N'phupass23', 5, N'PhuHuynh', N'0900111253', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (137, N'phuhuynh24@example.com', N'phupass24', 5, N'PhuHuynh', N'0900111254', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (138, N'phuhuynh25@example.com', N'phupass25', 5, N'PhuHuynh', N'0900111255', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (139, N'phuhuynh26@example.com', N'phupass26', 5, N'PhuHuynh', N'0900111256', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (140, N'phuhuynh27@example.com', N'phupass27', 5, N'PhuHuynh', N'0900111257', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (141, N'phuhuynh28@example.com', N'phupass28', 5, N'PhuHuynh', N'0900111258', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (142, N'phuhuynh29@example.com', N'phupass29', 5, N'PhuHuynh', N'0900111259', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (143, N'phuhuynh30@example.com', N'phupass30', 5, N'PhuHuynh', N'0900111260', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (144, N'phuhuynh31@example.com', N'phupass31', 5, N'PhuHuynh', N'0900111261', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (145, N'phuhuynh32@example.com', N'phupass32', 5, N'PhuHuynh', N'0900111262', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (146, N'phuhuynh33@example.com', N'phupass33', 5, N'PhuHuynh', N'0900111263', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (147, N'phuhuynh34@example.com', N'phupass34', 5, N'PhuHuynh', N'0900111264', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (148, N'phuhuynh35@example.com', N'phupass35', 5, N'PhuHuynh', N'0900111265', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (149, N'phuhuynh36@example.com', N'phupass36', 5, N'PhuHuynh', N'0900111266', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (150, N'phuhuynh37@example.com', N'phupass37', 5, N'PhuHuynh', N'0900111267', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (151, N'phuhuynh38@example.com', N'phupass38', 5, N'PhuHuynh', N'0900111268', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (152, N'phuhuynh39@example.com', N'phupass39', 5, N'PhuHuynh', N'0900111269', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (153, N'phuhuynh40@example.com', N'phupass40', 5, N'PhuHuynh', N'0900111270', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (154, N'phuhuynh41@example.com', N'phupass41', 5, N'PhuHuynh', N'0900111271', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (155, N'phuhuynh42@example.com', N'phupass42', 5, N'PhuHuynh', N'0900111272', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (156, N'phuhuynh43@example.com', N'phupass43', 5, N'PhuHuynh', N'0900111273', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (157, N'phuhuynh44@example.com', N'phupass44', 5, N'PhuHuynh', N'0900111274', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (158, N'phuhuynh45@example.com', N'phupass45', 5, N'PhuHuynh', N'0900111275', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (159, N'phuhuynh46@example.com', N'phupass46', 5, N'PhuHuynh', N'0900111276', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (160, N'phuhuynh47@example.com', N'phupass47', 5, N'PhuHuynh', N'0900111277', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (161, N'phuhuynh48@example.com', N'phupass48', 5, N'PhuHuynh', N'0900111278', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (162, N'phuhuynh49@example.com', N'phupass49', 5, N'PhuHuynh', N'0900111279', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (163, N'phuhuynh50@example.com', N'phupass50', 5, N'PhuHuynh', N'0900111280', N'Active', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (164, N'trungdam1305@gmail.com', N'asd', 4, N'HocSinh', N'0972178865', N'Active', CAST(N'2025-07-15T17:08:26.147' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (165, N'trungdam1302@gmail.com', N'trung123', 4, N'HocSinh', N'0972178865', N'Inactive', CAST(N'2025-07-15T17:09:26.890' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (166, N'trungdam@gmail.com', N'trung123', 4, N'HocSinh', N'0972178865', N'Inactive', CAST(N'2025-07-15T17:10:36.393' AS DateTime))
SET IDENTITY_INSERT [dbo].[TaiKhoan] OFF
GO
SET IDENTITY_INSERT [dbo].[TaoBaiTap] ON 

INSERT [dbo].[TaoBaiTap] ([ID_BaiTap], [ID_GiaoVien], [TenBaiTap], [MoTa], [NgayTao], [ID_LopHoc], [Deadline], [FileName]) VALUES (1, 1, N'Bài tập Đại số tuần 1', N'Giải phương trình bậc hai', CAST(N'2025-06-01' AS Date), 1, CAST(N'2025-06-15' AS Date), NULL)
INSERT [dbo].[TaoBaiTap] ([ID_BaiTap], [ID_GiaoVien], [TenBaiTap], [MoTa], [NgayTao], [ID_LopHoc], [Deadline], [FileName]) VALUES (2, 2, N'Bài tập Văn tuần 1', N'Phân tích bài thơ', CAST(N'2025-06-01' AS Date), 2, CAST(N'2025-06-15' AS Date), NULL)
INSERT [dbo].[TaoBaiTap] ([ID_BaiTap], [ID_GiaoVien], [TenBaiTap], [MoTa], [NgayTao], [ID_LopHoc], [Deadline], [FileName]) VALUES (3, 6, N'Bài tập Sinh học tuần 1', N'Phân tích hệ sinh thái', CAST(N'2025-06-01' AS Date), 3, CAST(N'2025-06-15' AS Date), NULL)
INSERT [dbo].[TaoBaiTap] ([ID_BaiTap], [ID_GiaoVien], [TenBaiTap], [MoTa], [NgayTao], [ID_LopHoc], [Deadline], [FileName]) VALUES (4, 7, N'Bài tập Lịch sử tuần 1', N'Tóm tắt lịch sử Việt Nam', CAST(N'2025-06-01' AS Date), 4, CAST(N'2025-06-15' AS Date), NULL)
INSERT [dbo].[TaoBaiTap] ([ID_BaiTap], [ID_GiaoVien], [TenBaiTap], [MoTa], [NgayTao], [ID_LopHoc], [Deadline], [FileName]) VALUES (11, 1, N'Bài Tập Toán Nâng Cao', N'Làm ngay', CAST(N'2025-07-17' AS Date), 1, CAST(N'2025-07-31' AS Date), N'Adding New Course IT.xlsx')
INSERT [dbo].[TaoBaiTap] ([ID_BaiTap], [ID_GiaoVien], [TenBaiTap], [MoTa], [NgayTao], [ID_LopHoc], [Deadline], [FileName]) VALUES (12, 1, N'Bài Tập Toán', N'kkkk', CAST(N'2025-07-18' AS Date), 1, CAST(N'2025-08-01' AS Date), NULL)
INSERT [dbo].[TaoBaiTap] ([ID_BaiTap], [ID_GiaoVien], [TenBaiTap], [MoTa], [NgayTao], [ID_LopHoc], [Deadline], [FileName]) VALUES (13, 1, N'aaaa', N'aaaa', CAST(N'2025-07-19' AS Date), 1, CAST(N'2025-07-15' AS Date), N'Page_3.png')
INSERT [dbo].[TaoBaiTap] ([ID_BaiTap], [ID_GiaoVien], [TenBaiTap], [MoTa], [NgayTao], [ID_LopHoc], [Deadline], [FileName]) VALUES (14, 1, N'Bài Tập Toán', N'', CAST(N'2025-07-20' AS Date), 1, CAST(N'2025-08-01' AS Date), N'Page_3.png')
SET IDENTITY_INSERT [dbo].[TaoBaiTap] OFF
GO
SET IDENTITY_INSERT [dbo].[ThongBao] ON 

INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (1, 16, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (2, 18, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (3, 20, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (4, 21, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (5, 23, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (6, 24, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (7, 26, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (8, 28, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (9, 30, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (10, 32, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (11, 34, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (12, 35, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (13, 37, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (14, 38, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (15, 40, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (16, 42, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (17, 44, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (18, 45, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (19, 47, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (20, 48, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (21, 50, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (22, 52, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (23, 54, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (24, 55, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (25, 57, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (26, 58, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (27, 60, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (28, 62, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (29, 64, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (30, 65, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (31, 67, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (32, 68, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (33, 70, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (34, 72, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (35, 74, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (36, 75, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (37, 77, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (38, 78, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (39, 80, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (40, 82, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (41, 84, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (42, 85, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (43, 87, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (44, 88, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (45, 90, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (46, 92, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (47, 94, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (48, 95, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (49, 97, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (50, 98, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (51, 100, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (52, 102, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (53, 104, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (54, 105, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (55, 107, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (56, 108, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (57, 110, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (58, 112, N'dme chung may
', NULL, CAST(N'2025-07-14T22:13:08.010' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (59, 4, N'day ngu vcl', NULL, CAST(N'2025-07-14T22:13:49.793' AS DateTime), N'ALLTEACHER')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (60, 5, N'day ngu vcl', NULL, CAST(N'2025-07-14T22:13:49.793' AS DateTime), N'ALLTEACHER')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (61, 8, N'day ngu vcl', NULL, CAST(N'2025-07-14T22:13:49.793' AS DateTime), N'ALLTEACHER')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (62, 9, N'day ngu vcl', NULL, CAST(N'2025-07-14T22:13:49.793' AS DateTime), N'ALLTEACHER')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (63, 11, N'day ngu vcl', NULL, CAST(N'2025-07-14T22:13:49.793' AS DateTime), N'ALLTEACHER')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (64, 12, N'day ngu vcl', NULL, CAST(N'2025-07-14T22:13:49.793' AS DateTime), N'ALLTEACHER')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (65, 16, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (66, 18, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (67, 20, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (68, 21, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (69, 23, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (70, 24, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (71, 26, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (72, 28, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (73, 30, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (74, 32, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (75, 34, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (76, 35, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (77, 37, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (78, 38, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (79, 40, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (80, 42, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (81, 44, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (82, 45, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (83, 47, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (84, 48, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (85, 50, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (86, 52, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (87, 54, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (88, 55, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (89, 57, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (90, 58, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (91, 60, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (92, 62, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (93, 64, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (94, 65, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (95, 67, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (96, 68, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (97, 70, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (98, 72, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (99, 74, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
GO
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (100, 75, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (101, 77, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (102, 78, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (103, 80, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (104, 82, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (105, 84, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (106, 85, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (107, 87, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (108, 88, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (109, 90, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (110, 92, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (111, 94, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (112, 95, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (113, 97, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (114, 98, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (115, 100, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (116, 102, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (117, 104, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (118, 105, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (119, 107, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (120, 108, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (121, 110, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (122, 112, N'day ngu vai lon', NULL, CAST(N'2025-07-14T22:14:03.927' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (123, 4, N'hoc ngu', NULL, CAST(N'2025-07-14T22:14:03.987' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (124, 5, N'hoc ngu', NULL, CAST(N'2025-07-14T22:14:03.987' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (125, 8, N'hoc ngu', NULL, CAST(N'2025-07-14T22:14:03.987' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (126, 9, N'hoc ngu', NULL, CAST(N'2025-07-14T22:14:03.987' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (127, 11, N'hoc ngu', NULL, CAST(N'2025-07-14T22:14:03.987' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (128, 12, N'hoc ngu', NULL, CAST(N'2025-07-14T22:14:03.987' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (129, 14, N'hajka', NULL, CAST(N'2025-07-14T22:14:18.450' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (130, 18, N'hajka', NULL, CAST(N'2025-07-14T22:14:18.450' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (131, 21, N'hajka', NULL, CAST(N'2025-07-14T22:14:18.450' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (132, 25, N'hajka', NULL, CAST(N'2025-07-14T22:14:18.450' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (133, 28, N'hajka', NULL, CAST(N'2025-07-14T22:14:18.450' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (134, 32, N'hajka', NULL, CAST(N'2025-07-14T22:14:18.450' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (135, 36, N'hajka', NULL, CAST(N'2025-07-14T22:14:18.450' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (136, 40, N'hajka', NULL, CAST(N'2025-07-14T22:14:18.450' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (137, 44, N'hajka', NULL, CAST(N'2025-07-14T22:14:18.450' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (138, 48, N'hajka', NULL, CAST(N'2025-07-14T22:14:18.450' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (139, 52, N'hajka', NULL, CAST(N'2025-07-14T22:14:18.450' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (140, 56, N'hajka', NULL, CAST(N'2025-07-14T22:14:18.450' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (141, 60, N'hajka', NULL, CAST(N'2025-07-14T22:14:18.450' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (142, 64, N'hajka', NULL, CAST(N'2025-07-14T22:14:18.450' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (143, 68, N'hajka', NULL, CAST(N'2025-07-14T22:14:18.450' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (144, 72, N'hajka', NULL, CAST(N'2025-07-14T22:14:18.450' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (145, 76, N'hajka', NULL, CAST(N'2025-07-14T22:14:18.450' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (146, 80, N'hajka', NULL, CAST(N'2025-07-14T22:14:18.450' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (147, 84, N'hajka', NULL, CAST(N'2025-07-14T22:14:18.450' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (148, 88, N'hajka', NULL, CAST(N'2025-07-14T22:14:18.450' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (149, 92, N'hajka', NULL, CAST(N'2025-07-14T22:14:18.450' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (150, 96, N'hajka', NULL, CAST(N'2025-07-14T22:14:18.450' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (151, 100, N'hajka', NULL, CAST(N'2025-07-14T22:14:18.450' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (152, 104, N'hajka', NULL, CAST(N'2025-07-14T22:14:18.450' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (153, 108, N'hajka', NULL, CAST(N'2025-07-14T22:14:18.450' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (154, 112, N'hajka', NULL, CAST(N'2025-07-14T22:14:18.450' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (155, 37, N'hajka', NULL, CAST(N'2025-07-14T22:14:18.450' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (156, 93, N'hajka', NULL, CAST(N'2025-07-14T22:14:18.450' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (157, 4, N'huhe', NULL, CAST(N'2025-07-14T22:14:18.480' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (158, 16, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (159, 18, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (160, 20, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (161, 21, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (162, 23, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (163, 24, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (164, 26, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (165, 28, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (166, 30, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (167, 32, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (168, 34, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (169, 35, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (170, 37, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (171, 38, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (172, 40, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (173, 42, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (174, 44, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (175, 45, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (176, 47, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (177, 48, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (178, 50, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (179, 52, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (180, 54, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (181, 55, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (182, 57, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (183, 58, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (184, 60, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (185, 62, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (186, 64, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (187, 65, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (188, 67, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (189, 68, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (190, 70, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (191, 72, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (192, 74, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (193, 75, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (194, 77, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (195, 78, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (196, 80, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (197, 82, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (198, 84, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (199, 85, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
GO
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (200, 87, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (201, 88, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (202, 90, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (203, 92, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (204, 94, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (205, 95, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (206, 97, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (207, 98, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (208, 100, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (209, 102, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (210, 104, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (211, 105, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (212, 107, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (213, 108, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (214, 110, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (215, 112, N'a', NULL, CAST(N'2025-07-15T08:14:43.593' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (216, 16, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (217, 18, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (218, 20, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (219, 21, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (220, 23, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (221, 24, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (222, 26, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (223, 28, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (224, 30, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (225, 32, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (226, 34, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (227, 35, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (228, 37, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (229, 38, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (230, 40, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (231, 42, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (232, 44, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (233, 45, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (234, 47, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (235, 48, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (236, 50, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (237, 52, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (238, 54, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (239, 55, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (240, 57, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (241, 58, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (242, 60, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (243, 62, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (244, 64, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (245, 65, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (246, 67, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (247, 68, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (248, 70, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (249, 72, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (250, 74, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (251, 75, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (252, 77, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (253, 78, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (254, 80, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (255, 82, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (256, 84, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (257, 85, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (258, 87, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (259, 88, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (260, 90, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (261, 92, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (262, 94, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (263, 95, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (264, 97, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (265, 98, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (266, 100, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (267, 102, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (268, 104, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (269, 105, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (270, 107, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (271, 108, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (272, 110, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (273, 112, N'a', NULL, CAST(N'2025-07-18T02:10:00.497' AS DateTime), N'ALLSTUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (274, 4, N'aa', NULL, CAST(N'2025-07-18T02:10:03.380' AS DateTime), N'ALLTEACHER')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (275, 5, N'aa', NULL, CAST(N'2025-07-18T02:10:03.380' AS DateTime), N'ALLTEACHER')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (276, 8, N'aa', NULL, CAST(N'2025-07-18T02:10:03.380' AS DateTime), N'ALLTEACHER')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (277, 9, N'aa', NULL, CAST(N'2025-07-18T02:10:03.380' AS DateTime), N'ALLTEACHER')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (278, 11, N'aa', NULL, CAST(N'2025-07-18T02:10:03.380' AS DateTime), N'ALLTEACHER')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (279, 12, N'aa', NULL, CAST(N'2025-07-18T02:10:03.380' AS DateTime), N'ALLTEACHER')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (280, 16, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (281, 18, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (282, 20, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (283, 21, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (284, 23, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (285, 24, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (286, 26, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (287, 28, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (288, 30, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (289, 32, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (290, 34, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (291, 35, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (292, 37, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (293, 38, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (294, 40, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (295, 42, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (296, 44, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (297, 45, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (298, 47, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (299, 48, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
GO
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (300, 50, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (301, 52, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (302, 54, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (303, 55, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (304, 57, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (305, 58, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (306, 60, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (307, 62, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (308, 64, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (309, 65, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (310, 67, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (311, 68, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (312, 70, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (313, 72, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (314, 74, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (315, 75, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (316, 77, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (317, 78, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (318, 80, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (319, 82, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (320, 84, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (321, 85, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (322, 87, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (323, 88, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (324, 90, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (325, 92, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (326, 94, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (327, 95, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (328, 97, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (329, 98, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (330, 100, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (331, 102, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (332, 104, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (333, 105, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (334, 107, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (335, 108, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (336, 110, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (337, 112, N'á', NULL, CAST(N'2025-07-18T02:10:06.333' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (338, 4, N'âsa', NULL, CAST(N'2025-07-18T02:10:06.460' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (339, 5, N'âsa', NULL, CAST(N'2025-07-18T02:10:06.460' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (340, 8, N'âsa', NULL, CAST(N'2025-07-18T02:10:06.460' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (341, 9, N'âsa', NULL, CAST(N'2025-07-18T02:10:06.460' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (342, 11, N'âsa', NULL, CAST(N'2025-07-18T02:10:06.460' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (343, 12, N'âsa', NULL, CAST(N'2025-07-18T02:10:06.460' AS DateTime), N'ALLCLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (344, 14, N'aaaa', NULL, CAST(N'2025-07-18T02:10:19.283' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (345, 18, N'aaaa', NULL, CAST(N'2025-07-18T02:10:19.283' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (346, 21, N'aaaa', NULL, CAST(N'2025-07-18T02:10:19.283' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (347, 25, N'aaaa', NULL, CAST(N'2025-07-18T02:10:19.283' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (348, 28, N'aaaa', NULL, CAST(N'2025-07-18T02:10:19.283' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (349, 32, N'aaaa', NULL, CAST(N'2025-07-18T02:10:19.283' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (350, 36, N'aaaa', NULL, CAST(N'2025-07-18T02:10:19.283' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (351, 40, N'aaaa', NULL, CAST(N'2025-07-18T02:10:19.283' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (352, 44, N'aaaa', NULL, CAST(N'2025-07-18T02:10:19.283' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (353, 48, N'aaaa', NULL, CAST(N'2025-07-18T02:10:19.283' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (354, 52, N'aaaa', NULL, CAST(N'2025-07-18T02:10:19.283' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (355, 56, N'aaaa', NULL, CAST(N'2025-07-18T02:10:19.283' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (356, 60, N'aaaa', NULL, CAST(N'2025-07-18T02:10:19.283' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (357, 64, N'aaaa', NULL, CAST(N'2025-07-18T02:10:19.283' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (358, 68, N'aaaa', NULL, CAST(N'2025-07-18T02:10:19.283' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (359, 72, N'aaaa', NULL, CAST(N'2025-07-18T02:10:19.283' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (360, 76, N'aaaa', NULL, CAST(N'2025-07-18T02:10:19.283' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (361, 80, N'aaaa', NULL, CAST(N'2025-07-18T02:10:19.283' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (362, 84, N'aaaa', NULL, CAST(N'2025-07-18T02:10:19.283' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (363, 88, N'aaaa', NULL, CAST(N'2025-07-18T02:10:19.283' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (364, 92, N'aaaa', NULL, CAST(N'2025-07-18T02:10:19.283' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (365, 96, N'aaaa', NULL, CAST(N'2025-07-18T02:10:19.283' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (366, 100, N'aaaa', NULL, CAST(N'2025-07-18T02:10:19.283' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (367, 104, N'aaaa', NULL, CAST(N'2025-07-18T02:10:19.283' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (368, 108, N'aaaa', NULL, CAST(N'2025-07-18T02:10:19.283' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (369, 112, N'aaaa', NULL, CAST(N'2025-07-18T02:10:19.283' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (370, 37, N'aaaa', NULL, CAST(N'2025-07-18T02:10:19.283' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (371, 93, N'aaaa', NULL, CAST(N'2025-07-18T02:10:19.283' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (372, 4, N'aa', NULL, CAST(N'2025-07-18T02:10:19.333' AS DateTime), N'CLASS')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (373, NULL, N'[TƯ VẤN] Họ tên: Trung Dam | Email: trungdam1305@gmail.com | SĐT: 0972178865 | Nội dung: Toi can dang ki tu van', NULL, CAST(N'2025-07-18T11:15:51.467' AS DateTime), NULL)
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (374, 14, N'Yêu cầu đăng ký vào lớp TOAN06A', NULL, CAST(N'2025-07-19T23:19:06.700' AS DateTime), NULL)
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (375, NULL, N'[TƯ VẤN] Họ tên: Trung Dam | Email: khanhvhhe190685@gmail.com | SĐT: 0972178865 | Nội dung: a', NULL, CAST(N'2025-07-19T23:19:46.970' AS DateTime), NULL)
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (376, NULL, N'[TƯ VẤN] Họ tên: Trung Dam | Email: khanhvhhe190685@gmail.com | SĐT: 0972178865 | Nội dung: aaaaa', NULL, CAST(N'2025-07-19T23:20:03.583' AS DateTime), NULL)
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (377, NULL, N'[TƯ VẤN] Họ tên: Trung Dam | Email: trungdam1305@gmail.com | SĐT: 0972178865 | Nội dung: aaaa', NULL, CAST(N'2025-07-19T23:20:55.473' AS DateTime), NULL)
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (378, 14, N'Chào em Nguyễn Văn A,

Đây là thông báo học phí tháng 6/2025 của em tại lớp Toán Nâng Cao. Số tiền: 2000000 VNĐ.

Chúc em học tập tốt và đạt kết quả cao nhé!

– ELCENTRE –
        ', NULL, CAST(N'2025-07-21T22:27:47.340' AS DateTime), N'STUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (379, 114, N'Kính gửi quý phụ huynh,

Trung tâm Anh ngữ ELCENTRE xin thông báo học phí của học sinh Nguyễn Văn A – lớp Toán Nâng Cao cho tháng 6/2025 như sau:

Số tiền cần đóng: 2000000 VNĐ

Quý phụ huynh vui lòng hoàn tất học phí đúng hạn để đảm bảo quá trình học tập của học sinh diễn ra thuận lợi.

Trân trọng cảm ơn quý phụ huynh đã đồng hành cùng ELCENTRE!
        ', NULL, CAST(N'2025-07-21T22:27:47.380' AS DateTime), N'PARENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (380, 14, N'Chào em Nguyễn Văn A,

Đây là thông báo học phí tháng 6/2025 của em tại lớp Toán Nâng Cao. Số tiền: 2.000.000 VNĐ.

Chúc em học tập tốt và đạt kết quả cao nhé!

– ELCENTRE –
', NULL, CAST(N'2025-07-21T22:29:07.893' AS DateTime), N'STUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (381, 114, N'Kính gửi quý phụ huynh,

Trung tâm Anh ngữ ELCENTRE xin thông báo học phí của học sinh Nguyễn Văn A – lớp Toán Nâng Cao cho tháng 6/2025 như sau:

Số tiền cần đóng: 2.000.000 VNĐ

Quý phụ huynh vui lòng hoàn tất học phí đúng hạn để đảm bảo quá trình học tập của học sinh diễn ra thuận lợi.

Trân trọng cảm ơn quý phụ huynh đã đồng hành cùng ELCENTRE!
', NULL, CAST(N'2025-07-21T22:29:07.953' AS DateTime), N'PARENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (382, 18, N'Chào em Hoàng Văn E,

Đây là thông báo học phí tháng 6/2025 của em tại lớp Toán Nâng Cao. Số tiền: 2.000.000 VNĐ.

Chúc em học tập tốt và đạt kết quả cao nhé!

– ELCENTRE –
', NULL, CAST(N'2025-07-21T22:29:08.147' AS DateTime), N'STUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (383, 116, N'Kính gửi quý phụ huynh,

Trung tâm Anh ngữ ELCENTRE xin thông báo học phí của học sinh Hoàng Văn E – lớp Toán Nâng Cao cho tháng 6/2025 như sau:

Số tiền cần đóng: 2.000.000 VNĐ

Quý phụ huynh vui lòng hoàn tất học phí đúng hạn để đảm bảo quá trình học tập của học sinh diễn ra thuận lợi.

Trân trọng cảm ơn quý phụ huynh đã đồng hành cùng ELCENTRE!
', NULL, CAST(N'2025-07-21T22:29:08.220' AS DateTime), N'PARENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (384, 21, N'Chào em Lê Thị H,

Đây là thông báo học phí tháng 6/2025 của em tại lớp Toán Nâng Cao. Số tiền: 2.000.000 VNĐ.

Chúc em học tập tốt và đạt kết quả cao nhé!

– ELCENTRE –
', NULL, CAST(N'2025-07-21T22:29:08.260' AS DateTime), N'STUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (385, 117, N'Kính gửi quý phụ huynh,

Trung tâm Anh ngữ ELCENTRE xin thông báo học phí của học sinh Lê Thị H – lớp Toán Nâng Cao cho tháng 6/2025 như sau:

Số tiền cần đóng: 2.000.000 VNĐ

Quý phụ huynh vui lòng hoàn tất học phí đúng hạn để đảm bảo quá trình học tập của học sinh diễn ra thuận lợi.

Trân trọng cảm ơn quý phụ huynh đã đồng hành cùng ELCENTRE!
', NULL, CAST(N'2025-07-21T22:29:08.307' AS DateTime), N'PARENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (386, 32, N'Chào em Hoàng Văn T,

Đây là thông báo học phí tháng 6/2025 của em tại lớp Toán Nâng Cao. Số tiền: 2.000.000 VNĐ.

Chúc em học tập tốt và đạt kết quả cao nhé!

– ELCENTRE –
', NULL, CAST(N'2025-07-21T22:29:08.353' AS DateTime), N'STUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (387, 123, N'Kính gửi quý phụ huynh,

Trung tâm Anh ngữ ELCENTRE xin thông báo học phí của học sinh Hoàng Văn T – lớp Toán Nâng Cao cho tháng 6/2025 như sau:

Số tiền cần đóng: 2.000.000 VNĐ

Quý phụ huynh vui lòng hoàn tất học phí đúng hạn để đảm bảo quá trình học tập của học sinh diễn ra thuận lợi.

Trân trọng cảm ơn quý phụ huynh đã đồng hành cùng ELCENTRE!
', NULL, CAST(N'2025-07-21T22:29:08.400' AS DateTime), N'PARENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (388, 36, N'Chào em Phạm Văn X,

Đây là thông báo học phí tháng 6/2025 của em tại lớp Toán Nâng Cao. Số tiền: 2.000.000 VNĐ.

Chúc em học tập tốt và đạt kết quả cao nhé!

– ELCENTRE –
', NULL, CAST(N'2025-07-21T22:29:08.447' AS DateTime), N'STUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (389, 125, N'Kính gửi quý phụ huynh,

Trung tâm Anh ngữ ELCENTRE xin thông báo học phí của học sinh Phạm Văn X – lớp Toán Nâng Cao cho tháng 6/2025 như sau:

Số tiền cần đóng: 2.000.000 VNĐ

Quý phụ huynh vui lòng hoàn tất học phí đúng hạn để đảm bảo quá trình học tập của học sinh diễn ra thuận lợi.

Trân trọng cảm ơn quý phụ huynh đã đồng hành cùng ELCENTRE!
', NULL, CAST(N'2025-07-21T22:29:08.497' AS DateTime), N'PARENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (390, 40, N'Chào em Lê Văn AB,

Đây là thông báo học phí tháng 6/2025 của em tại lớp Toán Nâng Cao. Số tiền: 2.000.000 VNĐ.

Chúc em học tập tốt và đạt kết quả cao nhé!

– ELCENTRE –
', NULL, CAST(N'2025-07-21T22:29:08.523' AS DateTime), N'STUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (391, 127, N'Kính gửi quý phụ huynh,

Trung tâm Anh ngữ ELCENTRE xin thông báo học phí của học sinh Lê Văn AB – lớp Toán Nâng Cao cho tháng 6/2025 như sau:

Số tiền cần đóng: 2.000.000 VNĐ

Quý phụ huynh vui lòng hoàn tất học phí đúng hạn để đảm bảo quá trình học tập của học sinh diễn ra thuận lợi.

Trân trọng cảm ơn quý phụ huynh đã đồng hành cùng ELCENTRE!
', NULL, CAST(N'2025-07-21T22:29:08.550' AS DateTime), N'PARENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (392, 48, N'Chào em Nguyễn Văn AJ,

Đây là thông báo học phí tháng 6/2025 của em tại lớp Toán Nâng Cao. Số tiền: 2.000.000 VNĐ.

Chúc em học tập tốt và đạt kết quả cao nhé!

– ELCENTRE –
', NULL, CAST(N'2025-07-21T22:29:08.580' AS DateTime), N'STUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (393, 131, N'Kính gửi quý phụ huynh,

Trung tâm Anh ngữ ELCENTRE xin thông báo học phí của học sinh Nguyễn Văn AJ – lớp Toán Nâng Cao cho tháng 6/2025 như sau:

Số tiền cần đóng: 2.000.000 VNĐ

Quý phụ huynh vui lòng hoàn tất học phí đúng hạn để đảm bảo quá trình học tập của học sinh diễn ra thuận lợi.

Trân trọng cảm ơn quý phụ huynh đã đồng hành cùng ELCENTRE!
', NULL, CAST(N'2025-07-21T22:29:08.610' AS DateTime), N'PARENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (394, 52, N'Chào em Hoàng Văn AN,

Đây là thông báo học phí tháng 6/2025 của em tại lớp Toán Nâng Cao. Số tiền: 2.000.000 VNĐ.

Chúc em học tập tốt và đạt kết quả cao nhé!

– ELCENTRE –
', NULL, CAST(N'2025-07-21T22:29:08.633' AS DateTime), N'STUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (395, 133, N'Kính gửi quý phụ huynh,

Trung tâm Anh ngữ ELCENTRE xin thông báo học phí của học sinh Hoàng Văn AN – lớp Toán Nâng Cao cho tháng 6/2025 như sau:

Số tiền cần đóng: 2.000.000 VNĐ

Quý phụ huynh vui lòng hoàn tất học phí đúng hạn để đảm bảo quá trình học tập của học sinh diễn ra thuận lợi.

Trân trọng cảm ơn quý phụ huynh đã đồng hành cùng ELCENTRE!
', NULL, CAST(N'2025-07-21T22:29:08.660' AS DateTime), N'PARENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (396, 60, N'Chào em Lê Văn AV,

Đây là thông báo học phí tháng 6/2025 của em tại lớp Toán Nâng Cao. Số tiền: 2.000.000 VNĐ.

Chúc em học tập tốt và đạt kết quả cao nhé!

– ELCENTRE –
', NULL, CAST(N'2025-07-21T22:29:08.687' AS DateTime), N'STUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (397, 137, N'Kính gửi quý phụ huynh,

Trung tâm Anh ngữ ELCENTRE xin thông báo học phí của học sinh Lê Văn AV – lớp Toán Nâng Cao cho tháng 6/2025 như sau:

Số tiền cần đóng: 2.000.000 VNĐ

Quý phụ huynh vui lòng hoàn tất học phí đúng hạn để đảm bảo quá trình học tập của học sinh diễn ra thuận lợi.

Trân trọng cảm ơn quý phụ huynh đã đồng hành cùng ELCENTRE!
', NULL, CAST(N'2025-07-21T22:29:08.713' AS DateTime), N'PARENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (398, 64, N'Chào em Trần Văn AZ,

Đây là thông báo học phí tháng 6/2025 của em tại lớp Toán Nâng Cao. Số tiền: 2.000.000 VNĐ.

Chúc em học tập tốt và đạt kết quả cao nhé!

– ELCENTRE –
', NULL, CAST(N'2025-07-21T22:29:08.740' AS DateTime), N'STUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (399, 139, N'Kính gửi quý phụ huynh,

Trung tâm Anh ngữ ELCENTRE xin thông báo học phí của học sinh Trần Văn AZ – lớp Toán Nâng Cao cho tháng 6/2025 như sau:

Số tiền cần đóng: 2.000.000 VNĐ

Quý phụ huynh vui lòng hoàn tất học phí đúng hạn để đảm bảo quá trình học tập của học sinh diễn ra thuận lợi.

Trân trọng cảm ơn quý phụ huynh đã đồng hành cùng ELCENTRE!
', NULL, CAST(N'2025-07-21T22:29:08.763' AS DateTime), N'PARENT')
GO
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (400, 72, N'Chào em Hoàng Văn BH,

Đây là thông báo học phí tháng 6/2025 của em tại lớp Toán Nâng Cao. Số tiền: 2.000.000 VNĐ.

Chúc em học tập tốt và đạt kết quả cao nhé!

– ELCENTRE –
', NULL, CAST(N'2025-07-21T22:29:08.790' AS DateTime), N'STUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (401, 143, N'Kính gửi quý phụ huynh,

Trung tâm Anh ngữ ELCENTRE xin thông báo học phí của học sinh Hoàng Văn BH – lớp Toán Nâng Cao cho tháng 6/2025 như sau:

Số tiền cần đóng: 2.000.000 VNĐ

Quý phụ huynh vui lòng hoàn tất học phí đúng hạn để đảm bảo quá trình học tập của học sinh diễn ra thuận lợi.

Trân trọng cảm ơn quý phụ huynh đã đồng hành cùng ELCENTRE!
', NULL, CAST(N'2025-07-21T22:29:08.817' AS DateTime), N'PARENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (402, 76, N'Chào em Phạm Văn BL,

Đây là thông báo học phí tháng 6/2025 của em tại lớp Toán Nâng Cao. Số tiền: 2.000.000 VNĐ.

Chúc em học tập tốt và đạt kết quả cao nhé!

– ELCENTRE –
', NULL, CAST(N'2025-07-21T22:29:08.850' AS DateTime), N'STUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (403, 145, N'Kính gửi quý phụ huynh,

Trung tâm Anh ngữ ELCENTRE xin thông báo học phí của học sinh Phạm Văn BL – lớp Toán Nâng Cao cho tháng 6/2025 như sau:

Số tiền cần đóng: 2.000.000 VNĐ

Quý phụ huynh vui lòng hoàn tất học phí đúng hạn để đảm bảo quá trình học tập của học sinh diễn ra thuận lợi.

Trân trọng cảm ơn quý phụ huynh đã đồng hành cùng ELCENTRE!
', NULL, CAST(N'2025-07-21T22:29:08.873' AS DateTime), N'PARENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (404, 84, N'Chào em Trần Văn BT,

Đây là thông báo học phí tháng 6/2025 của em tại lớp Toán Nâng Cao. Số tiền: 2.000.000 VNĐ.

Chúc em học tập tốt và đạt kết quả cao nhé!

– ELCENTRE –
', NULL, CAST(N'2025-07-21T22:29:08.900' AS DateTime), N'STUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (405, 149, N'Kính gửi quý phụ huynh,

Trung tâm Anh ngữ ELCENTRE xin thông báo học phí của học sinh Trần Văn BT – lớp Toán Nâng Cao cho tháng 6/2025 như sau:

Số tiền cần đóng: 2.000.000 VNĐ

Quý phụ huynh vui lòng hoàn tất học phí đúng hạn để đảm bảo quá trình học tập của học sinh diễn ra thuận lợi.

Trân trọng cảm ơn quý phụ huynh đã đồng hành cùng ELCENTRE!
', NULL, CAST(N'2025-07-21T22:29:08.923' AS DateTime), N'PARENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (406, 100, N'Chào em Lê Văn CJ,

Đây là thông báo học phí tháng 6/2025 của em tại lớp Toán Nâng Cao. Số tiền: 2.000.000 VNĐ.

Chúc em học tập tốt và đạt kết quả cao nhé!

– ELCENTRE –
', NULL, CAST(N'2025-07-21T22:29:08.953' AS DateTime), N'STUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (407, 156, N'Kính gửi quý phụ huynh,

Trung tâm Anh ngữ ELCENTRE xin thông báo học phí của học sinh Lê Văn CJ – lớp Toán Nâng Cao cho tháng 6/2025 như sau:

Số tiền cần đóng: 2.000.000 VNĐ

Quý phụ huynh vui lòng hoàn tất học phí đúng hạn để đảm bảo quá trình học tập của học sinh diễn ra thuận lợi.

Trân trọng cảm ơn quý phụ huynh đã đồng hành cùng ELCENTRE!
', NULL, CAST(N'2025-07-21T22:29:08.983' AS DateTime), N'PARENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (408, 104, N'Chào em Trần Văn CN,

Đây là thông báo học phí tháng 6/2025 của em tại lớp Toán Nâng Cao. Số tiền: 2.000.000 VNĐ.

Chúc em học tập tốt và đạt kết quả cao nhé!

– ELCENTRE –
', NULL, CAST(N'2025-07-21T22:29:09.007' AS DateTime), N'STUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (409, 157, N'Kính gửi quý phụ huynh,

Trung tâm Anh ngữ ELCENTRE xin thông báo học phí của học sinh Trần Văn CN – lớp Toán Nâng Cao cho tháng 6/2025 như sau:

Số tiền cần đóng: 2.000.000 VNĐ

Quý phụ huynh vui lòng hoàn tất học phí đúng hạn để đảm bảo quá trình học tập của học sinh diễn ra thuận lợi.

Trân trọng cảm ơn quý phụ huynh đã đồng hành cùng ELCENTRE!
', NULL, CAST(N'2025-07-21T22:29:09.037' AS DateTime), N'PARENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (410, 108, N'Chào em Nguyễn Văn CR,

Đây là thông báo học phí tháng 6/2025 của em tại lớp Toán Nâng Cao. Số tiền: 2.000.000 VNĐ.

Chúc em học tập tốt và đạt kết quả cao nhé!

– ELCENTRE –
', NULL, CAST(N'2025-07-21T22:29:09.063' AS DateTime), N'STUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (411, 158, N'Kính gửi quý phụ huynh,

Trung tâm Anh ngữ ELCENTRE xin thông báo học phí của học sinh Nguyễn Văn CR – lớp Toán Nâng Cao cho tháng 6/2025 như sau:

Số tiền cần đóng: 2.000.000 VNĐ

Quý phụ huynh vui lòng hoàn tất học phí đúng hạn để đảm bảo quá trình học tập của học sinh diễn ra thuận lợi.

Trân trọng cảm ơn quý phụ huynh đã đồng hành cùng ELCENTRE!
', NULL, CAST(N'2025-07-21T22:29:09.087' AS DateTime), N'PARENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (412, 112, N'Chào em Hoàng Văn CV,

Đây là thông báo học phí tháng 6/2025 của em tại lớp Toán Nâng Cao. Số tiền: 2.000.000 VNĐ.

Chúc em học tập tốt và đạt kết quả cao nhé!

– ELCENTRE –
', NULL, CAST(N'2025-07-21T22:29:09.117' AS DateTime), N'STUDENT')
INSERT [dbo].[ThongBao] ([ID_ThongBao], [ID_TaiKhoan], [NoiDung], [ID_HocPhi], [ThoiGian], [Status]) VALUES (413, 160, N'Kính gửi quý phụ huynh,

Trung tâm Anh ngữ ELCENTRE xin thông báo học phí của học sinh Hoàng Văn CV – lớp Toán Nâng Cao cho tháng 6/2025 như sau:

Số tiền cần đóng: 2.000.000 VNĐ

Quý phụ huynh vui lòng hoàn tất học phí đúng hạn để đảm bảo quá trình học tập của học sinh diễn ra thuận lợi.

Trân trọng cảm ơn quý phụ huynh đã đồng hành cùng ELCENTRE!
', NULL, CAST(N'2025-07-21T22:29:09.143' AS DateTime), N'PARENT')
SET IDENTITY_INSERT [dbo].[ThongBao] OFF
GO
SET IDENTITY_INSERT [dbo].[TruongHoc] ON 

INSERT [dbo].[TruongHoc] ([ID_TruongHoc], [TenTruongHoc], [DiaChi]) VALUES (1, N'Trường THPT Hà Nội - Amsterdam', N'1. Hoàng Minh Giám, Trung Hòa, Cầu Giấy, Hà Nội')
INSERT [dbo].[TruongHoc] ([ID_TruongHoc], [TenTruongHoc], [DiaChi]) VALUES (2, N'Trường THPT Nguyễn Trãi - Ba Đình', N'50 P. Nam Cao, Giảng Võ, Ba Đình, Hà Nội')
INSERT [dbo].[TruongHoc] ([ID_TruongHoc], [TenTruongHoc], [DiaChi]) VALUES (3, N'Trường THPT Chuyên Chu Văn An', N'10 Đ. Thụy Khuê, Thuỵ Khuê, Tây Hồ, Hà Nội')
INSERT [dbo].[TruongHoc] ([ID_TruongHoc], [TenTruongHoc], [DiaChi]) VALUES (4, N'Trường THCS Lê Quý Đôn', N'123 Đường Láng, Đống Đa, Hà Nội')
INSERT [dbo].[TruongHoc] ([ID_TruongHoc], [TenTruongHoc], [DiaChi]) VALUES (5, N'Trường THPT Trần Phú', N'8 Hai Bà Trưng, Hoàn Kiếm, Hà Nội')
SET IDENTITY_INSERT [dbo].[TruongHoc] OFF
GO
SET IDENTITY_INSERT [dbo].[UserLogs] ON 

INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1, 1, N'Đăng nhập hệ thống', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (2, 4, N'Tải tài liệu Toán Đại số', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (3, 14, N'Xem lịch học', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (4, 114, N'Kiểm tra kết quả học tập', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (5, 5, N'Cập nhật bài tập', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (6, 9, N'Đăng nhập hệ thống', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (7, 15, N'Xem điểm học sinh', CAST(N'2025-06-01T10:00:00.000' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (8, 1, N'Vô hiệu hóa tài khoản giáo viên có ID tài khoản 5', CAST(N'2025-07-01T08:41:17.547' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (9, 1, N'Vô hiệu hóa tài khoản giáo viên có ID tài khoản 7', CAST(N'2025-07-01T08:41:18.800' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (10, 1, N'Thay đổi thông tin giáo viên có ID tài khoản 4', CAST(N'2025-07-01T08:42:48.980' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (11, 1, N'Thay đổi thông tin học sinh có ID tài khoản 16', CAST(N'2025-07-01T08:44:16.547' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (12, 1, N'Thay đổi thông tin học sinh có ID tài khoản 14', CAST(N'2025-07-02T08:01:18.140' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (13, 1, N'Thay đổi thông tin học sinh có ID tài khoản 14', CAST(N'2025-07-02T08:01:21.503' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (14, 1, N'Thay đổi thông tin học sinh có ID tài khoản 14', CAST(N'2025-07-02T08:09:12.457' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (15, 1, N'Thay đổi thông tin học sinh có ID tài khoản 14', CAST(N'2025-07-02T08:13:36.033' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (16, 1, N'Thay đổi thông tin học sinh có ID tài khoản 14', CAST(N'2025-07-02T08:14:42.283' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (17, 1, N'Thay đổi thông tin học sinh có ID tài khoản 14', CAST(N'2025-07-02T08:33:17.480' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (18, 1, N'Thay đổi thông tin học sinh có ID tài khoản 14', CAST(N'2025-07-02T08:47:26.753' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (19, 1, N'Thay đổi thông tin học sinh có ID tài khoản 14', CAST(N'2025-07-02T09:00:41.203' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (20, 1, N'Thay đổi thông tin học sinh có ID tài khoản 14', CAST(N'2025-07-02T09:03:36.923' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (21, 1, N'Thay đổi thông tin học sinh có ID tài khoản 14', CAST(N'2025-07-02T09:04:17.393' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (22, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-07T20:52:37.253' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (23, 1, N'Đăng nhập hệ thống', CAST(N'2025-07-07T21:01:41.043' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (24, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-07T21:24:50.170' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (25, 1, N'Đăng nhập hệ thống', CAST(N'2025-07-07T21:40:51.883' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (26, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-07T21:42:31.993' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (27, 1, N'Đăng nhập hệ thống', CAST(N'2025-07-08T01:42:45.020' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (28, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T12:27:28.853' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (29, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T12:40:43.783' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (30, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T12:41:08.970' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (31, 1, N'Đăng nhập hệ thống', CAST(N'2025-07-08T12:41:29.987' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (32, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T13:14:31.200' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (33, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T13:15:29.680' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (34, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T13:17:16.930' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (35, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T13:21:33.373' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (36, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T17:46:19.363' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (37, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T18:01:25.367' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (38, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T18:04:11.853' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (39, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T19:32:50.763' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (40, 1, N'Đăng nhập hệ thống', CAST(N'2025-07-08T19:35:10.303' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (41, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T19:35:46.047' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (42, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T19:51:32.433' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (43, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T20:09:43.190' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (44, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T20:19:59.190' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (45, 1, N'Đăng nhập hệ thống', CAST(N'2025-07-08T20:23:38.093' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (46, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T20:27:54.473' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (47, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T20:32:56.377' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (48, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T20:53:57.160' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (49, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T20:55:42.243' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (50, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T20:56:21.577' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (51, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T20:59:43.193' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (52, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T21:01:41.217' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (53, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T21:02:12.150' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (54, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T21:09:16.670' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (55, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T21:09:54.483' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (56, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T21:11:46.837' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (57, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T21:13:28.980' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (58, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T21:23:43.573' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (59, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T22:55:53.393' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (60, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T22:57:40.967' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (61, 1, N'Đăng nhập hệ thống', CAST(N'2025-07-08T22:58:12.873' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (62, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T23:00:55.327' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (63, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T23:29:34.970' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (64, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T23:32:11.823' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (65, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T23:33:12.737' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (66, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T23:45:08.030' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (67, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T23:51:15.427' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (68, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T23:56:01.670' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (69, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-08T23:59:15.973' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (70, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T00:02:42.700' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (71, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T00:04:48.210' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (72, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T00:14:46.733' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (73, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T00:18:40.837' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (74, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T01:42:00.727' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (75, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T01:42:05.047' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (76, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T01:51:35.543' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (77, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T01:59:10.557' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (78, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T02:00:05.413' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (79, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T02:25:22.227' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (80, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T02:32:35.010' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (81, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T02:34:32.537' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (82, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T02:35:35.393' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (83, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T02:44:03.633' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (84, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T02:44:24.607' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (85, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T02:45:32.640' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (86, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T02:47:23.027' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (87, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T02:56:48.680' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (88, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T03:01:24.187' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (89, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T03:37:54.777' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (90, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T03:39:49.417' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (91, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T13:30:57.560' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (92, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T13:39:31.290' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (93, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T13:50:36.843' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (94, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T13:56:14.430' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (95, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T13:58:34.630' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (96, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T14:04:59.623' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (97, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T14:28:55.077' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (98, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T15:13:51.300' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (99, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T15:58:54.757' AS DateTime))
GO
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (100, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T16:03:32.863' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (101, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T16:08:34.613' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (102, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T16:09:40.050' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (103, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T16:10:06.960' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (104, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T16:11:42.890' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (105, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T16:15:01.217' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (106, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T16:26:45.397' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (107, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T16:27:20.287' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (108, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T16:27:47.640' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (109, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T16:28:43.137' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (110, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T16:40:14.730' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (111, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T16:41:22.193' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (112, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T16:43:39.683' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (113, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T16:49:58.230' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (114, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T17:05:59.373' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (115, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T17:10:25.230' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (116, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T17:20:13.433' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (117, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T17:21:28.587' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (118, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T17:24:27.230' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (119, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T23:36:03.347' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (120, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T23:39:02.357' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (121, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T23:40:08.843' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (122, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T23:41:23.797' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (123, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T23:50:10.303' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (124, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-09T23:56:21.680' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (125, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-10T00:10:27.550' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (126, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-10T10:44:40.643' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (127, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-10T11:10:21.237' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (128, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-10T11:30:12.067' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (129, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-10T11:45:12.323' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (130, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-10T11:48:01.823' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (131, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-10T14:28:39.260' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (132, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-10T14:34:30.340' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (133, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-10T18:31:32.040' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (134, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-10T21:56:29.963' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (135, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-10T22:14:40.400' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (136, 1, N'Đăng nhập hệ thống', CAST(N'2025-07-10T22:36:26.310' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (137, 4, N'Đăng nhập hệ thống', CAST(N'2025-07-11T00:08:07.997' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (138, 1, N'Thay đổi thông tin giáo viên có ID tài khoản 4', CAST(N'2025-07-11T00:14:10.107' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (139, 1, N'Thay đổi thông tin giáo viên có ID tài khoản 4', CAST(N'2025-07-11T01:50:11.853' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (140, 1, N'Thay đổi thông tin giáo viên có ID tài khoản 4', CAST(N'2025-07-11T02:10:30.463' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (141, 1, N'Thay đổi thông tin học sinh có ID tài khoản 14', CAST(N'2025-07-11T02:15:46.557' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (142, 1, N'Thay đổi thông tin học sinh có ID tài khoản 14', CAST(N'2025-07-11T02:15:48.913' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (143, 4, N'Thêm phân công giáo viên ID=1 cho lớp ID=6', CAST(N'2025-07-14T22:28:44.597' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (144, 1, N'Đăng nhập hệ thống', CAST(N'2025-07-15T08:07:46.820' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (145, 1, N'Mở tài khoản giáo viên có ID tài khoản 7', CAST(N'2025-07-18T00:57:14.507' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (146, 7, N'Thêm phân công giáo viên ID=4 cho lớp ID=9', CAST(N'2025-07-18T01:04:31.593' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (147, 7, N'Xóa phân công giáo viên ID=4 cho lớp ID=9', CAST(N'2025-07-18T01:04:50.997' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (148, 1, N'Thay đổi thông tin giáo viên có ID tài khoản 4', CAST(N'2025-07-18T02:10:58.280' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (149, 1, N'Thay đổi thông tin học sinh có ID tài khoản 14', CAST(N'2025-07-18T02:11:15.820' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (150, 1, N'Thay đổi thông tin phụ huynh có ID tài khoản 114', CAST(N'2025-07-18T02:12:02.000' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (151, 4, N'Thêm phân công giáo viên ID=1 cho lớp ID=11', CAST(N'2025-07-18T02:25:27.320' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (152, 7, N'Thêm phân công giáo viên ID=4 cho lớp ID=9', CAST(N'2025-07-18T11:44:12.167' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (153, 1, N'Mở tài khoản giáo viên có ID tài khoản 5', CAST(N'2025-07-19T23:22:19.443' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (154, 1, N'Thay đổi thông tin học sinh có ID tài khoản 14', CAST(N'2025-07-21T11:05:39.490' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (155, 1, N'Thay đổi thông tin giáo viên có ID tài khoản 4', CAST(N'2025-07-21T22:23:18.243' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (156, 1, N'Thay đổi thông tin giáo viên có ID tài khoản 4', CAST(N'2025-07-21T22:23:50.283' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (157, 1, N'Thay đổi thông tin giáo viên có ID tài khoản 4', CAST(N'2025-07-21T22:24:10.137' AS DateTime))
SET IDENTITY_INSERT [dbo].[UserLogs] OFF
GO
SET IDENTITY_INSERT [dbo].[VaiTro] ON 

INSERT [dbo].[VaiTro] ([ID_VaiTro], [TenVaiTro], [MieuTa], [TrangThai], [NgayTao]) VALUES (1, N'Admin', N'Quản trị hệ thống, có toàn quyền điều khiển', N'Active', CAST(N'2025-05-24T18:28:39.913' AS DateTime))
INSERT [dbo].[VaiTro] ([ID_VaiTro], [TenVaiTro], [MieuTa], [TrangThai], [NgayTao]) VALUES (2, N'Staff', N'Nhân viên hỗ trợ, có quyền điều khiển hệ thống ở mức giới hạn', N'Active', CAST(N'2025-05-24T18:28:39.913' AS DateTime))
INSERT [dbo].[VaiTro] ([ID_VaiTro], [TenVaiTro], [MieuTa], [TrangThai], [NgayTao]) VALUES (3, N'GiaoVien', N'Giáo viên giảng dạy, quản lý lớp học và học sinh', N'Active', CAST(N'2025-05-24T18:28:39.913' AS DateTime))
INSERT [dbo].[VaiTro] ([ID_VaiTro], [TenVaiTro], [MieuTa], [TrangThai], [NgayTao]) VALUES (4, N'HocSinh', N'Học sinh tham gia các khóa học', N'Active', CAST(N'2025-05-24T18:28:39.913' AS DateTime))
INSERT [dbo].[VaiTro] ([ID_VaiTro], [TenVaiTro], [MieuTa], [TrangThai], [NgayTao]) VALUES (5, N'PhuHuynh', N'Phụ huynh học sinh, theo dõi kết quả học tập', N'Active', CAST(N'2025-05-24T18:28:39.913' AS DateTime))
SET IDENTITY_INSERT [dbo].[VaiTro] OFF
GO
/****** Object:  Index [UQ_GiaoVien_ID_TaiKhoan]    Script Date: 22/07/2025 7:51:27 SA ******/
ALTER TABLE [dbo].[GiaoVien] ADD  CONSTRAINT [UQ_GiaoVien_ID_TaiKhoan] UNIQUE NONCLUSTERED 
(
	[ID_TaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_HocSinh_ID_TaiKhoan]    Script Date: 22/07/2025 7:51:27 SA ******/
ALTER TABLE [dbo].[HocSinh] ADD  CONSTRAINT [UQ_HocSinh_ID_TaiKhoan] UNIQUE NONCLUSTERED 
(
	[ID_TaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_HocSinh_MaHocSinh]    Script Date: 22/07/2025 7:51:27 SA ******/
ALTER TABLE [dbo].[HocSinh] ADD  CONSTRAINT [UQ_HocSinh_MaHocSinh] UNIQUE NONCLUSTERED 
(
	[MaHocSinh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_KhoaHoc_CourseCode]    Script Date: 22/07/2025 7:51:27 SA ******/
ALTER TABLE [dbo].[KhoaHoc] ADD  CONSTRAINT [UQ_KhoaHoc_CourseCode] UNIQUE NONCLUSTERED 
(
	[CourseCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_LopHoc_ClassCode]    Script Date: 22/07/2025 7:51:27 SA ******/
ALTER TABLE [dbo].[LopHoc] ADD  CONSTRAINT [UQ_LopHoc_ClassCode] UNIQUE NONCLUSTERED 
(
	[ClassCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_PhuHuynh_ID_TaiKhoan]    Script Date: 22/07/2025 7:51:27 SA ******/
ALTER TABLE [dbo].[PhuHuynh] ADD  CONSTRAINT [UQ_PhuHuynh_ID_TaiKhoan] UNIQUE NONCLUSTERED 
(
	[ID_TaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_TaiKhoan_Email]    Script Date: 22/07/2025 7:51:27 SA ******/
ALTER TABLE [dbo].[TaiKhoan] ADD  CONSTRAINT [UQ_TaiKhoan_Email] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DangKyLopHoc] ADD  DEFAULT (getdate()) FOR [NgayDangKy]
GO
ALTER TABLE [dbo].[DangTaiLieu] ADD  CONSTRAINT [DF__DangTaiLi__NgayT__1CBC4616]  DEFAULT (getdate()) FOR [NgayTao]
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
ALTER TABLE [dbo].[KhoiHoc] ADD  DEFAULT ((1)) FOR [Status_Khoi]
GO
ALTER TABLE [dbo].[LopHoc] ADD  DEFAULT ('Active') FOR [TrangThai]
GO
ALTER TABLE [dbo].[LopHoc] ADD  DEFAULT (getdate()) FOR [NgayTao]
GO
ALTER TABLE [dbo].[NopBaiTap] ADD  DEFAULT (getdate()) FOR [NgayNop]
GO
ALTER TABLE [dbo].[PhongHoc] ADD  DEFAULT ('Active') FOR [TrangThai]
GO
ALTER TABLE [dbo].[PhuHuynh] ADD  DEFAULT ('Active') FOR [TrangThai]
GO
ALTER TABLE [dbo].[PhuHuynh] ADD  DEFAULT (getdate()) FOR [NgayTao]
GO
ALTER TABLE [dbo].[TaiKhoan] ADD  DEFAULT ('Active') FOR [TrangThai]
GO
ALTER TABLE [dbo].[TaiKhoan] ADD  DEFAULT (getdate()) FOR [NgayTao]
GO
ALTER TABLE [dbo].[TaoBaiTap] ADD  DEFAULT (getdate()) FOR [NgayTao]
GO
ALTER TABLE [dbo].[ThongBao] ADD  DEFAULT (getdate()) FOR [ThoiGian]
GO
ALTER TABLE [dbo].[UserLogs] ADD  DEFAULT (getdate()) FOR [ThoiGian]
GO
ALTER TABLE [dbo].[VaiTro] ADD  DEFAULT ('Active') FOR [TrangThai]
GO
ALTER TABLE [dbo].[VaiTro] ADD  DEFAULT (getdate()) FOR [NgayTao]
GO
ALTER TABLE [dbo].[Admin]  WITH CHECK ADD  CONSTRAINT [FK_Admin_TaiKhoan] FOREIGN KEY([ID_TaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([ID_TaiKhoan])
GO
ALTER TABLE [dbo].[Admin] CHECK CONSTRAINT [FK_Admin_TaiKhoan]
GO
ALTER TABLE [dbo].[Blog]  WITH CHECK ADD  CONSTRAINT [FK_Blog_KeyTag] FOREIGN KEY([ID_KeyTag])
REFERENCES [dbo].[KeyTag] ([ID_KeyTag])
GO
ALTER TABLE [dbo].[Blog] CHECK CONSTRAINT [FK_Blog_KeyTag]
GO
ALTER TABLE [dbo].[Blog]  WITH CHECK ADD  CONSTRAINT [FK_Blog_Keyword] FOREIGN KEY([ID_Keyword])
REFERENCES [dbo].[Keyword] ([ID_Keyword])
GO
ALTER TABLE [dbo].[Blog] CHECK CONSTRAINT [FK_Blog_Keyword]
GO
ALTER TABLE [dbo].[Blog]  WITH CHECK ADD  CONSTRAINT [FK_Blog_KhoiHoc] FOREIGN KEY([ID_Khoi])
REFERENCES [dbo].[KhoiHoc] ([ID_Khoi])
GO
ALTER TABLE [dbo].[Blog] CHECK CONSTRAINT [FK_Blog_KhoiHoc]
GO
ALTER TABLE [dbo].[Blog]  WITH CHECK ADD  CONSTRAINT [FK_Blog_PhanLoaiBlog] FOREIGN KEY([ID_PhanLoai])
REFERENCES [dbo].[PhanLoaiBlog] ([ID_PhanLoai])
GO
ALTER TABLE [dbo].[Blog] CHECK CONSTRAINT [FK_Blog_PhanLoaiBlog]
GO
ALTER TABLE [dbo].[DangKyLopHoc]  WITH CHECK ADD  CONSTRAINT [FK_DangKyLopHoc_HocSinh] FOREIGN KEY([ID_HocSinh])
REFERENCES [dbo].[HocSinh] ([ID_HocSinh])
GO
ALTER TABLE [dbo].[DangKyLopHoc] CHECK CONSTRAINT [FK_DangKyLopHoc_HocSinh]
GO
ALTER TABLE [dbo].[DangKyLopHoc]  WITH CHECK ADD  CONSTRAINT [FK_DangKyLopHoc_LopHoc] FOREIGN KEY([ID_LopHoc])
REFERENCES [dbo].[LopHoc] ([ID_LopHoc])
GO
ALTER TABLE [dbo].[DangKyLopHoc] CHECK CONSTRAINT [FK_DangKyLopHoc_LopHoc]
GO
ALTER TABLE [dbo].[DangTaiLieu]  WITH CHECK ADD  CONSTRAINT [FK_DangTaiLieu_LoaiTaiLieu] FOREIGN KEY([ID_LoaiTaiLieu])
REFERENCES [dbo].[LoaiTaiLieu] ([ID_LoaiTaiLieu])
GO
ALTER TABLE [dbo].[DangTaiLieu] CHECK CONSTRAINT [FK_DangTaiLieu_LoaiTaiLieu]
GO
ALTER TABLE [dbo].[DangTaiLieu]  WITH CHECK ADD  CONSTRAINT [FK_DangTaiLieu_MonHoc] FOREIGN KEY([ID_MonHoc])
REFERENCES [dbo].[MonHoc] ([ID_MonHoc])
GO
ALTER TABLE [dbo].[DangTaiLieu] CHECK CONSTRAINT [FK_DangTaiLieu_MonHoc]
GO
ALTER TABLE [dbo].[Diem]  WITH CHECK ADD  CONSTRAINT [FK_Diem_HocSinh] FOREIGN KEY([ID_HocSinh])
REFERENCES [dbo].[HocSinh] ([ID_HocSinh])
GO
ALTER TABLE [dbo].[Diem] CHECK CONSTRAINT [FK_Diem_HocSinh]
GO
ALTER TABLE [dbo].[Diem]  WITH CHECK ADD  CONSTRAINT [FK_Diem_LopHoc] FOREIGN KEY([ID_LopHoc])
REFERENCES [dbo].[LopHoc] ([ID_LopHoc])
GO
ALTER TABLE [dbo].[Diem] CHECK CONSTRAINT [FK_Diem_LopHoc]
GO
ALTER TABLE [dbo].[DiemDanh]  WITH CHECK ADD  CONSTRAINT [FK_DiemDanh_HocSinh] FOREIGN KEY([ID_HocSinh])
REFERENCES [dbo].[HocSinh] ([ID_HocSinh])
GO
ALTER TABLE [dbo].[DiemDanh] CHECK CONSTRAINT [FK_DiemDanh_HocSinh]
GO
ALTER TABLE [dbo].[DiemDanh]  WITH CHECK ADD  CONSTRAINT [FK_DiemDanh_LichHoc] FOREIGN KEY([ID_Schedule])
REFERENCES [dbo].[LichHoc] ([ID_Schedule])
GO
ALTER TABLE [dbo].[DiemDanh] CHECK CONSTRAINT [FK_DiemDanh_LichHoc]
GO
ALTER TABLE [dbo].[GiaoVien]  WITH CHECK ADD  CONSTRAINT [FK_GiaoVien_TaiKhoan] FOREIGN KEY([ID_TaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([ID_TaiKhoan])
GO
ALTER TABLE [dbo].[GiaoVien] CHECK CONSTRAINT [FK_GiaoVien_TaiKhoan]
GO
ALTER TABLE [dbo].[GiaoVien]  WITH CHECK ADD  CONSTRAINT [FK_GiaoVien_TruongHoc] FOREIGN KEY([ID_TruongHoc])
REFERENCES [dbo].[TruongHoc] ([ID_TruongHoc])
GO
ALTER TABLE [dbo].[GiaoVien] CHECK CONSTRAINT [FK_GiaoVien_TruongHoc]
GO
ALTER TABLE [dbo].[GiaoVien_LopHoc]  WITH CHECK ADD  CONSTRAINT [FK_GiaoVien_LopHoc_GiaoVien] FOREIGN KEY([ID_GiaoVien])
REFERENCES [dbo].[GiaoVien] ([ID_GiaoVien])
GO
ALTER TABLE [dbo].[GiaoVien_LopHoc] CHECK CONSTRAINT [FK_GiaoVien_LopHoc_GiaoVien]
GO
ALTER TABLE [dbo].[GiaoVien_LopHoc]  WITH CHECK ADD  CONSTRAINT [FK_GiaoVien_LopHoc_LopHoc] FOREIGN KEY([ID_LopHoc])
REFERENCES [dbo].[LopHoc] ([ID_LopHoc])
GO
ALTER TABLE [dbo].[GiaoVien_LopHoc] CHECK CONSTRAINT [FK_GiaoVien_LopHoc_LopHoc]
GO
ALTER TABLE [dbo].[HocPhi]  WITH CHECK ADD  CONSTRAINT [FK_HocPhi_HocSinh] FOREIGN KEY([ID_HocSinh])
REFERENCES [dbo].[HocSinh] ([ID_HocSinh])
GO
ALTER TABLE [dbo].[HocPhi] CHECK CONSTRAINT [FK_HocPhi_HocSinh]
GO
ALTER TABLE [dbo].[HocPhi]  WITH CHECK ADD  CONSTRAINT [FK_HocPhi_LopHoc] FOREIGN KEY([ID_LopHoc])
REFERENCES [dbo].[LopHoc] ([ID_LopHoc])
GO
ALTER TABLE [dbo].[HocPhi] CHECK CONSTRAINT [FK_HocPhi_LopHoc]
GO
ALTER TABLE [dbo].[HocSinh]  WITH CHECK ADD  CONSTRAINT [FK_HocSinh_TaiKhoan] FOREIGN KEY([ID_TaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([ID_TaiKhoan])
GO
ALTER TABLE [dbo].[HocSinh] CHECK CONSTRAINT [FK_HocSinh_TaiKhoan]
GO
ALTER TABLE [dbo].[HocSinh]  WITH CHECK ADD  CONSTRAINT [FK_HocSinh_TruongHoc] FOREIGN KEY([ID_TruongHoc])
REFERENCES [dbo].[TruongHoc] ([ID_TruongHoc])
GO
ALTER TABLE [dbo].[HocSinh] CHECK CONSTRAINT [FK_HocSinh_TruongHoc]
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
ALTER TABLE [dbo].[HocSinh_PhuHuynh]  WITH CHECK ADD  CONSTRAINT [FK_HocSinh_PhuHuynh_HocSinh] FOREIGN KEY([ID_HocSinh])
REFERENCES [dbo].[HocSinh] ([ID_HocSinh])
GO
ALTER TABLE [dbo].[HocSinh_PhuHuynh] CHECK CONSTRAINT [FK_HocSinh_PhuHuynh_HocSinh]
GO
ALTER TABLE [dbo].[HocSinh_PhuHuynh]  WITH CHECK ADD  CONSTRAINT [FK_HocSinh_PhuHuynh_PhuHuynh] FOREIGN KEY([ID_PhuHuynh])
REFERENCES [dbo].[PhuHuynh] ([ID_PhuHuynh])
GO
ALTER TABLE [dbo].[HocSinh_PhuHuynh] CHECK CONSTRAINT [FK_HocSinh_PhuHuynh_PhuHuynh]
GO
ALTER TABLE [dbo].[HoTro]  WITH CHECK ADD  CONSTRAINT [FK_HoTro_TaiKhoan] FOREIGN KEY([ID_TaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([ID_TaiKhoan])
GO
ALTER TABLE [dbo].[HoTro] CHECK CONSTRAINT [FK_HoTro_TaiKhoan]
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
ALTER TABLE [dbo].[LichHoc]  WITH CHECK ADD  CONSTRAINT [FK_LichHoc_PhongHoc] FOREIGN KEY([ID_PhongHoc])
REFERENCES [dbo].[PhongHoc] ([ID_PhongHoc])
GO
ALTER TABLE [dbo].[LichHoc] CHECK CONSTRAINT [FK_LichHoc_PhongHoc]
GO
ALTER TABLE [dbo].[LichHoc]  WITH CHECK ADD  CONSTRAINT [FK_LichHoc_SlotHoc] FOREIGN KEY([ID_SlotHoc])
REFERENCES [dbo].[SlotHoc] ([ID_SlotHoc])
GO
ALTER TABLE [dbo].[LichHoc] CHECK CONSTRAINT [FK_LichHoc_SlotHoc]
GO
ALTER TABLE [dbo].[LopHoc]  WITH CHECK ADD  CONSTRAINT [FK_LopHoc_KhoaHoc] FOREIGN KEY([ID_KhoaHoc])
REFERENCES [dbo].[KhoaHoc] ([ID_KhoaHoc])
GO
ALTER TABLE [dbo].[LopHoc] CHECK CONSTRAINT [FK_LopHoc_KhoaHoc]
GO
ALTER TABLE [dbo].[LopHoc]  WITH CHECK ADD  CONSTRAINT [FK_LopHoc_PhongHoc] FOREIGN KEY([ID_PhongHoc])
REFERENCES [dbo].[PhongHoc] ([ID_PhongHoc])
GO
ALTER TABLE [dbo].[LopHoc] CHECK CONSTRAINT [FK_LopHoc_PhongHoc]
GO
ALTER TABLE [dbo].[NopBaiTap]  WITH CHECK ADD  CONSTRAINT [FK_NopBaiTap_HocSinh] FOREIGN KEY([ID_HocSinh])
REFERENCES [dbo].[HocSinh] ([ID_HocSinh])
GO
ALTER TABLE [dbo].[NopBaiTap] CHECK CONSTRAINT [FK_NopBaiTap_HocSinh]
GO
ALTER TABLE [dbo].[NopBaiTap]  WITH CHECK ADD  CONSTRAINT [FK_NopBaiTap_TaoBaiTap] FOREIGN KEY([ID_BaiTap])
REFERENCES [dbo].[TaoBaiTap] ([ID_BaiTap])
GO
ALTER TABLE [dbo].[NopBaiTap] CHECK CONSTRAINT [FK_NopBaiTap_TaoBaiTap]
GO
ALTER TABLE [dbo].[PhuHuynh]  WITH CHECK ADD  CONSTRAINT [FK_PhuHuynh_TaiKhoan] FOREIGN KEY([ID_TaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([ID_TaiKhoan])
GO
ALTER TABLE [dbo].[PhuHuynh] CHECK CONSTRAINT [FK_PhuHuynh_TaiKhoan]
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD  CONSTRAINT [FK_Staff_TaiKhoan] FOREIGN KEY([ID_TaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([ID_TaiKhoan])
GO
ALTER TABLE [dbo].[Staff] CHECK CONSTRAINT [FK_Staff_TaiKhoan]
GO
ALTER TABLE [dbo].[TaiKhoan]  WITH CHECK ADD  CONSTRAINT [FK_TaiKhoan_VaiTro] FOREIGN KEY([ID_VaiTro])
REFERENCES [dbo].[VaiTro] ([ID_VaiTro])
GO
ALTER TABLE [dbo].[TaiKhoan] CHECK CONSTRAINT [FK_TaiKhoan_VaiTro]
GO
ALTER TABLE [dbo].[TaoBaiTap]  WITH CHECK ADD  CONSTRAINT [FK_TaoBaiTap_GiaoVien] FOREIGN KEY([ID_GiaoVien])
REFERENCES [dbo].[GiaoVien] ([ID_GiaoVien])
GO
ALTER TABLE [dbo].[TaoBaiTap] CHECK CONSTRAINT [FK_TaoBaiTap_GiaoVien]
GO
ALTER TABLE [dbo].[TaoBaiTap]  WITH CHECK ADD  CONSTRAINT [FK_TaoBaiTap_LopHoc] FOREIGN KEY([ID_LopHoc])
REFERENCES [dbo].[LopHoc] ([ID_LopHoc])
GO
ALTER TABLE [dbo].[TaoBaiTap] CHECK CONSTRAINT [FK_TaoBaiTap_LopHoc]
GO
ALTER TABLE [dbo].[ThongBao]  WITH CHECK ADD  CONSTRAINT [FK_ThongBao_HocPhi] FOREIGN KEY([ID_HocPhi])
REFERENCES [dbo].[HocPhi] ([ID_HocPhi])
GO
ALTER TABLE [dbo].[ThongBao] CHECK CONSTRAINT [FK_ThongBao_HocPhi]
GO
ALTER TABLE [dbo].[ThongBao]  WITH CHECK ADD  CONSTRAINT [FK_ThongBao_TaiKhoan] FOREIGN KEY([ID_TaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([ID_TaiKhoan])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ThongBao] CHECK CONSTRAINT [FK_ThongBao_TaiKhoan]
GO
ALTER TABLE [dbo].[UserLogs]  WITH CHECK ADD  CONSTRAINT [FK_UserLogs_TaiKhoan] FOREIGN KEY([ID_TaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([ID_TaiKhoan])
GO
ALTER TABLE [dbo].[UserLogs] CHECK CONSTRAINT [FK_UserLogs_TaiKhoan]
GO

select * from TaiKhoan ; 
					
						



