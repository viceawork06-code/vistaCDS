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