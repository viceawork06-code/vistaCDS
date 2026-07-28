@AbapCatalog.sqlViewName: 'ZCPROD00'
@EndUserText.label: 'CDS View: Productos'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@OData.publish: true
define root view entity ZC_Products
  as select from mara as M
{
  key M.matnr   as ProductID,    // número de material
      M.mtart   as ProductType,  // tipo
      M.mfrgr   as Manufacturer, // grupo fabricante (ejemplo)
      M.meins   as Unit          // unidad de medida
}