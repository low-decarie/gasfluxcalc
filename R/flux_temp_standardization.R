#' Temperature standardization of gas flux measurements from freshwater systems
#'
#' @param source_temperature temperature at which measurements were made
#' @param reference_temperature temperature at which measurements are to be standardized
#' @param gas gas for which flux was measured
#'
#' @details based on DOI: 10.1038/nature13164 ; given an average apparent activation energy, standardizes flux measurements to a reference temperature
#'
#' @return
#' @export
#'
#' @examples
#'url <- "https://media.nature.com/original/nature-assets/nature/journal/v507/n7493/source_data/nature13164-f2.xlsx"
#'destfile <- "nature13164_f2.xlsx"
#'curl::curl_download(url, destfile)
#'nature13164_f2 <- read_excel(destfile,na="see notes")
#'nature13164_f2 <- cbind(nature13164_f2, flux_temp_standardization(rate_at_source=nature13164_f2$flux,source_temperature=nature13164_f2$temp, reference_temperature=0))
#'require(ggplot2)
#'qplot(data=nature13164_f2,
#'x=temp, y=log(rate_std_temp),colour=site, facets=.~ecosystem.type)+theme(legend.position="none")+geom_smooth(method="lm",se=F)


flux_temp_standardization <- function(rate_at_source=2,
                                 source_temperature=15,
                                 reference_temperature=20,
                                 gas="CH4"){

  k <- 8.62*10^-5

  if(gas=="CH4"){

#Activations : ecosystem level
mean_activation <- 0.96 #eV
lower_activation <- 0.86 # 0.95 CI
upper_activation <- 1.07


rate_std_temp <- exp(log(rate_at_source)+mean_activation*(1/(k*(source_temperature+273))-1/(k*(reference_temperature+273))))
lower_estimate <- exp(log(rate_at_source)+lower_activation*(1/(k*(source_temperature+273))-1/(k*(reference_temperature+273))))
upper_estimate <- exp(log(rate_at_source)+upper_activation*(1/(k*(source_temperature+273))-1/(k*(reference_temperature+273))))

  }



return(data.frame(rate_std_temp=rate_std_temp, lower_estimate=lower_estimate, upper_estimate=upper_estimate))

  }
