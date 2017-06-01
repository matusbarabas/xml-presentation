<div class="list">
  <ul>
    <li>
      <h2><xsl:apply-templates select="one"/></h2>
      <ul>
        <xsl:for-each select="two">
          <li>
            <h3><xsl:apply-templates select="."/></h3>
            <ul>
              <xsl:for-each select="following-sibling::three[preceding-sibling::two[1]=current()]">
                <li>
                  <h4><xsl:apply-templates select="."/></h4>
                </li>
              </xsl:for-each>
            </ul>
          </li>
        </xsl:for-each>
      </ul>
    </li>
  </ul>
</div>
