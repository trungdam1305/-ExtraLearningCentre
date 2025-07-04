USE [SWP]
GO
/****** Object:  Table [dbo].[Admin]    Script Date: 23/06/2025 10:56:22 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admin](
	[ID_Admin] [int] IDENTITY(1,1) NOT NULL,
	[ID_TaiKhoan] [int] NOT NULL,
	[HoTen] [nvarchar](max) NULL,
	[Avatar] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Blog]    Script Date: 23/06/2025 10:56:22 CH ******/
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
	[ID_PhanLoai] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DangKyLopHoc]    Script Date: 23/06/2025 10:56:22 CH ******/
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
/****** Object:  Table [dbo].[DangTaiLieu]    Script Date: 23/06/2025 10:56:22 CH ******/
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
	[DanhMuc] [nvarchar](max) NULL,
	[GiaTien] [nvarchar](max) NULL,
	[Image] [nvarchar](max) NULL,
 CONSTRAINT [PK__DangTaiL__A7F521BB3898C8A8] PRIMARY KEY CLUSTERED 
(
	[ID_Material] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Diem]    Script Date: 23/06/2025 10:56:22 CH ******/
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
/****** Object:  Table [dbo].[DiemDanh]    Script Date: 23/06/2025 10:56:22 CH ******/
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
/****** Object:  Table [dbo].[FeedBack]    Script Date: 23/06/2025 10:56:22 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FeedBack](
	[ID_FeedBack] [int] NOT NULL,
	[NoiDung] [nvarchar](max) NOT NULL,
	[Status] [bit] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiaoVien]    Script Date: 23/06/2025 10:56:22 CH ******/
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
	[ID_TruongHoc] [int] NOT NULL,
	[Luong] [decimal](10, 2) NULL,
	[IsHot] [int] NULL,
	[TrangThai] [nvarchar](20) NULL,
	[NgayTao] [datetime] NULL,
	[Avatar] [nvarchar](max) NULL,
 CONSTRAINT [PK__GiaoVien__FF5765A207B04098] PRIMARY KEY CLUSTERED 
(
	[ID_GiaoVien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiaoVien_LopHoc]    Script Date: 23/06/2025 10:56:22 CH ******/
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
/****** Object:  Table [dbo].[HocPhi]    Script Date: 23/06/2025 10:56:22 CH ******/
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
/****** Object:  Table [dbo].[HocSinh]    Script Date: 23/06/2025 10:56:22 CH ******/
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
	[DiaChi] [nvarchar](255) NOT NULL,
	[SDT_PhuHuynh] [nvarchar](15) NOT NULL,
	[ID_TruongHoc] [int] NOT NULL,
	[GhiChu] [nvarchar](max) NULL,
	[TrangThai] [nvarchar](20) NULL,
	[NgayTao] [datetime] NULL,
 CONSTRAINT [PK__HocSinh__5C69B3B86323857F] PRIMARY KEY CLUSTERED 
(
	[ID_HocSinh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HocSinh_LopHoc]    Script Date: 23/06/2025 10:56:22 CH ******/
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
/****** Object:  Table [dbo].[HocSinh_PhuHuynh]    Script Date: 23/06/2025 10:56:22 CH ******/
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
/****** Object:  Table [dbo].[HoTro]    Script Date: 23/06/2025 10:56:22 CH ******/
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
PRIMARY KEY CLUSTERED 
(
	[ID_HoTro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhoaHoc]    Script Date: 23/06/2025 10:56:22 CH ******/
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
	[Image] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_KhoaHoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhoiHoc]    Script Date: 23/06/2025 10:56:22 CH ******/
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
/****** Object:  Table [dbo].[LichHoc]    Script Date: 23/06/2025 10:56:22 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LichHoc](
	[ID_Schedule] [int] IDENTITY(1,1) NOT NULL,
	[NgayHoc] [date] NOT NULL,
	[ID_SlotHoc] [int] NOT NULL,
	[ID_LopHoc] [int] NULL,
	[GhiChu] [nvarchar](max) NULL,
 CONSTRAINT [PK__LichHoc__73616218C5C45370] PRIMARY KEY CLUSTERED 
(
	[ID_Schedule] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LopHoc]    Script Date: 23/06/2025 10:56:22 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LopHoc](
	[ID_LopHoc] [int] IDENTITY(1,1) NOT NULL,
	[TenLopHoc] [nvarchar](100) NOT NULL,
	[ID_KhoaHoc] [int] NULL,
	[SiSo] [int] NULL,
	[ID_Schedule] [int] NULL,
	[GhiChu] [nvarchar](max) NULL,
	[TrangThai] [nvarchar](20) NULL,
	[SoTien] [nchar](10) NULL,
	[NgayTao] [datetime] NULL,
	[Image] [nvarchar](max) NULL,
	[SiSoToiDa] [int] NULL,
 CONSTRAINT [PK__LopHoc__5C25E9AE7400A479] PRIMARY KEY CLUSTERED 
(
	[ID_LopHoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NopBaiTap]    Script Date: 23/06/2025 10:56:22 CH ******/
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
/****** Object:  Table [dbo].[PhanLoaiBlog]    Script Date: 23/06/2025 10:56:22 CH ******/
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
/****** Object:  Table [dbo].[PhuHuynh]    Script Date: 23/06/2025 10:56:22 CH ******/
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
/****** Object:  Table [dbo].[Slider]    Script Date: 23/06/2025 10:56:22 CH ******/
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
/****** Object:  Table [dbo].[SlotHoc]    Script Date: 23/06/2025 10:56:22 CH ******/
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
/****** Object:  Table [dbo].[Staff]    Script Date: 23/06/2025 10:56:22 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[ID_Staff] [int] IDENTITY(1,1) NOT NULL,
	[ID_TaiKhoan] [int] NOT NULL,
	[HoTen] [nvarchar](max) NOT NULL,
	[Avatar] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 23/06/2025 10:56:22 CH ******/
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
/****** Object:  Table [dbo].[TaoBaiTap]    Script Date: 23/06/2025 10:56:22 CH ******/
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
/****** Object:  Table [dbo].[ThongBao]    Script Date: 23/06/2025 10:56:22 CH ******/
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
/****** Object:  Table [dbo].[TruongHoc]    Script Date: 23/06/2025 10:56:22 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TruongHoc](
	[ID_TruongHoc] [int] IDENTITY(1,1) NOT NULL,
	[TenTruongHoc] [nvarchar](max) NULL,
	[DiaChi] [nvarchar](max) NULL,
 CONSTRAINT [PK_TruongHoc] PRIMARY KEY CLUSTERED 
(
	[ID_TruongHoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserLogs]    Script Date: 23/06/2025 10:56:22 CH ******/
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
/****** Object:  Table [dbo].[VaiTro]    Script Date: 23/06/2025 10:56:22 CH ******/
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
SET IDENTITY_INSERT [dbo].[Admin] ON 

INSERT [dbo].[Admin] ([ID_Admin], [ID_TaiKhoan], [HoTen], [Avatar]) VALUES (1, 1, N'Nguyen Van Admin', N'avatarTeacher.jpg')
SET IDENTITY_INSERT [dbo].[Admin] OFF
GO
SET IDENTITY_INSERT [dbo].[Blog] ON 

INSERT [dbo].[Blog] ([ID_Blog], [BlogTitle], [BlogDescription], [BlogDate], [Image], [ID_Khoi], [ID_PhanLoai]) VALUES (1, N'Khám Phá Toán Học', N'Bài viết giới thiệu những phương pháp học Toán hiệu quả', CAST(N'2025-05-30' AS Date), N'avatarTeacher.jpg', 1, 1)
INSERT [dbo].[Blog] ([ID_Blog], [BlogTitle], [BlogDescription], [BlogDate], [Image], [ID_Khoi], [ID_PhanLoai]) VALUES (2, N'Học Tiếng Anh Thú Vị', N'Cách cải thiện kỹ năng tiếng Anh nhanh chóng', CAST(N'2025-06-01' AS Date), N'avatarTeacher.jpg', 2, 3)
INSERT [dbo].[Blog] ([ID_Blog], [BlogTitle], [BlogDescription], [BlogDate], [Image], [ID_Khoi], [ID_PhanLoai]) VALUES (3, N'Văn Học Việt Nam', N'Tổng quan các tác phẩm văn học nổi bật', CAST(N'2025-06-03' AS Date), N'avatarTeacher.jpg', 3, 2)
INSERT [dbo].[Blog] ([ID_Blog], [BlogTitle], [BlogDescription], [BlogDate], [Image], [ID_Khoi], [ID_PhanLoai]) VALUES (4, N'Giới Thiệu về Trung Tâm', N'Những sự kiện lịch sử quan trọng cần biết', CAST(N'2025-05-26' AS Date), N'avatarTeacher.jpg', 4, 4)
INSERT [dbo].[Blog] ([ID_Blog], [BlogTitle], [BlogDescription], [BlogDate], [Image], [ID_Khoi], [ID_PhanLoai]) VALUES (5, N'Giới Thiệu về Trung Tâm', N'29, Đại Lộ Thăng Long', CAST(N'2025-06-23' AS Date), N'avatarTeacher.jpg', NULL, 4)
SET IDENTITY_INSERT [dbo].[Blog] OFF
GO
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (1, 1, CAST(N'2025-05-24' AS Date), N'Đã đóng học phí')
INSERT [dbo].[DangKyLopHoc] ([ID_HocSinh], [ID_LopHoc], [NgayDangKy], [TinhTrangHocPhi]) VALUES (2, 2, CAST(N'2025-05-24' AS Date), N'Chưa đóng học phí')
GO
SET IDENTITY_INSERT [dbo].[DangTaiLieu] ON 

INSERT [dbo].[DangTaiLieu] ([ID_Material], [ID_GiaoVien], [TenTaiLieu], [LoaiTaiLieu], [DuongDan], [NgayTao], [DanhMuc], [GiaTien], [Image]) VALUES (1, 1, N'Tài liệu Toán Đại số', N'PDF', N'/files/tailieu_toan_daiso.pdf', CAST(N'2025-05-24' AS Date), N'Toán Học', N'200,000', N'Grade.jpg')
INSERT [dbo].[DangTaiLieu] ([ID_Material], [ID_GiaoVien], [TenTaiLieu], [LoaiTaiLieu], [DuongDan], [NgayTao], [DanhMuc], [GiaTien], [Image]) VALUES (2, 1, N'Tài Liệu Toán 12 Đại Học', N'PDF', NULL, CAST(N'2025-06-22' AS Date), N'Toán Học', N'200,000', N'Grade.jpg')
INSERT [dbo].[DangTaiLieu] ([ID_Material], [ID_GiaoVien], [TenTaiLieu], [LoaiTaiLieu], [DuongDan], [NgayTao], [DanhMuc], [GiaTien], [Image]) VALUES (5, 1, N'Tài Liệu Toán Lớp 9', N'Word', NULL, CAST(N'2025-06-22' AS Date), N'Ngữ Văn', N'200,000', N'Grade.jpg')
INSERT [dbo].[DangTaiLieu] ([ID_Material], [ID_GiaoVien], [TenTaiLieu], [LoaiTaiLieu], [DuongDan], [NgayTao], [DanhMuc], [GiaTien], [Image]) VALUES (10, 1, N'Tài liệu Toán học lớp 6', N'PDF', N'/tai_lieu/toan_lop6.pdf', CAST(N'2025-06-22' AS Date), N'Toán học', N'200,000', N'Grade.jpg')
INSERT [dbo].[DangTaiLieu] ([ID_Material], [ID_GiaoVien], [TenTaiLieu], [LoaiTaiLieu], [DuongDan], [NgayTao], [DanhMuc], [GiaTien], [Image]) VALUES (11, 2, N'Bài giảng Văn lớp 9', N'DOCX', N'/tai_lieu/van_lop9.docx', CAST(N'2025-06-22' AS Date), N'Ngữ Văn', N'200,000', N'Grade.jpg')
INSERT [dbo].[DangTaiLieu] ([ID_Material], [ID_GiaoVien], [TenTaiLieu], [LoaiTaiLieu], [DuongDan], [NgayTao], [DanhMuc], [GiaTien], [Image]) VALUES (12, 1, N'Trắc nghiệm Vật Lý 12', N'PDF', N'/tai_lieu/ly12_tracnghiem.pdf', CAST(N'2025-06-22' AS Date), N'Ngữ Văn', N'200,000', N'Grade.jpg')
INSERT [dbo].[DangTaiLieu] ([ID_Material], [ID_GiaoVien], [TenTaiLieu], [LoaiTaiLieu], [DuongDan], [NgayTao], [DanhMuc], [GiaTien], [Image]) VALUES (13, 2, N'PowerPoint Hóa học 11', N'PPTX', N'/tai_lieu/hoa11_baigiang.pptx', CAST(N'2025-06-22' AS Date), N'Tiếng Anh', N'200,000', N'Grade.jpg')
INSERT [dbo].[DangTaiLieu] ([ID_Material], [ID_GiaoVien], [TenTaiLieu], [LoaiTaiLieu], [DuongDan], [NgayTao], [DanhMuc], [GiaTien], [Image]) VALUES (14, 1, N'Tài liệu chung cho GV', N'ZIP', N'/tai_lieu/chung_gv.zip', CAST(N'2025-06-22' AS Date), N'Tổng hợp', N'200,000', N'Grade.jpg')
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

INSERT [dbo].[GiaoVien] ([ID_GiaoVien], [ID_TaiKhoan], [HoTen], [ChuyenMon], [SDT], [ID_TruongHoc], [Luong], [IsHot], [TrangThai], [NgayTao], [Avatar]) VALUES (1, 3, N'Vũ Văn Chủ', N'Toán học', N'0987654321', 1, CAST(12000000.00 AS Decimal(10, 2)), 1, N'Active', CAST(N'2025-05-24T18:28:39.923' AS DateTime), N'avatarTeacher.jpg')
INSERT [dbo].[GiaoVien] ([ID_GiaoVien], [ID_TaiKhoan], [HoTen], [ChuyenMon], [SDT], [ID_TruongHoc], [Luong], [IsHot], [TrangThai], [NgayTao], [Avatar]) VALUES (2, 11, N'Đàm Quang Trung', N'Toán học', N'0987654321', 2, CAST(15000000.00 AS Decimal(10, 2)), 2, N'Active', CAST(N'2025-05-29T10:20:03.967' AS DateTime), N'avatarTeacher.jpg')
INSERT [dbo].[GiaoVien] ([ID_GiaoVien], [ID_TaiKhoan], [HoTen], [ChuyenMon], [SDT], [ID_TruongHoc], [Luong], [IsHot], [TrangThai], [NgayTao], [Avatar]) VALUES (4, 17, N'Vũ Minh Hoàng', N'Lý', N'0923456789', 2, CAST(12000000.00 AS Decimal(10, 2)), 3, N'Active', CAST(N'2025-05-29T12:14:43.233' AS DateTime), N'avatarTeacher.jpg')
INSERT [dbo].[GiaoVien] ([ID_GiaoVien], [ID_TaiKhoan], [HoTen], [ChuyenMon], [SDT], [ID_TruongHoc], [Luong], [IsHot], [TrangThai], [NgayTao], [Avatar]) VALUES (5, 18, N'Đỗ Huy Đô', N'Hóa', N'0934567890', 2, CAST(12000000.00 AS Decimal(10, 2)), 4, N'Active', CAST(N'2025-05-29T12:14:43.233' AS DateTime), N'avatarTeacher.jpg')
INSERT [dbo].[GiaoVien] ([ID_GiaoVien], [ID_TaiKhoan], [HoTen], [ChuyenMon], [SDT], [ID_TruongHoc], [Luong], [IsHot], [TrangThai], [NgayTao], [Avatar]) VALUES (6, 19, N'Ngô Xuân Tuấn Dũng', N'Sinh', N'0945678901', 2, CAST(12000000.00 AS Decimal(10, 2)), 5, N'Active', CAST(N'2025-05-29T12:14:43.233' AS DateTime), N'avatarTeacher.jpg')
SET IDENTITY_INSERT [dbo].[GiaoVien] OFF
GO
INSERT [dbo].[GiaoVien_LopHoc] ([ID_GiaoVien], [ID_LopHoc]) VALUES (1, 1)
INSERT [dbo].[GiaoVien_LopHoc] ([ID_GiaoVien], [ID_LopHoc]) VALUES (1, 2)
INSERT [dbo].[GiaoVien_LopHoc] ([ID_GiaoVien], [ID_LopHoc]) VALUES (2, 1)
INSERT [dbo].[GiaoVien_LopHoc] ([ID_GiaoVien], [ID_LopHoc]) VALUES (2, 2)
INSERT [dbo].[GiaoVien_LopHoc] ([ID_GiaoVien], [ID_LopHoc]) VALUES (2, 3)
INSERT [dbo].[GiaoVien_LopHoc] ([ID_GiaoVien], [ID_LopHoc]) VALUES (2, 4)
GO
SET IDENTITY_INSERT [dbo].[HocPhi] ON 

INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu]) VALUES (1, 1, 1, N'Toán', N'Tiền mặt', N'Đã thanh toán', CAST(N'2025-06-01' AS Date), NULL)
INSERT [dbo].[HocPhi] ([ID_HocPhi], [ID_HocSinh], [ID_LopHoc], [MonHoc], [PhuongThucThanhToan], [TinhTrangThanhToan], [NgayThanhToan], [GhiChu]) VALUES (2, 2, 1, N'Văn', N'Chuyển khoản', N'Chưa thanh toán', NULL, NULL)
SET IDENTITY_INSERT [dbo].[HocPhi] OFF
GO
SET IDENTITY_INSERT [dbo].[HocSinh] ON 

INSERT [dbo].[HocSinh] ([ID_HocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao]) VALUES (1, 4, N'Nguyễn Văn A', CAST(N'2008-03-15' AS Date), N'Nam', N'Hà Nội', N'0900111222', 1, NULL, N'Active', CAST(N'2025-05-24T18:28:39.920' AS DateTime))
INSERT [dbo].[HocSinh] ([ID_HocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao]) VALUES (2, NULL, N'Trần Thị B', CAST(N'2007-09-10' AS Date), N'Nữ', N'Hải Phòng', N'0900333444', 1, NULL, N'Active', CAST(N'2025-05-24T18:28:39.920' AS DateTime))
INSERT [dbo].[HocSinh] ([ID_HocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao]) VALUES (4, 7, N'Lê Thị B', CAST(N'2011-08-22' AS Date), N'Nữ', N'456 Đường XYZ, TP.HCM', N'0912345678', 1, N'Đã đăng ký lớp toán nâng cao', N'Active', CAST(N'2025-05-26T09:46:55.163' AS DateTime))
INSERT [dbo].[HocSinh] ([ID_HocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao]) VALUES (5, 9, N'Nguyễn Văn A', CAST(N'2010-05-15' AS Date), N'Nam', N'123 Đường ABC, Hà Nội', N'0987654321', 2, NULL, N'Active', CAST(N'2025-05-26T10:07:02.520' AS DateTime))
INSERT [dbo].[HocSinh] ([ID_HocSinh], [ID_TaiKhoan], [HoTen], [NgaySinh], [GioiTinh], [DiaChi], [SDT_PhuHuynh], [ID_TruongHoc], [GhiChu], [TrangThai], [NgayTao]) VALUES (6, 10, N'Lê Thị B', CAST(N'2011-08-22' AS Date), N'Nữ', N'456 Đường XYZ, TP.HCM', N'0912345678', 2, N'Đã đăng ký lớp toán nâng cao', N'Active', CAST(N'2025-05-26T10:07:02.520' AS DateTime))
SET IDENTITY_INSERT [dbo].[HocSinh] OFF
GO
SET IDENTITY_INSERT [dbo].[HocSinh_LopHoc] ON 

INSERT [dbo].[HocSinh_LopHoc] ([ID_LopHoc], [ID_HocSinh], [ID_HSLopHoc], [FeedBack], [status_FeedBack]) VALUES (1, 1, 1, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_LopHoc], [ID_HocSinh], [ID_HSLopHoc], [FeedBack], [status_FeedBack]) VALUES (1, 2, 2, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_LopHoc], [ID_HocSinh], [ID_HSLopHoc], [FeedBack], [status_FeedBack]) VALUES (1, 4, 3, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_LopHoc], [ID_HocSinh], [ID_HSLopHoc], [FeedBack], [status_FeedBack]) VALUES (1, 5, 4, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_LopHoc], [ID_HocSinh], [ID_HSLopHoc], [FeedBack], [status_FeedBack]) VALUES (2, 1, 5, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_LopHoc], [ID_HocSinh], [ID_HSLopHoc], [FeedBack], [status_FeedBack]) VALUES (2, 2, 6, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_LopHoc], [ID_HocSinh], [ID_HSLopHoc], [FeedBack], [status_FeedBack]) VALUES (2, 4, 7, NULL, NULL)
INSERT [dbo].[HocSinh_LopHoc] ([ID_LopHoc], [ID_HocSinh], [ID_HSLopHoc], [FeedBack], [status_FeedBack]) VALUES (5, 4, 8, NULL, NULL)
SET IDENTITY_INSERT [dbo].[HocSinh_LopHoc] OFF
GO
INSERT [dbo].[HocSinh_PhuHuynh] ([ID_HocSinh], [ID_PhuHuynh]) VALUES (1, 1)
GO
SET IDENTITY_INSERT [dbo].[HoTro] ON 

INSERT [dbo].[HoTro] ([ID_HoTro], [HoTen], [TenHoTro], [ThoiGian], [MoTa], [ID_TaiKhoan]) VALUES (1, N'Vũ Minh Hoàng', N'Hỗ trợ sửa thành viên lớp', CAST(N'2025-06-23T22:03:48.010' AS DateTime), N'Thành viên lớp nghỉ học. Muốn xóa thành viên lớp', 17)
INSERT [dbo].[HoTro] ([ID_HoTro], [HoTen], [TenHoTro], [ThoiGian], [MoTa], [ID_TaiKhoan]) VALUES (2, N'Đàm Quang Trung', N'Hỗ trợ chuyển trường', CAST(N'2025-06-23T22:03:48.010' AS DateTime), N'Tôi chuyển trường. Muốn hỗ trợ chuyển trường.', 11)
INSERT [dbo].[HoTro] ([ID_HoTro], [HoTen], [TenHoTro], [ThoiGian], [MoTa], [ID_TaiKhoan]) VALUES (3, N'Vũ Minh Hoàng', N'Hỗ trợ sửa điểm', CAST(N'2025-06-23T22:03:48.010' AS DateTime), N'Tôi cập nhật điểm sai, muốn hỗ trợ sửa điểm.', 17)
SET IDENTITY_INSERT [dbo].[HoTro] OFF
GO
SET IDENTITY_INSERT [dbo].[KhoaHoc] ON 

INSERT [dbo].[KhoaHoc] ([ID_KhoaHoc], [TenKhoaHoc], [MoTa], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [TrangThai], [NgayTao], [ID_Khoi], [Image]) VALUES (1, N'Toán', N'Khóa học Toán nâng cao dành cho học sinh lớp 6', CAST(N'2025-06-01' AS Date), CAST(N'2025-12-01' AS Date), N'Khóa học gồm 2 học kỳ', N'Active', CAST(N'2025-05-24T18:28:39.920' AS DateTime), 1, N'Grade.jpg')
INSERT [dbo].[KhoaHoc] ([ID_KhoaHoc], [TenKhoaHoc], [MoTa], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [TrangThai], [NgayTao], [ID_Khoi], [Image]) VALUES (2, N'Văn', N'Khóa Học Văn lớp 6', CAST(N'2025-06-01' AS Date), CAST(N'2025-11-30' AS Date), NULL, N'Active', CAST(N'2025-05-24T18:28:39.920' AS DateTime), 1, N'Grade.jpg')
INSERT [dbo].[KhoaHoc] ([ID_KhoaHoc], [TenKhoaHoc], [MoTa], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [TrangThai], [NgayTao], [ID_Khoi], [Image]) VALUES (3, N'Toán', N'Môn học Toán', CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), NULL, N'Active', CAST(N'2025-05-29T18:14:15.233' AS DateTime), 2, N'Grade.jpg')
INSERT [dbo].[KhoaHoc] ([ID_KhoaHoc], [TenKhoaHoc], [MoTa], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [TrangThai], [NgayTao], [ID_Khoi], [Image]) VALUES (4, N'Văn', N'Môn học Văn', CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), NULL, N'Active', CAST(N'2025-05-29T18:14:15.233' AS DateTime), 2, N'Grade.jpg')
INSERT [dbo].[KhoaHoc] ([ID_KhoaHoc], [TenKhoaHoc], [MoTa], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [TrangThai], [NgayTao], [ID_Khoi], [Image]) VALUES (5, N'Anh', N'Môn học Anh', CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), NULL, N'Active', CAST(N'2025-05-29T18:14:15.233' AS DateTime), 2, N'Grade.jpg')
INSERT [dbo].[KhoaHoc] ([ID_KhoaHoc], [TenKhoaHoc], [MoTa], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [TrangThai], [NgayTao], [ID_Khoi], [Image]) VALUES (6, N'Toán', N'Môn học Toán', CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), NULL, N'Active', CAST(N'2025-05-29T18:14:15.233' AS DateTime), 3, N'Grade.jpg')
INSERT [dbo].[KhoaHoc] ([ID_KhoaHoc], [TenKhoaHoc], [MoTa], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [TrangThai], [NgayTao], [ID_Khoi], [Image]) VALUES (7, N'Văn', N'Môn học Văn', CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), NULL, N'Active', CAST(N'2025-05-29T18:14:15.233' AS DateTime), 3, N'Grade.jpg')
INSERT [dbo].[KhoaHoc] ([ID_KhoaHoc], [TenKhoaHoc], [MoTa], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [TrangThai], [NgayTao], [ID_Khoi], [Image]) VALUES (8, N'Anh', N'Môn học Anh', CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), NULL, N'Active', CAST(N'2025-05-29T18:14:15.233' AS DateTime), 3, N'Grade.jpg')
INSERT [dbo].[KhoaHoc] ([ID_KhoaHoc], [TenKhoaHoc], [MoTa], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [TrangThai], [NgayTao], [ID_Khoi], [Image]) VALUES (9, N'Toán', N'Môn học Toán', CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), NULL, N'Active', CAST(N'2025-05-29T18:14:15.233' AS DateTime), 4, N'Grade.jpg')
INSERT [dbo].[KhoaHoc] ([ID_KhoaHoc], [TenKhoaHoc], [MoTa], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [TrangThai], [NgayTao], [ID_Khoi], [Image]) VALUES (10, N'Văn', N'Môn học Văn', CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), NULL, N'Active', CAST(N'2025-05-29T18:14:15.233' AS DateTime), 4, N'Grade.jpg')
INSERT [dbo].[KhoaHoc] ([ID_KhoaHoc], [TenKhoaHoc], [MoTa], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [TrangThai], [NgayTao], [ID_Khoi], [Image]) VALUES (11, N'Anh', N'Môn học Anh', CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), NULL, N'Active', CAST(N'2025-05-29T18:14:15.233' AS DateTime), 4, N'Grade.jpg')
INSERT [dbo].[KhoaHoc] ([ID_KhoaHoc], [TenKhoaHoc], [MoTa], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [TrangThai], [NgayTao], [ID_Khoi], [Image]) VALUES (12, N'Toán', N'Môn học Toán', CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), NULL, N'Active', CAST(N'2025-05-29T18:14:15.233' AS DateTime), 5, N'Grade.jpg')
INSERT [dbo].[KhoaHoc] ([ID_KhoaHoc], [TenKhoaHoc], [MoTa], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [TrangThai], [NgayTao], [ID_Khoi], [Image]) VALUES (13, N'Văn', N'Môn học Văn', CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), NULL, N'Active', CAST(N'2025-05-29T18:14:15.233' AS DateTime), 5, N'Grade.jpg')
INSERT [dbo].[KhoaHoc] ([ID_KhoaHoc], [TenKhoaHoc], [MoTa], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [TrangThai], [NgayTao], [ID_Khoi], [Image]) VALUES (14, N'Anh', N'Môn học Anh', CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), NULL, N'Active', CAST(N'2025-05-29T18:14:15.233' AS DateTime), 5, N'Grade.jpg')
INSERT [dbo].[KhoaHoc] ([ID_KhoaHoc], [TenKhoaHoc], [MoTa], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [TrangThai], [NgayTao], [ID_Khoi], [Image]) VALUES (15, N'Toán', N'Môn học Toán', CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), NULL, N'Active', CAST(N'2025-05-29T18:14:15.233' AS DateTime), 6, N'Grade.jpg')
INSERT [dbo].[KhoaHoc] ([ID_KhoaHoc], [TenKhoaHoc], [MoTa], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [TrangThai], [NgayTao], [ID_Khoi], [Image]) VALUES (16, N'Văn', N'Môn học Văn', CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), NULL, N'Active', CAST(N'2025-05-29T18:14:15.233' AS DateTime), 6, N'Grade.jpg')
INSERT [dbo].[KhoaHoc] ([ID_KhoaHoc], [TenKhoaHoc], [MoTa], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [TrangThai], [NgayTao], [ID_Khoi], [Image]) VALUES (17, N'Anh', N'Môn học Anh', CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), NULL, N'Active', CAST(N'2025-05-29T18:14:15.233' AS DateTime), 6, N'Grade.jpg')
INSERT [dbo].[KhoaHoc] ([ID_KhoaHoc], [TenKhoaHoc], [MoTa], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [TrangThai], [NgayTao], [ID_Khoi], [Image]) VALUES (18, N'Toán', N'Môn học Toán', CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), NULL, N'Active', CAST(N'2025-05-29T18:14:15.233' AS DateTime), 7, N'Grade.jpg')
INSERT [dbo].[KhoaHoc] ([ID_KhoaHoc], [TenKhoaHoc], [MoTa], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [TrangThai], [NgayTao], [ID_Khoi], [Image]) VALUES (19, N'Văn', N'Môn học Văn', CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), NULL, N'Active', CAST(N'2025-05-29T18:14:15.233' AS DateTime), 7, N'Grade.jpg')
INSERT [dbo].[KhoaHoc] ([ID_KhoaHoc], [TenKhoaHoc], [MoTa], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [TrangThai], [NgayTao], [ID_Khoi], [Image]) VALUES (20, N'Anh', N'Môn học Anh', CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), NULL, N'Active', CAST(N'2025-05-29T18:14:15.233' AS DateTime), 7, N'Grade.jpg')
INSERT [dbo].[KhoaHoc] ([ID_KhoaHoc], [TenKhoaHoc], [MoTa], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [TrangThai], [NgayTao], [ID_Khoi], [Image]) VALUES (21, N'Ngữ văn', N'Khóa học dành cho người mới bắt đầu học lập trình Java', CAST(N'2025-03-15' AS Date), CAST(N'2025-05-15' AS Date), N'Ghi chú ví dụ', N'active', CAST(N'2025-06-02T15:46:06.200' AS DateTime), 1, N'Grade.jpg')
SET IDENTITY_INSERT [dbo].[KhoaHoc] OFF
GO
SET IDENTITY_INSERT [dbo].[KhoiHoc] ON 

INSERT [dbo].[KhoiHoc] ([ID_Khoi], [TenKhoi], [Status_Khoi]) VALUES (1, N'Khối 6', 1)
INSERT [dbo].[KhoiHoc] ([ID_Khoi], [TenKhoi], [Status_Khoi]) VALUES (2, N'Khối 7', 1)
INSERT [dbo].[KhoiHoc] ([ID_Khoi], [TenKhoi], [Status_Khoi]) VALUES (3, N'Khối 8', 1)
INSERT [dbo].[KhoiHoc] ([ID_Khoi], [TenKhoi], [Status_Khoi]) VALUES (4, N'Khối 9', 1)
INSERT [dbo].[KhoiHoc] ([ID_Khoi], [TenKhoi], [Status_Khoi]) VALUES (5, N'Khối 10', 1)
INSERT [dbo].[KhoiHoc] ([ID_Khoi], [TenKhoi], [Status_Khoi]) VALUES (6, N'Khối 11', 1)
INSERT [dbo].[KhoiHoc] ([ID_Khoi], [TenKhoi], [Status_Khoi]) VALUES (7, N'Khối 12', 1)
SET IDENTITY_INSERT [dbo].[KhoiHoc] OFF
GO
SET IDENTITY_INSERT [dbo].[LichHoc] ON 

INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [GhiChu]) VALUES (1, CAST(N'2025-06-10' AS Date), 1, NULL, N'Lớp 10A1 học Toán')
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [GhiChu]) VALUES (2, CAST(N'2025-06-11' AS Date), 2, NULL, N'Lớp 11B1 học Văn')
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [GhiChu]) VALUES (7, CAST(N'2025-06-16' AS Date), 1, 1, N'Toán sáng thứ Hai')
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [GhiChu]) VALUES (8, CAST(N'2025-06-17' AS Date), 2, 1, N'Văn chiều thứ Ba')
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [GhiChu]) VALUES (9, CAST(N'2025-06-18' AS Date), 2, 2, N'Anh tối thứ Tư')
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [GhiChu]) VALUES (10, CAST(N'2025-06-19' AS Date), 1, 2, N'Toán sáng thứ Năm')
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [GhiChu]) VALUES (11, CAST(N'2025-06-20' AS Date), 2, 2, N'Văn chiều thứ Sáu')
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [GhiChu]) VALUES (12, CAST(N'2025-06-21' AS Date), 1, 2, N'Anh tối thứ Bảy')
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [GhiChu]) VALUES (13, CAST(N'2025-06-22' AS Date), 1, 2, N'Toán sáng Chủ nhật')
INSERT [dbo].[LichHoc] ([ID_Schedule], [NgayHoc], [ID_SlotHoc], [ID_LopHoc], [GhiChu]) VALUES (14, CAST(N'2025-06-16' AS Date), 2, 2, N'Văn sáng thứ Hai')
SET IDENTITY_INSERT [dbo].[LichHoc] OFF
GO
SET IDENTITY_INSERT [dbo].[LopHoc] ON 

INSERT [dbo].[LopHoc] ([ID_LopHoc], [TenLopHoc], [ID_KhoaHoc], [SiSo], [ID_Schedule], [GhiChu], [TrangThai], [SoTien], [NgayTao], [Image], [SiSoToiDa]) VALUES (1, N'Toán Nâng Cao', 1, 30, 1, N'Lớp dành cho người mới bắt đầu', N'Active', N'2,000,000 ', CAST(N'2025-05-24T18:28:39.920' AS DateTime), N'avatarTeacher.jpg', 40)
INSERT [dbo].[LopHoc] ([ID_LopHoc], [TenLopHoc], [ID_KhoaHoc], [SiSo], [ID_Schedule], [GhiChu], [TrangThai], [SoTien], [NgayTao], [Image], [SiSoToiDa]) VALUES (2, N'Văn Học Nâng Cao', 2, 26, 2, N'Lớp dành cho người mới bắt đầu', N'Active', N'2,000,000 ', CAST(N'2025-05-24T18:28:39.920' AS DateTime), N'avatarTeacher.jpg', 40)
INSERT [dbo].[LopHoc] ([ID_LopHoc], [TenLopHoc], [ID_KhoaHoc], [SiSo], [ID_Schedule], [GhiChu], [TrangThai], [SoTien], [NgayTao], [Image], [SiSoToiDa]) VALUES (3, N'Toán Cơ Bản', 1, 30, 1, N'Lớp dành cho người mới bắt đầu', N'Active', N'2,000,000 ', CAST(N'2025-05-29T12:44:53.693' AS DateTime), N'avatarTeacher.jpg', 40)
INSERT [dbo].[LopHoc] ([ID_LopHoc], [TenLopHoc], [ID_KhoaHoc], [SiSo], [ID_Schedule], [GhiChu], [TrangThai], [SoTien], [NgayTao], [Image], [SiSoToiDa]) VALUES (4, N'Văn Học Cơ Bản', 2, 30, 2, N'Lớp dành cho người mới bắt đầu', N'Active', N'2000000   ', CAST(N'2025-05-29T12:46:43.910' AS DateTime), N'avatarTeacher.jpg', 40)
INSERT [dbo].[LopHoc] ([ID_LopHoc], [TenLopHoc], [ID_KhoaHoc], [SiSo], [ID_Schedule], [GhiChu], [TrangThai], [SoTien], [NgayTao], [Image], [SiSoToiDa]) VALUES (5, N'Toán Học Cơ Bản', 3, NULL, 2, NULL, N'Active', N'2,000,000 ', CAST(N'2025-06-21T22:47:51.070' AS DateTime), N'avatarTeacher.jpg', 40)
SET IDENTITY_INSERT [dbo].[LopHoc] OFF
GO
INSERT [dbo].[NopBaiTap] ([ID_HocSinh], [ID_BaiTap], [TepNop], [NgayNop], [Diem], [NhanXet]) VALUES (1, 1, N'/nopbai/hs1_baitap1.pdf', CAST(N'2025-05-24' AS Date), CAST(9.00 AS Decimal(5, 2)), N'Hoàn thành tốt')
GO
SET IDENTITY_INSERT [dbo].[PhanLoaiBlog] ON 

INSERT [dbo].[PhanLoaiBlog] ([ID_PhanLoai], [PhanLoai]) VALUES (1, N'Toán Học')
INSERT [dbo].[PhanLoaiBlog] ([ID_PhanLoai], [PhanLoai]) VALUES (2, N'Văn Học')
INSERT [dbo].[PhanLoaiBlog] ([ID_PhanLoai], [PhanLoai]) VALUES (3, N'Tiếng Anh')
INSERT [dbo].[PhanLoaiBlog] ([ID_PhanLoai], [PhanLoai]) VALUES (4, N'Trung Tâm')
SET IDENTITY_INSERT [dbo].[PhanLoaiBlog] OFF
GO
SET IDENTITY_INSERT [dbo].[PhuHuynh] ON 

INSERT [dbo].[PhuHuynh] ([ID_PhuHuynh], [ID_TaiKhoan], [HoTen], [SDT], [Email], [DiaChi], [GhiChu], [ID_HocSinh], [TrangThai], [NgayTao]) VALUES (1, 5, N'Nguyễn Văn B', N'0900111222', N'phuhuynh1@example.com', N'Hà Nội', NULL, NULL, N'Active', CAST(N'2025-05-24T18:28:39.923' AS DateTime))
SET IDENTITY_INSERT [dbo].[PhuHuynh] OFF
GO
SET IDENTITY_INSERT [dbo].[Slider] ON 

INSERT [dbo].[Slider] ([ID_Slider], [Title], [Image], [BackLink]) VALUES (1, N'Tuyển Sinh Khóa Học Hè', N'Slider.png', N'a')
INSERT [dbo].[Slider] ([ID_Slider], [Title], [Image], [BackLink]) VALUES (2, N'Tiếp đà 2k9', N'Slider2.png', N'b')
SET IDENTITY_INSERT [dbo].[Slider] OFF
GO
SET IDENTITY_INSERT [dbo].[SlotHoc] ON 

INSERT [dbo].[SlotHoc] ([ID_SlotHoc], [SlotThoiGian]) VALUES (1, N'7:00 đến 9:00')
INSERT [dbo].[SlotHoc] ([ID_SlotHoc], [SlotThoiGian]) VALUES (2, N'9:00 đến 11:00')
SET IDENTITY_INSERT [dbo].[SlotHoc] OFF
GO
SET IDENTITY_INSERT [dbo].[Staff] ON 

INSERT [dbo].[Staff] ([ID_Staff], [ID_TaiKhoan], [HoTen], [Avatar]) VALUES (1, 2, N'Dam Quang Staff', N'avatarTeacher.jpg')
SET IDENTITY_INSERT [dbo].[Staff] OFF
GO
SET IDENTITY_INSERT [dbo].[TaiKhoan] ON 

INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (1, N'admin@example.com', N'trung123', 1, N'Admin', N'0123456789', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (2, N'staff1@example.com', N'hashedpass2', 2, N'Staff', N'0123987654', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (3, N'giaovien1@example.com', N'hashedpass3', 3, N'GiaoVien', N'0987654321', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (4, N'hocsinh1@example.com', N'hashedpass4', 4, N'HocSinh', N'0911222333', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (5, N'phuhuynh1@example.com', N'hashedpass5', 5, N'PhuHuynh', N'0900111222', N'Active', CAST(N'2025-05-24T18:28:39.917' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (7, N'nguyenvana@example.co', N'abc123xyz', 2, N'HocSinh', N'0912345678', N'Active', CAST(N'2025-05-26T09:45:43.293' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (9, N'nguyenvan2@example.com', N'matkhau123', 2, N'HocSinh', N'0987654321', N'Active', CAST(N'2025-05-26T10:05:53.633' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (10, N'lethi3@example.com', N'abc123xyz', 2, N'HocSinh', N'0912345678', N'Active', CAST(N'2025-05-26T10:05:53.633' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (11, N'trungdam1305@gmail.com', N'trung123', 3, N'GiaoVien', N'0972178865', N'Active', CAST(N'2025-05-29T10:18:31.363' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (17, N'hoangvm@gmail.com', N'password2', 3, N'GiaoVien', N'0923456789', N'Active', CAST(N'2025-05-29T12:06:42.720' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (18, N'dohuydo@gmail.com', N'password3', 3, N'GiaoVien', N'0934567890', N'Active', CAST(N'2025-05-29T12:06:42.720' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (19, N'dungnxt@gmail.com', N'password4', 3, N'GiaoVien', N'0945678901', N'Active', CAST(N'2025-05-29T12:06:42.720' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (22, N'vuvanchu3012@gmail.com', N'trung123', 4, N'HocSinh', N'0389549904', N'Inactive', CAST(N'2025-05-30T11:29:27.037' AS DateTime))
INSERT [dbo].[TaiKhoan] ([ID_TaiKhoan], [Email], [MatKhau], [ID_VaiTro], [UserType], [SoDienThoai], [TrangThai], [NgayTao]) VALUES (23, N'hdawng05@gmail.com', N'Trung123!', 4, N'HocSinh', N'0922929292', N'Inactive', CAST(N'2025-06-03T08:15:10.983' AS DateTime))
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
SET IDENTITY_INSERT [dbo].[TruongHoc] ON 

INSERT [dbo].[TruongHoc] ([ID_TruongHoc], [TenTruongHoc], [DiaChi]) VALUES (1, N'Trường THPT Hà Nội - Amsterdam', N'1. Hoàng Minh Giám, Trung Hòa, Cầu Giấy, Hà Nội')
INSERT [dbo].[TruongHoc] ([ID_TruongHoc], [TenTruongHoc], [DiaChi]) VALUES (2, N'Trường THPT Nguyễn Trãi - Ba Đình', N'50 P. Nam Cao, Giảng Võ, Ba Đình, Hà Nội')
INSERT [dbo].[TruongHoc] ([ID_TruongHoc], [TenTruongHoc], [DiaChi]) VALUES (3, N'Trường THPT Chuyên Chu Văn An', N'10 Đ. Thụy Khuê, Thuỵ Khuê, Tây Hồ, Hà Nội')
SET IDENTITY_INSERT [dbo].[TruongHoc] OFF
GO
SET IDENTITY_INSERT [dbo].[UserLogs] ON 

INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1, 1, N'Đăng nhập hệ thống', CAST(N'2025-05-24T18:28:39.937' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (2, 3, N'Tải tài liệu Toán Đại số', CAST(N'2025-05-24T18:28:39.937' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (3, 1, N'Đăng nhập hệ thống', CAST(N'2025-05-29T23:03:28.017' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (4, 2, N'Đăng nhập hệ thống', CAST(N'2025-05-29T23:03:45.803' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (5, 2, N'Đăng nhập hệ thống', CAST(N'2025-05-29T23:04:04.253' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (6, 2, N'Đăng nhập hệ thống', CAST(N'2025-05-29T23:06:09.227' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (7, 1, N'Đăng nhập hệ thống', CAST(N'2025-05-29T23:19:10.093' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (8, 1, N'Đăng nhập hệ thống', CAST(N'2025-05-29T23:20:39.917' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (9, 1, N'Đăng nhập hệ thống', CAST(N'2025-05-29T23:29:35.543' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (10, 1, N'Đăng nhập hệ thống', CAST(N'2025-05-29T23:31:38.467' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (11, 1, N'Đăng nhập hệ thống', CAST(N'2025-05-29T23:33:55.073' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (12, 1, N'Đăng nhập hệ thống', CAST(N'2025-05-29T23:34:50.590' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (13, 1, N'Đăng nhập hệ thống', CAST(N'2025-05-29T23:35:10.257' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (14, 1, N'Đăng nhập hệ thống', CAST(N'2025-05-29T23:54:41.357' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (15, 1, N'Đăng nhập hệ thống', CAST(N'2025-05-30T00:10:30.767' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (16, 1, N'Đăng nhập hệ thống', CAST(N'2025-05-30T00:11:43.860' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (17, 1, N'Đăng nhập hệ thống', CAST(N'2025-05-30T07:25:20.733' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (18, 1, N'Đăng nhập hệ thống', CAST(N'2025-05-30T07:26:39.023' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (19, 1, N'Đăng nhập hệ thống', CAST(N'2025-05-30T07:34:08.100' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (20, 1, N'Đăng nhập hệ thống', CAST(N'2025-05-30T10:00:53.090' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (21, 1, N'Đăng nhập hệ thống', CAST(N'2025-05-30T10:06:15.093' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (22, 1, N'Đăng nhập hệ thống', CAST(N'2025-05-30T10:06:41.683' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (23, 1, N'Đăng nhập hệ thống', CAST(N'2025-05-30T10:10:11.287' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (24, 1, N'Đăng nhập hệ thống', CAST(N'2025-05-30T11:00:06.213' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (25, 1, N'Đăng nhập hệ thống', CAST(N'2025-05-30T11:09:20.783' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (26, 1, N'Đăng nhập hệ thống', CAST(N'2025-05-30T11:13:28.353' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (27, 1, N'Đăng nhập hệ thống', CAST(N'2025-05-30T11:25:59.137' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (28, 11, N'Đăng nhập hệ thống', CAST(N'2025-05-30T11:27:47.433' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (29, 1, N'Đăng nhập hệ thống', CAST(N'2025-05-30T11:30:17.287' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (30, 1, N'Đăng nhập hệ thống', CAST(N'2025-06-02T21:47:24.270' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (31, 1, N'Đăng nhập hệ thống', CAST(N'2025-06-03T01:41:20.493' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (32, 1, N'Đăng nhập hệ thống', CAST(N'2025-06-03T01:47:35.090' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (33, 1, N'Đăng nhập hệ thống', CAST(N'2025-06-03T07:24:19.033' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (34, 1, N'Đăng nhập hệ thống', CAST(N'2025-06-03T07:53:10.830' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (35, 1, N'Đăng nhập hệ thống', CAST(N'2025-06-03T08:49:55.430' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (36, 1, N'Đăng nhập hệ thống', CAST(N'2025-06-05T02:02:37.057' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (37, 1, N'Đăng nhập hệ thống', CAST(N'2025-06-05T02:26:28.387' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (38, 1, N'Đăng nhập hệ thống', CAST(N'2025-06-05T11:17:54.980' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (39, 1, N'Đăng nhập hệ thống', CAST(N'2025-06-11T21:04:21.733' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (40, 1, N'Đăng nhập hệ thống', CAST(N'2025-06-11T21:11:24.313' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (41, 1, N'Đăng nhập hệ thống', CAST(N'2025-06-13T10:12:58.677' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (42, 1, N'Đăng nhập hệ thống', CAST(N'2025-06-13T10:14:11.723' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (43, 1, N'Đăng nhập hệ thống', CAST(N'2025-06-13T10:50:56.940' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (44, 1, N'Đăng nhập hệ thống', CAST(N'2025-06-16T11:53:12.387' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (45, 1, N'Đăng nhập hệ thống', CAST(N'2025-06-16T16:15:16.870' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (46, 1, N'Đăng nhập hệ thống', CAST(N'2025-06-17T08:37:58.670' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (47, 1, N'Đăng nhập hệ thống', CAST(N'2025-06-17T21:33:31.327' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (48, 1, N'Đăng nhập hệ thống', CAST(N'2025-06-18T08:53:42.617' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1048, 1, N'Đăng nhập hệ thống', CAST(N'2025-06-20T11:05:04.403' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1049, 1, N'Đăng nhập hệ thống', CAST(N'2025-06-20T22:54:25.487' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1050, 1, N'Đăng nhập hệ thống', CAST(N'2025-06-21T09:08:49.403' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1051, 1, N'Đăng nhập hệ thống', CAST(N'2025-06-21T13:31:38.720' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1052, 1, N'Đăng nhập hệ thống', CAST(N'2025-06-21T19:28:31.793' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1053, 1, N'Đăng nhập hệ thống', CAST(N'2025-06-21T19:33:50.380' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1054, 1, N'Đăng nhập hệ thống', CAST(N'2025-06-21T19:40:00.237' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1055, 1, N'Đăng nhập hệ thống', CAST(N'2025-06-21T19:41:10.737' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1056, 11, N'Đăng nhập hệ thống', CAST(N'2025-06-21T19:56:14.240' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1057, 11, N'Đăng nhập hệ thống', CAST(N'2025-06-21T19:57:01.930' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1058, 11, N'Đăng nhập hệ thống', CAST(N'2025-06-21T20:14:01.260' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1059, 11, N'Đăng nhập hệ thống', CAST(N'2025-06-21T21:48:47.970' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1060, 11, N'Đăng nhập hệ thống', CAST(N'2025-06-21T22:08:34.953' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1061, 11, N'Đăng nhập hệ thống', CAST(N'2025-06-21T22:08:36.757' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1062, 11, N'Đăng nhập hệ thống', CAST(N'2025-06-21T22:18:47.073' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1063, 11, N'Đăng nhập hệ thống', CAST(N'2025-06-21T22:20:55.367' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1064, 11, N'Đăng nhập hệ thống', CAST(N'2025-06-21T22:54:32.213' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1065, 11, N'Đăng nhập hệ thống', CAST(N'2025-06-21T23:04:57.670' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1066, 11, N'Đăng nhập hệ thống', CAST(N'2025-06-21T23:15:40.760' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1067, 11, N'Đăng nhập hệ thống', CAST(N'2025-06-21T23:17:58.877' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1068, 11, N'Đăng nhập hệ thống', CAST(N'2025-06-22T10:58:04.230' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1069, 11, N'Đăng nhập hệ thống', CAST(N'2025-06-22T10:59:23.373' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1070, 11, N'Đăng nhập hệ thống', CAST(N'2025-06-22T10:59:36.433' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1071, 11, N'Đăng nhập hệ thống', CAST(N'2025-06-22T11:40:17.300' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1072, 11, N'Đăng nhập hệ thống', CAST(N'2025-06-22T11:43:01.067' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1073, 11, N'Đăng nhập hệ thống', CAST(N'2025-06-22T11:44:29.433' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1074, 11, N'Đăng nhập hệ thống', CAST(N'2025-06-22T11:44:59.697' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1075, 11, N'Đăng nhập hệ thống', CAST(N'2025-06-22T11:45:26.280' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1076, 11, N'Đăng nhập hệ thống', CAST(N'2025-06-22T12:34:47.517' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1077, 11, N'Đăng nhập hệ thống', CAST(N'2025-06-22T13:20:32.473' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1078, 11, N'Đăng nhập hệ thống', CAST(N'2025-06-22T13:25:31.903' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1079, 11, N'Đăng nhập hệ thống', CAST(N'2025-06-22T13:29:39.713' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1080, 11, N'Đăng nhập hệ thống', CAST(N'2025-06-22T13:30:22.037' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1081, 11, N'Đăng nhập hệ thống', CAST(N'2025-06-22T14:14:29.223' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1082, 1, N'Đăng nhập hệ thống', CAST(N'2025-06-22T14:22:30.720' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1083, 1, N'Đăng nhập hệ thống', CAST(N'2025-06-22T14:22:47.167' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1084, 1, N'Đăng nhập hệ thống', CAST(N'2025-06-22T14:23:25.437' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1085, 11, N'Đăng nhập hệ thống', CAST(N'2025-06-22T14:30:51.053' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1086, 11, N'Đăng nhập hệ thống', CAST(N'2025-06-22T14:37:49.040' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1087, 11, N'Đăng nhập hệ thống', CAST(N'2025-06-23T21:24:02.853' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1088, 11, N'Đăng nhập hệ thống', CAST(N'2025-06-23T21:24:04.877' AS DateTime))
INSERT [dbo].[UserLogs] ([ID_Log], [ID_TaiKhoan], [HanhDong], [ThoiGian]) VALUES (1089, 11, N'Đăng nhập hệ thống', CAST(N'2025-06-23T21:44:50.083' AS DateTime))
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
/****** Object:  Index [UQ__GiaoVien__0E3EC21155FF47C9]    Script Date: 23/06/2025 10:56:22 CH ******/
ALTER TABLE [dbo].[GiaoVien] ADD  CONSTRAINT [UQ__GiaoVien__0E3EC21155FF47C9] UNIQUE NONCLUSTERED 
(
	[ID_TaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__HocSinh__0E3EC211F37A45BA]    Script Date: 23/06/2025 10:56:22 CH ******/
ALTER TABLE [dbo].[HocSinh] ADD  CONSTRAINT [UQ__HocSinh__0E3EC211F37A45BA] UNIQUE NONCLUSTERED 
(
	[ID_TaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__PhuHuynh__0E3EC21165FFAC30]    Script Date: 23/06/2025 10:56:22 CH ******/
ALTER TABLE [dbo].[PhuHuynh] ADD  CONSTRAINT [UQ__PhuHuynh__0E3EC21165FFAC30] UNIQUE NONCLUSTERED 
(
	[ID_TaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__TaiKhoan__A9D1053431F3E0F9]    Script Date: 23/06/2025 10:56:22 CH ******/
ALTER TABLE [dbo].[TaiKhoan] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DangKyLopHoc] ADD  DEFAULT (getdate()) FOR [NgayDangKy]
GO
ALTER TABLE [dbo].[DangTaiLieu] ADD  CONSTRAINT [DF__DangTaiLi__NgayT__5EBF139D]  DEFAULT (getdate()) FOR [NgayTao]
GO
ALTER TABLE [dbo].[Diem] ADD  DEFAULT (getdate()) FOR [ThoiGianCapNhat]
GO
ALTER TABLE [dbo].[GiaoVien] ADD  CONSTRAINT [DF__GiaoVien__TrangT__60A75C0F]  DEFAULT ('Active') FOR [TrangThai]
GO
ALTER TABLE [dbo].[GiaoVien] ADD  CONSTRAINT [DF__GiaoVien__NgayTa__619B8048]  DEFAULT (getdate()) FOR [NgayTao]
GO
ALTER TABLE [dbo].[HocSinh] ADD  CONSTRAINT [DF__HocSinh__TrangTh__628FA481]  DEFAULT ('Active') FOR [TrangThai]
GO
ALTER TABLE [dbo].[HocSinh] ADD  CONSTRAINT [DF__HocSinh__NgayTao__6383C8BA]  DEFAULT (getdate()) FOR [NgayTao]
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
ALTER TABLE [dbo].[Admin]  WITH CHECK ADD  CONSTRAINT [FK_Admin_TaiKhoan] FOREIGN KEY([ID_TaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([ID_TaiKhoan])
GO
ALTER TABLE [dbo].[Admin] CHECK CONSTRAINT [FK_Admin_TaiKhoan]
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
ALTER TABLE [dbo].[DangKyLopHoc]  WITH CHECK ADD  CONSTRAINT [FK__DangKyKho__ID_Ho__71D1E811] FOREIGN KEY([ID_HocSinh])
REFERENCES [dbo].[HocSinh] ([ID_HocSinh])
GO
ALTER TABLE [dbo].[DangKyLopHoc] CHECK CONSTRAINT [FK__DangKyKho__ID_Ho__71D1E811]
GO
ALTER TABLE [dbo].[DangKyLopHoc]  WITH CHECK ADD  CONSTRAINT [FK_DangKyLopHoc_LopHoc] FOREIGN KEY([ID_LopHoc])
REFERENCES [dbo].[LopHoc] ([ID_LopHoc])
GO
ALTER TABLE [dbo].[DangKyLopHoc] CHECK CONSTRAINT [FK_DangKyLopHoc_LopHoc]
GO
ALTER TABLE [dbo].[DangTaiLieu]  WITH CHECK ADD  CONSTRAINT [FK__DangTaiLi__ID_Gi__73BA3083] FOREIGN KEY([ID_GiaoVien])
REFERENCES [dbo].[GiaoVien] ([ID_GiaoVien])
GO
ALTER TABLE [dbo].[DangTaiLieu] CHECK CONSTRAINT [FK__DangTaiLi__ID_Gi__73BA3083]
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
ALTER TABLE [dbo].[GiaoVien]  WITH CHECK ADD  CONSTRAINT [FK__GiaoVien__ID_Tai__787EE5A0] FOREIGN KEY([ID_TaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([ID_TaiKhoan])
GO
ALTER TABLE [dbo].[GiaoVien] CHECK CONSTRAINT [FK__GiaoVien__ID_Tai__787EE5A0]
GO
ALTER TABLE [dbo].[GiaoVien]  WITH CHECK ADD  CONSTRAINT [FK_GiaoVien_TruongHoc] FOREIGN KEY([ID_TruongHoc])
REFERENCES [dbo].[TruongHoc] ([ID_TruongHoc])
GO
ALTER TABLE [dbo].[GiaoVien] CHECK CONSTRAINT [FK_GiaoVien_TruongHoc]
GO
ALTER TABLE [dbo].[GiaoVien_LopHoc]  WITH CHECK ADD  CONSTRAINT [FK__GiaoVien___ID_Gi__797309D9] FOREIGN KEY([ID_GiaoVien])
REFERENCES [dbo].[GiaoVien] ([ID_GiaoVien])
GO
ALTER TABLE [dbo].[GiaoVien_LopHoc] CHECK CONSTRAINT [FK__GiaoVien___ID_Gi__797309D9]
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
ALTER TABLE [dbo].[HocSinh_PhuHuynh]  WITH CHECK ADD  CONSTRAINT [FK__HocSinh_P__ID_Ho__7E37BEF6] FOREIGN KEY([ID_HocSinh])
REFERENCES [dbo].[HocSinh] ([ID_HocSinh])
GO
ALTER TABLE [dbo].[HocSinh_PhuHuynh] CHECK CONSTRAINT [FK__HocSinh_P__ID_Ho__7E37BEF6]
GO
ALTER TABLE [dbo].[HocSinh_PhuHuynh]  WITH CHECK ADD  CONSTRAINT [FK__HocSinh_P__ID_Ph__7F2BE32F] FOREIGN KEY([ID_PhuHuynh])
REFERENCES [dbo].[PhuHuynh] ([ID_PhuHuynh])
GO
ALTER TABLE [dbo].[HocSinh_PhuHuynh] CHECK CONSTRAINT [FK__HocSinh_P__ID_Ph__7F2BE32F]
GO
ALTER TABLE [dbo].[HoTro]  WITH CHECK ADD FOREIGN KEY([ID_TaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([ID_TaiKhoan])
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
ALTER TABLE [dbo].[LichHoc]  WITH CHECK ADD  CONSTRAINT [FK_LichHoc_SlotHoc] FOREIGN KEY([ID_SlotHoc])
REFERENCES [dbo].[SlotHoc] ([ID_SlotHoc])
GO
ALTER TABLE [dbo].[LichHoc] CHECK CONSTRAINT [FK_LichHoc_SlotHoc]
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
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD  CONSTRAINT [FK_Staff_TaiKhoan] FOREIGN KEY([ID_TaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([ID_TaiKhoan])
GO
ALTER TABLE [dbo].[Staff] CHECK CONSTRAINT [FK_Staff_TaiKhoan]
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
