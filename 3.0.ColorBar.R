ColorBar <- function(brks, cols = NULL, vert = TRUE, subsampleg = 1,
                     cex = 1, tick = TRUE, upperspace = 1, lowerspace = 0,
                     rightspace=1, leftspace=1) {
  # Creates a horizontal or vertical colorbar to introduce in multipanels.
  #
  # Args:
  #   brks: Levels.
  #   cols: List of colours, optional.
  #   vert: TRUE/FALSE for vertical/horizontal colorbar.
  #   kharin: Supsampling factor of the interval between ticks on colorbar.
  #           Default: 1 = every level
  #   cex: Multiplicative factor to increase the ticks size, optional.
  #
  # Returns:
  #   This function returns nothing
  #
  # History:
  #   1.0  #  2012-04  (V. Guemas, vguemas@ic3.cat)  #  Original code
  #   1.1  #  2014-11  (C. Prodhomme, chloe.prodhomme@ic3.cat)
  # add cex option
  #
  #
  #  Input arguments
  # ~~~~~~~~~~~~~~~~~
  #
  if (is.null(cols) == TRUE) {
    nlev <- length(brks) - 1
    cols <- rainbow(nlev)
  } else {
    if (length(cols) != (length(brks) - 1)) {
      stop("Inconsistent colour levels / list of colours")
    }
  }
  # 
  #  Plotting colorbar
  # ~~~~~~~~~~~~~~~~~~~
  #
  if (vert) {
    par(mar = c(lowerspace, leftspace, upperspace, 1.5 *( rightspace + cex))
        , mgp = c(1, 1, 0), las = 1, cex = 1.2)
    image(1, c(1:length(cols)), t(c(1:length(cols))), axes = FALSE, col = cols, 
          xlab = '', ylab = '')
    box()
    axis(4, at = seq(0.5, length(brks) - 0.5, subsampleg), tick = tick, 
         labels = brks[seq(1, length(brks), subsampleg)], cex.axis = cex)
  } else {
    tickoffset=switch(as.character(tick), "TRUE"=0.5 , "T"=0.5, 0)
    posax=switch(as.character(tick), "TRUE"=max(c(0.3,0.8*cex-0.5)),
                 "T"=max(c(0.3,0.8*cex-0.5)), 0)
    par(mar = c(tickoffset + cex +lowerspace , leftspace,
                upperspace, rightspace),
        mgp = c(1.5, posax, 0),
        las = 1, cex = 1.2)
    image(1:length(cols), 1, t(t(1:length(cols))), axes = FALSE, col = cols,
          xlab = '', ylab = '')
    box()
    axis(1, at = seq(0.5, length(brks) - 0.5, subsampleg), tick = tick, 
         labels = brks[seq(1, length(brks), subsampleg)], cex.axis = cex)
  }
}