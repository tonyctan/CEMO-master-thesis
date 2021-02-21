mice.impute.2l.2stage.norm.mm <- function(y, ry, x,type,...)
{
  return(mice.impute.2l.2stage.norm.reml(y, ry, x,type,method_est="mm"))
}

