<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE xsl:stylesheet [
  <!ENTITY nested_list_fo_xsl SYSTEM "nested_list_fo.xsl">
  <!ENTITY image_fo_xsl SYSTEM "image_fo.xsl">
]>

<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:strip-space elements="*"/>

  <xsl:template match="/">
    <fo:root>
      <fo:layout-master-set>
        <fo:simple-page-master
					master-name="title-slide"
					page-width="33.86cm"
					page-height="19.05cm"
          >
            <fo:region-body margin-top="1cm" padding="1cm"/>
        </fo:simple-page-master>

        <fo:simple-page-master
					master-name="slide"
					page-width="33.86cm"
					page-height="19.05cm">
            <fo:region-body margin-top="1cm" padding="1cm"/>
            <fo:region-before extent="19.05cm"/>
            <fo:region-after extent="1.5cm"/>
        </fo:simple-page-master>

        <fo:page-sequence-master master-name="all">
          <fo:single-page-master-reference master-reference="title-slide" />
          <fo:repeatable-page-master-reference master-reference="slide" />
        </fo:page-sequence-master>
      </fo:layout-master-set>

      <fo:page-sequence master-reference="all" initial-page-number="1">
        <fo:static-content flow-name="xsl-region-after">
          <fo:block text-align="right" font-size="20pt" margin-right="0.5cm"><fo:page-number/></fo:block>
        </fo:static-content>
        <fo:flow flow-name="xsl-region-body">
          <fo:block><xsl:apply-templates/></fo:block>
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>

  <xsl:template match="inline[@type='bold']">
    <fo:inline font-weight="bold">
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="inline[@type='italic']">
    <fo:inline font-style="italic">
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="inline[@type='underline']">
    <fo:inline text-decoration="underline">
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="list">
    <xsl:for-each select="item">
      &nested_list_fo_xsl;
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="slide[@type='title-slide']">
    <fo:block font-size="45pt" font-weight="bold" text-align="center" margin-top="15%">
      <xsl:value-of select="title"/>
    </fo:block>
    <fo:block font-size="20pt" font-weight="bold" text-align="center" margin-top="5%">
      <xsl:value-of select="autor"/>
    </fo:block>
    <fo:block page-break-before="always"/>
  </xsl:template>

  <xsl:template match="slide[@type = 'content']">
    <fo:block font-size="35pt" font-weight="bold" space-after="1cm">
      <xsl:value-of select="title"/>
    </fo:block>
    <fo:list-block
      provisional-distance-between-starts="0.2cm"
      provisional-label-separation="0.5cm"
      start-indent="1.0cm">

      <xsl:for-each select="/presentation/slide">
        <xsl:if test="not(@type = 'title-slide') and not(@type = 'content')">
          <fo:list-item>
            <fo:list-item-label end-indent="label-end()">
              <fo:block font-size="20pt">- </fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="body-start()">
              <fo:block font-size="20pt" margin-left="0.5cm" space-after="0.4cm">
                <fo:basic-link>
                  <xsl:attribute name="internal-destination"><xsl:value-of select="position()"/></xsl:attribute>
                  <xsl:value-of select="title"/>
                </fo:basic-link>
              </fo:block>
            </fo:list-item-body>
          </fo:list-item>
        </xsl:if>
      </xsl:for-each>
    </fo:list-block>
    <fo:block page-break-before="always" />
  </xsl:template>


  <xsl:template match="slide[@type='list-only']">
    <fo:block font-size="35pt" font-weight="bold" space-after="1cm">
      <xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
      <xsl:value-of select="title"/>
    </fo:block>
    <xsl:apply-templates select="list"/>
    <fo:block page-break-before="always"/>
  </xsl:template>

  <xsl:template match="slide[@type='list-image']">
    <fo:block font-size="35pt" font-weight="bold" space-after="1cm">
      <xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
      <xsl:value-of select="title"/>
    </fo:block>
    <fo:table>

      <xsl:choose>
        <xsl:when test="image/align = 'right'">
          <fo:table-column>
            <xsl:attribute name="column-width"><xsl:value-of select="list/block_width"/>cm</xsl:attribute>
          </fo:table-column>
          <fo:table-column>
            <xsl:attribute name="column-width"><xsl:value-of select="image/block_width"/>cm</xsl:attribute>
          </fo:table-column>
        </xsl:when>
        <xsl:otherwise>
          <fo:table-column>
            <xsl:attribute name="column-width"><xsl:value-of select="image/block_width"/>cm</xsl:attribute>
          </fo:table-column>
          <fo:table-column>
            <xsl:attribute name="column-width"><xsl:value-of select="list/block_width"/>cm</xsl:attribute>
          </fo:table-column>
        </xsl:otherwise>
      </xsl:choose>

      <fo:table-body>
        <fo:table-row>
          <xsl:choose>
            <xsl:when test="image/align = 'right'">
              <fo:table-cell>
                <xsl:apply-templates select="list"/>
              </fo:table-cell>
              <fo:table-cell padding="70px 0">
                &image_fo_xsl;
              </fo:table-cell>
            </xsl:when>
            <xsl:otherwise>
              <fo:table-cell padding="70px 0">
                &image_fo_xsl;
              </fo:table-cell>
              <fo:table-cell>
                <xsl:apply-templates select="list"/>
              </fo:table-cell>
            </xsl:otherwise>
          </xsl:choose>
        </fo:table-row>
      </fo:table-body>
    </fo:table>
    <fo:block page-break-before="always" />
  </xsl:template>

  <xsl:template match="slide[@type='comparison']">
    <fo:block font-size="35pt" font-weight="bold" space-after="1cm">
      <xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
      <xsl:value-of select="title"/>
    </fo:block>

    <fo:table>
      <fo:table-column column-width="15.93cm" />
      <fo:table-column column-width="15.93cm"/>

      <fo:table-body>
        <fo:table-row>
          <fo:table-cell>
            <xsl:if test="list[@align = 'left']">
              <xsl:for-each select="list[@align = 'left']/item">
                &nested_list_fo_xsl;
              </xsl:for-each>
            </xsl:if>
          </fo:table-cell>
          <fo:table-cell>
            <xsl:if test="list[@align = 'right']">
              <xsl:for-each select="list[@align = 'right']/item">
                &nested_list_fo_xsl;
              </xsl:for-each>
            </xsl:if>
          </fo:table-cell>
        </fo:table-row>
      </fo:table-body>
    </fo:table>
    <fo:block page-break-before="always" />
  </xsl:template>

  <xsl:template match="slide[@type='table-only']">
    <fo:block font-size="35pt" font-weight="bold" space-after="1cm">
      <xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
      <xsl:value-of select="title"/>
    </fo:block>

    <fo:block text-align="center" font-size="16pt">
      <xsl:value-of select="popis"/>
    </fo:block>

    <fo:table font-size="15pt" text-align="center">
      <fo:table-column column-width="7.96cm" border-width="4px" border-style="solid"/>
      <fo:table-column column-width="7.96cm" border-width="4px" border-style="solid"/>
      <fo:table-column column-width="7.96cm" border-width="4px" border-style="solid"/>
      <fo:table-column column-width="7.96cm" border-width="4px" border-style="solid"/>

      <fo:table-header border-width="4px" border-style="solid">
        <xsl:for-each select="table/table_header/title">
          <fo:table-cell>
            <fo:block font-weight="bold" text-align="center">
              <xsl:value-of select="."/>
            </fo:block>
          </fo:table-cell>
        </xsl:for-each>
      </fo:table-header>

      <fo:table-body>
        <xsl:for-each select="table/row">
          <fo:table-row border-width="4px" border-style="solid">
            <fo:table-cell >
              <fo:block>
                <xsl:value-of select="first_column"/>
              </fo:block>
            </fo:table-cell>
            <fo:table-cell>
              <fo:block>
                <xsl:value-of select="second_column"/>
              </fo:block>
            </fo:table-cell>
            <fo:table-cell>
              <fo:block>
                <xsl:value-of select="third_column"/>
              </fo:block>
            </fo:table-cell>
            <fo:table-cell>
              <fo:block>
                <xsl:value-of select="fourth_column"/>
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
        </xsl:for-each>
      </fo:table-body>
    </fo:table>
    <fo:block page-break-before="always" />
  </xsl:template>

  <xsl:template match="slide[@type='image-only']">
    <fo:block font-size="35pt" font-weight="bold" space-after="1cm">
      <xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
      <xsl:value-of select="title"/>
    </fo:block>
      &image_fo_xsl;
    <fo:block text-align="center" font-size="16pt">
      <xsl:value-of select="popis"/>
    </fo:block>
    <fo:block page-break-before="always" />
  </xsl:template>

  <xsl:template match="slide[@type='resources']">
    <fo:block font-size="35pt" font-weight="bold" space-after="1cm">
      <xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
      <xsl:value-of select="title"/>
    </fo:block>

    <fo:list-block
      provisional-distance-between-starts="0.2cm"
      provisional-label-separation="0.5cm"
      start-indent="1.0cm">

      <xsl:for-each select="resource">

        <fo:list-item>
          <fo:list-item-label end-indent="label-end()">
            <fo:block font-size="16pt">-</fo:block>
          </fo:list-item-label>
          <fo:list-item-body start-indent="body-start()">
            <xsl:if test="@type='web'">
              <fo:block font-size="16pt" margin-left="0.5cm" space-after="0.2cm">
                <xsl:for-each select="author">
                  <xsl:value-of select="surname"/>,
                  <xsl:value-of select="name"/>.
                </xsl:for-each>
                (<xsl:value-of select="year"/>).
                [online] <xsl:value-of select="website_name"/>.
                Available at: <xsl:value-of select="url"/>.
              </fo:block>
            </xsl:if>
            <xsl:if test="@type='journal'">
              <fo:block font-size="16pt" margin-left="0.5cm" space-after="0.2cm">
                <xsl:for-each select="author">
                  <xsl:value-of select="surname"/>,
                  <xsl:value-of select="name"/>.
                </xsl:for-each>
                (<xsl:value-of select="year"/>).
                <xsl:value-of select="title"/>. In:
                <fo:inline font-style="italic"><xsl:value-of select="journal"/></fo:inline>,
                <xsl:value-of select="volume"/>.
                <xsl:value-of select="issue"/>,
                pp: <xsl:value-of select="pages_used"/>.
              </fo:block>
            </xsl:if>
            <xsl:if test="@type='book'">
              <fo:block font-size="16pt" margin-left="0.5cm" space-after="0.2cm">
                <xsl:for-each select="author">
                  <xsl:value-of select="surname"/>,
                  <xsl:value-of select="name"/>.
                </xsl:for-each>
                (<xsl:value-of select="year"/>).
                <xsl:value-of select="title"/>.
                <xsl:value-of select="city"/>,
                pp: <xsl:value-of select="pages_used"/>.
              </fo:block>
            </xsl:if>
          </fo:list-item-body>
        </fo:list-item>
      </xsl:for-each>
    </fo:list-block>
  </xsl:template>

</xsl:stylesheet>
