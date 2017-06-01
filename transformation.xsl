<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY css SYSTEM "style.css">
  <!ENTITY nested_list_xsl SYSTEM "nested_list.xsl">
  <!ENTITY image_xsl SYSTEM "image.xsl">
]>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:xs="http://www.w3.org/2001/XMLSchema">
  <xsl:param name="page-number" as="xs:boolean" required="no">true</xsl:param>
  <xsl:param name="font-type" as="xs:string" required="no">Thimes New Roman</xsl:param>
  <xsl:output method="xhtml" indent="yes" name="xhtml"/>
  <xsl:strip-space elements="*"/>

  <xsl:template match="slide" priority="2">
    <xsl:variable name="filename" select="concat('output/',position(),'.xhtml')"/>
    <xsl:value-of select="$filename"/>
    <xsl:result-document href="{$filename}" format="xhtml">
      <html>
        <head>
          <style>
            &css;
          </style>
        </head>
        <body>
          <div class="slide">
            <xsl:attribute name="style">font-family: <xsl:value-of select="$font-type"/></xsl:attribute>
            <xsl:if test="$page-number = true()">
              <div class="page_number">
                <xsl:if test="not(@type = 'title-slide')">
                  <xsl:value-of select="position()"/>
                </xsl:if>
              </div>
            </xsl:if>
            <xsl:next-match/>
          </div>
        </body>
      </html>
    </xsl:result-document>
  </xsl:template>

  <xsl:template match="inline[@type='italic']">
    <i><xsl:apply-templates/></i>
  </xsl:template>

  <xsl:template match="inline[@type='bold']">
    <b><xsl:apply-templates/></b>
  </xsl:template>

  <xsl:template match="inline[@type='underline']">
    <u><xsl:apply-templates/></u>
  </xsl:template>

  <xsl:template match="title">
    <h1><xsl:value-of select="."/></h1>
  </xsl:template>

  <xsl:template match="list">
    <xsl:for-each select="item">
      &nested_list_xsl;
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="slide[@type = 'title-slide']">
    <div class="container_title_slide">
      <h1><xsl:value-of select="title"/></h1>
      <h3><xsl:value-of select="autor"/></h3>
    </div>
  </xsl:template>

  <xsl:template match="slide[@type = 'content']">
    <xsl:apply-templates select="title"/>
    <xsl:for-each select="/presentation/slide">
      <xsl:variable name="filename" select="concat('file:///C:/Z3-xbarabas/output/' ,position(),'.xhtml')"/>
      <xsl:if test="not(@type = 'title-slide') and not(@type = 'content')">
        <ul style="font-size: 20pt;">
          <li><a href="{$filename}"><xsl:value-of select="title"/></a></li>
        </ul>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="slide[@type = 'list-only']">
    <xsl:apply-templates select="title"/>
    <xsl:apply-templates select="list"/>
  </xsl:template>

  <xsl:template match="slide[@type = 'list-image']">
    <xsl:apply-templates select="title"/>
    <xsl:choose>
      <xsl:when test="image/align = 'left'">
        <xsl:element name="div">
          <xsl:attribute name="class">text_block_right</xsl:attribute>
          <xsl:attribute name="style">width: <xsl:value-of select="list/block_width"/>cm</xsl:attribute>
          <xsl:apply-templates select="list"/>
        </xsl:element>
        <xsl:element name="div">
          <xsl:attribute name="class">text_block_left</xsl:attribute>
          <xsl:attribute name="style">width: <xsl:value-of select="image/block_width"/>cm</xsl:attribute>
          <div class="center_image_in_block">
            &image_xsl;
          </div>
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name="div">
          <xsl:attribute name="class">text_block_left</xsl:attribute>
          <xsl:attribute name="style">width: <xsl:value-of select="list/block_width"/>cm</xsl:attribute>
          <xsl:apply-templates select="list"/>
        </xsl:element>
        <xsl:element name="div">
          <xsl:attribute name="class">text_block_right</xsl:attribute>
          <xsl:attribute name="style">width: <xsl:value-of select="image/block_width"/>cm</xsl:attribute>
          <div class="center_image_in_block">
            &image_xsl;
          </div>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="slide[@type = 'comparison']">
    <xsl:apply-templates select="title"/>
    <xsl:if test="list[@align = 'left']">
      <div class="text_block_left" style="width: 16.93cm">
        <xsl:for-each select="list[@align = 'left']/item">
          &nested_list_xsl;
        </xsl:for-each>
      </div>
    </xsl:if>
    <xsl:if test="list[@align = 'right']">
      <div class="text_block_right" style="width: 16.93cm">
        <xsl:for-each select="list[@align = 'right']/item">
          &nested_list_xsl;
        </xsl:for-each>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template match="slide[@type = 'table-only']">
    <xsl:apply-templates select="title"/>
    <div class="text_block_upper_table">
        <xsl:value-of select="popis"/>
    </div>
    <xsl:element name="table">
      <xsl:attribute name="border">1</xsl:attribute>
      <xsl:element name="tr">
        <xsl:attribute name="bgcolor">#9acd32</xsl:attribute>
        <xsl:for-each select="table/table_header/title">
          <xsl:element name="th">
            <xsl:value-of select="."/>
          </xsl:element>
        </xsl:for-each>
      </xsl:element>

      <xsl:for-each select="table/row">
        <xsl:element name="tr">
          <xsl:element name="td">
            <xsl:value-of select="first_column"/>
          </xsl:element>
          <xsl:element name="td">
            <xsl:value-of select="second_column"/>
          </xsl:element>
          <xsl:element name="td">
            <xsl:value-of select="third_column"/>
          </xsl:element>
          <xsl:element name="td">
            <xsl:value-of select="fourth_column"/>
          </xsl:element>
        </xsl:element>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>

  <xsl:template match="slide[@type = 'image-only']">
    <xsl:apply-templates select="title"/>
    <div class="center">
      &image_xsl;
    </div>
    <div class="text_block_under_image">
        <xsl:value-of select="popis"/>
    </div>
  </xsl:template>

  <xsl:template match="slide[@type = 'resources']">
    <xsl:apply-templates select="title"/>
    <div class="resources">
      <ul>
        <xsl:for-each select="resource">
          <li style="margin: 10px 0;">
            <xsl:if test="@type='web'">
              <xsl:for-each select="author">
                <xsl:value-of select="surname"/>,
                <xsl:value-of select="name"/>.
              </xsl:for-each>
              (<xsl:value-of select="year"/>).
              [online] <xsl:value-of select="website_name"/>.
              Available at: <xsl:value-of select="url"/>.
            </xsl:if>
            <xsl:if test="@type='journal'">
              <xsl:for-each select="author">
                <xsl:value-of select="surname"/>,
                <xsl:value-of select="name"/>.
              </xsl:for-each>
              (<xsl:value-of select="year"/>).
              <xsl:value-of select="title"/>. In:
              <i><xsl:value-of select="journal"/></i>,
              <xsl:value-of select="volume"/>.
              <xsl:value-of select="issue"/>,
              pp: <xsl:value-of select="pages_used"/>.
            </xsl:if>
            <xsl:if test="@type='book'">
              <xsl:for-each select="author">
                <xsl:value-of select="surname"/>,
                <xsl:value-of select="name"/>.
              </xsl:for-each>
              (<xsl:value-of select="year"/>).
              <xsl:value-of select="title"/>.
              <xsl:value-of select="city"/>,
              pp: <xsl:value-of select="pages_used"/>.
            </xsl:if>
          </li>
        </xsl:for-each>
      </ul>
    </div>
  </xsl:template>

</xsl:stylesheet>
