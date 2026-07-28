# Guía: Publicar una vista ABAP CDS (MARA) como servicio OData

**Archivo resultante:** Guía_Publicar_CDS_OData.pdf  
**Placeholders:** las URL/host y el nombre de servicio se dejan como <host> y <SERVICE_NAME>.

---

## Contenido
- Resumen
- Archivo CDS listo
- Crear y activar el objeto CDS en ADT
- Registrar el servicio OData en SAP Gateway (/IWFND/MAINT_SERVICE)
- Probar el servicio (GW_CLIENT y curl)
- Troubleshooting
- Apéndice: transacciones útiles

---

## Resumen
Objetivo: crear una vista CDS sobre las tablas MARA + MAKT, publicarla con `@OData.publish: true` y registrar/activar el servicio OData en SAP Gateway para consumirlo vía REST.

Requisitos: ADT conectado al sistema, permisos para crear objetos en paquete/transport, acceso a /IWFND/MAINT_SERVICE y /IWFND/GW_CLIENT.

---

## Archivo CDS (para pegar en ADT)
Guarda también este archivo como `ZC_MaraProducts.cds` si quieres (ve bloque aparte). Aquí tienes el bloque para pegar directamente en ADT:

```abap
@AbapCatalog.sqlViewName: 'ZCMARA01'
@ClientDependent: true
@EndUserText.label: 'CDS View: MARA - Productos con texto'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@OData.publish: true
define root view entity ZC_MaraProducts
  as select from mara as M
    left outer join makt as T
      on M.mandt = T.mandt
     and M.matnr = T.matnr
{
  key M.matnr           as ProductID,     // Número de material (CHAR 18)
      M.mtart           as MaterialType,  // Tipo de material
      M.matkl           as MaterialGroup, // Grupo de material
      M.meins           as BaseUnit,      // Unidad base
      T.spras           as Language,      // Idioma del texto
      T.maktx           as ProductText    // Texto descriptivo
}
// Para filtrar por español, descomenta la siguiente línea:
// where T.spras = 'ES'