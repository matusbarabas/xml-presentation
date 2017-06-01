<fo:list-block
	provisional-distance-between-starts="0.2cm"
	provisional-label-separation="0.5cm"
	start-indent="1.0cm">
	<fo:list-item>
		<fo:list-item-label end-indent="label-end()">
			<fo:block font-size="20pt">-</fo:block>
		</fo:list-item-label>
		<fo:list-item-body start-indent="body-start()">
			<fo:block font-size="20pt" margin-left="0.5cm" space-after="0.4cm"><xsl:apply-templates select="one"/></fo:block>

			<fo:list-block
				provisional-distance-between-starts="0.2cm"
				provisional-label-separation="0.5cm"
				start-indent="1.5cm">

				 <xsl:for-each select="two">

					<fo:list-item>
						<fo:list-item-label end-indent="label-end()">
							<fo:block font-size="18pt">- </fo:block>
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block font-size="18pt" margin-left="0.5cm" space-after="0.4cm"><xsl:apply-templates select="."/></fo:block>

							<fo:list-block
								provisional-distance-between-starts="0.2cm"
								provisional-label-separation="0.5cm"
								start-indent="2.0cm">

								<xsl:for-each select="following-sibling::three[preceding-sibling::two[1]=current()]">

									<fo:list-item>
										<fo:list-item-label end-indent="label-end()">
											<fo:block font-size="16pt">- </fo:block>
										</fo:list-item-label>
										<fo:list-item-body start-indent="body-start()">
											<fo:block font-size="16pt" margin-left="0.5cm" space-after="0.4cm"><xsl:apply-templates select="."/></fo:block>
										</fo:list-item-body>
									</fo:list-item>

								</xsl:for-each>

							</fo:list-block>

						</fo:list-item-body>
					</fo:list-item>

				</xsl:for-each>
			</fo:list-block>

		</fo:list-item-body>
	</fo:list-item>
</fo:list-block>
