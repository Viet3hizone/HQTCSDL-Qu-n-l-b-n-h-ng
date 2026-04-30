 
--Yêu cầu 2: Nhập dữ liệu tối thiểu 20 bản ghi cho mỗi bảng 
-- NHẬP DỮ LIỆU ĐẦY ĐỦ 20 BẢN GHI/BẢNG

-- 1. Bảng LOAISP (20 dòng)
INSERT INTO LOAISP VALUES 
('LSP01', N'Giày Chạy Bộ'), ('LSP02', N'Giày Bóng Rổ'), ('LSP03', N'Giày Lifestyle'), 
('LSP04', N'Giày Đá Banh'), ('LSP05', N'Áo Thun'), ('LSP06', N'Áo Khoác'), 
('LSP07', N'Quần Short'), ('LSP08', N'Quần Jogger'), ('LSP09', N'Balo'), 
('LSP10', N'Túi Đeo Chéo'), ('LSP11', N'Vớ/Tất'), ('LSP12', N'Mũ Lưỡi Trai'), 
('LSP13', N'Găng Tay'), ('LSP14', N'Bình Nước'), ('LSP15', N'Thảm Tập Yoga'), 
('LSP16', N'Dây Nhảy'), ('LSP17', N'Áo Hoodie'), ('LSP18', N'Áo Polo'), 
('LSP19', N'Quần Legging'), ('LSP20', N'Dép Slide');

-- 2. Bảng NHACUNGCAP (20 dòng)
INSERT INTO NHACUNGCAP VALUES 
('NCC01', N'Nike Global VN', N'Quận 1, HCM', '0901234567', 'contact@nike.vn'),
('NCC02', N'Tổng kho Nike Đông Nam Á', N'Bình Dương', '0907654321', 'sea_warehouse@nike.com'),
('NCC03', N'Xưởng Gia Công May Mặc 1', N'Đà Nẵng', '02363555666', 'factory1@vinatex.com'),
('NCC04', N'Công ty CP Giày Da Việt', N'Hải Phòng', '02253888999', 'giayviet@gmail.com'),
('NCC05', N'Nike Retail Service', N'Hà Nội', '0243111222', 'retail@nike.com.vn'),
('NCC06', N'Logistics Alpha', N'Long An', '0272312345', 'alpha@logistics.vn'),
('NCC07', N'Kho Nike Cần Thơ', N'Cần Thơ', '0292378945', 'cantho@nike.vn'),
('NCC08', N'Xưởng Phụ Kiện Sport', N'Đồng Nai', '0251398765', 'sportacc@gmail.com'),
('NCC09', N'Công ty May 10', N'Hà Nội', '0243456789', 'may10@garment.vn'),
('NCC10', N'Công ty May Nhà Bè', N'HCM', '0283456789', 'nhabe@garment.vn'),
('NCC11', N'Bình Tiên Corp', N'HCM', '0283123456', 'bitis@com.vn'),
('NCC12', N'Xưởng In Ấn Nike', N'Bắc Ninh', '02223888777', 'print@nike.vn'),
('NCC13', N'Kho Vận Việt Thái', N'Hà Tĩnh', '02393666555', 'vietthai@log.vn'),
('NCC14', N'Công ty TNHH Thể Thao Việt', N'HCM', '0283888999', 'thethaoviet@gmail.com'),
('NCC15', N'Xưởng Giày Thượng Đình', N'Hà Nội', '0243999888', 'thuongdinh@vn.com'),
('NCC16', N'Dệt Kim Đông Xuân', N'Hà Nội', '0243777666', 'dongxuan@textile.vn'),
('NCC17', N'Công ty Cao Su Đà Nẵng', N'Đà Nẵng', '02363111222', 'drc@danang.vn'),
('NCC18', N'Xưởng May Mặc 24h', N'Bắc Giang', '02043555444', 'may24h@gmail.com'),
('NCC19', N'Vận tải Trường Hải', N'Quảng Nam', '02353888111', 'thaco@log.vn'),
('NCC20', N'Hệ thống kho Shopee Nike', N'HCM', '19001221', 'shopee_nike@shopee.vn');

-- 3. Bảng KHUYENMAI (20 dòng)
INSERT INTO KHUYENMAI VALUES 
('KM01', N'Chào Hè 2026', 10.0, '2026-05-01', '2026-06-30'),
('KM02', N'Black Friday', 30.0, '2026-11-20', '2026-11-30'),
('KM03', N'Giáng Sinh An Lành', 20.0, '2026-12-20', '2026-12-31'),
('KM04', N'Mừng Xuân Mới', 15.0, '2026-01-01', '2026-02-15'),
('KM05', N'Back To School', 10.0, '2026-08-15', '2026-09-15'),
('KM06', N'Nike Membership', 5.0, '2026-01-01', '2026-12-31'),
('KM07', N'Sale Giày Chạy', 25.0, '2026-03-01', '2026-03-15'),
('KM08', N'Cuối Tuần Vui Vẻ', 7.0, '2026-01-01', '2026-12-31'),
('KM09', N'Mừng Quốc Khánh', 10.0, '2026-08-30', '2026-09-05'),
('KM10', N'Sale Phụ Kiện', 50.0, '2026-10-10', '2026-10-15'),
('KM11', N'Sinh Nhật Khách', 15.0, '2026-01-01', '2026-12-31'),
('KM12', N'Flash Sale Đêm', 40.0, '2026-04-15', '2026-04-16'),
('KM13', N'Giải Cứu Tồn Kho', 60.0, '2026-07-01', '2026-07-15'),
('KM14', N'Ngày Hội Thể Thao', 12.0, '2026-04-01', '2026-04-05'),
('KM15', N'Ưu Đãi Mở Rộng', 8.0, '2026-05-15', '2026-05-30'),
('KM16', N'Tri Ân Khách Cũ', 20.0, '2026-06-01', '2026-06-10'),
('KM17', N'Sale Hàng Mới', 5.0, '2026-02-20', '2026-02-28'),
('KM18', N'Nike App Only', 10.0, '2026-01-01', '2026-12-31'),
('KM19', N'Ngày Độc Thân', 11.0, '2026-11-11', '2026-11-12'),
('KM20', N'Siêu Sale 12/12', 22.0, '2026-12-12', '2026-12-13');

-- 4. Bảng KHACHHANG (20 dòng)
INSERT INTO KHACHHANG VALUES 
('KH01', N'Nguyễn Văn A', 'vana@gmail.com', '0911111111', N'Hà Nội', '123'),
('KH02', N'Trần Thị B', 'thib@gmail.com', '0922222222', N'HCM', '123'),
('KH03', N'Lê Văn C', 'vanc@gmail.com', '0933333333', N'Đà Nẵng', '123'),
('KH04', N'Phạm Minh D', 'minhd@gmail.com', '0944444444', N'Cần Thơ', '123'),
('KH05', N'Hoàng Anh E', 'anhe@gmail.com', '0955555555', N'Hải Phòng', '123'),
('KH06', N'Vũ Văn F', 'vanf@gmail.com', '0966666666', N'Bình Dương', '123'),
('KH07', N'Đỗ Thị G', 'thig@gmail.com', '0977777777', N'Đồng Nai', '123'),
('KH08', N'Bùi Văn H', 'vanh@gmail.com', '0988888888', N'Huế', '123'),
('KH09', N'Lý Minh I', 'minhi@gmail.com', '0999999999', N'Nha Trang', '123'),
('KH10', N'Đặng Thị K', 'thik@gmail.com', '0811111111', N'Vũng Tàu', '123'),
('KH11', N'Ngô Văn L', 'vanl@gmail.com', '0822222222', N'Nam Định', '123'),
('KH12', N'Dương Minh M', 'minhm@gmail.com', '0833333333', N'Thanh Hóa', '123'),
('KH13', N'Trịnh Văn N', 'vann@gmail.com', '0844444444', N'Quảng Ninh', '123'),
('KH14', N'Hồ Thị O', 'thio@gmail.com', '0855555555', N'Kiên Giang', '123'),
('KH15', N'Mai Văn P', 'vanp@gmail.com', '0866666666', N'Lâm Đồng', '123'),
('KH16', N'Đinh Minh Q', 'minhq@gmail.com', '0877777777', N'Gia Lai', '123'),
('KH17', N'Quách Văn R', 'vanr@gmail.com', '0888888888', N'Sóc Trăng', '123'),
('KH18', N'Tạ Thị S', 'this@gmail.com', '0899999999', N'Hà Nam', '123'),
('KH19', N'Phan Văn T', 'vant@gmail.com', '0711111111', N'Long An', '123'),
('KH20', N'Vương Minh U', 'minhu@gmail.com', '0722222222', N'Tây Ninh', '123');

-- 5. Bảng NHANVIEN (20 dòng)
INSERT INTO NHANVIEN VALUES 
('NV01', N'Admin Boss', '0111111111', 'admin@nike.vn', 'admin123', 2),
('NV02', N'Quản lý Kho', '0222222222', 'manager@nike.vn', '123', 2),
('NV03', N'Bán hàng 1', '0333333333', 'staff1@nike.vn', '123', 1),
('NV04', N'Bán hàng 2', '0444444444', 'staff2@nike.vn', '123', 1),
('NV05', N'Bán hàng 3', '0555555555', 'staff3@nike.vn', '123', 1),
('NV06', N'Bán hàng 4', '0666666666', 'staff4@nike.vn', '123', 1),
('NV07', N'Bán hàng 5', '0777777777', 'staff5@nike.vn', '123', 1),
('NV08', N'Shipper 1', '0888888888', 'ship1@nike.vn', '123', 0),
('NV09', N'Shipper 2', '0999999999', 'ship2@nike.vn', '123', 0),
('NV10', N'Shipper 3', '0121212121', 'ship3@nike.vn', '123', 0),
('NV11', N'Shipper 4', '0131313131', 'ship4@nike.vn', '123', 0),
('NV12', N'Shipper 5', '0141414141', 'ship5@nike.vn', '123', 0),
('NV13', N'Kế Toán 1', '0151515151', 'acc1@nike.vn', '123', 2),
('NV14', N'Bán hàng 6', '0161616161', 'staff6@nike.vn', '123', 1),
('NV15', N'Bán hàng 7', '0171717171', 'staff7@nike.vn', '123', 1),
('NV16', N'Bán hàng 8', '0181818181', 'staff8@nike.vn', '123', 1),
('NV17', N'Bán hàng 9', '0191919191', 'staff9@nike.vn', '123', 1),
('NV18', N'Bán hàng 10', '0202020202', 'staff10@nike.vn', '123', 1),
('NV19', N'Shipper 6', '0212121212', 'ship6@nike.vn', '123', 0),
('NV20', N'Shipper 7', '0222222223', 'ship7@nike.vn', '123', 0);

-- 6. Bảng SANPHAM (20 dòng)
INSERT INTO SANPHAM VALUES 
('SP01', N'Nike Air Force 1', N'Huyền thoại', 'af1.jpg', 'LSP03', 'NCC01'),
('SP02', N'Nike Air Max 270', N'Êm ái', 'am270.jpg', 'LSP01', 'NCC01'),
('SP03', N'Nike Pegasus 40', N'Quốc dân', 'pegasus40.jpg', 'LSP01', 'NCC02'),
('SP04', N'Nike Jordan 1 Low', N'Streetwear', 'jordan1.jpg', 'LSP03', 'NCC01'),
('SP05', N'Nike Mercurial', N'Tốc độ', 'mercurial.jpg', 'LSP04', 'NCC08'),
('SP06', N'Nike Dri-FIT Tee', N'Thoáng khí', 'drifit.jpg', 'LSP05', 'NCC09'),
('SP07', N'Nike Hoodie', N'Thời trang', 'hoodie.jpg', 'LSP17', 'NCC10'),
('SP08', N'Nike Tech Fleece', N'Cao cấp', 'techfleece.jpg', 'LSP08', 'NCC10'),
('SP09', N'Nike Backpack', N'Tiện lợi', 'backpack.jpg', 'LSP09', 'NCC01'),
('SP10', N'Nike Waistpack', N'Cá tính', 'waistpack.jpg', 'LSP10', 'NCC14'),
('SP11', N'Nike Zoom Fly 5', N'Chạy bộ', 'zoomfly.jpg', 'LSP01', 'NCC02'),
('SP12', N'Nike Phantom GX', N'Kiểm soát', 'phantom.jpg', 'LSP04', 'NCC08'),
('SP13', N'Nike SB Dunk', N'Trượt ván', 'sbdunk.jpg', 'LSP03', 'NCC01'),
('SP14', N'Nike Jacket', N'Thể thao', 'jacket.jpg', 'LSP06', 'NCC09'),
('SP15', N'Nike Socks', N'Vớ cao cấp', 'socks.jpg', 'LSP11', 'NCC12'),
('SP16', N'Nike Leggings', N'Co giãn', 'leggings.jpg', 'LSP19', 'NCC16'),
('SP17', N'Nike Windrunner', N'Áo gió', 'windrunner.jpg', 'LSP06', 'NCC18'),
('SP18', N'Nike Court Vision', N'Cổ điển', 'courtvision.jpg', 'LSP03', 'NCC01'),
('SP19', N'Nike Tanjun', N'Đi bộ', 'tanjun.jpg', 'LSP01', 'NCC01'),
('SP20', N'Nike Slides', N'Tiện lợi', 'benassi.jpg', 'LSP20', 'NCC20');

-- 7. Bảng CHITIET_SANPHAM (20 dòng)
INSERT INTO CHITIET_SANPHAM VALUES 
('CT01', 'SP01', 40, N'Trắng', 2900000, 50, 'KM01'),
('CT02', 'SP01', 41, N'Trắng', 2900000, 30, 'KM01'),
('CT03', 'SP01', 42, N'Đen', 2800000, 20, NULL),
('CT04', 'SP02', 39, N'Đỏ', 3500000, 15, 'KM07'),
('CT05', 'SP03', 40, N'Xanh', 3200000, 40, 'KM07'),
('CT06', 'SP04', 42, N'Panda', 4500000, 10, 'KM02'),
('CT07', 'SP05', 41, N'Vàng', 2200000, 25, NULL),
('CT08', 'SP06', 0, N'Xám', 550000, 100, 'KM05'),
('CT09', 'SP07', 0, N'Đen', 1200000, 45, NULL),
('CT10', 'SP08', 0, N'Xanh', 1500000, 30, NULL),
('CT11', 'SP09', 0, N'Đen', 850000, 60, 'KM10'),
('CT12', 'SP10', 0, N'Cam', 450000, 80, 'KM10'),
('CT13', 'SP11', 42, N'Hồng', 4200000, 12, 'KM07'),
('CT14', 'SP12', 40, N'Xanh', 5800000, 5, NULL),
('CT15', 'SP13', 41, N'Nâu', 3900000, 8, 'KM02'),
('CT16', 'SP14', 0, N'Trắng', 1100000, 20, NULL),
('CT17', 'SP15', 0, N'Đen', 250000, 200, 'KM06'),
('CT18', 'SP16', 0, N'Tím', 950000, 35, NULL),
('CT19', 'SP17', 0, N'Xanh', 2100000, 15, NULL),
('CT20', 'SP20', 41, N'Đen', 650000, 150, 'KM13');

-- 8. Bảng HOADON (20 dòng)
INSERT INTO HOADON VALUES 
('HD01', '2026-05-02', '2026-05-04', 'KH01', 'NV03', 'NV08', 'KM01', 2),
('HD02', '2026-05-05', '2026-05-07', 'KH02', 'NV04', 'NV09', 'KM01', 2),
('HD03', '2026-05-10', NULL, 'KH03', 'NV03', NULL, NULL, 1),
('HD04', '2026-05-12', NULL, 'KH04', NULL, NULL, NULL, 0),
('HD05', '2026-05-15', '2026-05-17', 'KH05', 'NV04', 'NV10', 'KM15', 2),
('HD06', '2026-05-18', NULL, 'KH06', 'NV03', 'NV11', NULL, 1),
('HD07', '2026-05-20', '2026-05-22', 'KH07', 'NV05', 'NV12', NULL, 2),
('HD08', '2026-05-25', NULL, 'KH08', NULL, NULL, NULL, 0),
('HD09', '2026-06-01', '2026-06-03', 'KH09', 'NV06', 'NV08', 'KM16', 2),
('HD10', '2026-06-05', NULL, 'KH10', 'NV03', NULL, NULL, 1),
('HD11', '2026-06-10', '2026-06-12', 'KH11', 'NV07', 'NV09', NULL, 2),
('HD12', '2026-06-15', NULL, 'KH12', NULL, NULL, NULL, 0),
('HD13', '2026-06-20', '2026-06-22', 'KH13', 'NV03', 'NV10', 'KM16', 2),
('HD14', '2026-06-25', NULL, 'KH14', 'NV04', 'NV11', NULL, 1),
('HD15', '2026-07-02', '2026-07-04', 'KH15', 'NV03', 'NV12', 'KM13', 2),
('HD16', '2026-07-05', NULL, 'KH16', NULL, NULL, NULL, 0),
('HD17', '2026-07-10', '2026-07-12', 'KH17', 'NV05', 'NV08', 'KM13', 2),
('HD18', '2026-07-15', NULL, 'KH18', 'NV03', 'NV09', NULL, 1),
('HD19', '2026-07-20', '2026-07-22', 'KH19', 'NV06', 'NV10', NULL, 2),
('HD20', '2026-07-25', NULL, 'KH20', NULL, NULL, NULL, 0);

-- 9. Bảng CHITIET_HD (20 dòng)
INSERT INTO CHITIET_HD VALUES 
('HD01', 'CT01', 1, 2610000), ('HD02', 'CT02', 1, 2610000),
('HD03', 'CT03', 2, 2800000), ('HD04', 'CT04', 1, 2625000),
('HD05', 'CT05', 1, 2400000), ('HD06', 'CT06', 1, 3150000),
('HD07', 'CT07', 1, 2200000), ('HD08', 'CT08', 3, 495000),
('HD09', 'CT09', 1, 1200000), ('HD10', 'CT10', 1, 1500000),
('HD11', 'CT11', 1, 425000), ('HD12', 'CT12', 2, 225000),
('HD13', 'CT13', 1, 3150000), ('HD14', 'CT14', 1, 5800000),
('HD15', 'CT15', 1, 2730000), ('HD16', 'CT16', 1, 1100000),
('HD17', 'CT17', 5, 200000), ('HD18', 'CT18', 1, 950000),
('HD19', 'CT19', 1, 2100000), ('HD20', 'CT20', 2, 260000);
--Yêu cầu 3: Tạo 40 câu truy vấn
