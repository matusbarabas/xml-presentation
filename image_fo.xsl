<fo:block space-after="12pt" text-align="center">
	<fo:external-graphic content-height="scale-to-fit" scaling="non-uniform">
		<xsl:attribute name="src">url(<xsl:value-of select="image/src"/>)</xsl:attribute>
		<xsl:attribute name="content-width"><xsl:value-of select="image/width"/>px</xsl:attribute>
		<xsl:attribute name="height"><xsl:value-of select="image/height"/>px</xsl:attribute>
  </fo:external-graphic>
 </fo:block>
