% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/EValue.R
\name{confounded_meta}
\alias{confounded_meta}
\title{Estimates and inference for sensitivity analyses}
\usage{
confounded_meta(q, r = NA, muB = NA, sigB = 0, yr, vyr = NA, t2,
  vt2 = NA, CI.level = 0.95, tail = NA)
}
\arguments{
\item{q}{True effect size that is the threshold for "scientific significance"}

\item{r}{For \code{Tmin} and \code{Gmin}, value to which the proportion of large effect sizes is to be reduced}

\item{muB}{Mean bias factor on the log scale across studies}

\item{sigB}{Standard deviation of log bias factor across studies}

\item{yr}{Pooled point estimate (on log scale) from confounded meta-analysis}

\item{vyr}{Estimated variance of pooled point estimate from confounded meta-analysis}

\item{t2}{Estimated heterogeneity (tau^2) from confounded meta-analysis}

\item{vt2}{Estimated variance of tau^2 from confounded meta-analysis}

\item{CI.level}{Confidence level as a proportion}

\item{tail}{\code{above} for the proportion of effects above \code{q}; \code{below} for
the proportion of effects below \code{q}. By default, is set to \code{above} for relative risks
above 1 and to \code{below} for relative risks below 1.}
}
\description{
Computes point estimates, standard errors, and confidence interval bounds
for (1) \code{prop}, the proportion of studies with true effect sizes above \code{q} (or below
\code{q} for an apparently preventive \code{yr}) as a function of the bias parameters;
(2) the minimum bias factor on the relative risk scale (\code{Tmin}) required to reduce to
less than \code{r} the proportion of studies with true effect sizes more extreme than
\code{q}; and (3) the counterpart to (2) in which bias is parameterized as the minimum
relative risk for both confounding associations (\code{Gmin}).
}
\details{
To compute all three point estimates (\code{prop, Tmin, and Gmin}) and inference, all
arguments must be non-\code{NA}. To compute only a point estimate for \code{prop},
arguments \code{r, vyr}, and \code{vt2} can be left \code{NA}. To compute only
point estimates for \code{Tmin} and \code{Gmin}, arguments \code{muB, vyr}, and \code{vt2}
can be left \code{NA}. To compute inference for all point estimates, \code{vyr} and 
\code{vt2} must be supplied.
}
\examples{
d = metafor::escalc(measure="RR", ai=tpos, bi=tneg,
ci=cpos, di=cneg, data=metafor::dat.bcg)

m = metafor::rma.uni(yi= d$yi, vi=d$vi, knha=FALSE,
                     measure="RR", method="DL" ) 
yr = as.numeric(m$b)  # metafor returns on log scale
vyr = as.numeric(m$vb)
t2 = m$tau2
vt2 = m$se.tau2^2 

# obtaining all three estimators and inference
confounded_meta( q=log(0.90), r=0.20, muB=log(1.5), sigB=0.1,
                 yr=yr, vyr=vyr, t2=t2, vt2=vt2,
                 CI.level=0.95 )

# passing only arguments needed for prop point estimate
confounded_meta( q=log(0.90), muB=log(1.5),
                 yr=yr, t2=t2, CI.level=0.95 )

# passing only arguments needed for Tmin, Gmin point estimates
confounded_meta( q=log(0.90), r=0.20,
                 yr=yr, t2=t2, CI.level=0.95 )
}
