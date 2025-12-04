
create database PolyOE

use PolyOE

create table Users(
	Id varchar(20) not null,
	Password nvarchar(50) not null,
	Fullname nvarchar(50) not null,
	Email nvarchar(50) not null,
	Admin bit not null,
	primary key(Id)
)

create table Videos(
	Id varchar(20), 
	Title nvarchar(max) not null,
	Poster varchar(255),
	Description nvarchar(max) not null,
	Views int not null,
	Active bit not null,
	Category nvarchar(50) null,
	primary key(Id)
)

create table Favorites(
	Id bigint identity(1,1), 
	UserId varchar(20) not null,
	VideoId varchar(20) not null,
	LikeDate date not null,
	primary key(Id),
	foreign key(UserId) references Users(Id),
	foreign key(VideoId) references Videos(Id)
)

create table Shares(
	--Id varchar(50), 
	Id bigint identity(1,1),
	UserId varchar(20) not null,
	VideoId varchar(20) not null,
	Email varchar(255) not null,
	ShareDate date not null,
	primary key(Id),
	foreign key(UserId) references Users(Id),
	foreign key(VideoId) references Videos(Id)
)

INSERT INTO Users(Id, Password, Fullname, Email, Admin) VALUES
('admin', '123456', N'Nguy?n V?n A', 'admin@poly.edu.vn', 1),
('nv01', '123456', N'Tr?n Th? B', 'btran@poly.edu.vn', 0),
('nv02', '123456', N'Lê V?n C', 'cle@poly.edu.vn', 0),
('nv03', '123456', N'Ph?m Th? D', 'dpham@poly.edu.vn', 0),
('nv04', '123456', N'Lê Qu?c E', 'edo@poly.edu.vn', 1);



-- 5 d? li?u Shares test m?i
INSERT INTO Shares (UserId, VideoId, Email, ShareDate) VALUES
('nv01', 'vd005', 'friend01@example.com', '2025-01-05'),
('nv02', 'vd006', 'friend02@example.com', '2025-02-10'),
('nv03', 'vd007', 'friend03@example.com', '2025-03-15'),
('nv04', 'vd008', 'friend04@example.com', '2025-04-20'),
('nv01', 'vd009', 'friend05@example.com', '2025-05-25');


-- Thêm d? li?u yêu thích cho user nv01
INSERT INTO Favorites (UserId, VideoId, LikeDate) VALUES
('nv01', 'vd001', GETDATE()),
('nv01', 'vd003', GETDATE()),
('nv01', 'vd006', GETDATE());

-- Thêm d? li?u yêu thích cho user nv02
INSERT INTO Favorites (UserId, VideoId, LikeDate) VALUES
('nv02', 'vd002', GETDATE()),
('nv02', 'vd004', GETDATE());

-- Thêm d? li?u yêu thích cho user admin
INSERT INTO Favorites (UserId, VideoId, LikeDate) VALUES
('admin', 'vd005', GETDATE());


INSERT INTO Videos (Id, Title, Poster, Description, Views, Active, Category) VALUES
(N'vd001', N'W/n - 3107 3 (Official Video) ft. Nâu, Duongg, Titie', N'kfw7MYah2n0', 
N'Sáng tác & Music Producer: W/n
Rap: Nâu
Executive Supervisor: Hai Dang
Partnership Manager: Tam Meo
Social network advisor: Tu Anh
Art Director: Vo Van Hieu
Stylist: Nguyen Quoc Ky
Hair Stylist: Nguyen Quoc Ky
Wardrobe: ZUNE.ZX', 100, 1, N'Music'),

(N'vd002', N'QUÂN A.P - BÔNG HOA ??P NH?T [OFFICIAL LYRICS VIDEO]', N'e2Xx7WcvEns',
N'BÔNG HOA ??P NH?T
Singer: Quân A.P
Composer: V? Hà Anh – Phan Vi?t Tính – Nguy?n V?n Trung', 100, 1, N'Music'),

(N'vd003', N'Ánh Sao Và B?u Tr?i - T.R.I x Cá | [Official Audio]', N'9vaLkYElidg',
N'Performer: T.R.I
Music Producer: T.R.I
Composer: Cá (B3212)
Video by Van Duc', 100, 1, N'Music'),

(N'vd004', N'hieuthuhai - ng? m?t mình (tình r?t tình) ft. negav (prod. by kewtiie)', N'1OJQdxT6WHE',
N'Produced by Dargon
Executive producer: Ai Nguyen
Director: Ho Viet Quan
DOP: Ho Viet Quan
Cam OP: Cong Min
Focus Puller: Thai Minh Tam
Producer: Viet Anh
Editor & Colorist: kingduckinthelake
Set design: uin
Runner: Dong Nguyen, Ro
Lighting & Equipment: HD Equipment', 100, 1, N'Music'),

(N'vd005', N'L?ng L? | MASEW x BRAY ft. RedT x Ý Tiên | MV OFFICIAL', N'HehotFZ8BGo',
N'M?t s?n ph?m th?c hi?n b?i Great Entertainment
Project manager: Phan Viet Tinh - Nguyen Son Quyen
Chief Marketing Official: Phan Viet Tinh
Cast: Trang Dai, Thuy Linh, Cam Ngan, Quynh Anh, Truong Ngoc.
Director: Quan Giay
Assistant Director: Quoc Dat
Producer: Thao Phuong
Assistant Producer: Hoang Thanh - Vu Nguyen
Art Director: Thao Phuong
Editor - VFX: Quan Giay
BTS: Pham Le Ba Huynh', 100, 1, N'Music'),

(N'vd006', N'MONO - Waiting For You (Album 22 - Track No.10)', N'CHw1b_1LVBA',
N'Ngh? s? bi?u di?n: MONO, Onionn
Author: Nguy?n Vi?t Hoàng
Composer: Nguy?n Ng?c Hoàng Anh, Nguy?n Vi?t Hoàng
Arranger: Onionn
Producer: Onionn', 100, 1, N'Music'),

(N'vd007', N'HIEUTHUHAI - V? Tinh ft. Hoàng Tôn (prod. by Kewtiie) | OFFICIAL MV', N'TTwlhJzXHo4',
N'Artist: HIEUTHUHAI & HOÀNG TÔN
Music Composer: HIEUTHUHAI & HOÀNG TÔN
Music Producer: KEWTIIE
Mix & Master: KEWTIIE, HOÀNG TÔN, HPRO', 100, 1, N'Music'),

(N'vd008', N'An Th?n (ft. Th?ng) | Low G | Rap Nhà Làm', N'J7eYhM6wXPo',
N'Produced by Th?ng & Chí Trung
Mix n’ Mastered by Th?ng & Chí Trung
Video by Low G
Camera by KZ', 100, 1, N'Music'),

(N'vd009', N'N?I NÀY CÓ ANH | OFFICIAL MUSIC VIDEO | S?N TÙNG M-TP', N'FN7ALfpGxiI',
N'???c th?c hi?n b?i Dreams Productions
Sáng tác: S?n Tùng M-TP
Ph?i khí: Kh?c H?ng
Master: Long Halo
??o di?n: Gin Tran
D.O.P: Lub Nguyen
Giám ??c ngh? thu?t: Thien Thanh
Thi?t k? ?? ho?: Meimei Hoang', 100, 1, N'Music'),

(N'vd010', N'VAN SON ?? Hài K?ch | TR?N MINH KH? CHU?I Vân S?n - B?o Liêm', N'XTEHX-5rjpo',
N'©VAN SON ENTERTAINMENT, INC. ALL RIGHTS RESERVED.
Không re-upload d??i m?i hình th?c.', 100, 1, N'Comedy'),

(N'vd011', N'VAN SON ?? Hài k?ch | 2 LÁ TH? | Vân S?n - B?o Liêm - Quang Minh - H?ng ?ào', N'VUDZ2LAyFGc',
N'©VAN SON ENTERTAINMENT, INC. ALL RIGHTS RESERVED.
Không re-upload d??i m?i hình th?c.', 100, 1, N'Comedy'),

(N'vd012', N'VAN SON ?? San Jose | Hài K?ch HAI ??T 3 RU?NG', N'LsLJCb0jQqI',
N'©VAN SON ENTERTAINMENT, INC. ALL RIGHTS RESERVED.', 100, 1, N'Comedy'),

(N'vd013', N'VAN SON ?? Ca Nh?c Hài | H?C B?CH CÔNG T?', N'Q03GEFCi-cM',
N'©VAN SON ENTERTAINMENT, INC. ALL RIGHTS RESERVED.', 100, 1, N'Comedy'),

(N'vd014', N'VAN SON ?? Hài Kinh ?i?n | S?N TINH THU? TINH', N'7Ez2_bxvExk',
N'©VAN SON ENTERTAINMENT, INC. ALL RIGHTS RESERVED.', 100, 1, N'Comedy'),

(N'vd015', N'PHIM HÀNH ??NG | CHI?N LANG - PH?N CU?I', N'hDuttHj9WWw',
N'Phim hành ??ng võ thu?t Trung Qu?c, Ngô Kinh ??o di?n và ?óng chính.', 1000, 1, N'Action'),

(N'vd016', N'NG??I V?N CHUY?N - Ph?n Cu?i | Transporter Refueled', N's7lY5w51a8c',
N'Phim hành ??ng M?, reboot series Transporter.', 1000, 1, N'Action'),

(N'vd017', N'[VIETSUB] Tay B?n T?a: Báo Thù | Sniper Vengeance', N'7ZlX6H1CerE',
N'N? x? th? Anna và ??ng ??i ch?ng l?i trùm ma túy Roger.', 500, 1, N'Action'),

(N'vd018', N'[VIETSUB] Vua B?n T?a: Ám Sát - The King of Snipers', N'K8mZVqAQofs',
N'N? x? th? Anna h?p tác cùng ??c v? Artai.', 500, 1, N'Action'),

(N'vd019', N'[VIETSUB] Black Fox: Ultimate Rescue | Ti?u ??i Cáo ?en', N'DIeQidmCM84',
N'Phim chi?n tranh – hành ??ng Trung Qu?c 2020.', 800, 1, N'Action'),

(N'vd020', N'Siêu Ph?m Kháng Nh?t | X? TH? - ??I ??T KÍCH H?NG ?NG', N'efFUtxO60FI',
N'Phim chi?n tranh – hành ??ng, th?i k? kháng Nh?t.', 800, 1, N'Action'),

(N'vd021', N'TRÁNG S? XU?T KÍCH | Phim Chi?n Tranh', N'phgY-ovAaDc',
N'Câu chuy?n v? 82 d?ng s? Tân t? quân.', 700, 1, N'Action'),

(N'vd022', N'S?C M?NH C?A R?NG - Ph?n Cu?i', N'uRwPB-_O9cE',
N'Phim vi?n t??ng – hành ??ng ph??ng ?ông.', 300, 1, N'Action'),

(N'vd023', N'Review Phim Big Mouth (2022) - Full B?n Tóm T?t', N'egwCJMkFmHU',
N'Tóm t?t phim Big Mouth (2022) c?a Lee Jong Suk và Yoona.', 400, 1, N'Movie'),

(N'vd024', N'Review Phim: T?i Ác Vô Hình | Blind | Full T?p 1–16', N'T2nNe915ebk',
N'Tóm t?t phim T?i Ác Vô Hình — hành trình phá án gi?t ng??i hàng lo?t.', 1500, 1, N'Movie');

