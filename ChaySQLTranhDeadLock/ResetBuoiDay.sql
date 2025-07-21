ALTER PROCEDURE [dbo].[ResetSoBuoiDay]
    @NgayHienTai date
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Kiểm tra nếu là ngày 15 (hoặc có thể gọi thủ công)
    -- IF DAY(@NgayHienTai) = 15  -- Bỏ comment nếu chỉ chạy tự động ngày 15
    
    DECLARE @ChuKyBatDau date = DATEADD(MONTH, -1, DATEFROMPARTS(YEAR(@NgayHienTai), MONTH(@NgayHienTai), 15));
    DECLARE @ChuKyKetThuc date = DATEADD(DAY, -1, @NgayHienTai);
    
    -- Tính lương cho từng giáo viên, nhóm theo lớp
    INSERT INTO [dbo].[LuongGiaoVien] 
        (ID_GiaoVien, ID_LopHoc, ChuKyBatDau, ChuKyKetThuc, SoBuoiDay, LuongDuTinh, TrangThai, NgayCapNhat)
    SELECT 
        glh.ID_GiaoVien,
        glh.ID_LopHoc,
        @ChuKyBatDau,
        @ChuKyKetThuc,
        COUNT(lh.ID_Schedule) AS SoBuoiDay,
        (COUNT(lh.ID_Schedule) * CAST(l.SoTien AS DECIMAL(10,2))) * 0.7 AS LuongDuTinh,  -- Công thức: buổi * SoTien * 70%
        'Pending',
        GETDATE()
    FROM [dbo].[GiaoVien_LopHoc] glh
    LEFT JOIN [dbo].[LichHoc] lh ON glh.ID_LopHoc = lh.ID_LopHoc
    JOIN [dbo].[LopHoc] l ON glh.ID_LopHoc = l.ID_LopHoc
    WHERE lh.NgayHoc BETWEEN @ChuKyBatDau AND @ChuKyKetThuc
    GROUP BY glh.ID_GiaoVien, glh.ID_LopHoc, l.SoTien;
    
    -- Reset số buổi dạy nếu cần (sau khi tính, nhưng chỉ reset khi thanh toán - xử lý ở servlet)
    -- END  -- Bỏ comment nếu dùng IF
END
GO