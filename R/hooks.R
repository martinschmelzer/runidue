#'@import knitr 
set_hooks <- function() {
  # render_latex()
  default_hooks  <- knit_hooks$get()
  list(
    chunk = function(x, options) {
      x <- default_hooks$chunk(x, options)
      ifelse(!is.null(options$fontsize), paste0("\n", options$fontsize,"\n\n", x, "\n\n \\normalsize"), x)
    },
    cex = function(before, options, envir) {
      if (before) par(mar = c(4.1, 3.1, 1.5, 1), oma = c(0, 0, 0, 0), pch = 16,
                      mgp = c(1.7, 0.4, 0), tcl = -0.33, cex = options$cex)
    },
    output = function(x, options) {
      x <- paste0("```\n", x,"```\n")
      x <- ifelse(is.null(options$shadeoutput),
                  x,
                  paste0("\\Shaded\n", x, "\\endShaded\n"))
                  # paste0("\\begin{Shaded}\n\\begin{verbatim}\n", gsub(pattern = "```|^\\s*$", "", x, perl = T), "\\end{verbatim}\n\\end{Shaded}"))
      message(x)
      x
    }
  )
}


set_opt_hooks <- function() {
  list(
    fig.width = function(options) {
      if (!(options$fig.width <= 1 & options$fig.width > 0)) {
        stop("fig.width should be in (0, 1]")
      }
      options$cex <- magnify(options$fig.width)
      options$fig.width  <- options$fig.width * slide.width
      options$fig.height <- options$fig.asp * options$fig.width
      options
    }
  )
}