<xsl:element name="img">
  <xsl:attribute name="src">file:/<xsl:value-of select="image/src"/></xsl:attribute>
  <xsl:attribute name="width">
    <xsl:value-of select="image/width"/>
  </xsl:attribute>
  <xsl:attribute name="height">
    <xsl:value-of select="image/height"/>
  </xsl:attribute>
</xsl:element>
