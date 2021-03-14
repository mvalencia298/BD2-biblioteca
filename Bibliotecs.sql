select * from tblTipo_Material;

select * 
from tblMaterial m 
join tblPrestamo p on m.Cod_material = p.Cod_Material 
where p.Fecha_Entrega > '2010-01-01';

select t.NombreTipo_Material,  AVG(m.Valor)
from tblMaterial m 
left join tblPrestamo p on m.Cod_material = p.Cod_Material 
join tblTipo_Material t on m.CodTipo_Material = t.CodTipo_Material
group by t.NombreTipo_Material;

select u.Nombre, u.Cedula, u.telefono, u.Direccion, d.Nombre_Dependencia, m.Nombre_material, p.Cod_Prestamo, p.Fecha_Entrega
from tblusuario u 
join tblPrestamo p on u.Cedula = p.Cedula 
join tblMaterial m on p.Cod_Material = m.Cod_material
join tblPertenece pe on u.Cedula = pe.Cedula
join tbldependencia d on pe.Cod_Dependencia = d.Cod_Dependencia
where p.Cod_Prestamo not in (select d.Num_Prestamo from tblDevolucion d) ;

select * from tblTipo_Usuario;
select * from tbldependencia;
select * from tblPertenece;
select * from tblDevolucion;

select * from tblPrestamo p;