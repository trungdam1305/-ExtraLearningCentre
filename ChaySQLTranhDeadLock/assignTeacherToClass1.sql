-- Đảm bảo không có connection khác đang dùng DB (đóng tất cả connection)
ALTER DATABASE SSS SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

-- Enable option
ALTER DATABASE SSS SET READ_COMMITTED_SNAPSHOT ON;
GO

-- Trở về multi-user
ALTER DATABASE SSS SET MULTI_USER;
GO