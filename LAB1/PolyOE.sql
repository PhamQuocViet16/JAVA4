
create database PolyOE

use PolyOE

create table Users(
	Id nvarchar(20) not null,
	Password nvarchar(50) not null,
	Fullname nvarchar(50) not null,
	Email nvarchar(50) not null,
	Admin bit not null,
	primary key(Id)
)

insert into Users(Id, Password, Fullname, Email, Admin) values
('admin', '123456', N'Nguy?n V?n A', 'admin@poly.edu.vn', 1),
('nv01', '123456', N'Tr?n Th? B', 'btran@poly.edu.vn', 0),
('nv02', '123456', N'Lê V?n C', 'cle@poly.edu.vn', 0),
('nv03', '123456', N'Ph?m Th? D', 'dpham@poly.edu.vn', 0),
('nv04', '123456', N'?? Qu?c E', 'edo@poly.edu.vn', 1)