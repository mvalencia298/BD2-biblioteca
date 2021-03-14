/*
	Inserts
*/

Insert into tblusuario values(8888,'Carlos','32163','7512',1,'Vigente');


Insert into tblMaterial values('Buen vendedor',30000,2013,1,1);

select * from tblReserva;

Insert into tblReserva values(getdate(),8888,10);

create table tbldatos
(
 Cod_datos int identity (1,1),
 Fecha datetime default getdate() not null,
 Cedula int not null,
 Cod_Material int not null,
 Primary key (Cod_datos),
 Foreign Key (Cedula) references
 tblUsuario (Cedula) on delete cascade on update cascade,
 Foreign Key (Cod_Material) references
 tblMaterial (Cod_Material) on delete cascade on update cascade
)



/*
	Querys
*/
select m.* from tblMaterial m 
join tblPrestamo p on m.Cod_material = p.Cod_Material 
join tblPertenece tp on p.Cedula = tp.Cedula and tp.Cod_Dependencia in (2, 3) where p.Cod_Prestamo not in (select d.Num_Prestamo from tblDevolucion d);


select m.Nombre_material, count(p.Cod_Prestamo) from tblMaterial m 
join tblPrestamo p on m.Cod_material = p.Cod_Material 
group by m.Nombre_material, m.Cod_material, m.Valor, m.año, m.cantidad, m.CodTipo_Material
HAVING count(p.Cod_Prestamo) > (SELECT AVG(cantidad) FROM tblMaterial);


select * from tblusuario u join tblPertenece p on u.Cedula = p.Cedula where Estado_usuario = 'Betado';

/*
	Updates
*/
UPDATE e
SET e.estado = 'reservado'
from tblEjemplar e 
join tblMaterial m on e.Cod_Material = m.Cod_material 
join tblTipo_Material tm on m.CodTipo_Material = tm.CodTipo_Material
where tm.NombreTipo_Material in ('película', 'juegos');


UPDATE m 
SET m.Valor = m.Valor-(m.Valor*.05)
from tblMaterial m 
join (select p.Cod_Material 
from tblPrestamo p 
group by p.Cod_Prestamo, p.Cod_Material
HAVING count(p.Cod_Prestamo) > 5 ) as pr on m.Cod_material = pr.Cod_Material 
where m.año < 2000;


UPDATE tblusuario
SET Estado_usuario = 'vigente'
WHERE Nombre in ('Carlos', 'Camilo', 'Camila') 
and Cedula in (select Cedula from tblPertenece where Cod_Dependencia = 1);

/*
	Delete
*/

delete r 
from tblReserva r 
join tblusuario u on r.Cedula = u.Cedula 
where u.Nombre in ('Carlos', 'Camilo', 'Camila');

delete p 
from tblPrestamo p 
join tblEjemplar e on p.Num_Ejemplar = e.Num_Ejemplar 
join tblMaterial m on e.Cod_Material = m.Cod_material 
where m.CodTipo_Material = 1;
