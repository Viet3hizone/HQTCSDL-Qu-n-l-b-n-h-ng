--Tạo database
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
    QuyenSuDung INT, --ví dụ: 1 là Quản lý, 0 là Nhân viên bán hàng, 2 là Quản trị hệ thống
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
('S35', '35', 'Size nu'), 
('S355', '35.5', 'Size nu'), 
('S36', '36', 'Size nu'), 
('S365', '36.5', 'Size nu'), 
('S37', '37', 'Size nu'), 
('S375', '37.5', 'Size nu'), 
('S38', '38', 'Size nu'), 
('S385', '38.5', 'Size nu'), 
('S39', '39', 'Size chung'), 
('S395', '39.5', 'Size chung'), 
('S40', '40', 'Size chung'), 
('S405', '40.5', 'Size chung'), 
('S41', '41', 'Size nam'), 
('S42', '42', 'Size nam'), 
('S425', '42.5', 'Size nam'), 
('S43', '43', 'Size nam'), 
('S44', '44', 'Size nam'), 
('S445', '44.5', 'Size nam'), 
('S45', '45', 'Size nam'), 
('S46', '46', 'Size lon');

-- 2. MAUSAC (20 bản ghi)
INSERT INTO MAUSAC (MaMau, TenMau, MaHex) VALUES 
('M01', 'Trang', '#FFFFFF'),
('M02', 'Den', '#000000'), 
('M03', 'Do', '#FF0000'), 
('M04', 'Xanh Duong', '#0000FF'), 
('M05', 'Xanh La', '#00FF00'), 
('M06', 'Vang', '#FFFF00'), 
('M07', 'Cam', '#FFA500'), 
('M08', 'Tim', '#800080'), 
('M09', 'Hong', '#FFC0CB'), 
('M10', 'Xam', '#808080'), 
('M11', 'Nau', '#A52A2A'), 
('M12', 'Kem', '#F5F5DC'), 
('M13', 'Bac', '#C0C0C0'), 
('M14', 'Vang Dong', '#FFD700'), 
('M15', 'Xanh Than', '#000080'), 
('M16', 'Xanh Ngoc', '#40E0D0'), 
('M17', 'Do Do', '#8B0000'), 
('M18', 'Xanh Re', '#556B2F'), 
('M19', 'Neon', '#CCFF00'), 
('M20', 'Multi-color', 'MIX');
-- 3. LOAISP (20 bản ghi)
INSERT INTO LOAISP (MaLSP, TenLSP, MoTa) VALUES 
('LSP01', 'Running', 'Giay chay bo'), 
('LSP02', 'Basketball', 'Giay bong ro'),
('LSP03', 'Football', 'Giay da banh'), 
('LSP04', 'Lifestyle', 'Giay thoi trang'), 
('LSP05', 'Training', 'Giay tap gym'), 
('LSP06', 'T-Shirts', 'Ao thun'), 
('LSP07', 'Jackets', 'Ao khoac'), 
('LSP08', 'Shorts', 'Quan short'), 
('LSP09', 'Pants', 'Quan dai'), 
('LSP10', 'Socks', 'Tat/Vien'), 
('LSP11', 'Caps', 'Non/Mu'), 
('LSP12', 'Bags', 'Balo/Tui'), 
('LSP13', 'Hoodies', 'Ao Hoodie'), 
('LSP14', 'Tennis', 'Giay Tennis'), 
('LSP15', 'Skate', 'Giay truot van'), 
('LSP16', 'Tanktop', 'Ao ba lo'), 
('LSP17', 'Crossbody', 'Tui deo cheo'), 
('LSP18', 'Bottles', 'Binh nuoc'), 
('LSP19', 'Gloves', 'Gang tay'), 
('LSP20', 'Accessories', 'Phu kien khac');

-- 4. NHACUNGCAP (20 bản ghi)
INSERT INTO NHACUNGCAP (MaNCC, TenNCC, DiaChi, SDT, Email, NguoiDaiDien, Website) VALUES 
('NCC01', N'Nike VN', N'HCM', '0901649250', 'nikevn@gmail.com', 'Mr.A', 'nikevn.com.vn'),
('NCC02', N'Nike Global', N'USA', '0902275994', 'nikeglobal@gmail.com', 'Mr.B', 'nikeglobal.com.vn'),
('NCC03', N'May Mac 10', N'Ha Noi', '0902959053', 'maymac10@gmail.com', 'Mr.C', 'maymac10.com.vn'),
('NCC04', N'Thanh Cong', N'Da Nang', '0904285047', 'thanhcong@gmail.com', 'Mr.D', 'thanhcong.com.vn'),
('NCC05', N'Phong Phu', N'HCM', '0905245378', 'phongphu@gmail.com', 'Mr.E', 'phongphu.com.vn'),
('NCC06', N'Gia Cong A', N'Dong Nai', '0976389606', 'giaconga@gmail.com', 'Mr.F', 'giaconga.com.vn'),
('NCC07', N'Gia Cong B', N'Binh Duong', '0907373093', 'giacongb@gmail.com', 'Mr.G', 'giacongb.com.vn'),
('NCC08', N'Da Giay 1', N'Hai Phong', '0908462869', 'dagiay1@gmail.com', 'Mr.H', 'dagiay1.com.vn'),
('NCC09', N'Det Kim 2', N'Ha Noi', '0939268909', 'detkim2@gmail.com', 'Mr.I', 'detkim2.com.vn'),
('NCC10', N'Phu Kien Nike', N'HCM', '0910148702', 'phukiennike@gmail.com', 'Mr.K', 'phukiennike.com.vn'),
('NCC11', N'Vat Lieu A', N'Long An', '0911358061', 'vatlieua@gmail.com', 'Mr.L', 'vatlieua.com.vn'),
('NCC12', N'Logistics X', N'HCM', '0935983712', 'logisticsx@gmail.com', 'Mr.M', 'logisticsx.com.vn'),
('NCC13', N'Bao Bi Nike', N'Binh Duong', '0913385701', 'baobinike@gmail.com', 'Mr.N', 'baobinike.com.vn'),
('NCC14', N'Kho Van Y', N'Dong Nai', '0914540237', 'khovany@gmail.com', 'Mr.P', 'khovany.com.vn'),
('NCC15', N'XNK Nike', N'HCM', '0913968695', 'xnknike@gmail.com', 'Mr.Q', 'xnknike.com.vn'),
('NCC16', N'Det May 3', N'Nam Dinh', '0916573938', 'detmay3@gmail.com', 'Mr.R', 'detmay3.com.vn'),
('NCC17', N'Cao Su VN', N'Tay Ninh', '0917469020', 'caosuvn@gmail.com', 'Mr.S', 'caosuvn.com.vn'),
('NCC18', N'Nhua Nike', N'HCM', '0912697548', 'nhuanike@gmail.com', 'Mr.T', 'nhuanike.com.vn'),
('NCC19', N'Tem Nhan Z', N'Da Nang', '0919709265', 'temnhanz@gmail.com', 'Mr.U', 'temnhanz.com.vn'),
('NCC20', N'Tong Kho Nike', N'HCM', '0920459604', 'tongkhonike@gmail.com', 'Mr.V', 'tongkhonike.com.vn');

-- 5. KHUYENMAI (20 bản ghi)
INSERT INTO KHUYENMAI (MaKM, TenKM, LoaiKhuyenMai, PhanTramGiam, GiaTriToiDa, NgayBatDau, NgayKetThuc) VALUES 
('KM01', N'Tet 2024', N'Phần trăm', 20, 500000, '2024-01-01', '2024-02-15'),
('KM02', N'Valentine', N'Phần trăm', 14, 500000, '2024-02-10', '2024-02-16'),
('KM03', N'Mung 8/3', N'Phần trăm', 10, 500000, '2024-03-05', '2024-03-10'),
('KM04', N'Giai Phong', N'Phần trăm', 30, 500000, '2024-04-25', '2024-05-05'),
('KM05', N'He Ruc Ro', N'Phần trăm', 15, 500000, '2024-06-01', '2024-08-30'),
('KM06', N'Quoc Khanh', N'Phần trăm', 20, 500000, '2024-08-30', '2024-09-05'),
('KM07', N'Black Friday', N'Phần trăm', 50, 500000, '2024-11-20', '2024-11-30'),
('KM08', N'Noel 2024', N'Phần trăm', 25, 500000, '2024-12-20', '2024-12-31'),
('KM09', N'Sale Thang 1', N'Phần trăm', 10, 500000, '2024-01-01', '2024-01-31'),
('KM10', N'Sale Thang 2', N'Phần trăm', 10, 500000, '2024-02-01', '2024-02-29'),
('KM11', N'Sale Thang 3', N'Phần trăm', 10, 500000, '2024-03-01', '2024-03-31'),
('KM12', N'Sale Thang 4', N'Phần trăm', 10, 500000, '2024-04-01', '2024-04-30'),
('KM13', N'Sale Thang 5', N'Phần trăm', 10, 500000, '2024-05-01', '2024-05-31'),
('KM14', N'Sale Thang 6', N'Phần trăm', 10, 500000, '2024-06-01', '2024-06-30'),
('KM15', N'Sale Thang 7', N'Phần trăm', 10, 500000, '2024-07-01', '2024-07-31'),
('KM16', N'Sale Thang 8', N'Phần trăm', 10, 500000, '2024-08-01', '2024-08-31'),
('KM17', N'Sale Thang 9', N'Phần trăm', 10, 500000, '2024-09-01', '2024-09-30'),
('KM18', N'Sale Thang 10', N'Phần trăm', 10, 500000, '2024-10-01', '2024-10-31'),
('KM19', N'Sale Thang 11', N'Phần trăm', 10, 500000, '2024-11-01', '2024-11-30'),
('KM20', N'Sale Thang 12', N'Phần trăm', 10, 500000, '2024-12-01', '2024-12-31');
-- 6. KHACHHANG (20 bản ghi)
INSERT INTO KHACHHANG (MaKH, HoTen, NgaySinh, GioiTinh, Email, SDT, DiaChi, MatKhau, NgayDangKy) VALUES 
('KH01', N'Nguyễn Văn An', '1990-05-15', N'Nam', 'an.nguyen@gmail.com', '0901234567', N'123 Lê Lợi, TP. HCM', 'Pass123', '2023-01-10'),
('KH02', N'Trần Thị Bình', '1995-10-20', N'Nữ', 'binh.tran@gmail.com', '0912345678', N'456 Nguyễn Huệ, Nha Trang', 'Binh@2024', '2023-02-15'),
('KH03', N'Lê Hoàng Cường', '1988-12-05', N'Nam', 'cuong.le@gmail.com', '0923456789', N'789 Trần Hưng Đạo, Hà Nội', 'Cuong88', '2023-03-20'),
('KH04', N'Phạm Minh Dung', '2000-01-25', N'Nữ', 'dung.pham@gmail.com', '0934567890', N'12 Lý Tự Trọng, Đà Nẵng', 'DungMinh', '2023-04-05'),
('KH05', N'Hoàng Anh Em', '1992-07-14', N'Nam', 'em.hoang@gmail.com', '0945678901', N'88 Quang Trung, Gò Vấp', 'PassWordEm', '2023-05-12'),
('KH06', N'Đặng Thanh Phương', '1997-03-30', N'Nữ', 'phuong.dang@gmail.com', '0956789012', N'22 Hòa Bình, Cần Thơ', 'Phuong97', '2023-06-18'),
('KH07', N'Bùi Tiến Giang', '1985-09-09', N'Nam', 'giang.bui@gmail.com', '0967890123', N'101 Hùng Vương, Hải Phòng', 'GiangBui85', '2023-07-22'),
('KH08', N'Vũ Thu Hà', '1993-11-11', N'Nữ', 'ha.vu@gmail.com', '0978901234', N'55 Phan Chu Trinh, Huế', 'HaThu93', '2023-08-30'),
('KH09', N'Ngô Quốc Hùng', '1991-02-14', N'Nam', 'hung.ngo@gmail.com', '0989012345', N'34 Điện Biên Phủ, HCM', 'HungQuoc91', '2023-09-15'),
('KH10', N'Đỗ Mỹ Linh', '1996-08-08', N'Nữ', 'linh.do@gmail.com', '0990123456', N'77 Cách Mạng T8, Biên Hòa', 'LinhMy96', '2023-10-01'),
('KH11', N'Lý Văn Minh', '1989-04-12', N'Nam', 'minh.ly@gmail.com', '0812345678', N'09 Võ Văn Tần, Quy Nhơn', 'MinhLy89', '2023-11-20'),
('KH12', N'Tạ Thu Nga', '1994-06-25', N'Nữ', 'nga.ta@gmail.com', '0823456789', N'15 Xuân Thủy, Hà Nội', 'NgaThu94', '2023-12-05'),
('KH13', N'Nguyễn Đức Phúc', '2001-09-17', N'Nam', 'phuc.nguyen@gmail.com', '0834567890', N'42 Đinh Tiên Hoàng, Đà Lạt', 'Phuc2001', '2024-01-12'),
('KH14', N'Trương Mỹ Quyên', '1998-02-28', N'Nữ', 'quyen.truong@gmail.com', '0845678901', N'66 Lê Duẩn, HCM', 'QuyenMy98', '2024-02-14'),
('KH15', N'Sơn Tùng MTP', '1994-07-05', N'Nam', 'tung.son@gmail.com', '0856789012', N'99 Thái Bình', 'TungMTP94', '2024-03-01'),
('KH16', N'Võ Văn Thắng', '1987-03-15', N'Nam', 'thang.vo@gmail.com', '0867890123', N'123 Trường Chinh, HCM', 'ThangVo87', '2024-03-15'),
('KH17', N'Phan Như Uyên', '1999-12-12', N'Nữ', 'uyen.phan@gmail.com', '0878901234', N'20 Trần Phú, Vũng Tàu', 'UyenNhu99', '2024-04-10'),
('KH18', N'Cao Văn Xuân', '1986-05-01', N'Nam', 'xuan.cao@gmail.com', '0889012345', N'88 Hàm Nghi, HCM', 'XuanCao86', '2024-04-20'),
('KH19', N'Dương Thị Yến', '1995-11-22', N'Nữ', 'yen.duong@gmail.com', '0890123456', N'05 Bạch Đằng, Đà Nẵng', 'YenDuong95', '2024-05-01'),
('KH20', N'Mai Văn Zũng', '1992-06-06', N'Nam', 'zung.mai@gmail.com', '0701234567', N'50 Hai Bà Trưng, Hà Nội', 'ZungMai92', '2024-05-05');
-- 7. NHANVIEN (20 bản ghi)
INSERT INTO NHANVIEN (MaNV, HoTen, NgaySinh, GioiTinh, SDT, Email, DiaChi, MatKhau, QuyenSuDung, NgayVaoLam) VALUES 
('NV01', N'Lê Văn Tám', '1985-03-12', N'Nam', '0903123456', 'tam.le@nike.com', N'12 Quận 1, HCM', 'Admin@123', 2, '2020-01-01'),
('NV02', N'Nguyễn Thị Hoa', '1990-05-20', N'Nữ', '0913456789', 'hoa.nguyen@nike.com', N'45 Quận 3, HCM', 'Hoa12345', 1, '2020-02-15'),
('NV03', N'Trần Minh Tâm', '1992-08-10', N'Nam', '0924567890', 'tam.tran@nike.com', N'78 Quận 5, HCM', 'TamMinh92', 0, '2021-03-10'),
('NV04', N'Phạm Thu Thảo', '1995-11-25', N'Nữ', '0935678901', 'thao.pham@nike.com', N'12 Bình Thạnh, HCM', 'ThaoP95!', 0, '2021-05-20'),
('NV05', N'Hoàng Quốc Việt', '1988-02-14', N'Nam', '0946789012', 'viet.hoang@nike.com', N'90 Gò Vấp, HCM', 'VietHoang88', 1, '2020-06-01'),
('NV06', N'Vũ Phương Anh', '1998-07-30', N'Nữ', '0957890123', 'anh.vu@nike.com', N'34 Tân Bình, HCM', 'AnhVu98@', 0, '2022-01-15'),
('NV07', N'Đặng Hùng Dũng', '1991-09-05', N'Nam', '0968901234', 'dung.dang@nike.com', N'56 Phú Nhuận, HCM', 'DungDang91', 0, '2021-08-22'),
('NV08', N'Bùi Tuyết Mai', '1994-12-12', N'Nữ', '0979012345', 'mai.bui@nike.com', N'11 Quận 10, HCM', 'MaiTuyết94', 0, '2022-02-10'),
('NV09', N'Ngô Văn Tài', '1987-04-25', N'Nam', '0980123456', 'tai.ngo@nike.com', N'22 Thủ Đức, HCM', 'TaiNgo87$', 1, '2020-10-05'),
('NV10', N'Đỗ Kim Chi', '1996-01-01', N'Nữ', '0991234567', 'chi.do@nike.com', N'88 Quận 7, HCM', 'ChiKim96', 0, '2022-03-20'),
('NV11', N'Lý Hải Đăng', '1993-06-18', N'Nam', '0812345678', 'dang.ly@nike.com', N'15 Bình Tân, HCM', 'DangLy93!', 0, '2021-11-11'),
('NV12', N'Trương Mỹ Hạnh', '1997-02-28', N'Nữ', '0823456789', 'hanh.truong@nike.com', N'67 Quận 11, HCM', 'HanhMy97', 0, '2022-05-05'),
('NV13', N'Võ Thành Ý', '1990-10-10', N'Nam', '0834567890', 'y.vo@nike.com', N'09 Quận 4, HCM', 'ThanhY90', 1, '2020-12-25'),
('NV14', N'Phan Thanh Bình', '1989-05-05', N'Nam', '0845678901', 'binh.phan@nike.com', N'102 Nhà Bè, HCM', 'BinhPhan89', 0, '2021-02-14'),
('NV15', N'Diệp Bảo Ngọc', '1999-09-09', N'Nữ', '0856789012', 'ngoc.diep@nike.com', N'44 Củ Chi, HCM', 'NgocDiep99', 0, '2023-01-01'),
('NV16', N'Lâm Vĩnh Hải', '1992-04-20', N'Nam', '0867890123', 'hai.lam@nike.com', N'33 Hóc Môn, HCM', 'HaiLam92', 0, '2021-07-07'),
('NV17', N'Quách Ngọc Ngoan', '1986-12-30', N'Nam', '0878901234', 'ngoan.quach@nike.com', N'55 Quận 8, HCM', 'Ngoan86#', 0, '2020-04-18'),
('NV18', N'Tạ Quang Thắng', '1988-03-03', N'Nam', '0889012345', 'thang.ta@nike.com', N'77 Quận 12, HCM', 'ThangTa88', 0, '2021-09-30'),
('NV19', N'Mạc Văn Khoa', '1992-06-06', N'Nam', '0890123456', 'khoa.mac@nike.com', N'19 Bình Chánh, HCM', 'KhoaMac92', 0, '2022-10-10'),
('NV20', N'Nguyễn Thanh Sơn', '1991-01-20', N'Nam', '0701234567', 'son.nguyen@nike.com', N'25 Quận 9, HCM', 'SonThanh91', 0, '2021-06-15');
-- 8. SANPHAM (20 bản ghi)
INSERT INTO SANPHAM (MaSP, TenSP, MoTa, DonViTinh, ThuongHieu, ChatLieu, GioiTinh, DoiTuongSuDung, MaLSP, MaNCC) VALUES 
('SP01', N'Air Max 90', N'Giày chạy bộ huyền thoại', N'Đôi', 'Nike', N'Da/Lưới', N'Unisex', N'Người lớn', 'LSP01', 'NCC01'),
('SP02', N'Air Force 1', N'Giày thời trang classic', N'Đôi', 'Nike', N'Da', N'Unisex', N'Người lớn', 'LSP04', 'NCC01'),
('SP03', N'Jordan 1 High', N'Giày bóng rổ cổ cao', N'Đôi', 'Nike', N'Da cao cấp', N'Nam', N'Người lớn', 'LSP02', 'NCC02'),
('SP04', N'Mercurial Zoom', N'Giày đá bóng sân cỏ nhân tạo', N'Đôi', 'Nike', N'Sợi tổng hợp', N'Nam', N'Cầu thủ', 'LSP03', 'NCC17'),
('SP05', N'Metcon 9', N'Giày tập gym chuyên dụng', N'Đôi', 'Nike', N'Lưới bền bỉ', N'Unisex', N'Người tập gym', 'LSP05', 'NCC01'),
('SP06', N'Dri-FIT Tee', N'Áo thun thể thao thoáng mát', N'Cái', 'Nike', N'Polyester', N'Nam', N'Người lớn', 'LSP06', 'NCC03'),
('SP07', N'Windrunner', N'Áo khoác gió chạy bộ', N'Cái', 'Nike', N'Nylon', N'Unisex', N'Người lớn', 'LSP07', 'NCC04'),
('SP08', N'Challenger Shorts', N'Quần short chạy bộ', N'Cái', 'Nike', N'Polyester', N'Nam', N'Vận động viên', 'LSP08', 'NCC03'),
('SP09', N'Tech Fleece', N'Quần dài giữ nhiệt', N'Cái', 'Nike', N'Cotton/Poly', N'Nam', N'Người lớn', 'LSP09', 'NCC05'),
('SP10', N'Elite Socks', N'Tất thể thao cổ cao', N'Đôi', 'Nike', N'Sợi tổng hợp', N'Unisex', N'Trẻ em/Người lớn', 'LSP10', 'NCC09'),
('SP11', N'Heritage Cap', N'Mũ lưỡi trai thời trang', N'Cái', 'Nike', N'Cotton', N'Unisex', N'Người lớn', 'LSP11', 'NCC10'),
('SP12', N'Hayward Backpack', N'Balo đi học/thể thao', N'Cái', 'Nike', N'Polyester', N'Unisex', N'Học sinh/Sinh viên', 'LSP12', 'NCC10'),
('SP13', N'Club Hoodie', N'Áo nỉ có mũ', N'Cái', 'Nike', N'Nỉ chân cua', N'Unisex', N'Người lớn', 'LSP13', 'NCC04'),
('SP14', N'Court Lite 4', N'Giày tennis chuyên nghiệp', N'Đôi', 'Nike', N'Da tổng hợp', N'Nữ', N'Người chơi tennis', 'LSP14', 'NCC01'),
('SP15', N'SB Dunk Low', N'Giày trượt ván thời trang', N'Đôi', 'Nike', N'Da lộn', N'Unisex', N'Giới trẻ', 'LSP15', 'NCC02'),
('SP16', N'Pro Tank', N'Áo ba lỗ thể thao', N'Cái', 'Nike', N'Spandex', N'Nữ', N'Người tập gym', 'LSP16', 'NCC05'),
('SP17', N'Futura Crossbody', N'Túi đeo chéo nhỏ gọn', N'Cái', 'Nike', N'Polyester', N'Unisex', N'Người lớn', 'LSP17', 'NCC13'),
('SP18', N'Hyperfuel Bottle', N'Bình nước thể thao', N'Cái', 'Nike', N'Nhựa BPA Free', N'Unisex', N'Người lớn', 'LSP18', 'NCC18'),
('SP19', N'Vapor Gloves', N'Găng tay thể thao', N'Cái', 'Nike', N'Vải tổng hợp', N'Unisex', N'Vận động viên', 'LSP19', 'NCC19'),
('SP20', N'Wristband', N'Băng cổ tay thấm mồ hôi', N'Cái', 'Nike', N'Thun', N'Unisex', N'Người lớn', 'LSP20', 'NCC19');
-- 9. CHITIET_SANPHAM (20 bản ghi)
INSERT INTO CHITIET_SANPHAM (MaCTSP, MaSP, MaMau, MaSize, SKU, GiaNhap, GiaBan, SoLuongTon) VALUES 
('CT01', 'SP01', 'M01', 'S40', 'SKU01', 2000000, 3500000, 50),
('CT02', 'SP02', 'M02', 'S41', 'SKU02', 1500000, 2800000, 40),
('CT03', 'SP03', 'M03', 'S42', 'SKU03', 3000000, 5500000, 20),
('CT04', 'SP04', 'M04', 'S40', 'SKU04', 2500000, 4200000, 30),
('CT05', 'SP05', 'M02', 'S41', 'SKU05', 1800000, 3200000, 25),
('CT06', 'SP06', 'M01', 'S39', 'SKU06', 400000, 850000, 100),
('CT07', 'SP07', 'M05', 'S38', 'SKU07', 1200000, 2200000, 15),
('CT08', 'SP08', 'M02', 'S40', 'SKU08', 350000, 750000, 60),
('CT09', 'SP09', 'M10', 'S41', 'SKU09', 1500000, 2900000, 12),
('CT10', 'SP10', 'M01', 'S35', 'SKU10', 150000, 350000, 200),
('CT11', 'SP11', 'M02', 'S35', 'SKU11', 200000, 450000, 80),
('CT12', 'SP12', 'M04', 'S35', 'SKU12', 600000, 1200000, 45),
('CT13', 'SP13', 'M03', 'S41', 'SKU13', 900000, 1800000, 33),
('CT14', 'SP14', 'M01', 'S42', 'SKU14', 1100000, 2100000, 18),
('CT15', 'SP15', 'M20', 'S43', 'SKU15', 2200000, 3900000, 10),
('CT16', 'SP16', 'M09', 'S38', 'SKU16', 300000, 650000, 70),
('CT17', 'SP17', 'M02', 'S35', 'SKU17', 450000, 950000, 55),
('CT18', 'SP18', 'M04', 'S35', 'SKU18', 250000, 550000, 90),
('CT19', 'SP19', 'M02', 'S35', 'SKU19', 350000, 800000, 40),
('CT20', 'SP20', 'M03', 'S35', 'SKU20', 100000, 250000, 150);
-- 10. HOADON (20 bản ghi)
INSERT INTO HOADON (SoHD, NgayDat,  MaKH, MaNVDuyet, MaNVGiao, MaKM,  TongTien, PhiVanChuyen, GiamGia, PhuongThucThanhToan, DiaChiGiaoHang) VALUES 
('HD01', '2024-01-05',  'KH01', 'NV02', 'NV04', 'KM01',  3500000, 30000, 0, N'Tiền mặt', N'123 Lê Lợi, TP. HCM'),
('HD02', '2024-01-06', 'KH02', 'NV03', 'NV05', 'KM01',  2800000, 30000, 0, N'Chuyển khoản', N'456 Nguyễn Huệ, Nha Trang'),
('HD03', '2024-02-14',  'KH03', 'NV02', 'NV04', 'KM02',  5500000, 0, 50000, N'Ví điện tử', N'789 Trần Hưng Đạo, Hà Nội'),
('HD04', '2024-03-08',  'KH04', 'NV07', 'NV09', 'KM03',  4200000, 35000, 0, N'Tiền mặt', N'12 Lý Tự Trọng, Đà Nẵng'),
('HD05', '2024-05-01','KH05', 'NV08', 'NV10', 'KM04',  3200000, 0, 100000, N'Chuyển khoản', N'88 Quang Trung, Gò Vấp'),
('HD06', '2024-06-15', 'KH06', 'NV02', 'NV04', 'KM05',  850000, 20000, 0, N'Tiền mặt', N'22 Hòa Bình, Cần Thơ'),
('HD07', '2024-07-20',  'KH07', 'NV03', 'NV05', 'KM05',  2200000, 30000, 0, N'Tiền mặt', N'101 Hùng Vương, Hải Phòng'),
('HD08', '2024-09-02',  'KH08', 'NV07', 'NV09', 'KM06',  750000, 25000, 0, N'Chuyển khoản', N'55 Phan Chu Trinh, Huế'),
('HD09', '2024-11-25', 'KH09', 'NV08', 'NV10', 'KM07',  2900000, 0, 200000, N'Ví điện tử', N'34 Điện Biên Phủ, HCM'),
('HD10', '2024-12-25',  'KH10', 'NV02', 'NV04', 'KM08',  350000, 15000, 0, N'Tiền mặt', N'77 Cách Mạng T8, Biên Hòa'),
('HD11', '2024-01-15',  'KH11', 'NV03', 'NV05', 'KM09',  450000, 20000, 0, N'Chuyển khoản', N'09 Võ Văn Tần, Quy Nhơn'),
('HD12', '2024-02-20',  'KH12', 'NV07', 'NV09', 'KM10',  1200000, 30000, 0, N'Tiền mặt', N'15 Xuân Thủy, Hà Nội'),
('HD13', '2024-03-25',  'KH13', 'NV08', 'NV10', 'KM11',  1800000, 0, 0, N'Chuyển khoản', N'42 Đinh Tiên Hoàng, Đà Lạt'),
('HD14', '2024-04-10',  'KH14', 'NV12', 'NV14', 'KM12',  2100000, 30000, 0, N'Tiền mặt', N'66 Lê Duẩn, HCM'),
('HD15', '2024-05-15',  'KH15', 'NV13', 'NV15', 'KM13',  3900000, 0, 150000, N'Chuyển khoản', N'99 Thái Bình'),
('HD16', '2024-06-20',  'KH16', 'NV12', 'NV14', 'KM14',  650000, 20000, 0, N'Tiền mặt', N'123 Trường Chinh, HCM'),
('HD17', '2024-07-25',  'KH17', 'NV13', 'NV15', 'KM15',  950000, 25000, 0, N'Ví điện tử', N'20 Trần Phú, Vũng Tàu'),
('HD18', '2024-08-10',  'KH18', 'NV12', 'NV14', 'KM16',  550000, 15000, 0, N'Tiền mặt', N'88 Hàm Nghi, HCM'),
('HD19', '2024-09-20',  'KH19', 'NV13', 'NV15', 'KM17',  800000, 20000, 0, N'Chuyển khoản', N'05 Bạch Đằng, Đà Nẵng'),
('HD20', '2024-10-30',  'KH20', 'NV12', 'NV14', 'KM18',  250000, 10000, 0, N'Tiền mặt', N'50 Hai Bà Trưng, Hà Nội');

-- 11. CHITIET_HD (20 bản ghi)
INSERT INTO CHITIET_HD (SoHD, MaCTSP, SoLuong, DonGiaBan, ThanhTien) VALUES 
('HD01', 'CT01', 1, 3500000, 3500000),
('HD02', 'CT02', 1, 2800000, 2800000),
('HD03', 'CT03', 1, 5500000, 5500000),
('HD04', 'CT04', 1, 4200000, 4200000),
('HD05', 'CT05', 1, 3200000, 3200000),
('HD06', 'CT06', 1, 850000, 850000),
('HD07', 'CT07', 1, 2200000, 2200000),
('HD08', 'CT08', 1, 750000, 750000),
('HD09', 'CT09', 1, 2900000, 2900000),
('HD10', 'CT10', 1, 350000, 350000),
('HD11', 'CT11', 1, 450000, 450000),
('HD12', 'CT12', 1, 1200000, 1200000),
('HD13', 'CT13', 1, 1800000, 1800000),
('HD14', 'CT14', 1, 2100000, 2100000),
('HD15', 'CT15', 1, 3900000, 3900000),
('HD16', 'CT16', 1, 650000, 650000),
('HD17', 'CT17', 1, 950000, 950000),
('HD18', 'CT18', 1, 550000, 550000),
('HD19', 'CT19', 1, 800000, 800000),
('HD20', 'CT20', 1, 250000, 250000);
-- 12. PHIEUNHAP (20 bản ghi)
INSERT INTO PHIEUNHAP (MaPN, MaNCC, MaNV, NgayNhap, TongTien, GhiChu, TrangThai) VALUES 
('PN01', 'NCC01', 'NV16', '2024-01-02', 100000000, N'Nhập hàng đầu năm', 1),
('PN02', 'NCC01', 'NV17', '2024-01-03', 50000000, N'Nhập bổ sung', 1),
('PN03', 'NCC02', 'NV16', '2024-01-05', 150000000, N'Hàng nhập khẩu Jordan', 1),
('PN04', 'NCC03', 'NV17', '2024-01-10', 20000000, N'Nhập áo thun', 1),
('PN05', 'NCC04', 'NV16', '2024-02-15', 45000000, N'Nhập áo khoác', 1),
('PN06', 'NCC05', 'NV17', '2024-02-20', 30000000, N'Nhập quần dài', 1),
('PN07', 'NCC06', 'NV16', '2024-03-01', 80000000, N'Gia công đợt 1', 1),
('PN08', 'NCC07', 'NV17', '2024-03-10', 90000000, N'Gia công đợt 2', 1),
('PN09', 'NCC08', 'NV16', '2024-03-20', 55000000, N'Nhập da giày', 1),
('PN10', 'NCC09', 'NV17', '2024-04-01', 25000000, N'Nhập tất/vớ', 1),
('PN11', 'NCC10', 'NV16', '2024-04-15', 40000000, N'Nhập phụ kiện mũ', 1),
('PN12', 'NCC11', 'NV17', '2024-05-05', 15000000, N'Nhập vật liệu A', 1),
('PN13', 'NCC12', 'NV16', '2024-05-15', 10000000, N'Phí vận chuyển nhập', 1),
('PN14', 'NCC13', 'NV17', '2024-06-01', 12000000, N'Nhập bao bì', 1),
('PN15', 'NCC14', 'NV16', '2024-06-15', 18000000, N'Chi phí kho vận', 1),
('PN16', 'NCC15', 'NV17', '2024-07-01', 22000000, N'Nhập khẩu SB Dunk', 1),
('PN17', 'NCC16', 'NV16', '2024-07-20', 60000000, N'Nhập dệt may', 1),
('PN18', 'NCC17', 'NV17', '2024-08-05', 70000000, N'Nhập cao su đế giày', 1),
('PN19', 'NCC18', 'NV16', '2024-08-15', 10000000, N'Nhập nhựa phụ kiện', 1),
('PN20', 'NCC19', 'NV17', '2024-09-01', 5000000, N'Nhập tem nhãn', 1);
-- 13. CHITIET_PHIEUNHAP (20 bản ghi)
INSERT INTO CHITIET_PHIEUNHAP (MaPN, MaCTSP, SoLuong, GiaNhap, ThanhTien) VALUES 
('PN01', 'CT01', 50, 2000000, 100000000), ('PN02', 'CT02', 33, 1500000, 49500000), 
('PN03', 'CT03', 50, 3000000, 150000000), ('PN04', 'CT06', 50, 400000, 20000000), 
('PN05', 'CT07', 37, 1200000, 44400000), ('PN06', 'CT16', 100, 300000, 30000000), 
('PN07', 'CT14', 72, 1100000, 79200000), ('PN08', 'CT05', 50, 1800000, 90000000), 
('PN09', 'CT04', 22, 2500000, 55000000), ('PN10', 'CT10', 166, 150000, 24900000), 
('PN11', 'CT11', 200, 200000, 40000000), ('PN12', 'CT18', 60, 250000, 15000000), 
('PN13', 'CT12', 16, 600000, 9600000), ('PN14', 'CT17', 26, 450000, 11700000), 
('PN15', 'CT13', 20, 900000, 18000000), ('PN16', 'CT15', 10, 2200000, 22000000), 
('PN17', 'CT01', 30, 2000000, 60000000), ('PN18', 'CT04', 28, 2500000, 70000000), 
('PN19', 'CT19', 28, 350000, 9800000), ('PN20', 'CT20', 50, 100000, 5000000);
-- 14. THANHTOAN (20 bản ghi)
INSERT INTO THANHTOAN (MaTT, SoHD, NgayThanhToan, SoTien, PhuongThuc, TrangThai) VALUES 
('TT01', 'HD01', '2024-01-05', 3500000, N'Tiền mặt', 1), ('TT02', 'HD02', '2024-01-06', 2800000, N'Chuyển khoản', 1), 
('TT03', 'HD03', '2024-02-14', 5500000, N'Momo', 1), ('TT04', 'HD04', '2024-03-08', 4200000, N'Thẻ tín dụng', 1), 
('TT05', 'HD05', '2024-05-01', 3200000, N'Tiền mặt', 1), ('TT06', 'HD06', '2024-06-15', 850000, N'Chuyển khoản', 1), 
('TT07', 'HD07', '2024-07-20', 2200000, N'Momo', 1), ('TT08', 'HD08', '2024-09-02', 750000, N'Tiền mặt', 1), 
('TT09', 'HD09', '2024-11-25', 2900000, N'Chuyển khoản', 1), ('TT10', 'HD10', '2024-12-25', 350000, N'Tiền mặt', 1), 
('TT11', 'HD11', '2024-01-15', 450000, N'Tiền mặt', 1), ('TT12', 'HD12', '2024-02-20', 1200000, N'Chuyển khoản', 1), 
('TT13', 'HD13', '2024-03-25', 1800000, N'Momo', 1), ('TT14', 'HD14', '2024-04-10', 2100000, N'Tiền mặt', 1), 
('TT15', 'HD15', '2024-05-15', 3900000, N'Chuyển khoản', 1), ('TT16', 'HD16', '2024-06-20', 650000, N'Momo', 1), 
('TT17', 'HD17', '2024-07-25', 950000, N'Tiền mặt', 1), ('TT18', 'HD18', '2024-08-10', 550000, N'Chuyển khoản', 1), 
('TT19', 'HD19', '2024-09-20', 800000, N'Tiền mặt', 1), ('TT20', 'HD20', '2024-10-30', 250000, N'Momo', 1);
-- 15. VANCHUYEN (20 bản ghi)
INSERT INTO VANCHUYEN (MaVC, SoHD, DonViVanChuyen, MaVanDon, NgayGui, NgayNhan, TrangThai) VALUES 
('VC01', 'HD01', N'GHTK', 'VD01', '2024-01-05', '2024-01-07', N'Đã giao'),
('VC02', 'HD02', N'GHN', 'VD02', '2024-01-06', '2024-01-08', N'Đã giao'),
('VC03', 'HD03', N'Viettel Post', 'VD03', '2024-02-14', '2024-02-16', N'Đã giao'),
('VC04', 'HD04', N'GHTK', 'VD04', '2024-03-08', NULL, N'Đang giao'),
('VC05', 'HD05', N'J&T', 'VD05', '2024-05-01', NULL, N'Đang giao'),
('VC06', 'HD06', N'GHN', 'VD06', '2024-06-15', '2024-06-17', N'Đã giao'),
('VC07', 'HD07', N'GHTK', 'VD07', '2024-07-20', '2024-07-22', N'Đã giao'),
('VC08', 'HD08', N'Viettel Post', 'VD08', '2024-09-02', '2024-09-04', N'Đã giao'),
('VC09', 'HD09', N'J&T', 'VD09', '2024-11-25', NULL, N'Đang giao'),
('VC10', 'HD10', N'GHTK', 'VD10', '2024-12-25', '2024-12-27', N'Đã giao'),
('VC11', 'HD11', N'GHN', 'VD11', '2024-01-15', '2024-01-17', N'Đã giao'),
('VC12', 'HD12', N'J&T', 'VD12', '2024-02-20', '2024-02-22', N'Đã giao'),
('VC13', 'HD13', N'Viettel Post', 'VD13', '2024-03-25', '2024-03-27', N'Đã giao'),
('VC14', 'HD14', N'GHTK', 'VD14', '2024-04-10', '2024-04-12', N'Đã giao'),
('VC15', 'HD15', N'GHN', 'VD15', '2024-05-15', NULL, N'Đang giao'),
('VC16', 'HD16', N'Viettel Post', 'VD16', '2024-06-20', '2024-06-22', N'Đã giao'),
('VC17', 'HD17', N'J&T', 'VD17', '2024-07-25', '2024-07-27', N'Đã giao'),
('VC18', 'HD18', N'GHTK', 'VD18', '2024-08-10', '2024-08-12', N'Đã giao'),
('VC19', 'HD19', N'GHN', 'VD19', '2024-09-20', NULL, N'Chờ lấy hàng'),
('VC20', 'HD20', N'Viettel Post', 'VD20', '2024-10-30', '2024-11-01', N'Đã giao');
-- 16. DANHGIASANPHAM (20 bản ghi)
INSERT INTO DANHGIASANPHAM (MaDG, MaKH, MaSP, SoSao, NoiDung, NgayDanhGia, TrangThai) VALUES 
('DG01', 'KH01', 'SP01', 5, N'Giày đẹp lắm', '2024-01-10', 1), ('DG02', 'KH02', 'SP02', 4, N'Hơi chật tí', '2024-01-12', 1),
('DG03', 'KH03', 'SP03', 5, N'Đáng đồng tiền', '2024-02-20', 1), ('DG04', 'KH04', 'SP04', 3, N'Giao hơi lâu', '2024-03-15', 1),
('DG05', 'KH05', 'SP05', 5, N'Rất êm chân', '2024-05-10', 1), ('DG06', 'KH06', 'SP06', 4, N'Áo thun mát', '2024-06-20', 1),
('DG07', 'KH07', 'SP07', 5, N'Áo khoác ấm', '2024-07-25', 1), ('DG08', 'KH08', 'SP08', 4, N'Quần mặc thoải mái', '2024-09-10', 1),
('DG09', 'KH09', 'SP09', 5, N'Chất lượng Nike thì khỏi bàn', '2024-11-30', 1), ('DG10', 'KH10', 'SP10', 5, N'Tất mềm', '2024-12-30', 1),
('DG11', 'KH11', 'SP11', 4, N'Nón đẹp', '2024-01-20', 1), ('DG12', 'KH12', 'SP12', 5, N'Balo rộng rãi', '2024-02-25', 1),
('DG13', 'KH13', 'SP13', 4, N'Hoodie ấm', '2024-03-30', 1), ('DG14', 'KH14', 'SP14', 3, N'Đế hơi cứng', '2024-04-15', 1),
('DG15', 'KH15', 'SP15', 5, N'Màu sắc rất đẹp', '2024-05-20', 1), ('DG16', 'KH16', 'SP16', 4, N'Mặc đi tập gym rất tốt', '2024-06-25', 1),
('DG17', 'KH17', 'SP17', 5, N'Túi nhỏ gọn', '2024-07-30', 1), ('DG18', 'KH18', 'SP18', 5, N'Bình giữ nhiệt tốt', '2024-08-15', 1),
('DG19', 'KH19', 'SP19', 4, N'Găng tay chắc chắn', '2024-09-25', 1), ('DG20', 'KH20', 'SP20', 5, N'Phụ kiện tốt', '2024-11-05', 1);
-- 17. TRAHANG (20 bản ghi)
INSERT INTO TRAHANG (MaTra, SoHD, MaKH, NgayTra, LyDo, TongTienHoan, TrangThai) VALUES 
('T01', 'HD04', 'KH04', '2024-03-12', N'Lỗi kệ đế', 4200000, N'Đã hoàn tiền'), 
('T02', 'HD09', 'KH09', '2024-11-30', N'Size quá lớn', 2900000, N'Đang xử lý'),
('T03', 'HD01', 'KH01', '2024-01-10', N'Đổi màu', 0, N'Từ chối'), 
('T04', 'HD15', 'KH15', '2024-05-20', N'Sai sản phẩm', 3900000, N'Đã hoàn tiền'),
('T05', 'HD19', 'KH19', '2024-09-25', N'Hàng giả (nghi ngờ)', 800000, N'Đang xử lý'), 
('T06', 'HD12', 'KH12', '2024-02-25', N'Lỗi đường chỉ', 1200000, N'Đã hoàn tiền'),
('T07', 'HD05', 'KH05', '2024-05-10', N'Không ưng ý', 3200000, N'Từ chối'), 
('T08', 'HD02', 'KH02', '2024-01-12', N'Hư hỏng khi vận chuyển', 2800000, N'Đã hoàn tiền'),
('T09', 'HD10', 'KH10', '2024-12-30', N'Nhầm size', 350000, N'Đã hoàn tiền'), 
('T10', 'HD03', 'KH03', '2024-02-20', N'Lỗi sản xuất', 5500000, N'Đã hoàn tiền'),
('T11', 'HD11', 'KH11', '2024-01-20', N'Lỗi màu', 450000, N'Đã hoàn tiền'), 
('T12', 'HD06', 'KH06', '2024-06-20', N'Hư khóa kéo', 850000, N'Đã hoàn tiền'),
('T13', 'HD07', 'KH07', '2024-07-25', N'Rách vải', 2200000, N'Đã hoàn tiền'), 
('T14', 'HD13', 'KH13', '2024-03-30', N'Bung keo', 1800000, N'Đã hoàn tiền'),
('T15', 'HD20', 'KH20', '2024-11-05', N'Sai màu', 250000, N'Đã hoàn tiền'), 
('T16', 'HD14', 'KH14', '2024-04-15', N'Trầy xước', 2100000, N'Đã hoàn tiền'),
('T17', 'HD18', 'KH18', '2024-08-15', N'Thiếu phụ kiện', 550000, N'Đã hoàn tiền'), 
('T18', 'HD16', 'KH16', '2024-06-25', N'Không giống hình', 650000, N'Đã hoàn tiền'),
('T19', 'HD17', 'KH17', '2024-07-30', N'Mùi hôi lạ', 950000, N'Đã hoàn tiền'), 
('T20', 'HD08', 'KH08', '2024-09-10', N'Đế bị ố vàng', 750000, N'Đã hoàn tiền');
-- 18. CHITIET_TRAHANG (20 bản ghi)
INSERT INTO CHITIET_TRAHANG (MaTra, MaCTSP, SoLuong, DonGia, ThanhTien) VALUES 
('T01', 'CT04', 1, 4200000, 4200000), ('T02', 'CT09', 1, 2900000, 2900000), 
('T04', 'CT15', 1, 3900000, 3900000), ('T05', 'CT19', 1, 800000, 800000), 
('T06', 'CT12', 1, 1200000, 1200000), ('T08', 'CT02', 1, 2800000, 2800000), 
('T09', 'CT10', 1, 350000, 350000), ('T10', 'CT03', 1, 5500000, 5500000), 
('T11', 'CT11', 1, 450000, 450000), ('T12', 'CT06', 1, 850000, 850000), 
('T13', 'CT07', 1, 2200000, 2200000), ('T14', 'CT13', 1, 1800000, 1800000), 
('T15', 'CT20', 1, 250000, 250000), ('T16', 'CT14', 1, 2100000, 2100000), 
('T17', 'CT18', 1, 550000, 550000), ('T18', 'CT16', 1, 650000, 650000), 
('T19', 'CT17', 1, 950000, 950000), ('T20', 'CT08', 1, 750000, 750000), 
('T03', 'CT01', 1, 3500000, 3500000), ('T07', 'CT05', 1, 3200000, 3200000);

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
--Yêu cầu 4:
--Tạo 7 thủ tục

<<<<<<< HEAD
-- 1. THỦ TỤC ĐĂNG KÝ KHÁCH HÀNG MỚI (Dùng cho trang Đăng ký)
-- Kiểm tra xem Email hoặc SĐT đã tồn tại chưa trước khi thêm mới

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_KhachHang_DangKy')
    DROP PROCEDURE sp_KhachHang_DangKy;
GO
CREATE PROCEDURE sp_KhachHang_DangKy
    @MaKH VARCHAR(10),
    @HoTen NVARCHAR(100),
    @NgaySinh DATE,
    @GioiTinh NVARCHAR(10),
    @Email VARCHAR(100),
    @SDT VARCHAR(15),
    @DiaChi NVARCHAR(255),
    @MatKhau VARCHAR(50)
AS
BEGIN
    -- Kiểm tra trùng lặp Email hoặc Số điện thoại
    IF EXISTS (SELECT 1 FROM KHACHHANG WHERE Email = @Email OR SDT = @SDT)
    BEGIN
        PRINT N'LỖI: Email hoặc Số điện thoại đã được sử dụng!';
        RETURN;
    END

    -- Thêm khách hàng mới
    INSERT INTO KHACHHANG (MaKH, HoTen, NgaySinh, GioiTinh, Email, SDT, DiaChi, MatKhau, NgayDangKy, DiemTichLuy, TrangThai)
    VALUES (@MaKH, @HoTen, @NgaySinh, @GioiTinh, @Email, @SDT, @DiaChi, @MatKhau, GETDATE(), 0, 1);
    
    PRINT N'Đăng ký khách hàng thành công!';
END
GO
-- Minh họa: EXEC sp_KhachHang_DangKy 'KH21', N'Lê Mới', '2000-01-01', N'Nam', 'lemoi@gmail.com', '0123456789', N'Nha Trang', '123456';


-- 2. THỦ TỤC ĐĂNG NHẬP KHÁCH HÀNG (Dùng cho trang Đăng nhập)
-- Trả về thông tin khách hàng nếu đúng Email và Mật khẩu

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_KhachHang_DangNhap')
    DROP PROCEDURE sp_KhachHang_DangNhap;
GO
CREATE PROCEDURE sp_KhachHang_DangNhap
    @Email VARCHAR(100),
    @MatKhau VARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM KHACHHANG WHERE Email = @Email AND MatKhau = @MatKhau AND TrangThai = 1)
    BEGIN
        -- Trả về data để MVC lưu vào Session
        SELECT MaKH, HoTen, Email, SDT, DiaChi, DiemTichLuy 
        FROM KHACHHANG 
        WHERE Email = @Email AND MatKhau = @MatKhau;
    END
    ELSE
    BEGIN
        PRINT N'LỖI: Sai email, mật khẩu hoặc tài khoản đã bị khóa!';
    END
END
GO
-- Minh họa: EXEC sp_KhachHang_DangNhap 'an.nguyen@gmail.com', 'Pass123';


-- 3. THỦ TỤC TẠO HÓA ĐƠN MỚI (Dùng khi khách bấm Thanh toán)

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_HoaDon_TaoMoi')
    DROP PROCEDURE sp_HoaDon_TaoMoi;
GO
CREATE PROCEDURE sp_HoaDon_TaoMoi
    @SoHD VARCHAR(10),
    @MaKH VARCHAR(10),
    @MaKM VARCHAR(10) = NULL, -- Có thể NULL nếu không xài mã giảm giá
    @TongTien DECIMAL(18, 2),
    @PhiVanChuyen DECIMAL(18, 2),
    @GiamGia DECIMAL(18, 2),
    @PhuongThucThanhToan NVARCHAR(50),
    @DiaChiGiaoHang NVARCHAR(255),
    @GhiChu NVARCHAR(MAX) = NULL
AS
BEGIN
    INSERT INTO HOADON (SoHD, NgayDat, MaKH, MaKM, TinhTrang, TongTien, PhiVanChuyen, GiamGia, PhuongThucThanhToan, DiaChiGiaoHang, GhiChu)
    VALUES (@SoHD, GETDATE(), @MaKH, @MaKM, 0, @TongTien, @PhiVanChuyen, @GiamGia, @PhuongThucThanhToan, @DiaChiGiaoHang, @GhiChu);
    
    PRINT N'Tạo hóa đơn thành công. Trạng thái: Chờ duyệt (0)';
END
GO
-- Minh họa: EXEC sp_HoaDon_TaoMoi 'HD21', 'KH01', NULL, 2000000, 30000, 0, N'Tiền mặt', N'Nha Trang', N'Giao giờ hành chính';


-- 4. THỦ TỤC THÊM CHI TIẾT HÓA ĐƠN (Chạy lặp qua từng món trong Giỏ hàng)
-- Tính sẵn Thành Tiền = Số lượng * Đơn giá

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_HoaDon_ThemChiTiet')
    DROP PROCEDURE sp_HoaDon_ThemChiTiet;
GO
CREATE PROCEDURE sp_HoaDon_ThemChiTiet
    @SoHD VARCHAR(10),
    @MaCTSP VARCHAR(15),
    @SoLuong INT,
    @DonGiaBan DECIMAL(18, 2)
AS
BEGIN
    DECLARE @ThanhTien DECIMAL(18, 2);
    SET @ThanhTien = @SoLuong * @DonGiaBan;

    INSERT INTO CHITIET_HD (SoHD, MaCTSP, SoLuong, DonGiaBan, ThanhTien, GiamGia, TrangThaiTraHang)
    VALUES (@SoHD, @MaCTSP, @SoLuong, @DonGiaBan, @ThanhTien, 0, 0);
    
    -- (Lưu ý: Trigger trg_GiamTonKho của bạn sẽ tự động chạy ngầm ở bước này để trừ kho)
END
GO
-- Minh họa: EXEC sp_HoaDon_ThemChiTiet 'HD21', 'CT01', 1, 3500000;


-- 5. THỦ TỤC DUYỆT / CẬP NHẬT TRẠNG THÁI HÓA ĐƠN (Dùng cho Admin)

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_HoaDon_CapNhatTrangThai')
    DROP PROCEDURE sp_HoaDon_CapNhatTrangThai;
GO
CREATE PROCEDURE sp_HoaDon_CapNhatTrangThai
    @SoHD VARCHAR(10),
    @TinhTrangMoi INT, -- 1: Đã duyệt/Đang giao, 2: Hoàn thành
    @MaNVDuyet VARCHAR(10)
AS
BEGIN
    UPDATE HOADON
    SET TinhTrang = @TinhTrangMoi,
        MaNVDuyet = @MaNVDuyet
    WHERE SoHD = @SoHD;

    PRINT N'Cập nhật trạng thái đơn hàng thành công!';
END
GO
-- Minh họa: EXEC sp_HoaDon_CapNhatTrangThai 'HD21', 1, 'NV01';


-- 6. THỦ TỤC TÌM KIẾM SẢN PHẨM (Dùng cho thanh tìm kiếm trên Web)
-- Tìm theo tên sản phẩm dạng tương đối (LIKE)

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_SanPham_TimKiem')
    DROP PROCEDURE sp_SanPham_TimKiem;
GO
CREATE PROCEDURE sp_SanPham_TimKiem
    @TuKhoa NVARCHAR(100)
AS
BEGIN
    SELECT 
        S.MaSP, 
        S.TenSP, 
        L.TenLSP, 
        S.ThuongHieu, 
        S.GioiTinh,
        MIN(C.GiaBan) AS GiaBanThapNhat -- Lấy giá thấp nhất nếu 1 SP có nhiều phiên bản
    FROM SANPHAM S
    JOIN LOAISP L ON S.MaLSP = L.MaLSP
    JOIN CHITIET_SANPHAM C ON S.MaSP = C.MaSP
    WHERE S.TenSP LIKE '%' + @TuKhoa + '%' AND S.TrangThai = 1
    GROUP BY S.MaSP, S.TenSP, L.TenLSP, S.ThuongHieu, S.GioiTinh
    ORDER BY S.TenSP ASC;
END
GO
-- Minh họa: EXEC sp_SanPham_TimKiem N'Air Max';


-- 7. THỦ TỤC THỐNG KÊ DOANH THU THEO KHOẢNG THỜI GIAN (Dùng cho Admin Dashboard)

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_ThongKe_DoanhThu_KhoangThoiGian')
    DROP PROCEDURE sp_ThongKe_DoanhThu_KhoangThoiGian;
GO
CREATE PROCEDURE sp_ThongKe_DoanhThu_KhoangThoiGian
    @TuNgay DATE,
    @DenNgay DATE
AS
BEGIN
    SELECT 
        CAST(NgayDat AS DATE) AS Ngay,
        COUNT(SoHD) AS TongSoDonHang,
        SUM(TongTien) AS TongDoanhThu
    FROM HOADON
    -- Chỉ tính những đơn hàng đã giao hoặc hoàn thành (TinhTrang >= 1)
    WHERE NgayDat >= @TuNgay AND NgayDat <= @DenNgay AND TinhTrang >= 1
    GROUP BY CAST(NgayDat AS DATE)
    ORDER BY CAST(NgayDat AS DATE) ASC;
END
GO
-- Minh họa: EXEC sp_ThongKe_DoanhThu_KhoangThoiGian '2024-01-01', '2024-12-31';
=======
>>>>>>> eac908ebbb153cb0e88333baa6fde93a5fb4490b

--8 hàm 
--hàm lấy thông tin khách hàng dựa vào số điện thoại
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fn_TimKH_SDT')
    DROP FUNCTION fn_TimKH_SDT
GO
CREATE FUNCTION fn_TimKH_SDT (@SDT VARCHAR(15))
RETURNS Table
AS
RETURN
(
SELECT  MaKH ,HoTen ,NgaySinh , GioiTinh,  Email ,SDT ,DiaChi FROM KHACHHANG WHERE SDT=@SDT
)
GO
-- Minh họa: SELECT * FROM dbo.fn_TimKH_SDT('0999')

--Hàm tính tích lũy điểm
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fn_QuyDoiDiem' AND type = 'FN')
    DROP FUNCTION fn_QuyDoiDiem
GO
CREATE FUNCTION fn_QuyDoiDiem (@SoTien DECIMAL(18,2))
RETURNS INT
AS
BEGIN
    RETURN CAST(@SoTien / 100000 AS INT)
END
GO
-- Minh họa: SELECT dbo.fn_QuyDoiDiem(500000)
--Hàm trả về danh sách sản phẩm của 1 nhà cung cấp
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fn_SanPhamTheoNCC')
    DROP FUNCTION fn_SanPhamTheoNCC
GO
CREATE FUNCTION fn_SanPhamTheoNCC (@MaNCC VARCHAR(10))
RETURNS TABLE
AS
RETURN (
    SELECT MaSP, TenSP FROM SANPHAM WHERE MaNCC = @MaNCC
)
GO
-- Minh họa: SELECT * FROM dbo.fn_SanPhamTheoNCC('NCC01')
--Hàm tính số lượng tồn kho của 1 chi tiết sản phẩm 
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fn_SoLuongTon' AND type = 'FN')
    DROP FUNCTION fn_SoLuongTon
GO
CREATE FUNCTION fn_SoLuongTon (@MaCTSP VARCHAR(15))
RETURNS INT
AS
BEGIN
    DECLARE @Ton INT
    SELECT @Ton = SoLuongTon FROM CHITIET_SANPHAM WHERE MaCTSP = @MaCTSP
    RETURN ISNULL(@Ton, 0)
END
GO
-- Minh họa: SELECT dbo.fn_SoLuongTon('CT001')
-- tìm thông tin sản phẩm khi biết mã sản phẩm 
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fn_ThongTinSanPhamFull')
    DROP FUNCTION fn_ThongTinSanPhamFull
GO

CREATE FUNCTION fn_ThongTinSanPhamFull (@MaSP VARCHAR(10))
RETURNS TABLE
AS
RETURN
(
    SELECT 
        S.MaSP, 
        S.TenSP, 
        L.TenLSP, 
        N.TenNCC,
        C.SKU,
        C.GiaBan,
        C.SoLuongTon,
        S.TrangThai
    FROM SANPHAM S
    JOIN LOAISP L ON S.MaLSP = L.MaLSP
    JOIN NHACUNGCAP N ON S.MaNCC = N.MaNCC
    LEFT JOIN CHITIET_SANPHAM C ON S.MaSP = C.MaSP
    WHERE S.MaSP = @MaSP
)
GO
-- minh họa SELECT * FROM dbo.fn_ThongTinSanPhamFull('SP01');
--Hàm tính tổng doanh thu
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fn_TongDoanhThu')
    DROP FUNCTION fn_TongDoanhThu
GO

CREATE FUNCTION fn_TongDoanhThu ()
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @TongDoanhThu DECIMAL(18,2);
    SELECT @TongDoanhThu = SUM(TongTien) 
    FROM HOADON;
    
    RETURN ISNULL(@TongDoanhThu, 0);
END
GO

--minh họa: SELECT dbo.fn_TongDoanhThu() AS DoanhThuToanBo;
--Hàm tính doanh thu theo từng tháng ( dữ liệu chỉ nhập trong năm 2024)
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fn_DoanhThu12Thang')
    DROP FUNCTION fn_DoanhThu12Thang
GO

CREATE FUNCTION fn_DoanhThu12Thang (@Nam INT)
RETURNS TABLE
AS
RETURN
(
    -- Sử dụng truy vấn nhóm theo tháng từ bảng HOADON
    SELECT 
        thang.Month AS Thang,
        ISNULL(SUM(H.TongTien), 0) AS DoanhThu
    FROM (
        -- Tạo danh sách giả định 12 tháng để tránh việc tháng nào không có đơn hàng bị mất dòng
        SELECT 1 AS Month UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 
        UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 
        UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12
    ) AS thang
    LEFT JOIN HOADON H ON thang.Month = MONTH(H.NgayDat) AND YEAR(H.NgayDat) = @Nam
    GROUP BY thang.Month
)
GO
--minh họa: SELECT * FROM dbo.fn_DoanhThu12Thang(2024) ORDER BY Thang;
--Hàm xếp hạng sản phẩm bán chạy trong năm qua
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fn_XepHangSanPhamBanChay')
    DROP FUNCTION fn_XepHangSanPhamBanChay
GO

CREATE FUNCTION fn_XepHangSanPhamBanChay (@Nam INT)
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 100 PERCENT
        S.MaSP,
        S.TenSP,
        SUM(CTH.SoLuong) AS TongSoLuongBan,
        RANK() OVER (ORDER BY SUM(CTH.SoLuong) DESC) AS XepHang
    FROM SANPHAM S
    JOIN CHITIET_SANPHAM CTSP ON S.MaSP = CTSP.MaSP
    JOIN CHITIET_HD CTH ON CTSP.MaCTSP = CTH.MaCTSP
    JOIN HOADON H ON CTH.SoHD = H.SoHD
    WHERE YEAR(H.NgayDat) = @Nam
    GROUP BY S.MaSP, S.TenSP
    ORDER BY TongSoLuongBan DESC
)
GO
-- minh họa : SELECT * FROM dbo.fn_XepHangSanPhamBanChay(2024);
--5 trigger.
--Trigger kiểm tra tuổi nhân viên (>= 18)
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'trg_CheckTuoiNV')
    DROP TRIGGER trg_CheckTuoiNV
GO
CREATE TRIGGER trg_CheckTuoiNV ON NHANVIEN
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE DATEDIFF(YEAR, NgaySinh, GETDATE()) < 18)
    BEGIN
        PRINT N'LỖI: Nhân viên chưa đủ 18 tuổi!'
        ROLLBACK TRANSACTION
    END
END
GO
-- VÍ DỤ MINH HỌA:
-- INSERT INTO NHANVIEN (MaNV, HoTen, NgaySinh, ...) VALUES ('NV01', 'Tuoi Tre', '2015-01-01', ...)
-- SQL sẽ báo lỗi và không cho lưu nhân viên này.

--trigger tự động tăng số lượng tồn kho trong bảng CHITIET_SANPHAM khi nhập thêm trong bảng CHITIET_PHIEUNHAP 
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'trg_NhapKho')
    DROP TRIGGER trg_NhapKho
GO
CREATE TRIGGER trg_NhapKho ON CHITIET_PHIEUNHAP
AFTER INSERT
AS
BEGIN
    UPDATE CHITIET_SANPHAM
    SET SoLuongTon = SoLuongTon + (SELECT SoLuong FROM inserted WHERE inserted.MaCTSP = CHITIET_SANPHAM.MaCTSP)
    WHERE MaCTSP IN (SELECT MaCTSP FROM inserted)
END
GO
-- VÍ DỤ MINH HỌA:
-- Nhập thêm 50 đôi giày mã CT04 qua bảng CHITIET_PHIEUNHAP.
-- Kiểm tra bảng CHITIET_SANPHAM sẽ thấy SoLuongTon tăng thêm 50.

--Trigger ngăn chặn bán hàng khi kho đã hết
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'trg_KiemTraTonKho')
    DROP TRIGGER trg_KiemTraTonKho
GO
CREATE TRIGGER trg_KiemTraTonKho ON CHITIET_HD
FOR INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted i JOIN CHITIET_SANPHAM c ON i.MaCTSP = c.MaCTSP WHERE i.SoLuong > c.SoLuongTon)
    BEGIN
        PRINT N'LỖI: Kho không đủ hàng!'
        ROLLBACK TRANSACTION
    END
END
GO
-- VÍ DỤ MINH HỌA:
-- Giả sử CT02 còn 2 đôi giày. 
-- Thực hiện lệnh: INSERT INTO CHITIET_HD (SoHD, MaCTSP, SoLuong, ...) VALUES ('HD01', 'CT02', 10, ...)
-- Kết quả: SQL sẽ báo lỗi và lệnh Insert bị hủy.
--Trigger tự động trừ tồn kho khi bán hàng
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'trg_GiamTonKho')
    DROP TRIGGER trg_GiamTonKho
GO
CREATE TRIGGER trg_GiamTonKho ON CHITIET_HD
AFTER INSERT
AS
BEGIN
    UPDATE CHITIET_SANPHAM
    SET SoLuongTon = SoLuongTon - i.SoLuong
    FROM CHITIET_SANPHAM c JOIN inserted i ON c.MaCTSP = i.MaCTSP
END
GO
-- VÍ DỤ MINH HỌA:
-- Giả sử CT01 đang có 100 sản phẩm.
-- INSERT INTO CHITIET_HD (SoHD, MaCTSP, SoLuong, DonGiaBan) VALUES ('HD01', 'CT01', 5, 1000000)
-- Kiểm tra: SELECT SoLuongTon FROM CHITIET_SANPHAM WHERE MaCTSP = 'CT01' -> Kết quả sẽ là 95.
--Trigger tự động chuyển trạng thái vận chuyển khi hóa đơn hoàn tất
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'trg_UpdateHoaDonTuVanChuyen')
    DROP TRIGGER trg_UpdateHoaDonTuVanChuyen
GO

CREATE TRIGGER trg_UpdateHoaDonTuVanChuyen ON VANCHUYEN 
AFTER INSERT, UPDATE
AS
BEGIN
    -- Kiểm tra nếu có bản ghi nào được cập nhật trạng thái là 'Da giao'
    IF EXISTS (SELECT 1 FROM inserted WHERE TrangThai = N'Đã giao')
    BEGIN
        -- Cập nhật bảng HOADON dựa trên SoHD trong bảng VANCHUYEN vừa update
        UPDATE HOADON
        SET 
            TinhTrang = 1,          -- Chuyển sang trạng thái Đã giao
            NgayGiao = NgayGui    
        FROM HOADON H
        JOIN inserted i ON H.SoHD = i.SoHD
        WHERE i.TrangThai = N'Đã giao';
    END
END
GO
--Minh hoa:
--Yêu cầu 5: tạo user 

