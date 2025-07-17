-- Index cho ID_GiaoVien trong GiaoVien_LopHoc (nếu chưa có, vì đây là PK composite nhưng index riêng giúp COUNT nhanh)
CREATE NONCLUSTERED INDEX IDX_GiaoVien_LopHoc_ID_GiaoVien ON [dbo].[GiaoVien_LopHoc] (ID_GiaoVien);

-- Index cho ID_GiaoVien trong GiaoVien
CREATE NONCLUSTERED INDEX IDX_GiaoVien_ID_GiaoVien ON [dbo].[GiaoVien] (ID_GiaoVien);