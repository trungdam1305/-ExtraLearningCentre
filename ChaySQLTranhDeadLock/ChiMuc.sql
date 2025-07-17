-- Chỉ mục cho bảng GiaoVien
CREATE NONCLUSTERED INDEX idx_giaovien_id_trangthai ON GiaoVien (ID_GiaoVien, TrangThai, TrangThaiDay);

-- Chỉ mục cho bảng LichHoc
CREATE NONCLUSTERED INDEX idx_lichhoc_id_lophoc_ngayhoc ON LichHoc (ID_LopHoc, NgayHoc, ID_SlotHoc);

-- Chỉ mục cho bảng GiaoVien_LopHoc
CREATE NONCLUSTERED INDEX idx_giaovien_lophoc ON GiaoVien_LopHoc (ID_GiaoVien, ID_LopHoc);

-- Chỉ mục cho bảng SlotHoc
CREATE NONCLUSTERED INDEX idx_slot_hoc ON SlotHoc (ID_SlotHoc);