<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml" version="1.0">
  <xsl:output method="html"/>
  <xsl:template match="/xsi:schema">
    <xsl:element name="html">
      <xsl:element name="head">
        <xsl:if test="xsi:annotation/xsi:appinfo">
          <xsl:element name="title">
            <xsl:value-of select="xsi:annotation/xsi:appinfo"/>
          </xsl:element>
        </xsl:if>
        <xsl:element name="link">
          <xsl:attribute name="rel">stylesheet</xsl:attribute>
          <xsl:attribute name="href">/main.css</xsl:attribute>
        </xsl:element>
        <xsl:element name="link">
          <xsl:attribute name="rel">stylesheet</xsl:attribute>
          <xsl:attribute name="href">/schema.css</xsl:attribute>
        </xsl:element>
      </xsl:element>
      <xsl:element name="body">
        <xsl:element name="header">
          <xsl:element name="hgroup">
            <xsl:element name="h1">
              <xsl:choose>
                <xsl:when test="xsi:annotation/xsi:appinfo">
                  <xsl:value-of select="xsi:annotation/xsi:appinfo"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:element name="script">document.write(location.pathname)</xsl:element>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:element>
            <xsl:element name="p">
              <xsl:text>XSD </xsl:text>
              <xsl:value-of select="@version"/>
            </xsl:element>
          </xsl:element>
          <xsl:apply-templates select="xsi:annotation/xsi:documentation" mode="documentation"/>
        </xsl:element>
        <xsl:apply-templates select="xsi:*"/>
      </xsl:element>
    </xsl:element>
  </xsl:template>
  <xsl:template match="xsi:documentation" mode="documentation">
    <xsl:element name="p">
      <xsl:attribute name="class">documentation</xsl:attribute>
      <xsl:value-of select="text()"/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="xsi:annotation"/>
  <xsl:template match="xsi:*">
    <xsl:element name="details">
      <xsl:attribute name="class">
        <xsl:value-of select="name()"/>
        <xsl:if test="not(*[not(name() = 'annotation')])">
          <xsl:text> locked</xsl:text>
        </xsl:if>
      </xsl:attribute>
      <xsl:element name="summary">
        <xsl:call-template name="heading"/>
      </xsl:element>
      <xsl:apply-templates select="xsi:*"/>
    </xsl:element>
  </xsl:template>
  <xsl:template name="heading">
    <xsl:element name="p">
      <xsl:attribute name="class">heading</xsl:attribute>
      <xsl:element name="strong">
        <xsl:value-of select="name()"/>
      </xsl:element>
    </xsl:element>
    <xsl:apply-templates select="@*"/>
    <xsl:apply-templates select="xsi:annotation/xsi:documentation" mode="documentation"/>
  </xsl:template>
  <xsl:template match="@*">
    <xsl:element name="p">
      <xsl:element name="strong">
        <xsl:text>@</xsl:text>
        <xsl:value-of select="name()"/>
        <xsl:text>:</xsl:text>
      </xsl:element>
      <xsl:text> </xsl:text>
      <xsl:choose>
        <xsl:when test="name() = 'namespace' or name() = 'schemaLocation'">
          <xsl:element name="a">
            <xsl:attribute name="href">
              <xsl:value-of select="."/>
            </xsl:attribute>
            <xsl:value-of select="."/>
          </xsl:element>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>
