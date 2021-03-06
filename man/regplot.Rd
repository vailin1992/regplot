% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/regplot.R
\name{regplot}
\alias{regplot}
\title{Plots a regression nomogram showing covariate distribution.}
\usage{
regplot(reg, dummies = FALSE, center = FALSE, observation = NULL,
  title = NULL, points = TRUE, other = list(bvcol = "#DDEEDD", sqcol =
  "#EEEEEE", obscol = "red", failtime = NA, prfail = TRUE, ndisc = 5, droplines
  = FALSE))
}
\arguments{
\item{reg}{A regression object of either class \code{glm}, \code{lm}, or \code{coxph}  from a fitted model}

\item{dummies}{\code{TRUE} to treat dummy indicators of factor variables as distinct binary variables, with their own nomogram row. 
Otherwise different categories of the factor are represented on the same row.}

\item{center}{Produces plot in which regression score contributions of continuous data are  plotted with respect 
to mean values.}

\item{observation}{An observation whose values
are superimposed on the plot. A data frame whose column names must include variables used
 in the regression formula.}

\item{title}{A heading title written to the plot}

\item{points}{If \code{FALSE} the regression scores \eqn{\beta}\eqn{x}  are shown. 
Otherwise the scale is represented by "points".}

\item{other}{A \code{list} of other optional parameters for features of the plot. \code{bvcol} is color fill of box and violin plots, 
\code{sqcol} is color fill of frequency boxes, \code{obscol} is color of observation dots,
\code{failtime}   specifies the cut-off time for
plotting the risk  nomogram of a \code{coxph} regression (if \code{failtime=NA}, cut-off is the median of time variable,
 with no account of censoring), \code{prfail=TRUE} if 
probability of failure before \code{failtime} is summarised, otherwise after \code{failtime}. 
If the number of unique values of covariate is less than
\code{ndisc},  discrete frequencies are plotted by scaled boxes. 
 \code{droplines} draws faint vertical lines showing score contributions to an observation.}
}
\description{
\code{regplot} plots a regression nomogram of \code{coxph}, \code{lm} and \code{glm}
 regressions. Covariate distributions are superimposed on nomogram scales and the plot
is animated to allow on the fly changes to distribution representation and to 
enable outcome calculation.
}
\details{
Creates a nomogram  representation of a fitted regression. 
The distribution of covariates in the model, and of the total regression score, are superimposed on the 
nomogram scales. Also the values of a particular observation can be superimposed. The plot is active for mouse input 
allowing on-the-fly changes to distribution type (boxes, spikes, box plot, density, violin and bean plots)
and also to observation values. 
Assumes that a regression has been fitted by either \code{glm},  \code{lm} or \code{coxph}. For \code{glm},
the supported family/link pairings are: gaussian/identity, binomial/logit, and  poisson/log.
}
\examples{
## Analysis of pbc data
library(survival)
data(pbc) 
pbc$catbili <- cut(pbc$bili,breaks=c(-Inf, 2, 4, Inf),
               labels=c("low","medium","high"))
pbc$died <- pbc$status==2
## Fit a Cox survival model
pbccox <-  coxph(formula = Surv(time,died) ~  age + catbili + sex + 
                 log(copper+1) +stage + trt,data=pbc)
obs <- pbc[1,]
regplot(pbccox,observation=obs, other=list( failtime = 1825, prfail = TRUE) ) 
## Fit a glm  logistic regression
pbcglm <- glm(formula = died ~  age + catbili + sex + copper +stage ,family = "binomial", data=pbc )
regplot(pbcglm)
}
\author{
Roger Marshall <rj.marshall@auckland.ac.nz> The University of Auckland, New Zealand
}
