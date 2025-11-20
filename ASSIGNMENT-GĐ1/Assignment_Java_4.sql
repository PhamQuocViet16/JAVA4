
create database Assignment_Java_4

use Assignment_Java_4

create table Users(
	Id varchar(20), 
	Password varchar(100) not null,
	Email varchar(255) not null,
	Fullname nvarchar(100) not null,
	Admin bit not null,
	primary key(Id)
)


create table Videos(
	Id varchar(20), 
	Title nvarchar(max) not null,
	Poster varchar(255),
	Views int not null,
	Description nvarchar(max) not null,
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
	Id varchar(50), 
	UserId varchar(20) not null,
	VideoId varchar(20) not null,
	Email varchar(255) not null,
	ShareDate date not null,
	primary key(Id),
	foreign key(UserId) references Users(Id),
	foreign key(VideoId) references Videos(Id)
)

insert into USERS values
('admin',  'admin123', 'admin@gmail.com', N'Qu?n tr? viên', 1),
('user01', '123', 'user01@gmail.com', N'Nguy?n V?n A', 0),
('user02', '123', 'user02@gmail.com', N'Tr?n Th? B', 0),
('user03', '123', 'user03@gmail.com', N'Lê Hoàng C', 0),
('user04', '123', 'user04@gmail.com', N'Ph?m Th? D', 0),
('user05', '123', 'user05@gmail.com', N'Lê V?n E', 0),
('user06', '123', 'user06@gmail.com', N'Hoàng Th? F', 0),
('user07', '123', 'user07@gmail.com', N'Ngô V?n G', 0),
('user08', '123', 'user08@gmail.com', N'Võ Th? H', 0),
('user09', '123', 'user09@gmail.com', N'Bùi V?n I', 0);



INSERT INTO Videos (Id, Title, Poster, Views, Description, Active, Category) VALUES
(N'vd001', N'W/n - 3107 3 (Official Video) ft. Nâu, Duongg, Titie', N'kfw7MYah2n0', 100, 
N'Sáng tác & Music Producer : W/n 
Rap : Nâu
Executive Supervisor: Hai Dang
Partnership Manager : Tam Meo
Social network advisor : Tu Anh
Art Director: Vo Van Hieu
Stylist: Nguyen Quoc Ky
Hair Stylist: Nguyen Quoc Ky
Wardrobe: ZUNE.ZX', 1, N'Music');

INSERT INTO Videos VALUES
(N'vd002', N'QUÂN A.P - BÔNG HOA ??P NH?T [OFFICIAL LYRICS VIDEO]', N'e2Xx7WcvEns', 100,
N'BÔNG HOA ??P NH?T 
Singer: Quân A.P
Composer: Vu? Hà Anh – Phan Vie??t Tính – Nguye??n Va?n Trung', 1, N'Music');

INSERT INTO Videos VALUES
(N'vd003', N'Ánh Sao Và B?u Tr?i - T.R.I x Cá | [Official Audio]', N'9vaLkYElidg', 100,
N'Performer: T.R.I
Music Producer: T.R.I 
Composer: Cá (B3212)
Video by Van Duc', 1, N'Music');

INSERT INTO Videos VALUES
(N'vd004', N'hieuthuhai - ng? m?t mình (tình r?t tình) ft. negav (prod. by kewtiie)', N'1OJQdxT6WHE', 100,
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
Lighting & Equipment: HD Equipment', 1, N'Music');

INSERT INTO Videos VALUES
(N'vd005', N'L?ng L? | MASEW x BRAY ft. RedT x Ý Tiên | MV OFFICIAL', N'HehotFZ8BGo', 100,
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
BTS: Pham Le Ba Huynh 
Special thanks Babyface & Ms Thu Liz, Minh Bao, Minh Xu', 1, N'Music');

INSERT INTO Videos VALUES
(N'vd006', N'MONO - Waiting For You (Album 22 - Track No.10)', N'CHw1b_1LVBA', 100,
N'* Ngh? s? bi?u di?n : MONO, Onionn 
* Author : Nguy?n Vi?t Hoàng 
* Composer : Nguy?n Ng?c Hoàng Anh, Nguy?n Vi?t Hoàng 
* Arranger : Onionn
* Producer : Onionn', 1, N'Music');

INSERT INTO Videos VALUES
(N'vd007', N'HIEUTHUHAI - V? Tinh ft. Hoàng Tôn (prod. by Kewtiie) | OFFICIAL MV', N'TTwlhJzXHo4', 100,
N'Artist: HIEUTHUHAI & HOÀNG TÔN
Music Composer: HIEUTHUHAI & HOÀNG TÔN
Music Producer: KEWTIIE
Mix & Master: KEWTIIE, HOÀNG TÔN, HPRO', 1, N'Music');

INSERT INTO Videos VALUES
(N'vd008', N'An Th?n (ft. Th?ng) | Low G | Rap Nhà Làm', N'J7eYhM6wXPo', 100,
N'Produced by Th?ng & Chí Trung
Mix n'' Mastered by Th?ng & Chí Trung
Video by Low G
Camera by KZ', 1, N'Music');

INSERT INTO Videos VALUES
(N'vd009', N'N?I NÀY CÓ ANH | OFFICIAL MUSIC VIDEO | S?N TÙNG M-TP', N'FN7ALfpGxiI', 100,
N'???c th?c hi?n b?i / Video made by
Sáng tác / Composer: S?n Tùng M-TP
Ph?i khí / Arranger: Kh?c H?ng
Master: Long Halo
S?n xu?t / Produced by Dreams Productions
??o di?n / Director: Gin Tran
??o di?n hình ?nh / D.O.P: Lub Nguyen
Giám ??c ngh? thu?t / Art Director: Thien Thanh
Thi?t k? ?? ho? / Graphic Designer: Meimei Hoang
?i?u hành s?n xu?t / Executive Producer: M&M HOUSE', 1, N'Music');

INSERT INTO Videos VALUES
(N'vd010', N'VAN SON ?? Hài K?ch | TR?N MINH KH? CHU?I Vân S?n - B?o Liêm', N'XTEHX-5rjpo', 100,
N'©VAN SON ENTERTAINMENT, INC. ALL RIGHTS RESERVED ? DO NOT RE-UPLOAD
?T?t C? video, Album trên Vân S?n YouTube Channel, ?ã ???c Trung Tâm Vân S?n ??ng ký b?n quy?n YouTube. R?t mong các b?n, không sao chép HO?C re-upload d??i m?i hình th?c.', 1, N'Comedy');

INSERT INTO Videos VALUES
(N'vd011', N'VAN SON ?? Ha?i ki?ch | 2 LÁ TH? | Vân S?n - B?o Liêm - Quang Minh - Ho??ng ?a?o', N'VUDZ2LAyFGc', 100,
N'©VAN SON ENTERTAINMENT, INC. ALL RIGHTS RESERVED ? DO NOT RE-UPLOAD
?T?t C? video, Album trên Vân S?n YouTube Channel, ?ã ???c Trung Tâm Vân S?n ??ng ký b?n quy?n YouTube Channel. R?t mong các b?n, không sao chép HO?C re-upload d??i m?i hình th?c.', 1, N'Comedy');

INSERT INTO Videos VALUES
(N'vd012', N'VAN SON ?? San Jose | Hài K?ch HAI ??T 3 RU?NG | Vân S?n - B?o Liêm - Giáng Ng?c', N'LsLJCb0jQqI', 100,
N'©VAN SON ENTERTAINMENT, INC. ALL RIGHTS RESERVED ? DO NOT RE-UPLOAD
?T?t C? video, Album trên Vân S?n YouTube Channel, ?ã ???c Trung Tâm Vân S?n ??ng ký b?n quy?n YouTube. R?t mong các b?n, không sao chép HO?C re-upload d??i m?i hình th?c.', 1, N'Comedy');

INSERT INTO Videos VALUES
(N'vd013', N'VAN SON ?? Ca Nh?c Hài | H?C B?CH CÔNG T? | Vân S?n - Hoài Linh - H?ng ?ào - Úp M?p - Bé M?p', N'Q03GEFCi-cM', 100,
N'©VAN SON ENTERTAINMENT, INC. ALL RIGHTS RESERVED ? DO NOT RE-UPLOAD
?T?t C? video, Album trên Vân S?n YouTube Channel, ?ã ???c Trung Tâm Vân S?n ??ng ký b?n quy?n YouTube. R?t mong các b?n, không sao chép HO?C re-upload d??i m?i hình th?c.', 1, N'Comedy');

INSERT INTO Videos VALUES
(N'vd014', N'VAN SON ?? Hài Kinh ?i?n | S?N TINH THU? TINH | Vân S?n - B?o Liêm - V?n Chung', N'7Ez2_bxvExk', 100,
N'©VAN SON ENTERTAINMENT, INC. ALL RIGHTS RESERVED ? DO NOT RE-UPLOAD
?T?t C? video, Album trên Vân S?n YouTube Channel, ?ã ???c Trung Tâm Vân S?n ??ng ký b?n quy?n YouTube. R?t mong các b?n, không sao chép HO?C re-upload d??i m?i hình th?c.', 1, N'Comedy');

INSERT INTO Videos VALUES
(N'vd015', N'PHIM HÀNH ??NG VÕ THU?T KINH ?I?N | CHI?N LANG - PH?N CU?I | Phim Hành ??ng Võ Thu?t Hay Nh?t', N'hDuttHj9WWw', 1000,
N'? N?i Dung Phim CHI?N LANG - PH?N CU?I :
Phim Chi?n Lang Ph?n Cu?i là b? phim hành ??ng, võ thu?t chi?u r?p c?a ?i?n ?nh Trung Qu?c. Phim do Ngô Kinh ??o di?n và có s? tham gia c?a c?p di?n viên ??nh cao Scott Adkins – Ngô Kinh.
V??ng Lãnh Phong (Ngô Kinh), m?t ng??i lính s?n sàng xông pha tr?n m?c. Nh?ng sau l?n cãi l?i ch? huy và b?n ch?t m?t ph?n t? kh?ng b?, anh b? khai tr? kh?i quân ??i. K? b? ?ánh ch?t v?n là em trai c?a tên trùm ma túy M?n ??ng. ?? tr? thù, h?n k?t h?p v?i tên lính ?ánh thuê Lão Miêu (Scott Adkins) ?? sát h?i Lãnh Phong và nh?ng ng??i ??ng ??i c?a anh.', 1, N'Action');

INSERT INTO Videos VALUES
(N'vd016', N'PHIM HÀNH ??NG CHI?U R?P 2020 | NG??I V?N CHUY?N - Ph?n Cu?i | Phim Hành ??ng M? 2020', N's7lY5w51a8c', 1000,
N'Ph?n phim m?i c?a series Ng??i v?n chuy?n có tên g?i The Transporter: Refueled, ?ây s? là t?p phim t?p trung vào vi?c kh?i ??ng l?i d? án ?ình ?ám này do “lính m?i” Ed Skrein ??m nh?n vai chính. Europacorp, nhà s?n xu?t c?a lo?t phim hành ??ng n?i ti?ng Taken và Lucy, h?a h?n s? ?em ??n cho khán gi? m?t s?c s?ng m?i, m?t cái nhìn m?i v? Ng??i V?n Chuy?n. Chuy?n phim v?n xoay quanh nhân v?t Frank Martin, “ng??i v?n chuy?n” n?i ti?ng nh?t trong gi?i kinh doanh và t?i ph?m v?i k? n?ng lái xe siêu h?ng. Frank Martin có th? v?n chuy?n b?t c? món hàng nào ??n m?i ??a ?i?m ???c ch? ??nh, ch? c?n ???c tr? công t??ng x?ng. Nguyên t?c làm vi?c c?a anh là không phá v? h?p ??ng, không h?i tên và không m? ki?n hàng. Nh?ng d? nhiên trong nh?ng cu?c hành trình ??y r?y nh?ng nguy hi?m và nh?ng ?i?u b?t ng? ?p ??n, nh?ng nguyên t?c kia ?ã b? phá v?.', 1, N'Action');

INSERT INTO Videos VALUES
(N'vd017', N'[VIETSUB] Tay B?n T?a: Báo Thù | Sniper Vengeance | Phim L? YOUKU', N'7ZlX6H1CerE', 500,
N'N? x? th? tài ba Anna bu?c ph?i nh?n nhi?m v? ám sát, trong quá trình thi hành án d?n th?c t?nh thành m?t chi?n s? công lý t?t b?ng và ??y lòng yêu th??ng, liên quân ??c v? Artai ?ã ??ng lên bênh v?c công lý khi ??i m?t v?i s? ?àn áp ng??i dân c?a trùm ma túy. C? hai ?ã h?p tác ?? ng?n ch?n vi?c thông qua lu?t h?p pháp hóa vi?c tr?ng và buôn bán ma túy ? Libiwala, ??ng th?i phát ??ng tr?n chi?n sinh t? v?i trùm ma túy ph?n di?n Roger, cu?i cùng ??p tan âm m?u c?a k? ác, b?o v? ng??i dân kh?i ma túy, và c?u n??c.
Th? lo?i: Hành ??ng / Th?m h?a / Kinh d? / Phiêu l?u', 1, N'Action');

INSERT INTO Videos VALUES
(N'vd018', N'[VIETSUB] Vua B?n T?a: Ám Sát - The King of Snipers | Phim L? YOUKU', N'K8mZVqAQofs', 500,
N'N? x? th? tài ba Anna bu?c ph?i nh?n nhi?m v? ám sát, trong quá trình thi hành án d?n th?c t?nh thành m?t chi?n s? công lý t?t b?ng và ??y lòng yêu th??ng, liên quân ??c v? Artai ?ã ??ng lên bênh v?c công lý khi ??i m?t v?i s? ?àn áp ng??i dân c?a trùm ma túy. C? hai ?ã h?p tác ?? ng?n ch?n vi?c thông qua lu?t h?p pháp hóa vi?c tr?ng và buôn bán ma túy ? Libiwala, ??ng th?i phát ??ng tr?n chi?n sinh t? v?i trùm ma túy ph?n di?n Roger, cu?i cùng ??p tan âm m?u c?a k? ác, b?o v? ng??i dân kh?i ma túy, và c?u n??c.
Th? lo?i: Hành ??ng / Th?m h?a / Kinh d? / Phiêu l?u', 1, N'Action');

INSERT INTO Videos VALUES
(N'vd019', N'[VIETSUB] Cu?c Gi?i C?u C?a Ti?u ??i Cáo ?en - Black Fox: Ultimate Rescue | Phim L? YOUKU', N'DIeQidmCM84', 800,
N'N?m 1945, chuyên gia quân s? Liên Xô mang thông tin quan tr?ng ??n Trung Qu?c, ?ã b? quân ??i Nh?t B?n c??p trên ???ng ?i. ??i c?u h? do Qu?c dân ??ng d?n ??u ?ã th?t b?i th?m h?i. Cùng lúc ?ó, c?a ??i quân s? 8 ???c l?nh gia nh?p ??i quân tinh nhu? c?a Black Fox, và sau nhi?u khó kh?n và nguy hi?m, ?ã ???c gi?i c?u thành công.
?Th? lo?i: Hành ??ng / Kinh d? / Bí ?n', 1, N'Action');

INSERT INTO Videos VALUES
(N'vd020', N'Siêu Ph?m Hành ??ng Kháng Nh?t M?i Nh?t 2020 | X? TH? - ??I ??T KÍCH H?NG ?NG | Thuy?t Minh', N'efFUtxO60FI', 800,
N'? ??o di?n: Lý Ki?n Khôi
? Di?n viên: T? H?i Vi, Hà Quân
? X? TH? - ??I ??T KÍCH H?NG ?NG k? v? th?i k? kháng chi?n, khi bát l? quân chu?n b? tri?n khai tác chi?n quy mô l?n ?? kháng Nh?t, nhân viên tình báo ?n n?p trong quân Nh?t g?i ??n ?i?n báo bí m?t báo tin quân Nh?t ??nh s? d?ng v? khí sinh hóa trên chi?n tr??ng. Quân tr??ng Lý Thiên H?u c? ??i ??t kích H?ng ?ng ??n ti?p ?ng nhân viên tình báo, mang t? li?u v? v? khí sinh hóa v? ?? d? dàng ?ng phó. Không ng? ?i?n báo c?a nhân viên tình báo b? quân nh?t phát giác, l?p t?c ra l?nh di d?i ??i quân thí nghi?m, ??ng th?i c? ti?u ??i 35 ng??i chu?n b? tiêu di?t ??i ??t kích H?ng ?ng.', 1, N'Action');

INSERT INTO Videos VALUES
(N'vd021', N'[Thuy?t Minh] TRÁNG S? XU?T KÍCH | Phim Chi?n Tranh Kháng Nh?t C?c Hay | Phim L? M?i Nh?t 2020', N'phgY-ovAaDc', 700,
N'? ??o di?n: D??ng H?
? Di?n viên: Tri?u Ngh?, L?u Giám, B?ch V?
? TRÁNG S? XU?T KÍCH k? v? câu chuy?n anh d?ng hi sinh vì n??c nhà c?a 82 v? anh hùng c?a Tân t? quân. Tháng 3 n?m 1943, 82 d?ng s? c?a Tân t? quân vì y?m h? cho quân ch? l?c và ??ng b? an toàn di chuy?n, h? ?ã ngoan c??ng ch?ng l?i h?n m??i l?n t?n công c?a quân Nh?t.', 1, N'Action');

INSERT INTO Videos VALUES
(N'vd022', N'PHIM HÀNH ??NG CHI?U R?P 2020 | S?C M?NH C?A R?NG - Ph?n Cu?i | Phim Hành ??ng Võ Thu?t Hay Nh?t', N'uRwPB-_O9cE', 300,
N'Phim S?c M?nh C?a R?ng nh?n l?nh Peter ??i ??, nhà du hành ng??i Anh Jonathan Green l?i m?t l?n n?a lên ???ng v?i yêu c?u l?n này là v? l?i b?n ?? vùng Vi?n ?ông Nga. Trên chuy?n hành trình dài c?a mình, nh?ng cu?c phiêu l?u k? thú s? d?n ???ng cho anh ??n v?i ??t n??c Trung Hoa và b?t ng? ??i m?t v?i vô vàn nh?ng khám phá ngo?n m?c, nh?ng sinh v?t k? quái, nh?ng nàng công chúa, ph?i ??i ??u sinh t? v?i nh?ng b?t th?y võ thu?t và th?m chí là vua c?a t?t c? loài R?ng, Long V??ng. ?âu m?i là nguy hi?m ?áng s? nh?t? Li?u s?c m?nh nào s? chi?m th? th??ng phong, s? trung thành v?i khao khát ???c tìm ra s? th?t c?a m?t nhà khoa h?c hay các ma thu?t ?en t?i ?ang th?ng tr? nh?ng vùng ??t ph??ng ?ông?', 1, N'Action');

INSERT INTO Videos VALUES
(N'vd023', N'Review Phim Big Mouth (2022) B?n Full | Tóm T?t Phim Big Mouth | Lee Jong Suk và Yoona', N'egwCJMkFmHU', 400,
N'Phim:  Big Mouth (2022)
B? phim Big Mouth k? v? câu chuy?n v? m?t anh chàng lu?t s? kém tài và không may b? cu?n vào m?t v? án gi?t ng??i. ?? s?ng sót và b?o v? gia ?ình mình, anh b?t bu?c ph?i ?ào sâu khám phá âm m?u l?n c?a t?ng l?p th??ng l?u.', 1, N'Movie');

INSERT INTO Videos VALUES
(N'vd024', N'Review Phim: T?i Ác Vô Hình | Blind | B?n Full | T?p 1-16 | Taecyeon | Ha Seok Jin | Jung Eun Ji', N'T2nNe915ebk', 1500,
N'T?i ác vô hình là câu chuy?n k? v? cu?c ??i Ryu Sung Joon - m?t thanh tra ??y nhi?t huy?t và quy?t tâm truy b?t nh?ng k? x?u. Jo Eun Ki - m?t nhân viên xã h?i v?i trái tim ?m áp, luôn tin vào công lý. Và Ryu Sung Hoon - anh trai c?a Sung Joon, là m?t v? th?m phán ??y tài n?ng, luôn ??a ra nh?ng phán xét công b?ng.
Tuy nhiên, cu?c ??i th?t tr? trêu khi c? ba vô tình dính vào m?t v? án gi?t ng??i hàng lo?t mà n?n nhân chính là các thành viên c?a b?i th?m ?oàn, h? ?ã cùng nhau tìm ra chân t??ng s? th?t, b?t k? th? ác ch?u trách nhi?m tr??c pháp lu?t, ??ng th?i gi?i mã nh?ng bí ?n ??ng sau v? án này.
Các c?nh trong video hoàn toàn ???c th?c hi?n trên phim ?nh, hi?u ?ng, hóa trang và b?i nh?ng di?n viên chuyên nghi?p, an toàn ??n ng??i xem.
A Phim Review - tóm t?t n?i dung & ?ánh giá', 1, N'Movie');

