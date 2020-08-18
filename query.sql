CREATE DATABASE Lab05
USE Lab05
--
CREATE TABLE PhongBan(
			MaPB varchar(7),
			TenPB nvarchar(50)
			CONSTRAINT PK_PhongBan PRIMARY KEY (MaPB)
			)
GO
---
CREATE TABLE NhanVien(
			MaNV varchar(7),
			TenNV nvarchar(50),
			NgaySinh datetime CHECK (NgaySinh < getdate()),
			SoCMND char(9) CHECK (SoCMND > 0),
			GioiTinh char(1) Default('M'),
			DiaChi nvarchar(100),
			NgayVaoLam datetime,
			MaPB varchar(7) 
			CONSTRAINT PK_NhanVien PRIMARY KEY (MaNV)
			)
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD  CONSTRAINT [fk_nv_maPB] FOREIGN KEY([MaPB])
REFERENCES [dbo].[PhongBan] ([MaPB])
GO

ALTER TABLE [dbo].[NhanVien] CHECK CONSTRAINT [fk_nv_maPB]
GO
ALTER TABLE [dbo].[NhanVien] 
ADD CONSTRAINT checkngayvaolam
 CHECK (YEAR(NgayVaoLam) - YEAR(NgaySinh) > 20)

----
CREATE TABLE LuongDA(
				MaDA varchar(8),
				MaNV varchar(7),
				NgayNhan datetime NOT NULL DEFAULT(getdate()),
				SoTien money CHECK (SoTien > 0)
				CONSTRAINT PK_LuongDA PRIMARY KEY (MaDA,MaNV)
				)

ALTER TABLE LuongDA  WITH CHECK ADD  CONSTRAINT [fk_luongda_manv] FOREIGN KEY([MaNV])
REFERENCES [NhanVien] ([MaNV])
GO

ALTER TABLE [dbo].[LuongDA] CHECK CONSTRAINT [fk_luongda_manv]
GO

----1.Th?c hi?n chèn d? li?u vào các b?ng v?a t?o (ít nh?t 5 b?n ghi cho m?i b?ng).
INSERT [dbo].[PhongBan] ([MaPB], [TenPB]) VALUES (N'1', N'Cedrus01')
INSERT [dbo].[PhongBan] ([MaPB], [TenPB]) VALUES (N'2', N'Cedrus02')
INSERT [dbo].[PhongBan] ([MaPB], [TenPB]) VALUES (N'3', N'Cedrus03')
INSERT [dbo].[PhongBan] ([MaPB], [TenPB]) VALUES (N'4', N'Cedrus04')
INSERT [dbo].[PhongBan] ([MaPB], [TenPB]) VALUES (N'5', N'Cedrus05')
INSERT [dbo].[NhanVien] ([MaNV], [TenNV], [NgaySinh], [SoCMND], [GioiTinh], [DiaChi], [NgayVaoLam], [MaPB]) VALUES (N'1', N'Hoang01', CAST(N'2000-01-07T00:00:00.000' AS DateTime), N'123123123', N'M', N'Cau Giay', CAST(N'2021-01-07T00:00:00.000' AS DateTime), N'1')
INSERT [dbo].[NhanVien] ([MaNV], [TenNV], [NgaySinh], [SoCMND], [GioiTinh], [DiaChi], [NgayVaoLam], [MaPB]) VALUES (N'2', N'Hoang02', CAST(N'2000-01-07T00:00:00.000' AS DateTime), N'123123123', N'M', N'Cau Giay', CAST(N'2021-01-07T00:00:00.000' AS DateTime), N'2')
INSERT [dbo].[NhanVien] ([MaNV], [TenNV], [NgaySinh], [SoCMND], [GioiTinh], [DiaChi], [NgayVaoLam], [MaPB]) VALUES (N'3', N'Hoang03', CAST(N'2000-01-07T00:00:00.000' AS DateTime), N'123123123', N'M', N'Cau Giay', CAST(N'2021-01-07T00:00:00.000' AS DateTime), N'3')
INSERT [dbo].[NhanVien] ([MaNV], [TenNV], [NgaySinh], [SoCMND], [GioiTinh], [DiaChi], [NgayVaoLam], [MaPB]) VALUES (N'4', N'Hoang04', CAST(N'2000-01-07T00:00:00.000' AS DateTime), N'123123123', N'M', N'Cau Giay', CAST(N'2021-01-07T00:00:00.000' AS DateTime), N'4')
INSERT [dbo].[NhanVien] ([MaNV], [TenNV], [NgaySinh], [SoCMND], [GioiTinh], [DiaChi], [NgayVaoLam], [MaPB]) VALUES (N'5', N'Hoang05', CAST(N'2000-01-07T00:00:00.000' AS DateTime), N'123123123', N'M', N'Cau Giay', CAST(N'2021-01-07T00:00:00.000' AS DateTime), N'5')
INSERT [dbo].[LuongDA] ([MaDA], [MaNV], [NgayNhan], [SoTien]) VALUES (N'1', N'1', CAST(N'2020-08-19T04:08:51.220' AS DateTime), 1000.0000)
INSERT [dbo].[LuongDA] ([MaDA], [MaNV], [NgayNhan], [SoTien]) VALUES (N'2', N'2', CAST(N'2000-01-07T00:00:00.000' AS DateTime), 123123123.0000)
INSERT [dbo].[LuongDA] ([MaDA], [MaNV], [NgayNhan], [SoTien]) VALUES (N'3', N'3', CAST(N'2000-01-07T00:00:00.000' AS DateTime), 123123.0000)
INSERT [dbo].[LuongDA] ([MaDA], [MaNV], [NgayNhan], [SoTien]) VALUES (N'4', N'4', CAST(N'2000-01-07T00:00:00.000' AS DateTime), 123123.0000)
INSERT [dbo].[LuongDA] ([MaDA], [MaNV], [NgayNhan], [SoTien]) VALUES (N'5', N'5', CAST(N'2000-01-07T00:00:00.000' AS DateTime), 123123.0000)
--2.Vi?t m?t query ?? hi?n th? thông tin v? các b?ng LUONGDA, NHANVIEN, PHONGBAN.
SELECT * FROM LuongDA
SELECT * FROM NhanVien
SELECT * FROM PhongBan
--3 Vi?t m?t query ?? hi?n th? nh?ng nhân viên có gi?i tính là ‘F’.
SELECT * FROM NhanVien Where GioiTinh = 'F'
--4 Hi?n th? t?t c? các d? án, m?i d? án trên 1 dòng.
SELECT * FROM NhanVien
--5.Hi?n th? t?ng l??ng c?a t?ng nhân viên (dùng m?nh ?? GROUP BY).
SELECT LuongDA.MaNV, LuongDA.SoTien,NhanVien.TenNV
FROM LuongDA INNER JOIN NhanVien ON LuongDA.MaNV = NhanVien.MaNV
--6.Hiển thị tất cả các nhân viên trên một phòng ban cho trước (VD: ‘Hành chính’).
SELECT * FROM NhanVien where MaPB in (select MaPB From PhongBan where TenPB = N'Hành Chính')

--7.Hiển thị mức lương của những nhân viên phòng hành chính.
SELECT * FROM LuongDA where MaNV in (select MaNV from NhanVien where MaPB in (select MaPB from PhongBan where TenPB = N'Hành Chính'))

--8.Hiển thị số lượng nhân viên của từng phòng.
SELECT NhanVien.MaPB, NhanVien.MaNV
FROM NhanVien INNER JOIN PhongBan ON NhanVien.MAPB = PhongBan.MaPB

--9.Viết một query để hiển thị những nhân viên mà tham gia ít nhất vào một dự án. éo hiểu đề bài lắm
SELECT * FROM NhanVien where MaNV in (Select MaNV from LuongDA)

--10.Viết một query hiển thị phòng ban có số lượng nhân viên nhiều nhất.
--SELECT * FROM PhongBan where MaPB in (Select MaPB from NhanVien )

--11. Tính tổng số lượng của các nhân viên trong phòng Hành chính.
SELECT COUNT(MaNV) as Soluongnv FROM NhanVien where MaPB in (SELECT MaPB From PhongBan where TenPB = N'Hành Chính')

--12. Hiển thị tống lương của các nhân viên có số CMND tận cùng bằng 9.

SELECT Sum(SoTien) as sotien from LuongDA Where MaNV in (select MaNV from NhanVien where SoCMND like '%9')

--13. Tìm nhân viên có số lương cao nhất.

SELECT TOP 1 * FROM LuongDA Order By SoTien DESC


--14. Tìm nhân viên ở phòng Hành chính có giới tính bằng ‘F’ và có mức lương > 1200000.

SELECT * FROM NhanVien where GioiTinh='F' and MaPB in (select MaPB from PhongBan where TenPB = N'Hành Chính') and MaNV in (select MaNV from LuongDA where SoTien > 1200000)

--15.Tìm tổng lương trên từng phòng.

SELECT dbo.LuongDA.SoTien, dbo.PhongBan.MaPB
FROM     dbo.LuongDA INNER JOIN
                  dbo.NhanVien ON dbo.LuongDA.MaNV = dbo.NhanVien.MaNV INNER JOIN
                  dbo.PhongBan ON dbo.NhanVien.MaPB = dbo.PhongBan.MaPB
--16. Liệt kê các dự án có ít nhất 2 người tham gia.

--17.Liệt kê thông tin chi tiết của nhân viên có tên bắt đầu bằng ký tự ‘N’.

SELECT * FROM NhanVien where TenNV like N'N%'

--18.Hiển thị thông tin chi tiết của nhân viên được nhận tiền dự án trong năm 2003.

SELECT * FROM NhanVien where MaNV in (select MaNV From LuongDA where YEAR(NgayNhan) = 2003)

--19.Hiển thị thông tin chi tiết của nhân viên không tham gia bất cứ dự án nào.

SELECT * FROM NhanVien where MaNV not in (select MaNV From LuongDA)

--20 . Xoá dự án có mã dự án là DXD02.
DELETE LuongDA where MaDA = 'DXD02'

--21.Xoá đi từ bảng LuongDA những nhân viên có mức lương 2000000.

DELETE LuongDA Where SoTien >= 2000000

--22.Cập nhật lại lương cho những người tham gia dự án XDX01 thêm 10% lương cũ.

UPDATE LuongDA Set SoTien = Sotien + Sotien * 10 /100 where MaDA = 'XDX01'

--23. Xoá các bản ghi tương ứng từ bảng NhanVien đối với những nhân viên không có mã nhân viên tồn tại trong bảng LuongDA.

DELETE NhanVien where MaNV not in (select MaNV from LuongDA)

--24.Viết một truy vấn đặt lại ngày vào làm của tất cả các nhân viên thuộc phòng hành chính là ngày 12/02/1999

UPDATE NhanVien set NgayVaoLam = '1999-02-12' where MaPb in (Select MaPB from PhongBan where TenPB=N'Hành Chính')

