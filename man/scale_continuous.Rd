% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/scale-continuous.R
\name{scale_continuous}
\alias{scale_x_continuous}
\alias{scale_y_continuous}
\alias{scale_x_log10}
\alias{scale_y_log10}
\alias{scale_x_reverse}
\alias{scale_y_reverse}
\alias{scale_x_sqrt}
\alias{scale_y_sqrt}
\title{Position scales for continuous data (x & y)}
\usage{
scale_x_continuous(
  name = waiver(),
  breaks = waiver(),
  minor_breaks = waiver(),
  n.breaks = NULL,
  labels = waiver(),
  limits = NULL,
  expand = waiver(),
  oob = censor,
  na.value = NA_real_,
  transform = "identity",
  trans = deprecated(),
  guide = waiver(),
  position = "bottom",
  sec.axis = waiver()
)

scale_y_continuous(
  name = waiver(),
  breaks = waiver(),
  minor_breaks = waiver(),
  n.breaks = NULL,
  labels = waiver(),
  limits = NULL,
  expand = waiver(),
  oob = censor,
  na.value = NA_real_,
  transform = "identity",
  trans = deprecated(),
  guide = waiver(),
  position = "left",
  sec.axis = waiver()
)

scale_x_log10(...)

scale_y_log10(...)

scale_x_reverse(...)

scale_y_reverse(...)

scale_x_sqrt(...)

scale_y_sqrt(...)
}
\arguments{
\item{name}{The name of the scale. Used as the axis or legend title. If
\code{waiver()}, the default, the name of the scale is taken from the first
mapping used for that aesthetic. If \code{NULL}, the legend title will be
omitted.}

\item{breaks}{One of:
\itemize{
\item \code{NULL} for no breaks
\item \code{waiver()} for the default breaks computed by the
\link[scales:new_transform]{transformation object}
\item A numeric vector of positions
\item A function that takes the limits as input and returns breaks
as output (e.g., a function returned by \code{\link[scales:breaks_extended]{scales::extended_breaks()}}).
Note that for position scales, limits are provided after scale expansion.
Also accepts rlang \link[rlang:as_function]{lambda} function notation.
}}

\item{minor_breaks}{One of:
\itemize{
\item \code{NULL} for no minor breaks
\item \code{waiver()} for the default breaks (none for discrete, one minor break
between each major break for continuous)
\item A numeric vector of positions
\item A function that given the limits returns a vector of minor breaks. Also
accepts rlang \link[rlang:as_function]{lambda} function notation. When
the function has two arguments, it will be given the limits and major
break positions.
}}

\item{n.breaks}{An integer guiding the number of major breaks. The algorithm
may choose a slightly different number to ensure nice break labels. Will
only have an effect if \code{breaks = waiver()}. Use \code{NULL} to use the default
number of breaks given by the transformation.}

\item{labels}{One of the options below. Please note that when \code{labels} is a
vector, it is highly recommended to also set the \code{breaks} argument as a
vector to protect against unintended mismatches.
\itemize{
\item \code{NULL} for no labels
\item \code{waiver()} for the default labels computed by the
transformation object
\item A character vector giving labels (must be same length as \code{breaks})
\item An expression vector (must be the same length as breaks). See ?plotmath for details.
\item A function that takes the breaks as input and returns labels
as output. Also accepts rlang \link[rlang:as_function]{lambda} function
notation.
}}

\item{limits}{One of:
\itemize{
\item \code{NULL} to use the default scale range
\item A numeric vector of length two providing limits of the scale.
Use \code{NA} to refer to the existing minimum or maximum
\item A function that accepts the existing (automatic) limits and returns
new limits. Also accepts rlang \link[rlang:as_function]{lambda} function
notation.
Note that setting limits on positional scales will \strong{remove} data outside of the limits.
If the purpose is to zoom, use the limit argument in the coordinate system
(see \code{\link[=coord_cartesian]{coord_cartesian()}}).
}}

\item{expand}{For position scales, a vector of range expansion constants used to add some
padding around the data to ensure that they are placed some distance
away from the axes. Use the convenience function \code{\link[=expansion]{expansion()}}
to generate the values for the \code{expand} argument. The defaults are to
expand the scale by 5\% on each side for continuous variables, and by
0.6 units on each side for discrete variables.}

\item{oob}{One of:
\itemize{
\item Function that handles limits outside of the scale limits
(out of bounds). Also accepts rlang \link[rlang:as_function]{lambda}
function notation.
\item The default (\code{\link[scales:oob]{scales::censor()}}) replaces out of
bounds values with \code{NA}.
\item \code{\link[scales:oob]{scales::squish()}} for squishing out of bounds values into range.
\item \code{\link[scales:oob]{scales::squish_infinite()}} for squishing infinite values into range.
}}

\item{na.value}{Missing values will be replaced with this value.}

\item{transform}{For continuous scales, the name of a transformation object
or the object itself. Built-in transformations include "asn", "atanh",
"boxcox", "date", "exp", "hms", "identity", "log", "log10", "log1p", "log2",
"logit", "modulus", "probability", "probit", "pseudo_log", "reciprocal",
"reverse", "sqrt" and "time".

A transformation object bundles together a transform, its inverse,
and methods for generating breaks and labels. Transformation objects
are defined in the scales package, and are called \verb{transform_<name>}. If
transformations require arguments, you can call them from the scales
package, e.g. \code{\link[scales:transform_boxcox]{scales::transform_boxcox(p = 2)}}.
You can create your own transformation with \code{\link[scales:new_transform]{scales::new_transform()}}.}

\item{trans}{\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#deprecated}{\figure{lifecycle-deprecated.svg}{options: alt='[Deprecated]'}}}{\strong{[Deprecated]}} Deprecated in favour of
\code{transform}.}

\item{guide}{A function used to create a guide or its name. See
\code{\link[=guides]{guides()}} for more information.}

\item{position}{For position scales, The position of the axis.
\code{left} or \code{right} for y axes, \code{top} or \code{bottom} for x axes.}

\item{sec.axis}{\code{\link[=sec_axis]{sec_axis()}} is used to specify a secondary axis.}

\item{...}{Other arguments passed on to \verb{scale_(x|y)_continuous()}}
}
\description{
\code{scale_x_continuous()} and \code{scale_y_continuous()} are the default
scales for continuous x and y aesthetics. There are three variants
that set the \code{transform} argument for commonly used transformations:
\verb{scale_*_log10()}, \verb{scale_*_sqrt()} and \verb{scale_*_reverse()}.
}
\details{
For simple manipulation of labels and limits, you may wish to use
\code{\link[=labs]{labs()}} and \code{\link[=lims]{lims()}} instead.
}
\examples{
p1 <- ggplot(mpg, aes(displ, hwy)) +
  geom_point()
p1

# Manipulating the default position scales lets you:
#  * change the axis labels
p1 +
  scale_x_continuous("Engine displacement (L)") +
  scale_y_continuous("Highway MPG")

# You can also use the short-cut labs().
# Use NULL to suppress axis labels
p1 + labs(x = NULL, y = NULL)

#  * modify the axis limits
p1 + scale_x_continuous(limits = c(2, 6))
p1 + scale_x_continuous(limits = c(0, 10))

# you can also use the short hand functions `xlim()` and `ylim()`
p1 + xlim(2, 6)

#  * choose where the ticks appear
p1 + scale_x_continuous(breaks = c(2, 4, 6))

#  * choose your own labels
p1 + scale_x_continuous(
  breaks = c(2, 4, 6),
  label = c("two", "four", "six")
)

# Typically you'll pass a function to the `labels` argument.
# Some common formats are built into the scales package:
set.seed(1)
df <- data.frame(
  x = rnorm(10) * 100000,
  y = seq(0, 1, length.out = 10)
)
p2 <- ggplot(df, aes(x, y)) + geom_point()
p2 + scale_y_continuous(labels = scales::label_percent())
p2 + scale_y_continuous(labels = scales::label_dollar())
p2 + scale_x_continuous(labels = scales::label_comma())

# You can also override the default linear mapping by using a
# transformation. There are three shortcuts:
p1 + scale_y_log10()
p1 + scale_y_sqrt()
p1 + scale_y_reverse()

# Or you can supply a transformation in the `trans` argument:
p1 + scale_y_continuous(transform = scales::transform_reciprocal())

# You can also create your own. See ?scales::new_transform

}
\seealso{
The \link[=aes_position]{position documentation}.

The \href{https://ggplot2-book.org/scales-position#sec-numeric-position-scales}{numeric position scales section} of the online ggplot2 book.

Other position scales: 
\code{\link{scale_x_binned}()},
\code{\link{scale_x_date}()},
\code{\link{scale_x_discrete}()}
}
\concept{position scales}
