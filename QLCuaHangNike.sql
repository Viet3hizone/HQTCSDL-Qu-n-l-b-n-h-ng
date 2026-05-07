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
--Yêu cầu 2: Nhập dữ liệu tối thiểu 20 bản ghi cho mỗi bảng 
-- NHẬP DỮ LIỆU ĐẦY ĐỦ 20 BẢN GHI/BẢNG

-- 1. KICHCO (20 bản ghi)
INSERT INTO KICHCO (MaSize, TenSize, MoTa) VALUES 
('S35', '35', 'Size nu'), ('S355', '35.5', 'Size nu'), ('S36', '36', 'Size nu'), ('S365', '36.5', 'Size nu'), 
('S37', '37', 'Size nu'), ('S375', '37.5', 'Size nu'), ('S38', '38', 'Size nu'), ('S385', '38.5', 'Size nu'), 
('S39', '39', 'Size chung'), ('S395', '39.5', 'Size chung'), ('S40', '40', 'Size chung'), ('S405', '40.5', 'Size chung'), 
('S41', '41', 'Size nam'), ('S42', '42', 'Size nam'), ('S425', '42.5', 'Size nam'), ('S43', '43', 'Size nam'), 
('S44', '44', 'Size nam'), ('S445', '44.5', 'Size nam'), ('S45', '45', 'Size nam'), ('S46', '46', 'Size lon');

-- 2. MAUSAC (20 bản ghi)
INSERT INTO MAUSAC (MaMau, TenMau, MaHex) VALUES 
('M01', 'Trang', '#FFFFFF'), ('M02', 'Den', '#000000'), ('M03', 'Do', '#FF0000'), ('M04', 'Xanh Duong', '#0000FF'), 
('M05', 'Xanh La', '#00FF00'), ('M06', 'Vang', '#FFFF00'), ('M07', 'Cam', '#FFA500'), ('M08', 'Tim', '#800080'), 
('M09', 'Hong', '#FFC0CB'), ('M10', 'Xam', '#808080'), ('M11', 'Nau', '#A52A2A'), ('M12', 'Kem', '#F5F5DC'), 
('M13', 'Bac', '#C0C0C0'), ('M14', 'Vang Dong', '#FFD700'), ('M15', 'Xanh Than', '#000080'), ('M16', 'Xanh Ngoc', '#40E0D0'), 
('M17', 'Do Do', '#8B0000'), ('M18', 'Xanh Re', '#556B2F'), ('M19', 'Neon', '#CCFF00'), ('M20', 'Multi-color', 'MIX');

-- 3. LOAISP (20 bản ghi)
INSERT INTO LOAISP (MaLSP, TenLSP, MoTa) VALUES 
('L01', 'Running', 'Giay chay bo'), ('L02', 'Basketball', 'Giay bong ro'), ('L03', 'Football', 'Giay da banh'), 
('L04', 'Lifestyle', 'Giay thoi trang'), ('L05', 'Training', 'Giay tap gym'), ('L06', 'T-Shirts', 'Ao thun'), 
('L07', 'Jackets', 'Ao khoac'), ('L08', 'Shorts', 'Quan short'), ('L09', 'Pants', 'Quan dai'), ('L10', 'Socks', 'Tat/Vien'), 
('L11', 'Caps', 'Non/Mu'), ('L12', 'Bags', 'Balo/Tui'), ('L13', 'Hoodies', 'Ao Hoodie'), ('L14', 'Tennis', 'Giay Tennis'), 
('L15', 'Skate', 'Giay truot van'), ('L16', 'Tanktop', 'Ao ba lo'), ('L17', 'Crossbody', 'Tui deo cheo'), 
('L18', 'Bottles', 'Binh nuoc'), ('L19', 'Gloves', 'Gang tay'), ('L20', 'Accessories', 'Phu kien khac');

-- 4. NHACUNGCAP (20 bản ghi)
INSERT INTO NHACUNGCAP (MaNCC, TenNCC, DiaChi, SDT) VALUES 
('NCC01', 'Nike VN', 'HCM', '0901'), ('NCC02', 'Nike Global', 'USA', '0902'), ('NCC03', 'May Mac 10', 'Ha Noi', '0903'), 
('NCC04', 'Thanh Cong', 'Da Nang', '0904'), ('NCC05', 'Phong Phu', 'HCM', '0905'), ('NCC06', 'Gia Cong A', 'Dong Nai', '0906'), 
('NCC07', 'Gia Cong B', 'Binh Duong', '0907'), ('NCC08', 'Da Giay 1', 'Hai Phong', '0908'), ('NCC09', 'Det Kim 2', 'Ha Noi', '0909'), 
('NCC10', 'Phu Kien Nike', 'HCM', '0910'), ('NCC11', 'Vat Lieu A', 'Long An', '0911'), ('NCC12', 'Logistics X', 'HCM', '0912'), 
('NCC13', 'Bao Bi Nike', 'Binh Duong', '0913'), ('NCC14', 'Kho Van Y', 'Dong Nai', '0914'), ('NCC15', 'XNK Nike', 'HCM', '0915'), 
('NCC16', 'Det May 3', 'Nam Dinh', '0916'), ('NCC17', 'Cao Su VN', 'Tay Ninh', '0917'), ('NCC18', 'Nhua Nike', 'HCM', '0918'), 
('NCC19', 'Tem Nhan Z', 'Da Nang', '0919'), ('NCC20', 'Tong Kho Nike', 'HCM', '0920');

-- 5. KHUYENMAI (20 bản ghi)
INSERT INTO KHUYENMAI (MaKM, TenKM, PhanTramGiam, NgayBatDau, NgayKetThuc) VALUES 
('KM01', 'Tet 2024', 20, '2024-01-01', '2024-02-15'), ('KM02', 'Valentine', 14, '2024-02-10', '2024-02-16'),
('KM03', 'Mung 8/3', 10, '2024-03-05', '2024-03-10'), ('KM04', 'Giai Phong', 30, '2024-04-25', '2024-05-05'),
('KM05', 'He Ruc Ro', 15, '2024-06-01', '2024-08-30'), ('KM06', 'Quoc Khanh', 20, '2024-08-30', '2024-09-05'),
('KM07', 'Black Friday', 50, '2024-11-20', '2024-11-30'), ('KM08', 'Noel 2024', 25, '2024-12-20', '2024-12-31'),
('KM09', 'Sale Thang 1', 10, '2024-01-01', '2024-01-31'), ('KM10', 'Sale Thang 2', 10, '2024-02-01', '2024-02-29'),
('KM11', 'Sale Thang 3', 10, '2024-03-01', '2024-03-31'), ('KM12', 'Sale Thang 4', 10, '2024-04-01', '2024-04-30'),
('KM13', 'Sale Thang 5', 10, '2024-05-01', '2024-05-31'), ('KM14', 'Sale Thang 6', 10, '2024-06-01', '2024-06-30'),
('KM15', 'Sale Thang 7', 10, '2024-07-01', '2024-07-31'), ('KM16', 'Sale Thang 8', 10, '2024-08-01', '2024-08-31'),
('KM17', 'Sale Thang 9', 10, '2024-09-01', '2024-09-30'), ('KM18', 'Sale Thang 10', 10, '2024-10-01', '2024-10-31'),
('KM19', 'Sale Thang 11', 10, '2024-11-01', '2024-11-30'), ('KM20', 'Sale Thang 12', 10, '2024-12-01', '2024-12-31');
-- 6. KHACHHANG (20 bản ghi)
INSERT INTO KHACHHANG (MaKH, HoTen, Email, MatKhau, SDT) VALUES 
('KH01', 'Nguyen An', 'an@gmail.com', '123', '0111'), ('KH02', 'Tran Binh', 'binh@gmail.com', '123', '0222'),
('KH03', 'Le Chi', 'chi@gmail.com', '123', '0333'), ('KH04', 'Pham Dung', 'dung@gmail.com', '123', '0444'),
('KH05', 'Hoang Em', 'em@gmail.com', '123', '0555'), ('KH06', 'Vo Phi', 'phi@gmail.com', '123', '0666'),
('KH07', 'Dang Gia', 'gia@gmail.com', '123', '0777'), ('KH08', 'Bui Hoa', 'hoa@gmail.com', '123', '0888'),
('KH09', 'Do Im', 'im@gmail.com', '123', '0999'), ('KH10', 'Ly Khanh', 'khanh@gmail.com', '123', '1010'),
('KH11', 'Ngo Lam', 'lam@gmail.com', '123', '1111'), ('KH12', 'Phan Minh', 'minh@gmail.com', '123', '1212'),
('KH13', 'Truong Nam', 'nam@gmail.com', '123', '1313'), ('KH14', 'Dinh Oanh', 'oanh@gmail.com', '123', '1414'),
('KH15', 'Quach Phu', 'phu@gmail.com', '123', '1515'), ('KH16', 'Lam Quoc', 'quoc@gmail.com', '123', '1616'),
('KH17', 'Duong Son', 'son@gmail.com', '123', '1717'), ('KH18', 'Luong Tam', 'tam@gmail.com', '123', '1818'),
('KH19', 'Trieu Uy', 'uy@gmail.com', '123', '1919'), ('KH20', 'Vi Viet', 'viet@gmail.com', '123', '2020');

-- 7. NHANVIEN (20 bản ghi)
INSERT INTO NHANVIEN (MaNV, HoTen, Email, MatKhau, QuyenSuDung) VALUES 
('NV01', 'Admin 1', 'ad1@nike.com', 'admin', 1), ('NV02', 'Sales 1', 's1@nike.com', '123', 2),
('NV03', 'Sales 2', 's2@nike.com', '123', 2), ('NV04', 'Ship 1', 'sh1@nike.com', '123', 3),
('NV05', 'Ship 2', 'sh2@nike.com', '123', 3), ('NV06', 'Admin 2', 'ad2@nike.com', 'admin', 1),
('NV07', 'Sales 3', 's3@nike.com', '123', 2), ('NV08', 'Sales 4', 's4@nike.com', '123', 2),
('NV09', 'Ship 3', 'sh3@nike.com', '123', 3), ('NV10', 'Ship 4', 'sh4@nike.com', '123', 3),
('NV11', 'Admin 3', 'ad3@nike.com', 'admin', 1), ('NV12', 'Sales 5', 's5@nike.com', '123', 2),
('NV13', 'Sales 6', 's6@nike.com', '123', 2), ('NV14', 'Ship 5', 'sh5@nike.com', '123', 3),
('NV15', 'Ship 6', 'sh6@nike.com', '123', 3), ('NV16', 'Stock 1', 'st1@nike.com', '123', 4),
('NV17', 'Stock 2', 'st2@nike.com', '123', 4), ('NV18', 'Acc 1', 'ac1@nike.com', '123', 5),
('NV19', 'Acc 2', 'ac2@nike.com', '123', 5), ('NV20', 'Security', 'se@nike.com', '123', 6);

-- 8. SANPHAM (20 bản ghi)
INSERT INTO SANPHAM (MaSP, TenSP, MaLSP, MaNCC) VALUES 
('SP01', 'Air Max 90', 'L01', 'NCC01'), ('SP02', 'Air Force 1', 'L04', 'NCC01'),
('SP03', 'Jordan 1 High', 'L02', 'NCC02'), ('SP04', 'Mercurial Zoom', 'L03', 'NCC17'),
('SP05', 'Metcon 9', 'L05', 'NCC01'), ('SP06', 'Dri-FIT Tee', 'L06', 'NCC03'),
('SP07', 'Windrunner', 'L07', 'NCC04'), ('SP08', 'Challenger Shorts', 'L08', 'NCC03'),
('SP09', 'Tech Fleece', 'L09', 'NCC05'), ('SP10', 'Elite Socks', 'L10', 'NCC09'),
('SP11', 'Heritage Cap', 'L11', 'NCC10'), ('SP12', 'Hayward Backpack', 'L12', 'NCC10'),
('SP13', 'Club Hoodie', 'L13', 'NCC04'), ('SP14', 'Court Lite 4', 'L14', 'NCC01'),
('SP15', 'SB Dunk Low', 'L15', 'NCC02'), ('SP16', 'Pro Tank', 'L16', 'NCC05'),
('SP17', 'Futura Crossbody', 'L17', 'NCC13'), ('SP18', 'Hyperfuel Bottle', 'L18', 'NCC18'),
('SP19', 'Vapor Gloves', 'L19', 'NCC19'), ('SP20', 'Wristband', 'L20', 'NCC19');

-- 9. CHITIET_SANPHAM (20 bản ghi)
INSERT INTO CHITIET_SANPHAM (MaCTSP, MaSP, MaMau, MaSize, SKU, GiaNhap, GiaBan, SoLuongTon) VALUES 
('CT01', 'SP01', 'M01', 'S40', 'SKU01', 2000000, 3500000, 50), ('CT02', 'SP02', 'M02', 'S41', 'SKU02', 1500000, 2800000, 40),
('CT03', 'SP03', 'M03', 'S42', 'SKU03', 3000000, 5500000, 20), ('CT04', 'SP04', 'M04', 'S40', 'SKU04', 2500000, 4200000, 30),
('CT05', 'SP05', 'M02', 'S41', 'SKU05', 1800000, 3200000, 25), ('CT06', 'SP06', 'M01', 'S39', 'SKU06', 400000, 850000, 100),
('CT07', 'SP07', 'M05', 'S38', 'SKU07', 1200000, 2200000, 15), ('CT08', 'SP08', 'M02', 'S40', 'SKU08', 350000, 750000, 60),
('CT09', 'SP09', 'M10', 'S41', 'SKU09', 1500000, 2900000, 12), ('CT10', 'SP10', 'M01', 'S35', 'SKU10', 150000, 350000, 200),
('CT11', 'SP11', 'M02', 'S35', 'SKU11', 200000, 450000, 80), ('CT12', 'SP12', 'M04', 'S35', 'SKU12', 600000, 1200000, 45),
('CT13', 'SP13', 'M03', 'S41', 'SKU13', 900000, 1800000, 33), ('CT14', 'SP14', 'M01', 'S42', 'SKU14', 1100000, 2100000, 18),
('CT15', 'SP15', 'M20', 'S43', 'SKU15', 2200000, 3900000, 10), ('CT16', 'SP16', 'M09', 'S38', 'SKU16', 300000, 650000, 70),
('CT17', 'SP17', 'M02', 'S35', 'SKU17', 450000, 950000, 55), ('CT18', 'SP18', 'M04', 'S35', 'SKU18', 250000, 550000, 90),
('CT19', 'SP19', 'M02', 'S35', 'SKU19', 350000, 800000, 40), ('CT20', 'SP20', 'M03', 'S35', 'SKU20', 100000, 250000, 150);
-- 10. HOADON (20 bản ghi)
INSERT INTO HOADON (SoHD, NgayDat, MaKH, MaNVDuyet, MaNVGiao, MaKM, TongTien) VALUES 
('HD01', '2024-01-05', 'KH01', 'NV02', 'NV04', 'KM01', 3500000), ('HD02', '2024-01-06', 'KH02', 'NV03', 'NV05', 'KM01', 2800000),
('HD03', '2024-02-14', 'KH03', 'NV02', 'NV04', 'KM02', 5500000), ('HD04', '2024-03-08', 'KH04', 'NV07', 'NV09', 'KM03', 4200000),
('HD05', '2024-05-01', 'KH05', 'NV08', 'NV10', 'KM04', 3200000), ('HD06', '2024-06-15', 'KH06', 'NV02', 'NV04', 'KM05', 850000),
('HD07', '2024-07-20', 'KH07', 'NV03', 'NV05', 'KM05', 2200000), ('HD08', '2024-09-02', 'KH08', 'NV07', 'NV09', 'KM06', 750000),
('HD09', '2024-11-25', 'KH09', 'NV08', 'NV10', 'KM07', 2900000), ('HD10', '2024-12-25', 'KH10', 'NV02', 'NV04', 'KM08', 350000),
('HD11', '2024-01-15', 'KH11', 'NV03', 'NV05', 'KM09', 450000), ('HD12', '2024-02-20', 'KH12', 'NV07', 'NV09', 'KM10', 1200000),
('HD13', '2024-03-25', 'KH13', 'NV08', 'NV10', 'KM11', 1800000), ('HD14', '2024-04-10', 'KH14', 'NV12', 'NV14', 'KM12', 2100000),
('HD15', '2024-05-15', 'KH15', 'NV13', 'NV15', 'KM13', 3900000), ('HD16', '2024-06-20', 'KH16', 'NV12', 'NV14', 'KM14', 650000),
('HD17', '2024-07-25', 'KH17', 'NV13', 'NV15', 'KM15', 950000), ('HD18', '2024-08-10', 'KH18', 'NV12', 'NV14', 'KM16', 550000),
('HD19', '2024-09-20', 'KH19', 'NV13', 'NV15', 'KM17', 800000), ('HD20', '2024-10-30', 'KH20', 'NV12', 'NV14', 'KM18', 250000);

-- 11. CHITIET_HD (20 bản ghi)
INSERT INTO CHITIET_HD (SoHD, MaCTSP, SoLuong, DonGiaBan, ThanhTien) VALUES 
('HD01', 'CT01', 1, 3500000, 3500000), ('HD02', 'CT02', 1, 2800000, 2800000), ('HD03', 'CT03', 1, 5500000, 5500000),
('HD04', 'CT04', 1, 4200000, 4200000), ('HD05', 'CT05', 1, 3200000, 3200000), ('HD06', 'CT06', 1, 850000, 850000),
('HD07', 'CT07', 1, 2200000, 2200000), ('HD08', 'CT08', 1, 750000, 750000), ('HD09', 'CT09', 1, 2900000, 2900000),
('HD10', 'CT10', 1, 350000, 350000), ('HD11', 'CT11', 1, 450000, 450000), ('HD12', 'CT12', 1, 1200000, 1200000),
('HD13', 'CT13', 1, 1800000, 1800000), ('HD14', 'CT14', 1, 2100000, 2100000), ('HD15', 'CT15', 1, 3900000, 3900000),
('HD16', 'CT16', 1, 650000, 650000), ('HD17', 'CT17', 1, 950000, 950000), ('HD18', 'CT18', 1, 550000, 550000),
('HD19', 'CT19', 1, 800000, 800000), ('HD20', 'CT20', 1, 250000, 250000);
-- 12. PHIEUNHAP (20 bản ghi)
INSERT INTO PHIEUNHAP (MaPN, MaNCC, MaNV, TongTien) VALUES 
('PN01', 'NCC01', 'NV16', 100000000), ('PN02', 'NCC01', 'NV17', 50000000), ('PN03', 'NCC02', 'NV16', 150000000),
('PN04', 'NCC03', 'NV17', 20000000), ('PN05', 'NCC04', 'NV16', 45000000), ('PN06', 'NCC05', 'NV17', 30000000),
('PN07', 'NCC06', 'NV16', 80000000), ('PN08', 'NCC07', 'NV17', 90000000), ('PN09', 'NCC08', 'NV16', 55000000),
('PN10', 'NCC09', 'NV17', 25000000), ('PN11', 'NCC10', 'NV16', 40000000), ('PN12', 'NCC11', 'NV17', 15000000),
('PN13', 'NCC12', 'NV16', 10000000), ('PN14', 'NCC13', 'NV17', 12000000), ('PN15', 'NCC14', 'NV16', 18000000),
('PN16', 'NCC15', 'NV17', 22000000), ('PN17', 'NCC16', 'NV16', 60000000), ('PN18', 'NCC17', 'NV17', 70000000),
('PN19', 'NCC18', 'NV16', 10000000), ('PN20', 'NCC19', 'NV17', 5000000);

-- 13. CHITIET_PHIEUNHAP (20 bản ghi)
INSERT INTO CHITIET_PHIEUNHAP (MaPN, MaCTSP, SoLuong, GiaNhap, ThanhTien) VALUES 
('PN01', 'CT01', 50, 2000000, 100000000), ('PN02', 'CT02', 33, 1500000, 49500000), ('PN03', 'CT03', 50, 3000000, 150000000),
('PN04', 'CT06', 50, 400000, 20000000), ('PN05', 'CT07', 37, 1200000, 44400000), ('PN06', 'CT16', 100, 300000, 30000000),
('PN07', 'CT14', 72, 1100000, 79200000), ('PN08', 'CT05', 50, 1800000, 90000000), ('PN09', 'CT04', 22, 2500000, 55000000),
('PN10', 'CT10', 166, 150000, 24900000), ('PN11', 'CT11', 200, 200000, 40000000), ('PN12', 'CT18', 60, 250000, 15000000),
('PN13', 'CT12', 16, 600000, 9600000), ('PN14', 'CT17', 26, 450000, 11700000), ('PN15', 'CT13', 20, 900000, 18000000),
('PN16', 'CT15', 10, 2200000, 22000000), ('PN17', 'CT01', 30, 2000000, 60000000), ('PN18', 'CT04', 28, 2500000, 70000000),
('PN19', 'CT19', 28, 350000, 9800000), ('PN20', 'CT20', 50, 100000, 5000000);

-- 14. THANHTOAN (20 bản ghi)
INSERT INTO THANHTOAN (MaTT, SoHD, SoTien, PhuongThuc) VALUES 
('TT01', 'HD01', 3500000, 'Tien mat'), ('TT02', 'HD02', 2800000, 'Chuyen khoan'), ('TT03', 'HD03', 5500000, 'Momo'),
('TT04', 'HD04', 4200000, 'The tin dung'), ('TT05', 'HD05', 3200000, 'Tien mat'), ('TT06', 'HD06', 850000, 'Chuyen khoan'),
('TT07', 'HD07', 2200000, 'Momo'), ('TT08', 'HD08', 750000, 'Tien mat'), ('TT09', 'HD09', 2900000, 'Chuyen khoan'),
('TT10', 'HD10', 350000, 'Tien mat'), ('TT11', 'HD11', 450000, 'Tien mat'), ('TT12', 'HD12', 1200000, 'Chuyen khoan'),
('TT13', 'HD13', 1800000, 'Momo'), ('TT14', 'HD14', 2100000, 'Tien mat'), ('TT15', 'HD15', 3900000, 'Chuyen khoan'),
('TT16', 'HD16', 650000, 'Momo'), ('TT17', 'HD17', 950000, 'Tien mat'), ('TT18', 'HD18', 550000, 'Chuyen khoan'),
('TT19', 'HD19', 800000, 'Tien mat'), ('TT20', 'HD20', 250000, 'Momo');

-- 15. VANCHUYEN (20 bản ghi)
INSERT INTO VANCHUYEN (MaVC, SoHD, DonViVanChuyen, MaVanDon, TrangThai) VALUES 
('VC01', 'HD01', 'GHTK', 'VD01', 'Da giao'), ('VC02', 'HD02', 'GHN', 'VD02', 'Da giao'),
('VC03', 'HD03', 'Viettel Post', 'VD03', 'Da giao'), ('VC04', 'HD04', 'GHTK', 'VD04', 'Dang giao'),
('VC05', 'HD05', 'J&T', 'VD05', 'Cho lay hang'), ('VC06', 'HD06', 'GHN', 'VD06', 'Da giao'),
('VC07', 'HD07', 'GHTK', 'VD07', 'Da giao'), ('VC08', 'HD08', 'Viettel Post', 'VD08', 'Da giao'),
('VC09', 'HD09', 'J&T', 'VD09', 'Dang giao'), ('VC10', 'HD10', 'GHTK', 'VD10', 'Da giao'),
('VC11', 'HD11', 'GHN', 'VD11', 'Da giao'), ('VC12', 'HD12', 'J&T', 'VD12', 'Da giao'),
('VC13', 'HD13', 'Viettel Post', 'VD13', 'Da giao'), ('VC14', 'HD14', 'GHTK', 'VD14', 'Da giao'),
('VC15', 'HD15', 'GHN', 'VD15', 'Dang giao'), ('VC16', 'HD16', 'Viettel Post', 'VD16', 'Da giao'),
('VC17', 'HD17', 'J&T', 'VD17', 'Da giao'), ('VC18', 'HD18', 'GHTK', 'VD18', 'Da giao'),
('VC19', 'HD19', 'GHN', 'VD19', 'Cho lay hang'), ('VC20', 'HD20', 'Viettel Post', 'VD20', 'Da giao');
-- 16. DANHGIASANPHAM (20 bản ghi)
INSERT INTO DANHGIASANPHAM (MaDG, MaKH, MaSP, SoSao, NoiDung) VALUES 
('DG01', 'KH01', 'SP01', 5, 'Giay dep lam'), ('DG02', 'KH02', 'SP02', 4, 'Hoi chat ti'),
('DG03', 'KH03', 'SP03', 5, 'Dang dong tien'), ('DG04', 'KH04', 'SP04', 3, 'Giao hoi lau'),
('DG05', 'KH05', 'SP05', 5, 'Rat em chan'), ('DG06', 'KH06', 'SP06', 4, 'Ao thun mat'),
('DG07', 'KH07', 'SP07', 5, 'Ao khoac am'), ('DG08', 'KH08', 'SP08', 4, 'Quan mac thoi mai'),
('DG09', 'KH09', 'SP09', 5, 'Chat luong Nike thi khoi ban'), ('DG10', 'KH10', 'SP10', 5, 'Tat mem'),
('DG11', 'KH11', 'SP11', 4, 'Non dep'), ('DG12', 'KH12', 'SP12', 5, 'Balo rong rai'),
('DG13', 'KH13', 'SP13', 4, 'Hoodie am'), ('DG14', 'KH14', 'SP14', 3, 'De hoi cung'),
('DG15', 'KH15', 'SP15', 5, 'Mau sac rat dep'), ('DG16', 'KH16', 'SP16', 4, 'Mac di tap gym rat tot'),
('DG17', 'KH17', 'SP17', 5, 'Tui nho gon'), ('DG18', 'KH18', 'SP18', 5, 'Binh giu nhiet tot'),
('DG19', 'KH19', 'SP19', 4, 'Gang tay chac chan'), ('DG20', 'KH20', 'SP20', 5, 'Phu kien tot');

-- 17. TRAHANG (20 bản ghi)
INSERT INTO TRAHANG (MaTra, SoHD, MaKH, LyDo, TongTienHoan, TrangThai) VALUES 
('T01', 'HD04', 'KH04', 'Loi ke de', 4200000, 'Da hoan tien'), ('T02', 'HD09', 'KH09', 'Size qua lon', 2900000, 'Dang xu ly'),
('T03', 'HD01', 'KH01', 'Doi mau', 0, 'Tu choi'), ('T04', 'HD15', 'KH15', 'Sai san pham', 3900000, 'Da hoan tien'),
('T05', 'HD19', 'KH19', 'Hang gia (nghi ngo)', 800000, 'Dang xu ly'), ('T06', 'HD12', 'KH12', 'Loi duong chi', 1200000, 'Da hoan tien'),
('T07', 'HD05', 'KH05', 'Khong ung y', 3200000, 'Tu choi'), ('T08', 'HD02', 'KH02', 'Hu hong khi van chuyen', 2800000, 'Da hoan tien'),
('T09', 'HD10', 'KH10', 'Nham size', 350000, 'Da hoan tien'), ('T10', 'HD03', 'KH03', 'Loi san xuat', 5500000, 'Da hoan tien'),
('T11', 'HD11', 'KH11', 'Loi mau', 450000, 'Da hoan tien'), ('T12', 'HD06', 'KH06', 'Hu khoa keo', 850000, 'Da hoan tien'),
('T13', 'HD07', 'KH07', 'Rach vai', 2200000, 'Da hoan tien'), ('T14', 'HD13', 'KH13', 'Bung keo', 1800000, 'Da hoan tien'),
('T15', 'HD20', 'KH20', 'Sai mau', 250000, 'Da hoan tien'), ('T16', 'HD14', 'KH14', 'Tray xuoc', 2100000, 'Da hoan tien'),
('T17', 'HD18', 'KH18', 'Thieu phu kien', 550000, 'Da hoan tien'), ('T18', 'HD16', 'KH16', 'Khong giong hinh', 650000, 'Da hoan tien'),
('T19', 'HD17', 'KH17', 'Mui hoi la', 950000, 'Da hoan tien'), ('T20', 'HD08', 'KH08', 'De bi o vang', 750000, 'Da hoan tien');

-- 18. CHITIET_TRAHANG (20 bản ghi)
INSERT INTO CHITIET_TRAHANG (MaTra, MaCTSP, SoLuong, DonGia, ThanhTien) VALUES 
('T01', 'CT04', 1, 4200000, 4200000), ('T02', 'CT09', 1, 2900000, 2900000), ('T04', 'CT15', 1, 3900000, 3900000),
('T05', 'CT19', 1, 800000, 800000), ('T06', 'CT12', 1, 1200000, 1200000), ('T08', 'CT02', 1, 2800000, 2800000),
('T09', 'CT10', 1, 350000, 350000), ('T10', 'CT03', 1, 5500000, 5500000), ('T11', 'CT11', 1, 450000, 450000),
('T12', 'CT06', 1, 850000, 850000), ('T13', 'CT07', 1, 2200000, 2200000), ('T14', 'CT13', 1, 1800000, 1800000),
('T15', 'CT20', 1, 250000, 250000), ('T16', 'CT14', 1, 2100000, 2100000), ('T17', 'CT18', 1, 550000, 550000),
('T18', 'CT16', 1, 650000, 650000), ('T19', 'CT17', 1, 950000, 950000), ('T20', 'CT08', 1, 750000, 750000),
('T03', 'CT01', 1, 3500000, 3500000), ('T07', 'CT05', 1, 3200000, 3200000);
--Yêu cầu 3: Tạo 40 câu truy vấn
