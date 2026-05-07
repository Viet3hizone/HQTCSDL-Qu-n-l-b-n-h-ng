CREATE DATABASE QLCuaHangNike;
GO
USE QLCuaHangNike;
GO

CREATE DATABASE QLCuaHangNike;
GO
USE QLCuaHangNike;
GO

-- 1. Bảng Kích Cỡ
CREATE TABLE KICHCO (
    MaSize VARCHAR(10) PRIMARY KEY,
    TenSize NVARCHAR(50) NOT NULL,
    MoTa NVARCHAR(255),
    TrangThai BIT DEFAULT 1
);

-- 2. Bảng Màu Sắc
CREATE TABLE MAUSAC (
    MaMau VARCHAR(10) PRIMARY KEY,
    TenMau NVARCHAR(50) NOT NULL,
    MaHex VARCHAR(10),
    TrangThai BIT DEFAULT 1
);

-- 3. Bảng Loại Sản Phẩm
CREATE TABLE LOAISP (
    MaLSP VARCHAR(10) PRIMARY KEY,
    TenLSP NVARCHAR(100) NOT NULL,
    MoTa NVARCHAR(MAX),
    TrangThai BIT DEFAULT 1
);

-- 4. Bảng Nhà Cung Cấp
CREATE TABLE NHACUNGCAP (
    MaNCC VARCHAR(10) PRIMARY KEY,
    TenNCC NVARCHAR(100) NOT NULL,
    DiaChi NVARCHAR(255),
    SDT VARCHAR(15),
    Email VARCHAR(100),
    NguoiDaiDien NVARCHAR(100),
    Website VARCHAR(100),
    TrangThai BIT DEFAULT 1
);

-- 5. Bảng Khuyến Mãi
CREATE TABLE KHUYENMAI (
    MaKM VARCHAR(10) PRIMARY KEY,
    TenKM NVARCHAR(100) NOT NULL,
    LoaiKhuyenMai NVARCHAR(50), 
    PhanTramGiam FLOAT, 
    GiaTriToiDa DECIMAL(18,2),
    MoTa NVARCHAR(MAX),
    NgayBatDau DATE,
    NgayKetThuc DATE,
    TrangThai BIT DEFAULT 1
);

-- 6. Bảng Khách Hàng
CREATE TABLE KHACHHANG (
    MaKH VARCHAR(10) PRIMARY KEY,
    HoTen NVARCHAR(100) NOT NULL,
    NgaySinh DATE,
    GioiTinh NVARCHAR(10),
    Email VARCHAR(100) UNIQUE,
    SDT VARCHAR(15),
    DiaChi NVARCHAR(255),
    MatKhau VARCHAR(50) NOT NULL,
    NgayDangKy DATE DEFAULT GETDATE(),
    DiemTichLuy INT DEFAULT 0,
    TrangThai BIT DEFAULT 1
);

-- 7. Bảng Nhân Viên
CREATE TABLE NHANVIEN (
    MaNV VARCHAR(10) PRIMARY KEY,
    HoTen NVARCHAR(100) NOT NULL,
    NgaySinh DATE,
    GioiTinh NVARCHAR(10),
    SDT VARCHAR(15),
    Email VARCHAR(100) UNIQUE,
    DiaChi NVARCHAR(255),
    MatKhau VARCHAR(50) NOT NULL,
    QuyenSuDung INT, 
    NgayVaoLam DATE DEFAULT GETDATE(),
    TrangThai BIT DEFAULT 1
);

-- 8. Bảng Sản Phẩm
CREATE TABLE SANPHAM (
    MaSP VARCHAR(10) PRIMARY KEY,
    TenSP NVARCHAR(100) NOT NULL,
    MoTa NVARCHAR(MAX),
    DonViTinh NVARCHAR(50),
    AnhSP VARCHAR(255),
    ThuongHieu NVARCHAR(100) DEFAULT 'Nike',
    ChatLieu NVARCHAR(100),
    GioiTinh NVARCHAR(20), 
    DoiTuongSuDung NVARCHAR(50),
    MaLSP VARCHAR(10),
    MaNCC VARCHAR(10),
    NgayTao DATE DEFAULT GETDATE(),
    TrangThai BIT DEFAULT 1,
    FOREIGN KEY (MaLSP) REFERENCES LOAISP(MaLSP),
    FOREIGN KEY (MaNCC) REFERENCES NHACUNGCAP(MaNCC)
);

-- 9. Bảng Chi Tiết Sản Phẩm
CREATE TABLE CHITIET_SANPHAM (
    MaCTSP VARCHAR(15) PRIMARY KEY,
    MaSP VARCHAR(10),
    MaMau VARCHAR(10),
    MaSize VARCHAR(10),
    SKU VARCHAR(50) UNIQUE,
    GiaNhap DECIMAL(18, 2),
    GiaBan DECIMAL(18, 2),
    SoLuongTon INT CHECK (SoLuongTon >= 0),
    HinhAnhChiTiet VARCHAR(255),
    TrangThai BIT DEFAULT 1,
    FOREIGN KEY (MaSP) REFERENCES SANPHAM(MaSP),
    FOREIGN KEY (MaMau) REFERENCES MAUSAC(MaMau),
    FOREIGN KEY (MaSize) REFERENCES KICHCO(MaSize)
);

-- 10. Bảng Hóa Đơn 
CREATE TABLE HOADON (
    SoHD VARCHAR(10) PRIMARY KEY,
    NgayDat DATE,
    NgayGiao DATE,
    MaKH VARCHAR(10),
    MaNVDuyet VARCHAR(10),
    MaNVGiao VARCHAR(10),
    MaKM VARCHAR(10),
    TinhTrang INT, 
    TongTien DECIMAL(18, 2),
    PhiVanChuyen DECIMAL(18, 2) DEFAULT 0,
    GiamGia DECIMAL(18, 2) DEFAULT 0,
    PhuongThucThanhToan NVARCHAR(50),
    DiaChiGiaoHang NVARCHAR(255),
    GhiChu NVARCHAR(MAX),
    FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH),
    FOREIGN KEY (MaNVDuyet) REFERENCES NHANVIEN(MaNV),
    FOREIGN KEY (MaNVGiao) REFERENCES NHANVIEN(MaNV),
    FOREIGN KEY (MaKM) REFERENCES KHUYENMAI(MaKM)
);

-- 11. Bảng Chi Tiết Hóa Đơn
CREATE TABLE CHITIET_HD (
    SoHD VARCHAR(10),
    MaCTSP VARCHAR(15),
    SoLuong INT CHECK (SoLuong > 0),
    DonGiaBan DECIMAL(18, 2),
    ThanhTien DECIMAL(18, 2),
    GiamGia DECIMAL(18, 2) DEFAULT 0,
    TrangThaiTraHang BIT DEFAULT 0,
    PRIMARY KEY (SoHD, MaCTSP),
    FOREIGN KEY (SoHD) REFERENCES HOADON(SoHD),
    FOREIGN KEY (MaCTSP) REFERENCES CHITIET_SANPHAM(MaCTSP)
);

-- 12. Bảng Phiếu Nhập
CREATE TABLE PHIEUNHAP (
    MaPN VARCHAR(10) PRIMARY KEY,
    MaNCC VARCHAR(10),
    MaNV VARCHAR(10),
    NgayNhap DATE DEFAULT GETDATE(),
    TongTien DECIMAL(18,2),
    GhiChu NVARCHAR(MAX),
    TrangThai BIT DEFAULT 1,
    FOREIGN KEY (MaNCC) REFERENCES NHACUNGCAP(MaNCC),
    FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV)
);

-- 13. Bảng Chi Tiết Phiếu Nhập
CREATE TABLE CHITIET_PHIEUNHAP (
    MaPN VARCHAR(10),
    MaCTSP VARCHAR(15),
    SoLuong INT CHECK (SoLuong > 0),
    GiaNhap DECIMAL(18,2),
    ThanhTien DECIMAL(18,2),
    PRIMARY KEY (MaPN, MaCTSP),
    FOREIGN KEY (MaPN) REFERENCES PHIEUNHAP(MaPN),
    FOREIGN KEY (MaCTSP) REFERENCES CHITIET_SANPHAM(MaCTSP)
);

-- 14. Bảng Thanh Toán
CREATE TABLE THANHTOAN (
    MaTT VARCHAR(10) PRIMARY KEY,
    SoHD VARCHAR(10),
    NgayThanhToan DATE DEFAULT GETDATE(),
    SoTien DECIMAL(18,2),
    PhuongThuc NVARCHAR(50),
    TrangThai BIT DEFAULT 1,
    FOREIGN KEY (SoHD) REFERENCES HOADON(SoHD)
);

-- 15. Bảng Vận Chuyển
CREATE TABLE VANCHUYEN (
    MaVC VARCHAR(10) PRIMARY KEY,
    SoHD VARCHAR(10),
    DonViVanChuyen NVARCHAR(100),
    MaVanDon VARCHAR(50),
    NgayGui DATE,
    NgayNhan DATE,
    TrangThai NVARCHAR(50),
    FOREIGN KEY (SoHD) REFERENCES HOADON(SoHD)
);

-- 16. Bảng Đánh Giá Sản Phẩm
CREATE TABLE DANHGIASANPHAM (
    MaDG VARCHAR(10) PRIMARY KEY,
    MaKH VARCHAR(10),
    MaSP VARCHAR(10),
    SoSao INT CHECK (SoSao BETWEEN 1 AND 5),
    NoiDung NVARCHAR(MAX),
    NgayDanhGia DATE DEFAULT GETDATE(),
    TrangThai BIT DEFAULT 1,
    FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH),
    FOREIGN KEY (MaSP) REFERENCES SANPHAM(MaSP)
);

-- 17. Bảng Trả Hàng
CREATE TABLE TRAHANG (
    MaTra VARCHAR(10) PRIMARY KEY,
    SoHD VARCHAR(10),
    MaKH VARCHAR(10),
    NgayTra DATE DEFAULT GETDATE(),
    LyDo NVARCHAR(MAX),
    TongTienHoan DECIMAL(18,2),
    TrangThai NVARCHAR(50),
    FOREIGN KEY (SoHD) REFERENCES HOADON(SoHD),
    FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH)
);

-- 18. Bảng Chi Tiết Trả Hàng
CREATE TABLE CHITIET_TRAHANG (
    MaTra VARCHAR(10),
    MaCTSP VARCHAR(15),
    SoLuong INT CHECK (SoLuong > 0),
    DonGia DECIMAL(18,2),
    ThanhTien DECIMAL(18,2),
    PRIMARY KEY (MaTra, MaCTSP),
    FOREIGN KEY (MaTra) REFERENCES TRAHANG(MaTra),
    FOREIGN KEY (MaCTSP) REFERENCES CHITIET_SANPHAM(MaCTSP)
);
GO

INSERT INTO KICHCO (MaSize, TenSize, MoTa) VALUES 
('S39', 'Size 39', '24.5 cm'), ('S40', 'Size 40', '25 cm'), ('S41', 'Size 41', '26 cm'),
('M', 'Size M', 'Áo Quần M'), ('L', 'Size L', 'Áo Quần L');

INSERT INTO MAUSAC (MaMau, TenMau, MaHex) VALUES 
('M01', N'Trắng', '#FFFFFF'), ('M02', N'Đen', '#000000'), ('M03', N'Đỏ', '#FF0000');

INSERT INTO LOAISP (MaLSP, TenLSP, MoTa) VALUES 
('LSP01', N'Nike Air Max', N'Dòng giày đế Air huyền thoại'), 
('LSP02', N'Nike Jordan', N'Dòng giày bóng rổ nổi tiếng'),
('LSP03', N'Quần áo tập', N'Đồ thể thao chuyên dụng');

INSERT INTO NHACUNGCAP (MaNCC, TenNCC, DiaChi, NguoiDaiDien, TrangThai) VALUES 
('NCC01', N'Nike Vietnam Factory', N'KCN Amata, Đồng Nai', N'Nguyễn Văn A', 1),
('NCC02', N'ACFC Việt Nam', N'Quận 1, TP.HCM', N'Lê Thị B', 1);

INSERT INTO SANPHAM (MaSP, TenSP, ChatLieu, GioiTinh, MaLSP, MaNCC) VALUES 
('SP01', N'Air Max 270', N'Mesh/Rubber', N'Unisex', 'LSP01', 'NCC01'),
('SP02', N'Jordan 1 High OG', N'Leather', N'Nam', 'LSP02', 'NCC02'),
('SP10', N'Áo Nike Dri-FIT', N'Polyester', N'Nam', 'LSP03', 'NCC01');

INSERT INTO CHITIET_SANPHAM (MaCTSP, MaSP, MaMau, MaSize, SKU, GiaNhap, GiaBan, SoLuongTon) VALUES 
('CT01', 'SP01', 'M01', 'S40', 'AM270-W-40', 3000000, 4500000, 50),
('CT02', 'SP01', 'M02', 'S41', 'AM270-B-41', 3000000, 4500000, 30),
('CT03', 'SP02', 'M03', 'S41', 'JD1-R-41', 3500000, 5200000, 20),
('CT04', 'SP10', 'M02', 'M', 'DRI-B-M', 400000, 850000, 100);

INSERT INTO KHUYENMAI (MaKM, TenKM, LoaiKhuyenMai, PhanTramGiam) VALUES 
('KM01', N'Khai trương', N'GiamTheoPhanTram', 0.2),
('KM02', N'Lễ Tết', N'GiamTheoPhanTram', 0.15);

INSERT INTO KHACHHANG (MaKH, HoTen, Email, MatKhau, DiaChi, NgaySinh) VALUES 
('KH01', N'Nguyễn Văn An', 'an@gmail.com', 'pass', N'Trần Phú, Nha Trang', '2000-01-01'),
('KH02', N'Lê Thị Bình', 'binh@gmail.com', 'pass', N'Lê Thánh Tôn, Nha Trang', '1998-05-05');

INSERT INTO NHANVIEN (MaNV, HoTen, Email, MatKhau, QuyenSuDung) VALUES 
('NV01', N'Châu Quốc Cường', 'cuong.cq@nike.vn', 'admin123', 2),
('NV06', N'Phạm Hải Nam', 'nam.ph@nike.vn', 'ship01', 0);

INSERT INTO HOADON (SoHD, NgayDat, MaKH, MaNVDuyet, MaKM, TinhTrang, TongTien) VALUES 
('HD01', '2026-01-05', 'KH01', 'NV01', 'KM01', 2, 8160000); 

INSERT INTO CHITIET_HD (SoHD, MaCTSP, SoLuong, DonGiaBan, ThanhTien) VALUES 
('HD01', 'CT01', 1, 4500000, 4500000), 
('HD01', 'CT04', 2, 850000, 1700000);
GO

--Yêu cầu 3: Tạo 40 câu truy vấn

-- a. Truy vấn đơn giản: 5 câu

-- 1. Lấy danh sách tất cả sản phẩm đang kinh doanh
SELECT S.MaSP, S.TenSP, C.SKU, C.GiaBan, C.SoLuongTon 
FROM SANPHAM S JOIN CHITIET_SANPHAM C ON S.MaSP = C.MaSP;

-- 2. Lấy thông tin khách hàng sinh sống ở khu vực Nha Trang
SELECT MaKH, HoTen, SDT, DiaChi 
FROM KHACHHANG WHERE DiaChi LIKE N'%Nha Trang%';

-- 3. Liệt kê phiên bản sản phẩm có giá bán trên 1,000,000 VNĐ, sắp xếp giá giảm dần
SELECT C.MaCTSP, S.TenSP, C.GiaBan, M.TenMau, K.TenSize 
FROM CHITIET_SANPHAM C 
JOIN SANPHAM S ON C.MaSP = S.MaSP
JOIN MAUSAC M ON C.MaMau = M.MaMau
JOIN KICHCO K ON C.MaSize = K.MaSize
WHERE C.GiaBan > 1000000 
ORDER BY C.GiaBan DESC;

-- 4. Xem các chương trình khuyến mãi đang diễn ra
SELECT * FROM KHUYENMAI 
WHERE NgayBatDau <= GETDATE() AND NgayKetThuc >= GETDATE() AND TrangThai = 1;

-- 5. Danh sách các nhân viên đảm nhận vai trò giao hàng
SELECT MaNV, HoTen, SDT FROM NHANVIEN WHERE QuyenSuDung = 0;

-- b. Truy vấn với Aggregate Functions: 7 câu

-- 1. Thống kê số lượng mặt hàng (sản phẩm cha) theo từng loại
SELECT MaLSP, COUNT(MaSP) AS SoLuongSanPham FROM SANPHAM GROUP BY MaLSP;

-- 2. Tính tổng số lượng đã bán ra của từng biến thể sản phẩm (SKU)
SELECT MaCTSP, SUM(SoLuong) AS TongSoLuongDaBan 
FROM CHITIET_HD GROUP BY MaCTSP;

-- 3. Tính mức giá trung bình của các sản phẩm do từng nhà cung cấp phân phối
SELECT S.MaNCC, AVG(C.GiaBan) AS GiaTrungBinh 
FROM SANPHAM S JOIN CHITIET_SANPHAM C ON S.MaSP = C.MaSP 
GROUP BY S.MaNCC;

-- 4. Đếm tổng số lượng đơn hàng mà mỗi khách hàng đã đặt
SELECT MaKH, COUNT(SoHD) AS TongSoDonHang FROM HOADON GROUP BY MaKH;

-- 5. Tìm ngày có lượng đơn đặt hàng nhiều nhất
SELECT TOP 1 NgayDat, COUNT(SoHD) AS SoLuongHoaDon 
FROM HOADON GROUP BY NgayDat ORDER BY SoLuongHoaDon DESC;

-- 6. Tính tổng thành tiền của từng hóa đơn
SELECT SoHD, SUM(ThanhTien) AS TongTienHoaDon FROM CHITIET_HD GROUP BY SoHD;

-- 7. Thống kê số lượng nhân sự theo từng nhóm quyền
SELECT QuyenSuDung, COUNT(MaNV) AS SoLuongNV FROM NHANVIEN GROUP BY QuyenSuDung;

-- c. Truy vấn với mệnh đề having: 5 câu 

-- 1. Lấy ra mã loại sản phẩm có chứa từ 2 sản phẩm trở lên
SELECT MaLSP, COUNT(MaSP) AS SoLuongSP FROM SANPHAM 
GROUP BY MaLSP HAVING COUNT(MaSP) >= 2;

-- 2. Liệt kê các nhà cung cấp phân phối trên 1 mặt hàng cho cửa hàng
SELECT MaNCC, COUNT(MaSP) AS SoLuongSanPham FROM SANPHAM 
GROUP BY MaNCC HAVING COUNT(MaSP) > 1;

-- 3. Hiển thị các hóa đơn có tổng giá trị (thành tiền) lớn hơn 10,000,000 VNĐ
SELECT SoHD, SUM(ThanhTien) AS TongTien 
FROM CHITIET_HD GROUP BY SoHD HAVING SUM(ThanhTien) > 10000000;

-- 4. Tìm những khách hàng đã đặt từ 2 đơn hàng trở lên
SELECT MaKH, COUNT(SoHD) AS SoLanMua FROM HOADON 
GROUP BY MaKH HAVING COUNT(SoHD) >= 2;

-- 5. Những ngày có tổng số lượng sản phẩm bán ra lớn hơn 3 sản phẩm
SELECT H.NgayDat, SUM(C.SoLuong) AS TongSPBanRa
FROM HOADON H JOIN CHITIET_HD C ON H.SoHD = C.SoHD
GROUP BY H.NgayDat HAVING SUM(C.SoLuong) > 3;

-- d. Truy vấn lớn nhất, nhỏ nhất: 4 câu  

-- 1. Tìm biến thể sản phẩm có đơn giá nhập cao nhất cửa hàng
SELECT TOP 1 MaCTSP, SKU, GiaNhap FROM CHITIET_SANPHAM ORDER BY GiaNhap DESC;

-- 2. Tìm hóa đơn có tổng tiền thấp nhất
SELECT TOP 1 SoHD, TongTien FROM HOADON ORDER BY TongTien ASC;

-- 3. Tìm nhà cung cấp cung cấp nhiều sản phẩm đa dạng nhất
SELECT TOP 1 MaNCC, COUNT(MaSP) AS SoLuongSP FROM SANPHAM 
GROUP BY MaNCC ORDER BY SoLuongSP DESC;

-- 4. Khách hàng chi nhiều tiền nhất tại cửa hàng
SELECT TOP 1 H.MaKH, K.HoTen, SUM(H.TongTien) AS TongTienDaChi
FROM HOADON H JOIN KHACHHANG K ON H.MaKH = K.MaKH
GROUP BY H.MaKH, K.HoTen ORDER BY TongTienDaChi DESC;

-- e. Truy vấn Không/chưa có: 5 câu 

-- 1. Khách hàng chưa từng mua đơn hàng nào
SELECT K.MaKH, K.HoTen FROM KHACHHANG K 
LEFT JOIN HOADON H ON K.MaKH = H.MaKH WHERE H.SoHD IS NULL;

-- 2. Phiên bản sản phẩm chưa từng được bán ra
SELECT MaCTSP, SKU FROM CHITIET_SANPHAM 
WHERE MaCTSP NOT IN (SELECT DISTINCT MaCTSP FROM CHITIET_HD);

-- 3. Nhân viên chưa từng duyệt hóa đơn nào
SELECT N.MaNV, N.HoTen FROM NHANVIEN N 
LEFT JOIN HOADON H ON N.MaNV = H.MaNVDuyet
WHERE H.SoHD IS NULL AND N.QuyenSuDung IN (1, 2);

-- 4. Nhà cung cấp chưa có sản phẩm nào trong cửa hàng
SELECT MaNCC, TenNCC FROM NHACUNGCAP 
WHERE MaNCC NOT IN (SELECT DISTINCT MaNCC FROM SANPHAM WHERE MaNCC IS NOT NULL);

-- 5. Chương trình khuyến mãi chưa được áp dụng cho hóa đơn nào
SELECT K.MaKM, K.TenKM FROM HOADON H 
RIGHT JOIN KHUYENMAI K ON H.MaKM = K.MaKM WHERE H.SoHD IS NULL;

-- f. Truy vấn Hợp/Giao/Trừ: 3 câu

-- 1. HỢP (UNION)
SELECT SDT, Email, 'Khach Hang' AS DoiTuong FROM KHACHHANG
UNION
SELECT SDT, Email, 'Nhan Vien' AS DoiTuong FROM NHANVIEN;

-- 2. GIAO (INTERSECT): Các biến thể SP giá > 3tr VÀ thuộc loại LSP01/LSP02
SELECT C.MaCTSP FROM CHITIET_SANPHAM C WHERE C.GiaBan > 3000000
INTERSECT
SELECT C.MaCTSP FROM CHITIET_SANPHAM C 
JOIN SANPHAM S ON C.MaSP = S.MaSP WHERE S.MaLSP IN ('LSP01', 'LSP02');

-- 3. TRỪ (EXCEPT): Sản phẩm của NCC01 nhưng chưa ai mua
SELECT C.MaCTSP FROM CHITIET_SANPHAM C 
JOIN SANPHAM S ON C.MaSP = S.MaSP WHERE S.MaNCC = 'NCC01'
EXCEPT
SELECT MaCTSP FROM CHITIET_HD;

-- g. Truy vấn Update, Delete: 7 câu

-- 1. Tăng giá thêm 10% cho các phiên bản thuộc loại 'Nike Air Max'
UPDATE C SET C.GiaBan = C.GiaBan * 1.1 
FROM CHITIET_SANPHAM C JOIN SANPHAM S ON C.MaSP = S.MaSP WHERE S.MaLSP = 'LSP01';

-- 2. Đổi tình trạng hóa đơn 'HD06'
UPDATE HOADON SET TinhTrang = 2 WHERE SoHD = 'HD06';

-- 3. Cập nhật địa chỉ khách hàng
UPDATE KHACHHANG SET DiaChi = N'Trung tâm Cam Ranh, Khánh Hòa' WHERE MaKH = 'KH09';

-- 4. Giảm giá trực tiếp trong CT_HD (cập nhật Thành Tiền)
UPDATE CHITIET_HD SET DonGiaBan = DonGiaBan - 200000, ThanhTien = SoLuong * (DonGiaBan - 200000) 
WHERE SoHD = 'HD05' AND MaCTSP = 'CT05';

-- 5. Đổi nhân viên giao hàng
UPDATE HOADON SET MaNVGiao = 'NV20' WHERE SoHD = 'HD19';

-- 6. Xóa chi tiết hóa đơn
DELETE FROM CHITIET_HD WHERE SoHD = 'HD20' AND MaCTSP = 'CT10';

-- 7. Xóa khuyến mãi đã kết thúc
DELETE FROM KHUYENMAI WHERE NgayKetThuc < '2025-01-01';

-- h. Truy vấn sử dụng phép Chia: 4 câu 

-- 1. Tìm KH đã mua TẤT CẢ các biến thể sản phẩm của NCC01
SELECT MaKH, HoTen FROM KHACHHANG K
WHERE NOT EXISTS (
    SELECT C.MaCTSP FROM CHITIET_SANPHAM C JOIN SANPHAM S ON C.MaSP = S.MaSP WHERE S.MaNCC = 'NCC01'
    EXCEPT
    SELECT C.MaCTSP FROM HOADON H JOIN CHITIET_HD C ON H.SoHD = C.SoHD WHERE H.MaKH = K.MaKH
);

-- 2. Hóa đơn chứa TẤT CẢ các biến thể thuộc loại 'LSP04'
SELECT SoHD FROM HOADON H
WHERE NOT EXISTS (
    SELECT C.MaCTSP FROM CHITIET_SANPHAM C JOIN SANPHAM S ON C.MaSP = S.MaSP WHERE S.MaLSP = 'LSP04'
    EXCEPT
    SELECT MaCTSP FROM CHITIET_HD C WHERE C.SoHD = H.SoHD
);

-- 3. NV đã duyệt hóa đơn cho TẤT CẢ KH ở 'Hà Nội'
SELECT MaNV, HoTen FROM NHANVIEN N
WHERE NOT EXISTS (
    SELECT MaKH FROM KHACHHANG WHERE DiaChi LIKE N'%Hà Nội%'
    EXCEPT
    SELECT MaKH FROM HOADON H WHERE H.MaNVDuyet = N.MaNV
);

-- 4. Khách hàng đã mua TẤT CẢ các SP có giá > 7,000,000
SELECT H.MaKH
FROM HOADON H JOIN CHITIET_HD C ON H.SoHD = C.SoHD JOIN CHITIET_SANPHAM S ON C.MaCTSP = S.MaCTSP
WHERE S.GiaBan > 7000000
GROUP BY H.MaKH
HAVING COUNT(DISTINCT S.MaCTSP) = (SELECT COUNT(MaCTSP) FROM CHITIET_SANPHAM WHERE GiaBan > 7000000);
GO
