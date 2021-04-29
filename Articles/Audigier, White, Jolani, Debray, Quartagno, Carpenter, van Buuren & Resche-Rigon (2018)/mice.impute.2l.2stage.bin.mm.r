mice.impute.2l.2stage.bin.mm <- function(y, ry, x,type,...)
{
  return(mice.impute.2l.2stage.bin.reml(y=y, ry=ry, x=x,type=type,method_est="mm"))
}